local _, ns = ...

-- Quêtes connues, construites à la demande depuis QuestieDB et le jeu (voir ensure).
ns.Quests = {}

-- Ce client range les fonctions d'objets dans C_Item ; les anciennes globales peuvent manquer.
local GetItemInfo = (C_Item and C_Item.GetItemInfo) or GetItemInfo
local GetItemQualityColor = (C_Item and C_Item.GetItemQualityColor) or GetItemQualityColor
-- pareil pour les sorts (C_Spell) et les réputations (C_Reputation)
local function SpellName(id)
    if C_Spell and C_Spell.GetSpellName then return C_Spell.GetSpellName(id) end
    return GetSpellInfo and GetSpellInfo(id)
end
local function FactionName(id)
    if C_Reputation and C_Reputation.GetFactionDataByID then
        local d = C_Reputation.GetFactionDataByID(id)
        if d and d.name then return d.name end
    end
    return GetFactionInfoByID and GetFactionInfoByID(id)
end

-- Panneau à droite du journal de quêtes : la suite de quêtes de la quête affichée,
-- avec pour chaque étape les requis et les gains. Une quête isolée a sa fiche seule.
-- Données : QuestieDB (requis) et le jeu, lus au moment de l'affichage. Rien n'est embarqué.

local WIDTH, PAD, HEADER = 360, 10, 72
local CONTENT_W = WIDTH - 2 * PAD - 8
local RAIL_X, CARD_X = 12, 28
local CARD_W = CONTENT_W - CARD_X
local ICON = 22
local FLAT = "Interface\\Buttons\\WHITE8x8"

local C = {
    bg = { 0.05, 0.05, 0.07, 0.96 }, border = { 0.85, 0.65, 0.25, 0.55 }, header = { 0.11, 0.09, 0.06, 1 },
    card = { 1, 1, 1, 0.04 }, cardCur = { 1, 0.82, 0.2, 0.10 }, accent = { 1, 0.82, 0.2, 1 },
    done = { 0.2, 0.85, 0.4 }, cur = { 1, 0.82, 0.2 }, log = { 1, 0.6, 0.2 }, todo = { 0.45, 0.45, 0.5 },
    rail = { 1, 1, 1, 0.10 },
}
local HEX = { label = "|cff8a8a96", xp = "|cffb48cff", rep = "|cff5fd38a", white = "|cffffffff", grey = "|cff7a7a7a" }
local BADGE = {
    Elite = { "ÉLITE", 0.75, 0.2, 0.2 }, Dungeon = { "DONJON", 0.45, 0.3, 0.8 }, Raid = { "RAID", 0.8, 0.4, 0.1 },
    PvP = { "JcJ", 0.7, 0.2, 0.3 }, Group = { "GROUPE", 0.3, 0.5, 0.8 }, optional = { "FACULTATIVE", 0.35, 0.35, 0.4 },
    log = { "EN COURS", 0.8, 0.5, 0.15 },
}

local function has(mask, flag) return math.floor(mask / flag) % 2 == 1 end -- masques > 2^32, pas de bit.band
local function num(n) return BreakUpLargeNumbers and BreakUpLargeNumbers(n) or tostring(n) end

-- 14005 -> "1 po 40 pa 5 pc", chaque unité à sa couleur
local function money(c)
    local g, si, co = math.floor(c / 10000), math.floor(c / 100) % 100, c % 100
    local t = {}
    if g > 0 then t[#t + 1] = "|cffffd700" .. num(g) .. " po|r" end
    if si > 0 then t[#t + 1] = "|cffc7c7cf" .. si .. " pa|r" end
    if co > 0 then t[#t + 1] = "|cffeda55f" .. co .. " pc|r" end
    return table.concat(t, " ")
end

local function dbGet(kind, id, field)
    local db = _G.LibQuestieDB and _G.LibQuestieDB[kind]
    if not db or not db.Get then return nil end
    local ok, v = pcall(db.Get, id, field)
    return ok and v or nil
end

local QXP
local function questXP(id, q)
    if QXP == nil then
        QXP = false
        if _G.QuestieLoader and QuestieLoader.ImportModule then
            local ok, m = pcall(QuestieLoader.ImportModule, QuestieLoader, "QuestXP")
            if ok and m and m.GetQuestLogRewardXP then QXP = m end
        end
    end
    if QXP then
        local ok, xp = pcall(QXP.GetQuestLogRewardXP, QXP, id, false)
        if ok and xp and xp > 0 then return xp end
    end
    return q.rewards and q.rewards.xp
end

local function isDone(id)
    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then return C_QuestLog.IsQuestFlaggedCompleted(id) end
    return IsQuestFlaggedCompleted and IsQuestFlaggedCompleted(id)
end
local function inLog(id)
    if C_QuestLog and C_QuestLog.GetLogIndexForQuestID then return C_QuestLog.GetLogIndexForQuestID(id) ~= nil end
    return GetQuestLogIndexByID and (GetQuestLogIndexByID(id) or 0) > 0
end

local player = {}
local function forMe(q)
    if q.reqClass and player.class and not has(q.reqClass, player.class) then return false end
    if q.reqRace and player.race and not has(q.reqRace, player.race) then return false end
    return true
end

local function startText(s)
    if not s then return nil end
    local name
    if s.kind == "item" then name = GetItemInfo(s.id) or ("objet " .. s.id)
    else name = dbGet(s.kind == "object" and "Object" or "Npc", s.id, "name") or s.name end
    local zone = s.zoneId and C_Map and C_Map.GetAreaInfo and C_Map.GetAreaInfo(s.zoneId)
    local where = zone and (HEX.grey .. "  " .. zone .. (s.x and string.format(" %.0f, %.0f", s.x, s.y) or "") .. "|r") or ""
    return HEX.white .. (name or "?") .. "|r" .. where
end

-- Prérequis : quêtes à rendre avant (toutes, ou une seule au choix), niveau, réputation.
-- Renvoie le texte coloré (vert = fait, rouge = manquant) et si la quête est encore bloquée.
local function prereqs(id, q)
    local parts, locked = {}, false
    local function qname(pid) return dbGet("Quest", pid, "name") or (ns.Quests[pid] and ns.Quests[pid].name) or ("quête " .. pid) end
    local function mark(ok, txt) return (ok and "|cff5fd38a" or "|cffff6b5b") .. txt .. "|r" end
    local group = dbGet("Quest", id, "preQuestGroup")
    if type(group) == "table" then
        for _, pid in ipairs(group) do
            local ok = isDone(pid); if not ok then locked = true end
            parts[#parts + 1] = mark(ok, qname(pid))
        end
    end
    local single = dbGet("Quest", id, "preQuestSingle")
    if type(single) == "table" and #single > 0 then
        local any, names = false, {}
        for _, pid in ipairs(single) do
            if isDone(pid) then any = true end
            -- les variantes de l'autre faction ou d'une autre classe ne sont pas listées
            if not (ns.Quests[pid] and not forMe(ns.Quests[pid])) then names[#names + 1] = qname(pid) end
        end
        if #names == 0 then names[1] = qname(single[1]) end
        if not any then locked = true end
        local txt = #names > 1 and ("une de : " .. table.concat(names, ", ")) or names[1]
        parts[#parts + 1] = mark(any, txt)
    end
    local lvl = UnitLevel("player")
    if q.reqLevel and lvl and q.reqLevel > lvl then
        locked = true
        parts[#parts + 1] = mark(false, "niveau " .. q.reqLevel)
    end
    local rep = dbGet("Quest", id, "requiredMinRep")
    if type(rep) == "table" and rep[1] then
        local fname = FactionName(rep[1]) or rep[1]
        parts[#parts + 1] = HEX.white .. "réputation " .. fname .. "|r"
    end
    if #parts == 0 then return nil, false end
    return table.concat(parts, HEX.grey .. " · |r"), locked
end
ns.prereqs = prereqs

local npcQuest -- quête proposée ou rendue chez un PNJ en ce moment

-- Récompenses lues dans la fenêtre du PNJ ou dans le journal (QuestieDB ne les a pas).
local function linkId(link) return link and tonumber(link:match("item:(%d+)")) end
local function liveRewards(id, q)
    local r = { items = {}, choices = {}, counts = {} }
    local function add(list, iid, n) if iid then list[#list + 1] = iid; r.counts[iid] = n end end
    if id == npcQuest and GetQuestID and GetQuestID() == id and GetNumQuestRewards then
        for _, kind in ipairs({ "reward", "choice" }) do
            local n = kind == "reward" and GetNumQuestRewards() or GetNumQuestChoices()
            for i = 1, n or 0 do
                local _, _, count, _, _, iid = GetQuestItemInfo(kind, i)
                add(kind == "reward" and r.items or r.choices, iid or linkId(GetQuestItemLink(kind, i)), count)
            end
        end
        r.money = GetRewardMoney and GetRewardMoney()
    elseif GetNumQuestLogRewards and inLog(id) then
        for i = 1, GetNumQuestLogRewards(id) or 0 do
            local _, _, count, _, _, iid = GetQuestLogRewardInfo(i, id)
            add(r.items, iid or linkId(GetQuestLogItemLink("reward", i, id)), count)
        end
        for i = 1, (GetNumQuestLogChoices and GetNumQuestLogChoices(id)) or 0 do
            local _, _, count, _, _, iid = GetQuestLogChoiceInfo(i, id)
            add(r.choices, iid or linkId(GetQuestLogItemLink("choice", i, id)), count)
        end
        r.money = GetQuestLogRewardMoney and GetQuestLogRewardMoney(id)
    else return end
    if #r.items == 0 then r.items = nil end
    if #r.choices == 0 then r.choices = nil end
    -- rien trouvé (écran de progression du PNJ par exemple) : on réessaiera plus tard
    if r.items or r.choices or (r.money or 0) > 0 then q.rewards = r end
end

-- Données d'une quête pour l'affichage.
local function questInfo(id, current)
    local q = ns.Quests[id]
    if not q.rewards then pcall(liveRewards, id, q) end
    local r = q.rewards or {}
    if not r.rep and q.rep then r = setmetatable({ rep = q.rep }, { __index = r }) end
    local status = isDone(id) and "done" or (id == current and "cur") or (inLog(id) and "log") or "todo"
    local info = { id = id, q = q, status = status, name = dbGet("Quest", id, "name") or q.name, badges = {} }
    if q.type and BADGE[q.type] then info.badges[#info.badges + 1] = BADGE[q.type] end
    if status == "log" then info.badges[#info.badges + 1] = BADGE.log end

    local req = {}
    if q.reqLevel then req[#req + 1] = "niv. " .. q.reqLevel end
    if q.reqClass then req[#req + 1] = "ta classe" end
    if q.reqRace then req[#req + 1] = "ta race" end
    info.req = #req > 0 and table.concat(req, " · ") or nil
    info.pre, info.locked = prereqs(id, q)
    if info.locked and status == "todo" then info.badges[#info.badges + 1] = { "BLOQUÉE", 0.6, 0.2, 0.2 } end
    info.start = startText(q.start)
    local obj = dbGet("Quest", id, "objectivesText")
    info.obj = type(obj) == "table" and obj[1] and table.concat(obj, " ") or nil

    local gain = {}
    local xp = questXP(id, q)
    info.xp, info.money = xp or 0, r.money or 0
    -- XP réduite parce que tu as trop de niveaux d'avance
    if xp and r.xp and r.xp > 0 and xp < r.xp * 0.95 and status ~= "done" then
        info.badges[#info.badges + 1] = { ("XP -%d%%"):format(math.floor((1 - xp / r.xp) * 100 + 0.5)), 0.55, 0.35, 0.15 }
    end
    local P = ns.Profit
    if P then
        if status == "done" then info.run = P.Run(id)
        else
            local ok, est = pcall(P.Estimate, id, q, xp)
            info.est = ok and est or nil
        end
    end
    if xp and xp > 0 then gain[#gain + 1] = HEX.xp .. num(xp) .. " XP|r" end
    if r.money and r.money > 0 then gain[#gain + 1] = money(r.money) end
    for _, rep in ipairs(r.rep or {}) do
        local fname = FactionName(rep[1]) or rep[1]
        gain[#gain + 1] = HEX.rep .. (rep[2] > 0 and "+" or "") .. rep[2] .. " " .. fname .. "|r"
    end
    for _, sp in ipairs(r.spells or {}) do
        gain[#gain + 1] = HEX.white .. "Sort : " .. (SpellName(sp[1]) or sp[2] or sp[1]) .. "|r"
    end
    info.gain = #gain > 0 and table.concat(gain, HEX.grey .. "   |r") or nil
    info.items, info.choices, info.counts = r.items, r.choices, r.counts or {}
    return info
end

-- Étapes de la suite de la quête `id`, ou nil si elle n'est pas dans une suite.
-- Quête absente des données copiées : fiche minimale depuis QuestieDB.
-- Type affiché en badge, d'après l'étiquette que le jeu donne à la quête.
local TAG_TYPE = { [1] = "Group", [41] = "PvP", [62] = "Raid", [81] = "Dungeon" }
local function questType(id)
    local get = C_QuestLog and C_QuestLog.GetQuestTagInfo
    local ok, tag = pcall(get or error, id)
    if ok and type(tag) == "table" then
        return TAG_TYPE[tag.tagID] or (tag.isElite and "Elite") or nil
    end
    local flags = dbGet("Quest", id, "questFlags")
    if flags and has(flags, 64) then return "Raid" end
end

-- Premier donneur connu de QuestieDB (PNJ, objet du décor ou objet du sac), et où il se trouve.
local function questStart(id)
    local sb = dbGet("Quest", id, "startedBy")
    if type(sb) ~= "table" then return nil end
    for i, kind in ipairs({ "Npc", "Object", "Item" }) do
        local sid = type(sb[i]) == "table" and sb[i][1]
        if sid then
            local s = { id = sid, kind = (i == 2 and "object") or (i == 3 and "item") or nil }
            if i < 3 then
                local spawns = dbGet(kind, sid, "spawns")
                for zone, pts in pairs(type(spawns) == "table" and spawns or {}) do
                    s.zoneId = zone
                    if type(pts[1]) == "table" then s.x, s.y = pts[1][1], pts[1][2] end
                    break
                end
            end
            return s
        end
    end
end

-- Fiche d'une quête : QuestieDB d'abord, sinon ce que le jeu sait (journal ou fenêtre du PNJ).
-- Les récompenses en objets et en argent viennent du jeu (liveRewards), l'XP de Questie (questXP).
local function ensure(id)
    if ns.Quests[id] then return ns.Quests[id] end
    local name = dbGet("Quest", id, "name")
        or (C_QuestLog and C_QuestLog.GetTitleForQuestID and C_QuestLog.GetTitleForQuestID(id))
        or (GetQuestID and GetQuestID() == id and GetTitleText and GetTitleText())
    if not name or name == "" then return nil end
    local level = dbGet("Quest", id, "questLevel")
        or (C_QuestLog and C_QuestLog.GetQuestDifficultyLevel and C_QuestLog.GetQuestDifficultyLevel(id))
    if level == 0 then level = nil end
    local q = { name = name, level = level, reqLevel = dbGet("Quest", id, "requiredLevel") }
    local races, classes = dbGet("Quest", id, "requiredRaces"), dbGet("Quest", id, "requiredClasses")
    if races and races > 0 then q.reqRace = races end
    if classes and classes > 0 then q.reqClass = classes end
    q.type = questType(id)
    q.start = questStart(id)
    local rep = dbGet("Quest", id, "reputationReward")
    if type(rep) == "table" and #rep > 0 then q.rep = rep end
    ns.Quests[id] = q
    return q
end

-- Suite de quêtes : liens de QuestieDB (prérequis, quêtes débloquées).
-- Chaque quête est placée à l'étape qui suit son prérequis le plus tardif.
local MAX_CHAIN = 40
local function usable(qid) local q = ensure(qid); return q and forMe(q) end
local function preds(qid)
    local out = {}
    for _, f in ipairs({ "preQuestGroup", "preQuestSingle" }) do
        local l = dbGet("Quest", qid, f)
        if type(l) == "table" then for _, p in ipairs(l) do if usable(p) then out[#out + 1] = p end end end
    end
    return out
end
local function succs(qid)
    local out = {}
    local l = dbGet("Quest", qid, "childQuests")
    if type(l) == "table" then for _, c in ipairs(l) do if usable(c) then out[#out + 1] = c end end end
    local n = dbGet("Quest", qid, "nextQuestInChain")
    if n and n > 0 and usable(n) then out[#out + 1] = n end
    return out
end

local chainCache = {}
local function chainSteps(id)
    if chainCache[id] then return chainCache[id] end
    local set, order = { [id] = true }, { id }
    local function add(n)
        if set[n] or #order >= MAX_CHAIN then return false end
        set[n] = true; order[#order + 1] = n
        return true
    end
    -- 1. lignée directe d'abord : tous les prérequis en remontant, toutes les suites en descendant
    for _, walk in ipairs({ preds, succs }) do
        local line, i = { id }, 1
        while line[i] do
            for _, n in ipairs(walk(line[i])) do if add(n) then line[#line + 1] = n end end
            i = i + 1
        end
    end
    -- 2. branches voisines, dans les places qui restent
    local predOf, queue, i = {}, {}, 1
    for k, qid in ipairs(order) do queue[k] = qid end
    while queue[i] do
        local cur = queue[i]; i = i + 1
        predOf[cur] = preds(cur)
        if #order < MAX_CHAIN then
            for _, list in ipairs({ predOf[cur], succs(cur) }) do
                for _, n in ipairs(list) do if add(n) then queue[#queue + 1] = n end end
            end
        end
    end
    local depth, visiting = {}, {}
    local function D(qid)
        if depth[qid] then return depth[qid] end
        if visiting[qid] then return 1 end
        visiting[qid] = true
        local d = 1
        for _, p in ipairs(predOf[qid] or preds(qid)) do
            if set[p] then d = math.max(d, D(p) + 1) end
        end
        visiting[qid] = nil
        depth[qid] = d
        return d
    end
    local byDepth, maxD = {}, 0
    for _, qid in ipairs(order) do
        local d = D(qid)
        byDepth[d] = byDepth[d] or {}
        table.insert(byDepth[d], qid)
        if d > maxD then maxD = d end
    end
    local chain = {}
    for d = 1, maxD do
        local st = byDepth[d]
        if st then
            table.sort(st, function(a, b)
                local la, lb = ns.Quests[a].level or 0, ns.Quests[b].level or 0
                if la ~= lb then return la < lb end
                return a < b
            end)
            chain[#chain + 1] = st
        end
    end
    chainCache[id] = chain
    return chain
end

-- Place de la quête dans sa suite : étape, nombre d'étapes (nil si quête isolée).
local function chainPos(id)
    local chain = chainSteps(id)
    if #chain < 2 then return nil end
    for si, st in ipairs(chain) do
        for _, qid in ipairs(st) do if qid == id then return si, #chain end end
    end
end

local function Build(id)
    local q = id and ensure(id)
    if not q then return nil end
    local chain = chainSteps(id)
    local steps, done, leftXP, leftMoney = {}, 0, 0, 0
    for _, step in ipairs(chain) do
        local mine = {}
        for _, qid in ipairs(step) do
            if ns.Quests[qid] and (qid == id or forMe(ns.Quests[qid])) then mine[#mine + 1] = questInfo(qid, id) end
        end
        if #mine > 0 then
            local all = true
            for _, i in ipairs(mine) do
                if i.status ~= "done" then all = false; leftXP = leftXP + i.xp; leftMoney = leftMoney + i.money end
            end
            if all then done = done + 1 end
            steps[#steps + 1] = mine
        end
    end
    if #steps == 0 then return nil end
    return { solo = #steps == 1, steps = steps, done = done, first = steps[1][1].name, leftXP = leftXP, leftMoney = leftMoney }
end
ns.Build = Build

-------------------------------------------------------------------------------- UI
local panel, scroll, child, shown
local pool = { fs = {}, tex = {}, btn = {}, hit = {} }
local used = { fs = 0, tex = 0, btn = 0, hit = 0 }
local expandDone = false
local cardPos = {} -- id de quête -> {haut, hauteur} de sa carte dans le panneau
local waitingItems = {} -- objets affichés dont le jeu n'a pas encore envoyé les infos
local dismissed, curHost -- dismissed = id de la quête affichée quand on a fermé
local lastClick = 0

-- Sélectionne la quête dans le journal si elle y est.
local function OpenInLog(id)
    if QuestMapFrame_ShowQuestDetails and QuestMapFrame and QuestMapFrame:IsVisible() then
        pcall(QuestMapFrame_ShowQuestDetails, id); return
    end
    if C_QuestLog and C_QuestLog.SetSelectedQuest then pcall(C_QuestLog.SetSelectedQuest, id) end
    local idx = (C_QuestLog and C_QuestLog.GetLogIndexForQuestID and C_QuestLog.GetLogIndexForQuestID(id))
        or (GetQuestLogIndexByID and GetQuestLogIndexByID(id))
    if idx and idx > 0 and QuestLog_SetSelection then pcall(QuestLog_SetSelection, idx) end
    if QuestLog_Update then pcall(QuestLog_Update) end
end

local STATUS_TXT = { done = "|cff5fd38aTerminée|r", cur = "|cffffd100Affichée dans le journal|r",
    log = "|cffff9933Dans ton journal|r", todo = "|cff8a8a96Pas encore prise|r" }

-- Zone survolable d'une carte ou d'une ligne (sous les icônes d'objets).
local function HIT(x, y, w, h, onEnter, onClick)
    used.hit = used.hit + 1
    local f = pool.hit[used.hit]
    if not f then
        f = CreateFrame("Button", nil, child)
        f.hl = f:CreateTexture(nil, "BACKGROUND"); f.hl:SetAllPoints(); f.hl:SetTexture(FLAT); f.hl:SetVertexColor(1, 1, 1, 0.05)
        f.hl:Hide()
        f:SetScript("OnEnter", function(self) self.hl:Show(); if self.onEnter then self.onEnter(self) end end)
        f:SetScript("OnLeave", function(self) self.hl:Hide(); GameTooltip:Hide() end)
        f:SetScript("OnClick", function(self) if self.onClick then self.onClick(self) end end)
        pool.hit[used.hit] = f
    end
    f:SetFrameLevel(child:GetFrameLevel() + 1)
    f.onEnter, f.onClick = onEnter, onClick
    f:ClearAllPoints(); f:SetPoint("TOPLEFT", x, y); f:SetSize(w, h); f:Show()
    return f
end

local function FS(font)
    used.fs = used.fs + 1
    local f = pool.fs[used.fs]
    if not f then f = child:CreateFontString(nil, "OVERLAY"); pool.fs[used.fs] = f end
    f:SetFontObject(font or "GameFontHighlightSmall")
    f:SetJustifyH("LEFT"); f:SetJustifyV("TOP"); f:SetWordWrap(true); f:SetSpacing(1)
    f:SetWidth(0); f:ClearAllPoints(); f:SetAlpha(1); f:SetTextColor(1, 1, 1); f:Show()
    return f
end
local function TEX(layer, r, g, b, a)
    used.tex = used.tex + 1
    local t = pool.tex[used.tex]
    if not t then t = child:CreateTexture(nil, "ARTWORK"); pool.tex[used.tex] = t end
    t:SetDrawLayer(layer or "ARTWORK"); t:SetTexture(FLAT); t:SetVertexColor(r, g, b, a or 1)
    if t.SetRotation then t:SetRotation(0) end
    t:ClearAllPoints(); t:Show()
    return t
end

local function ItemButton(id, n, x, y, dim)
    used.btn = used.btn + 1
    local b = pool.btn[used.btn]
    if not b then
        b = CreateFrame("Button", nil, child)
        b:SetSize(ICON, ICON)
        b:SetFrameLevel(child:GetFrameLevel() + 3)
        b.border = b:CreateTexture(nil, "BACKGROUND"); b.border:SetAllPoints(); b.border:SetTexture(FLAT)
        b.icon = b:CreateTexture(nil, "ARTWORK"); b.icon:SetPoint("TOPLEFT", 1, -1); b.icon:SetPoint("BOTTOMRIGHT", -1, 1)
        b.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        b.count = b:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall"); b.count:SetPoint("BOTTOMRIGHT", 1, 0)
        b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
        b:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if GameTooltip.SetItemByID then GameTooltip:SetItemByID(self.id) else GameTooltip:SetHyperlink("item:" .. self.id) end
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", function() GameTooltip:Hide() end)
        b:SetScript("OnClick", function(self)
            local _, link = GetItemInfo(self.id)
            if link and HandleModifiedItemClick then HandleModifiedItemClick(link) end
        end)
        pool.btn[used.btn] = b
    end
    b.id = id
    b.icon:SetTexture((C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(id)) or (GetItemIcon and GetItemIcon(id)) or 134400)
    local _, _, quality = GetItemInfo(id)
    if not quality then
        waitingItems[id] = true
        if C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(id) end
    end
    local qr, qg, qb = 0.3, 0.3, 0.3
    if quality and GetItemQualityColor then qr, qg, qb = GetItemQualityColor(quality) end
    b.border:SetVertexColor(qr, qg, qb, 1)
    b.count:SetText(n and n > 1 and n or "")
    b:SetAlpha(dim and 0.5 or 1)
    b:ClearAllPoints(); b:SetPoint("TOPLEFT", x, y); b:Show()
end

local function Badge(spec, x, y)
    local f = FS("GameFontNormalSmall")
    f:SetText(spec[1]); f:SetTextColor(1, 1, 1)
    local w = f:GetStringWidth() + 8
    local bg = TEX("BORDER", spec[2], spec[3], spec[4], 0.85)
    bg:SetPoint("TOPLEFT", x, y); bg:SetSize(w, 13)
    f:SetPoint("CENTER", bg, "CENTER", 0, 0)
    return w
end

-- Ligne de texte dans une carte : renvoie sa hauteur.
local function Line(text, x, y, w, font)
    local f = FS(font)
    f:SetWidth(w); f:SetText(text); f:SetPoint("TOPLEFT", x, y)
    return f:GetStringHeight(), f
end

local function Items(label, list, counts, x, y, dim)
    Line(HEX.label .. label .. "|r", x, y - (ICON - 10) / 2, 60)
    local bx = x + 58
    local maxX = CARD_X + CARD_W - ICON - 4
    local rows = 1
    for _, it in ipairs(list) do
        if bx > maxX then bx = x + 58; y = y - ICON - 3; rows = rows + 1 end
        ItemButton(it, counts[it], bx, y, dim)
        bx = bx + ICON + 4
    end
    return rows * (ICON + 3)
end

local function Card(info, y)
    local x, w, top = CARD_X + 10, CARD_W - 16, y
    local done, cur = info.status == "done", info.status == "cur"
    y = y - 8
    -- titre
    local lr, lg, lb = 1, 1, 1
    if GetQuestDifficultyColor and info.q.level then
        local c = GetQuestDifficultyColor(info.q.level); lr, lg, lb = c.r, c.g, c.b
    end
    local lvl = FS("GameFontNormalSmall")
    lvl:SetText(info.q.level or "?"); lvl:SetTextColor(lr, lg, lb); lvl:SetPoint("TOPLEFT", x, y - 1)
    local name = FS(cur and "GameFontNormal" or "GameFontHighlight")
    name:SetWidth(w - 24); name:SetText(info.name); name:SetPoint("TOPLEFT", x + 22, y)
    if done then name:SetTextColor(0.55, 0.6, 0.55) elseif cur then name:SetTextColor(1, 0.82, 0.2) else name:SetTextColor(1, 1, 1) end
    y = y - name:GetStringHeight() - 4
    if #info.badges > 0 then
        local bx = x + 22
        for _, b in ipairs(info.badges) do bx = bx + Badge(b, bx, y) + 4 end
        y = y - 17
    end
    if not done then
        local sub = {}
        if info.req then sub[#sub + 1] = HEX.label .. "Requis|r  " .. HEX.white .. info.req .. "|r" end
        if info.pre then sub[#sub + 1] = HEX.label .. "Avant|r  " .. info.pre end
        if info.start then sub[#sub + 1] = HEX.label .. "Donneur|r  " .. info.start end
        if info.obj then sub[#sub + 1] = HEX.label .. "Objectif|r  " .. HEX.white .. info.obj .. "|r" end
        for _, s in ipairs(sub) do y = y - Line(s, x, y, w) - 3 end
    end
    if info.gain then
        y = y - 2
        local sep = TEX("BORDER", 1, 1, 1, 0.06); sep:SetPoint("TOPLEFT", x, y); sep:SetSize(w, 1)
        y = y - 5
        local h = Line(info.gain, x, y, w, "GameFontHighlightSmall")
        y = y - h - 4
    end
    if info.est then
        local e = info.est
        local parts = { HEX.xp .. "~" .. num(math.floor(e.xph / 100 + 0.5) * 100) .. " XP/h|r",
            "~" .. math.max(1, math.floor(e.minutes + 0.5)) .. " min" .. (e.exact and " restantes" or "")
            .. (e.trip and (HEX.grey .. " dont " .. math.max(1, math.floor(e.trip + 0.5)) .. " de trajet|r") or "") }
        if e.kills > 0 then parts[#parts + 1] = "~" .. e.kills .. " kills" end
        if e.objects > 0 then parts[#parts + 1] = e.objects .. " à ramasser" end
        y = y - Line(HEX.label .. "Rentabilité|r  " .. e.color .. e.label .. "|r", x, y, w) - 2
        y = y - Line(table.concat(parts, HEX.grey .. "  ·  |r"), x, y, w) - 4
    end
    if info.run then
        local rr = info.run
        local timed = rr.min >= 0.5
        local parts = { HEX.xp .. num(rr.xp) .. " XP|r" }
        if timed then table.insert(parts, 1, math.floor(rr.min + 0.5) .. " min") end
        if rr.money > 0 then parts[#parts + 1] = money(rr.money) end
        if rr.loot > 0 then parts[#parts + 1] = "butin " .. money(rr.loot) end
        if timed then parts[#parts + 1] = HEX.xp .. num(math.floor(rr.xp / rr.min * 60 / 100 + 0.5) * 100) .. " XP/h|r" end
        y = y - Line(HEX.label .. "Ton passage|r  " .. table.concat(parts, HEX.grey .. "  ·  |r"), x, y, w) - 4
    end
    if not done then
        if info.items then y = y - Items("Reçu", info.items, info.counts, x, y) - 2 end
        if info.choices then y = y - Items("Au choix", info.choices, info.counts, x, y) - 2 end
    end
    y = y - 4
    local h = top - y
    local bg = TEX("BACKGROUND", unpack(cur and C.cardCur or C.card)); bg:SetPoint("TOPLEFT", CARD_X, top); bg:SetSize(CARD_W, h)
    if cur then
        local acc = TEX("BORDER", unpack(C.accent)); acc:SetPoint("TOPLEFT", CARD_X, top); acc:SetSize(2, h)
    end
    local canOpen = info.status == "log" or info.status == "cur"
    HIT(CARD_X, top, CARD_W, h, function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(info.name, 1, 0.82, 0.2, true)
        GameTooltip:AddLine(STATUS_TXT[info.status])
        GameTooltip:AddLine("Quête n°" .. info.id, 0.5, 0.5, 0.55)
        if info.status == "log" then GameTooltip:AddLine("Clic : l'afficher dans le journal", 0.6, 0.8, 1) end
        GameTooltip:Show()
    end, canOpen and info.status ~= "cur" and function() OpenInLog(info.id) end or nil)
    -- losange sur la frise
    local col = C[info.status]
    if cur then
        local glow = TEX("ARTWORK", col[1], col[2], col[3], 0.35)
        glow:SetSize(16, 16); glow:SetPoint("CENTER", child, "TOPLEFT", RAIL_X, top - 14)
        if glow.SetRotation then glow:SetRotation(math.pi / 4) end
    end
    local node = TEX("OVERLAY", col[1], col[2], col[3], 1)
    node:SetSize(9, 9); node:SetPoint("CENTER", child, "TOPLEFT", RAIL_X, top - 14)
    if node.SetRotation then node:SetRotation(math.pi / 4) end
    return y, top
end

local function Render(data, currentId)
    used.fs, used.tex, used.btn, used.hit = 0, 0, 0, 0
    wipe(cardPos)
    child:SetWidth(CONTENT_W)
    local y, curY, firstNode, lastNode = -4, nil, nil, nil
    -- étapes déjà faites au début de la suite : repliées en une ligne
    local skip = 0
    for _, step in ipairs(data.steps) do
        local all = true
        for _, i in ipairs(step) do if i.status ~= "done" then all = false end end
        if not all then break end
        skip = skip + 1
    end
    if skip < 2 or skip == #data.steps then skip = 0 end
    if skip > 0 then
        local node = TEX("OVERLAY", C.done[1], C.done[2], C.done[3], 1)
        node:SetSize(9, 9); node:SetPoint("CENTER", child, "TOPLEFT", RAIL_X, y - 11)
        if node.SetRotation then node:SetRotation(math.pi / 4) end
        firstNode, lastNode = y - 11, y - 11
        local f = FS("GameFontNormalSmall")
        f:SetText(("|cff5fd38a%d étapes terminées|r  |cff7a7a7a%s|r"):format(skip, expandDone and "(replier)" or "(afficher)"))
        f:SetPoint("TOPLEFT", CARD_X + 10, y - 6)
        HIT(CARD_X, y, CARD_W, 22, nil, function() expandDone = not expandDone; ns.Refresh() end)
        y = y - 30
        if expandDone then skip = 0 end
    end
    for si, step in ipairs(data.steps) do
      if si > skip then
        if not data.solo then
            local hdr = FS("GameFontNormalSmall")
            hdr:SetText(("ÉTAPE %d"):format(si) .. (#step > 1 and HEX.grey .. "  ·  en parallèle|r" or ""))
            hdr:SetTextColor(0.55, 0.55, 0.62)
            hdr:SetPoint("TOPLEFT", CARD_X, y)
            y = y - 15
        end
        for _, info in ipairs(step) do
            local top
            y, top = Card(info, y)
            firstNode = firstNode or (top - 14)
            lastNode = top - 14
            if info.id == currentId then curY = top end
            cardPos[info.id] = { top, top - y }
            y = y - 6
        end
        y = y - 6
      end
    end
    local rail = TEX("BACKGROUND", unpack(C.rail))
    rail:SetPoint("TOP", child, "TOPLEFT", RAIL_X, firstNode); rail:SetSize(2, firstNode - lastNode)
    for i = used.fs + 1, #pool.fs do pool.fs[i]:Hide() end
    for i = used.tex + 1, #pool.tex do pool.tex[i]:Hide() end
    for i = used.btn + 1, #pool.btn do pool.btn[i]:Hide() end
    for i = used.hit + 1, #pool.hit do pool.hit[i]:Hide() end
    child:SetHeight(-y)
    return -y, curY
end

local function Create()
    panel = CreateFrame("Frame", "FreresDEpeeQCFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
    panel:SetWidth(WIDTH)
    panel:SetFrameStrata("HIGH")
    panel:SetClampedToScreen(true)
    if panel.SetBackdrop then
        panel:SetBackdrop({ bgFile = FLAT, edgeFile = FLAT, edgeSize = 1 })
        panel:SetBackdropColor(unpack(C.bg))
        panel:SetBackdropBorderColor(unpack(C.border))
    end
    -- en-tête : déplaçable, clic droit pour revenir à côté du journal
    local head = CreateFrame("Frame", nil, panel)
    head:SetPoint("TOPLEFT", 1, -1); head:SetPoint("TOPRIGHT", -1, -1); head:SetHeight(HEADER)
    local hbg = head:CreateTexture(nil, "BACKGROUND"); hbg:SetAllPoints(); hbg:SetTexture(FLAT); hbg:SetVertexColor(unpack(C.header))
    local shine = head:CreateTexture(nil, "BORDER"); shine:SetPoint("TOPLEFT"); shine:SetPoint("TOPRIGHT"); shine:SetHeight(HEADER / 2)
    shine:SetTexture(FLAT); shine:SetVertexColor(1, 0.85, 0.4, 0.04)
    local line = head:CreateTexture(nil, "ARTWORK"); line:SetPoint("BOTTOMLEFT"); line:SetPoint("BOTTOMRIGHT"); line:SetHeight(1)
    line:SetTexture(FLAT); line:SetVertexColor(unpack(C.border))
    panel.kicker = head:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    panel.kicker:SetPoint("TOPLEFT", 12, -9); panel.kicker:SetText("SUITE DE QUÊTES"); panel.kicker:SetTextColor(0.85, 0.65, 0.25)
    panel.title = head:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    panel.title:SetPoint("TOPLEFT", 12, -23); panel.title:SetPoint("RIGHT", -70, 0); panel.title:SetJustifyH("LEFT"); panel.title:SetWordWrap(false)
    panel.count = head:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    panel.count:SetPoint("TOPRIGHT", -30, -22)
    local mode = CreateFrame("Button", nil, head)
    mode:SetSize(44, 14); mode:SetPoint("TOPRIGHT", -10, -46)
    mode.bg = mode:CreateTexture(nil, "BACKGROUND"); mode.bg:SetAllPoints(); mode.bg:SetTexture(FLAT)
    mode.txt = mode:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"); mode.txt:SetPoint("CENTER")
    mode:SetScript("OnClick", function()
        local d = ns.Profit.DB(); d.duo = not d.duo
        ns.Refresh()
    end)
    mode:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:AddLine("Mode de calcul de la rentabilité")
        GameTooltip:AddLine("En duo, chacun doit looter ses objets de quête : il faut deux fois plus de kills.", 1, 1, 1, true)
        GameTooltip:AddLine("Clic : changer", 0.6, 0.8, 1)
        GameTooltip:Show()
    end)
    mode:SetScript("OnLeave", function() GameTooltip:Hide() end)
    panel.mode = mode
    panel.left = head:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    panel.left:SetPoint("TOPLEFT", 12, -46); panel.left:SetPoint("RIGHT", mode, "LEFT", -6, 0); panel.left:SetJustifyH("LEFT")
    local close = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", 1, 1); close:SetScale(0.8); close:SetFrameLevel(head:GetFrameLevel() + 5)
    close:SetScript("OnClick", function() ns.Dismiss() end)
    -- barre de progression
    local bar = CreateFrame("StatusBar", nil, head)
    bar:SetPoint("BOTTOMLEFT", 0, 1); bar:SetPoint("BOTTOMRIGHT", 0, 1); bar:SetHeight(3)
    bar:SetStatusBarTexture(FLAT); bar:SetStatusBarColor(C.done[1], C.done[2], C.done[3], 0.9)
    local bbg = bar:CreateTexture(nil, "BACKGROUND"); bbg:SetAllPoints(); bbg:SetTexture(FLAT); bbg:SetVertexColor(1, 1, 1, 0.06)
    panel.bar = bar

    panel:SetMovable(true); head:EnableMouse(true); head:RegisterForDrag("LeftButton")
    head:SetScript("OnDragStart", function() panel:StartMoving() end)
    head:SetScript("OnDragStop", function()
        panel:StopMovingOrSizing()
        local l, t = panel:GetLeft(), panel:GetTop()
        ns.Profit.DB().pos = { l, t }
    end)
    head:SetScript("OnMouseUp", function(_, btn)
        if btn == "RightButton" then
            ns.Profit.DB().pos = nil
            ns.Update()
        end
    end)

    scroll = CreateFrame("ScrollFrame", nil, panel)
    scroll:SetPoint("TOPLEFT", PAD, -HEADER - 8)
    scroll:SetPoint("BOTTOMRIGHT", -PAD - 8, PAD)
    child = CreateFrame("Frame", nil, scroll)
    child:SetSize(CONTENT_W, 10)
    scroll:SetScrollChild(child)
    -- barre de défilement fine, molette uniquement
    local track = panel:CreateTexture(nil, "ARTWORK"); track:SetTexture(FLAT); track:SetVertexColor(1, 1, 1, 0.05)
    track:SetPoint("TOPRIGHT", -5, -HEADER - 8); track:SetPoint("BOTTOMRIGHT", -5, PAD); track:SetWidth(3)
    local thumb = panel:CreateTexture(nil, "OVERLAY"); thumb:SetTexture(FLAT); thumb:SetVertexColor(0.85, 0.65, 0.25, 0.7)
    thumb:SetWidth(3)
    panel.track, panel.thumb = track, thumb
    local function UpdateThumb()
        local range = scroll:GetVerticalScrollRange() or 0
        local th = track:GetHeight() or 0
        if range <= 0 or th <= 0 then track:Hide(); thumb:Hide(); return end
        track:Show(); thumb:Show()
        local view = scroll:GetHeight()
        local hh = math.max(20, th * view / (view + range))
        thumb:SetHeight(hh)
        thumb:ClearAllPoints(); thumb:SetPoint("TOP", track, "TOP", 0, -(th - hh) * (scroll:GetVerticalScroll() / range))
    end
    panel.UpdateThumb = UpdateThumb
    scroll:EnableMouseWheel(true)
    scroll:SetScript("OnMouseWheel", function(self, delta)
        local range = self:GetVerticalScrollRange() or 0
        self:SetVerticalScroll(math.max(0, math.min(range, self:GetVerticalScroll() - delta * 50)))
    end)
    scroll:SetScript("OnVerticalScroll", UpdateThumb)
    scroll:SetScript("OnScrollRangeChanged", UpdateThumb)

    -- apparition en fondu
    local ag = panel:CreateAnimationGroup()
    local fade = ag:CreateAnimation("Alpha"); fade:SetFromAlpha(0); fade:SetToAlpha(1); fade:SetDuration(0.18)
    panel.anim = ag

    panel:Hide()
    -- rafraîchi quand la quête avance ou qu'un objet affiché arrive
    for _, e in ipairs({ "GET_ITEM_INFO_RECEIVED", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_LOG_UPDATE" }) do
        pcall(panel.RegisterEvent, panel, e)
    end
    local queued
    local function refresh()
        if queued or not panel:IsShown() then return end
        queued = true
        C_Timer.After(0.5, function() queued = nil; if panel:IsShown() then ns.Refresh() end end)
    end
    ns.OnRun = refresh -- passage enregistré, une seconde après le rendu
    panel:SetScript("OnEvent", function(_, event, itemId)
        if event == "GET_ITEM_INFO_RECEIVED" then
            if not waitingItems[itemId] then return end
            waitingItems[itemId] = nil
        end
        refresh()
    end)
end

local hostHooked = {}
local SelectedQuest
-- Fenêtre ouverte à l'écran à côté de laquelle se mettre, la quête qu'elle montre et d'où vient l'info.
local function Target()
    if ns.db.qcNpc and QuestFrame and QuestFrame:IsVisible() then
        local id = GetQuestID and GetQuestID()
        if id and id > 0 then return QuestFrame, id, "PNJ" end
    end
    if not ns.db.qcLog then return end
    local details = QuestMapFrame and QuestMapFrame.DetailsFrame
    if details and details:IsVisible() then
        local id = details.questID or SelectedQuest()
        if id and id > 0 then return WorldMapFrame.BorderFrame or WorldMapFrame, id, "journal (carte)" end
    end
    for _, f in ipairs({ _G.QuestLogExFrame, _G.ClassicQuestLog, _G.QuestLogFrame }) do
        if f and f:IsVisible() then
            local id = SelectedQuest()
            if id and id > 0 then return f, id, "journal" end
        end
    end
end

-- Coins visibles du cadre hôte (le journal classique a une zone vide autour de son dessin).
local function Visible(host)
    local l, r, t, b = 0, 0, 0, 0
    if host.GetHitRectInsets then l, r, t, b = host:GetHitRectInsets() end
    return r or 0, t or 0, b or 0
end

-- Dessine la quête `id` à côté de `host`. refresh : contenu mis à jour, sans repositionner ni défiler.
local function render(id, host, data, refresh)
    if not panel then Create() end
    if not hostHooked[host] then
        hostHooked[host] = true
        host:HookScript("OnHide", function() ns.Update() end)
    end
    if host ~= UIParent and host ~= curHost then
        panel:SetFrameStrata(host:GetFrameStrata()); panel:SetFrameLevel(host:GetFrameLevel() + 10)
    elseif host == UIParent then
        panel:SetFrameStrata("HIGH")
    end
    curHost = host
    local same = shown == id
    shown = id
    panel.title:SetText(data.first)
    panel.kicker:SetText(data.solo and "QUÊTE" or ("SUITE DE QUÊTES  ·  %d ÉTAPES"):format(#data.steps))
    if data.leftXP > 0 or data.leftMoney > 0 then
        local t = { HEX.xp .. num(data.leftXP) .. " XP|r" }
        if data.leftMoney > 0 then t[#t + 1] = money(data.leftMoney) end
        panel.left:SetText(HEX.label .. "Il reste à gagner|r  " .. table.concat(t, HEX.grey .. "  ·  |r"))
    else
        panel.left:SetText("|cff5fd38aSuite terminée|r")
    end
    local duo = ns.Profit.DB().duo
    panel.mode.txt:SetText(duo and "DUO" or "SOLO")
    if duo then panel.mode.bg:SetVertexColor(0.3, 0.5, 0.8, 0.85) else panel.mode.bg:SetVertexColor(0.4, 0.4, 0.45, 0.85) end
    panel.count:SetText(("|cff5fd38a%d|r|cff7a7a7a / %d|r"):format(data.done, #data.steps))
    panel.bar:SetMinMaxValues(0, #data.steps); panel.bar:SetValue(data.done)

    local contentH, curY = Render(data, id)
    -- hauteur ajustée au contenu, limitée à la hauteur visible du journal
    local r, t, b = Visible(host)
    local ratio = host:GetEffectiveScale() / panel:GetEffectiveScale()
    local maxH = host == UIParent and (UIParent:GetHeight() * 0.8) or math.max(320, (host:GetHeight() - t - b) * ratio)
    local h = math.min(maxH, contentH + HEADER + 8 + PAD + 2)
    panel:SetHeight(h)

    if not refresh then
        panel:ClearAllPoints()
        local pos = ns.Profit.DB().pos
        if pos then panel:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", pos[1], pos[2])
        elseif host == UIParent then panel:SetPoint("CENTER")
        else panel:SetPoint("TOPLEFT", host, "TOPRIGHT", 4 - r * ratio, -t * ratio) end
        if not (same and panel:IsShown()) then
            scroll:SetVerticalScroll(0)
            C_Timer.After(0, function()
                if scroll.UpdateScrollChildRect then scroll:UpdateScrollChildRect() end
                local maxS = scroll:GetVerticalScrollRange() or 0
                if curY and maxS > 0 then scroll:SetVerticalScroll(math.max(0, math.min(maxS, -curY - 22))) end
                panel.UpdateThumb()
            end)
            panel:Show()
            panel.anim:Stop(); panel.anim:Play()
        end
    end
    panel:Show()
    panel.UpdateThumb()
end


-------------------------------------------------------------------------------- quêtes du PNJ
-- Deuxième fenêtre, sous le panneau quand on parle à un PNJ : toutes les quêtes qu'il donne.
local npcPanel
local NPC_W, ROW = 320, 20

local function NpcId()
    local guid = UnitGUID and UnitGUID("npc")
    if not guid then return nil end
    local kind, _, _, _, _, id = strsplit("-", guid)
    return tonumber(id), kind == "GameObject" and "Object" or "Npc"
end

local function NpcQuests()
    local id, kind = NpcId()
    if not id then return nil end
    local starts = dbGet(kind, id, "questStarts")
    if type(starts) ~= "table" then return nil end
    local list = {}
    for _, qid in ipairs(starts) do
        local q = ensure(qid)
        if q and forMe(q) then list[#list + 1] = qid end
    end
    if #list == 0 then return nil end
    table.sort(list, function(a, b)
        local la, lb = ns.Quests[a].level or 0, ns.Quests[b].level or 0
        if la ~= lb then return la < lb end
        return a < b
    end)
    return list, dbGet(kind, id, "name") or UnitName("npc")
end

local function NpcRow(i)
    local r = npcPanel.rows[i]
    if r then return r end
    r = CreateFrame("Button", nil, npcPanel)
    r:SetSize(NPC_W - 16, ROW)
    r.hl = r:CreateTexture(nil, "BACKGROUND"); r.hl:SetAllPoints(); r.hl:SetTexture(FLAT); r.hl:SetVertexColor(1, 1, 1, 0.05); r.hl:Hide()
    r.sel = r:CreateTexture(nil, "BACKGROUND"); r.sel:SetAllPoints(); r.sel:SetTexture(FLAT); r.sel:SetVertexColor(1, 0.82, 0.2, 0.10)
    r.node = r:CreateTexture(nil, "ARTWORK"); r.node:SetTexture(FLAT); r.node:SetSize(7, 7); r.node:SetPoint("LEFT", 6, 0)
    if r.node.SetRotation then r.node:SetRotation(math.pi / 4) end
    r.lvl = r:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"); r.lvl:SetPoint("LEFT", 18, 0); r.lvl:SetWidth(20); r.lvl:SetJustifyH("LEFT")
    r.right = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); r.right:SetPoint("RIGHT", -4, 0); r.right:SetJustifyH("RIGHT")
    r.name = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); r.name:SetPoint("LEFT", 40, 0); r.name:SetPoint("RIGHT", r.right, "LEFT", -6, 0)
    r.name:SetJustifyH("LEFT"); r.name:SetWordWrap(false)
    r:SetScript("OnEnter", function(self)
        self.hl:Show()
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(self.title, 1, 0.82, 0.2, true)
        for _, l in ipairs(self.tip or {}) do GameTooltip:AddLine(l, 1, 1, 1, true) end
        GameTooltip:AddLine("Clic : afficher le détail", 0.6, 0.8, 1)
        GameTooltip:Show()
    end)
    r:SetScript("OnLeave", function(self) self.hl:Hide(); GameTooltip:Hide() end)
    r:SetScript("OnClick", function(self)
        if not ns.ScrollTo(self.qid) then ns.Show(self.qid) end
    end)
    npcPanel.rows[i] = r
    return r
end

local function npcListImpl()
    local list, npcName = NpcQuests()
    if not (list and npcQuest and panel and panel:IsShown()) or #list < 2 then
        if npcPanel then npcPanel:Hide() end
        return
    end
    if not npcPanel then
        npcPanel = CreateFrame("Frame", "FreresDEpeeQCNpcFrame", panel, BackdropTemplateMixin and "BackdropTemplate" or nil)
        npcPanel:SetWidth(NPC_W)
        if npcPanel.SetBackdrop then
            npcPanel:SetBackdrop({ bgFile = FLAT, edgeFile = FLAT, edgeSize = 1 })
            npcPanel:SetBackdropColor(unpack(C.bg)); npcPanel:SetBackdropBorderColor(unpack(C.border))
        end
        npcPanel.kicker = npcPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        npcPanel.kicker:SetPoint("TOPLEFT", 10, -8); npcPanel.kicker:SetTextColor(0.85, 0.65, 0.25)
        npcPanel.title = npcPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        npcPanel.title:SetPoint("TOPLEFT", 10, -21); npcPanel.title:SetPoint("RIGHT", -10, 0); npcPanel.title:SetJustifyH("LEFT")
        npcPanel.rows = {}
    end
    npcPanel.kicker:SetText(("QUÊTES DE CE PNJ  ·  %d"):format(#list))
    npcPanel.title:SetText(npcName or "")
    local y, todo = -40, 0
    for i, qid in ipairs(list) do
        local q = ns.Quests[qid]
        local r = NpcRow(i)
        local done, log = isDone(qid), inLog(qid)
        local status = done and "done" or (qid == shown and "cur") or (log and "log") or "todo"
        local col = C[status]
        r.node:SetVertexColor(col[1], col[2], col[3], 1)
        local c = GetQuestDifficultyColor and q.level and GetQuestDifficultyColor(q.level)
        r.lvl:SetText(q.level or "?"); if c then r.lvl:SetTextColor(c.r, c.g, c.b) end
        r.qid, r.title = qid, dbGet("Quest", qid, "name") or q.name
        r.name:SetText(r.title)
        if done then r.name:SetTextColor(0.5, 0.55, 0.5) else r.name:SetTextColor(1, 1, 1) end
        r.sel:SetShown(qid == shown)
        local xp = questXP(qid, q) or 0
        r.tip = {}
        local si, sn = chainPos(qid)
        local mark = si and (HEX.grey .. si .. "/" .. sn .. "|r  ") or ""
        if si then r.tip[#r.tip + 1] = ("Étape %d sur %d d'une suite"):format(si, sn) end
        if q.reqLevel then r.tip[#r.tip + 1] = "Niveau requis " .. q.reqLevel end
        local pre, locked = prereqs(qid, q)
        if pre then r.tip[#r.tip + 1] = "Prérequis : " .. pre end
        if done then
            r.right:SetText(mark .. "|cff5fd38afaite|r")
        else
            todo = todo + 1
            local ok, e = pcall(ns.Profit.Estimate, qid, q, xp)
            local txt = xp > 0 and (HEX.xp .. num(xp) .. " XP|r") or ""
            if ok and e then
                txt = txt .. "  " .. e.color .. e.short .. "|r"
                r.tip[#r.tip + 1] = "Rentabilité : " .. e.color .. e.label .. "|r (~" .. num(math.floor(e.xph / 100 + 0.5) * 100) .. " XP/h, ~"
                    .. math.max(1, math.floor(e.minutes + 0.5)) .. " min" .. (e.trip and (" dont " .. math.max(1, math.floor(e.trip + 0.5)) .. " de trajet") or "") .. ")"
            end
            if log then r.tip[#r.tip + 1] = "|cffff9933Dans ton journal|r" end
            if locked and not log then txt = "|cffff6b5bbloquée|r  " .. txt; r.name:SetTextColor(0.7, 0.7, 0.7) end
            r.right:SetText(mark .. txt)
        end
        r:ClearAllPoints(); r:SetPoint("TOPLEFT", 8, y); r:Show()
        y = y - ROW
    end
    for i = #list + 1, #npcPanel.rows do npcPanel.rows[i]:Hide() end
    local h = -y + 8
    npcPanel:SetHeight(h)
    npcPanel:ClearAllPoints()
    if (panel:GetBottom() or 0) - h - 6 > 10 then npcPanel:SetPoint("TOPLEFT", panel, "BOTTOMLEFT", 0, -6)
    else npcPanel:SetPoint("TOPLEFT", panel, "TOPRIGHT", 6, 0) end
    npcPanel:Show()
end

-- Fait défiler le panneau jusqu'à la carte de la quête et la fait briller. Faux si elle n'y est pas.
function ns.ScrollTo(qid)
    if not (panel and panel:IsShown() and shown) then return false end
    if not cardPos[qid] then
        if expandDone then return false end
        expandDone = true          -- peut-être dans les étapes terminées repliées
        ns.Refresh()
        if not cardPos[qid] then return false end
    end
    local top, h = cardPos[qid][1], cardPos[qid][2]
    if scroll.UpdateScrollChildRect then scroll:UpdateScrollChildRect() end
    local maxS = scroll:GetVerticalScrollRange() or 0
    scroll:SetVerticalScroll(math.max(0, math.min(maxS, -top - 22)))
    if not panel.flash then
        panel.flash = child:CreateTexture(nil, "OVERLAY"); panel.flash:SetTexture(FLAT)
        panel.flash:SetVertexColor(1, 0.82, 0.2, 0.25)
        local ag = panel.flash:CreateAnimationGroup()
        local a = ag:CreateAnimation("Alpha"); a:SetFromAlpha(1); a:SetToAlpha(0); a:SetDuration(0.9); a:SetStartDelay(0.15)
        ag:SetScript("OnFinished", function() panel.flash:Hide() end)
        panel.flash.ag = ag
    end
    panel.flash:ClearAllPoints(); panel.flash:SetPoint("TOPLEFT", CARD_X, top); panel.flash:SetSize(CARD_W, h)
    panel.flash:Show(); panel.flash.ag:Stop(); panel.flash.ag:Play()
    if panel.UpdateThumb then panel.UpdateThumb() end
    return true
end

function SelectedQuest()
    if C_QuestLog and C_QuestLog.GetSelectedQuest then
        local id = C_QuestLog.GetSelectedQuest()
        if id and id > 0 then return id end
    end
    if GetQuestLogSelection and GetQuestLogTitle then
        local i = GetQuestLogSelection()
        if i and i > 0 then return select(8, GetQuestLogTitle(i)) end
    end
end

-- Une erreur d'affichage s'écrit dans le chat (une fois par message) au lieu de disparaître en silence.
local reported = {}
local function report(err)
    err = tostring(err)
    if reported[err] then return end
    reported[err] = true
    print("|cffff6b5bFrères d'Épée, erreur Quest Chain :|r " .. err)
end
local function dbg(...) if ns.debugQC then print("|cff8a8a96[fdp]|r", ...) end end

-- Seul endroit qui décide de l'affichage : il regarde ce qui est ouvert à l'écran à cet instant.
-- override : quête choisie par toi (liste du PNJ, /fdp <id>), oubliée quand la fenêtre change de quête.
-- dismissed : quête dont tu as fermé le panneau, oubliée pareil ou par un nouveau clic dessus.
local override, baseId
local function hide()
    if panel then panel:Hide() end
    if npcPanel then npcPanel:Hide() end
    shown = nil
end
local function update(refresh)
    local host, id, src = Target()
    if id ~= baseId then baseId, override, dismissed = id, nil, nil end
    npcQuest = host == QuestFrame and id or nil
    if not ns.db.qcEnabled then return hide() end
    if override then host, id, src = host or UIParent, override, "choisie" end
    if not (host and id) then dbg("rien d'ouvert") return hide() end
    if dismissed == id then
        if refresh or GetTime() - lastClick > 0.5 then dbg(src, id, "fermé par toi") return hide() end
        dismissed = nil
    end
    local data = Build(id)
    if not data then dbg(src, id, "quête inconnue") return hide() end
    render(id, host, data, refresh)
    dbg(src, id, "affiché", data.first)
    npcListImpl()
end
local function safeUpdate(refresh) local ok, e = pcall(update, refresh); if not ok then hide(); report(e) end end -- pas de panneau à moitié dessiné

-- Plusieurs déclencheurs dans la même image : une seule mise à jour, à l'image suivante.
local pending
function ns.Update()
    if pending then return end
    pending = true
    C_Timer.After(0, function() pending = false; safeUpdate(false) end)
end
function ns.Refresh() safeUpdate(true) end -- tout de suite : ScrollTo lit les positions juste après
function ns.Show(id) override, dismissed = id, nil; ns.Update() end
function ns.Dismiss() dismissed = shown; override = nil; hide() end

local hooked = {}
local function Hook()
    -- journal moderne : l'ID de la quête cliquée, plus sûr que la sélection, pas toujours à jour à cet instant
    if not hooked.mapDetails and type(QuestMapFrame_ShowQuestDetails) == "function" then
        hooked.mapDetails = true
        hooksecurefunc("QuestMapFrame_ShowQuestDetails", ns.Update)
    end
    if not hooked.display and type(QuestInfo_Display) == "function" then
        hooked.display = true
        hooksecurefunc("QuestInfo_Display", ns.Update)
    end
    if not hooked.legacy and type(QuestLog_UpdateQuestDetails) == "function" then
        hooked.legacy = true
        hooksecurefunc("QuestLog_UpdateQuestDetails", ns.Update)
    end
    local details = QuestMapFrame and QuestMapFrame.DetailsFrame
    if details and not hooked.details then
        hooked.details = true
        details:HookScript("OnShow", ns.Update)
        details:HookScript("OnHide", ns.Update)
    end
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("ADDON_LOADED")
pcall(ev.RegisterEvent, ev, "GLOBAL_MOUSE_DOWN")
for _, e in ipairs({ "QUEST_DETAIL", "QUEST_PROGRESS", "QUEST_COMPLETE", "QUEST_FINISHED" }) do pcall(ev.RegisterEvent, ev, e) end
ev:SetScript("OnEvent", function(_, event)
    if event == "GLOBAL_MOUSE_DOWN" then lastClick = GetTime(); return end
    -- fenêtre de quête d'un PNJ : proposition, progression, rendu, fermeture
    if event == "QUEST_DETAIL" or event == "QUEST_PROGRESS" or event == "QUEST_COMPLETE" or event == "QUEST_FINISHED" then
        return ns.Update()
    end
    if event == "PLAYER_LOGIN" then
        local _, _, classId = UnitClass("player"); player.class = classId and 2 ^ (classId - 1)
        local _, _, raceId = UnitRace("player"); player.race = raceId and 2 ^ (raceId - 1)
    end
    Hook()
end)

-- /fdp <id>, /fdp duo, /fdp solo (appelé par Core.lua)
function ns.QuestChainCommand(msg)
    if msg == "duo" or msg == "solo" then
        ns.Profit.DB().duo = msg == "duo"
        print("Frères d'Épée : rentabilité calculée en " .. msg)
        ns.Refresh()
        return
    end
    if msg == "debug" then
        ns.debugQC = not ns.debugQC
        print("Frères d'Épée : debug Quest Chain " .. (ns.debugQC and "activé" or "désactivé"))
        return
    end
    local id = tonumber(msg)
    if not id then print("Frères d'Épée : /fdp, /fdp <id de quête>, /fdp duo, /fdp solo, /fdp debug") return end
    if not Build(id) then print("Frères d'Épée : quête " .. id .. " inconnue") return end
    ns.Show(id)
end

function ns.ResetQuestChainPos()
    ns.Profit.DB().pos = nil
    ns.Update()
end

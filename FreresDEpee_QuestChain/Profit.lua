local ns = FreresDEpee

-- Ce client range les fonctions d'objets dans C_Item ; les anciennes globales peuvent manquer.
local GetItemInfo = (C_Item and C_Item.GetItemInfo) or GetItemInfo

-- Rentabilité d'une quête :
--   * Estimate : XP/heure estimée (kills nécessaires, taux de loot, en solo ou en duo),
--     comparée au grind des mobs du même niveau ;
--   * Run : ton vrai passage (temps en jeu entre la prise et le rendu, XP gagnée, argent, butin).

local P = {}
ns.Profit = P

local MIN_PER_KILL = 0.5   -- ~30 s par mob (combat, loot, repos)
local MIN_PER_OBJECT = 0.25
local OVERHEAD = 3         -- trajet inconnu (positions absentes ou autre continent)
local TALK = 1             -- prendre et rendre la quête
local DETOUR = 1.3         -- on ne marche jamais en ligne droite
local RUN, MOUNT = 7, 11.2 -- yards par seconde, à pied et monté (+60 %)
local MOUNT_LEVEL = 40
local DEFAULT_RATE = 35    -- taux de loot inconnu
local DEFAULT_COUNT = 8    -- quantité inconnue (quête pas dans le journal)

local function DB()
    FreresDEpeeDB = FreresDEpeeDB or {}
    FreresDEpeeDB.questChain = FreresDEpeeDB.questChain or {}
    local d = FreresDEpeeDB.questChain
    d.runs = d.runs or {}; d.active = d.active or {}
    d.xpCounter = d.xpCounter or 0; d.lootCounter = d.lootCounter or 0
    if d.duo == nil then d.duo = true end
    return d
end
P.DB = DB

local function dbGet(kind, id, field)
    local db = _G.LibQuestieDB and _G.LibQuestieDB[kind]
    if not db or not db.Get then return nil end
    local ok, v = pcall(db.Get, id, field)
    return ok and v or nil
end

local DropDB
local rateCache = {}
local dropRateRaw
local function dropRate(itemId)
    if rateCache[itemId] == nil then rateCache[itemId] = dropRateRaw(itemId) or false end
    return rateCache[itemId] or nil
end
dropRateRaw = function(itemId)
    if DropDB == nil then
        DropDB = false
        if _G.QuestieLoader then
            local ok, m = pcall(QuestieLoader.ImportModule, QuestieLoader, "DropDB")
            if ok and m and m.GetItemDroprate then DropDB = m end
        end
    end
    local npcs = dbGet("Item", itemId, "npcDrops")
    if type(npcs) ~= "table" or #npcs == 0 then return nil end -- pas lâché par des mobs : objet à ramasser
    local rates = {}
    if DropDB then
        for i = 1, math.min(#npcs, 30) do
            local ok, r = pcall(DropDB.GetItemDroprate, itemId, npcs[i])
            local v = ok and type(r) == "table" and tonumber(r[1]) or (ok and tonumber(r))
            if v and v > 0 then rates[#rates + 1] = v end
        end
    end
    if #rates == 0 then return DEFAULT_RATE end
    table.sort(rates)
    return math.min(100, math.max(1, rates[math.ceil(#rates / 2)]))
end

-- Quantités tirées du texte de l'objectif quand la quête n'est pas dans le journal.
local function textCounts(id)
    local t = dbGet("Quest", id, "objectivesText")
    local nums = {}
    if type(t) == "table" then
        for n in table.concat(t, " "):gmatch("(%d+)") do
            n = tonumber(n)
            if n >= 2 and n <= 40 then nums[#nums + 1] = n end
        end
    end
    return nums
end

-- Objectifs : {kind = "monster"|"item"|"object", left = n, item = id?}
local function objectives(id)
    local list, fromLog = {}, false
    local obj = dbGet("Quest", id, "objectives") or {}
    local items = {}
    for _, it in ipairs(obj[3] or {}) do items[#items + 1] = it[1] end

    if C_QuestLog and C_QuestLog.GetQuestObjectives then
        local ok, lo = pcall(C_QuestLog.GetQuestObjectives, id)
        if ok and type(lo) == "table" and #lo > 0 then
            fromLog = true
            local used = {}
            for _, o in ipairs(lo) do
                local left = math.max(0, (o.numRequired or 1) - (o.numFulfilled or 0))
                local e = { kind = o.type == "item" and "item" or (o.type == "object" and "object" or "monster"), left = left }
                if e.kind == "item" then
                    for k, it in ipairs(items) do
                        local nm = GetItemInfo(it) or dbGet("Item", it, "name")
                        if not used[k] and nm and o.text and o.text:find(nm, 1, true) then e.item = it; used[k] = true; break end
                    end
                    if not e.item then
                        for k, it in ipairs(items) do if not used[k] then e.item = it; used[k] = true; break end end
                    end
                end
                if o.type ~= "event" and o.type ~= "reputation" then list[#list + 1] = e end
            end
            return list, fromLog
        end
    end
    local nums = textCounts(id)
    local i = 0
    local function count() i = i + 1; return nums[i] or (#nums == 1 and nums[1]) or DEFAULT_COUNT end
    for _ in ipairs(obj[1] or {}) do list[#list + 1] = { kind = "monster", left = count() } end
    for _ in ipairs(obj[2] or {}) do list[#list + 1] = { kind = "object", left = count() } end
    for _, it in ipairs(items) do list[#list + 1] = { kind = "item", left = count(), item = it } end
    return list, fromLog
end

-------------------------------------------------------------------------------- trajet
-- Positions de QuestieDB converties en coordonnées monde par HereBeDragons (fourni par Questie).
local HBD, ZoneDB
local function libs()
    if HBD == nil then HBD = (LibStub and LibStub("HereBeDragons-2.0", true)) or false end
    if ZoneDB == nil then
        ZoneDB = false
        if _G.QuestieLoader then
            local ok, m = pcall(QuestieLoader.ImportModule, QuestieLoader, "ZoneDB")
            if ok and m and m.GetUiMapIdByAreaId then ZoneDB = m end
        end
    end
    return HBD and ZoneDB
end

local mapOf = {}
local function points(spawns, out)
    if type(spawns) ~= "table" then return out end
    for area, list in pairs(spawns) do
        if mapOf[area] == nil then
            local ok, m = pcall(ZoneDB.GetUiMapIdByAreaId, ZoneDB, area)
            mapOf[area] = ok and m or false
        end
        local map = mapOf[area]
        if map and type(list) == "table" then
            for _, c in ipairs(list) do
                if c[1] and c[1] >= 0 then
                    local x, y, inst = HBD:GetWorldCoordinatesFromZone(c[1] / 100, c[2] / 100, map)
                    if x then out[#out + 1] = { x, y, inst } end
                end
            end
        end
    end
    return out
end
local function spawnsOf(kind, ids, out, max)
    for i, id in ipairs(ids or {}) do
        if max and i > max then break end
        points(dbGet(kind, id, "spawns"), out)
    end
    return out
end

local function nearest(from, pts)
    local best, bd
    for _, p in ipairs(pts) do
        if p[3] == from[3] then
            local dx, dy = p[1] - from[1], p[2] - from[2]
            local d = dx * dx + dy * dy
            if not bd or d < bd then best, bd = p, d end
        end
    end
    return best, bd and math.sqrt(bd)
end

-- Lieux à visiter : une liste de points par objectif (on va au plus proche de chacun).
local function stops(id)
    local obj = dbGet("Quest", id, "objectives") or {}
    local list = {}
    local function add(pts) if #pts > 0 then list[#list + 1] = pts end end
    for _, o in ipairs(obj[1] or {}) do add(spawnsOf("Npc", { o[1] }, {})) end
    for _, o in ipairs(obj[2] or {}) do add(spawnsOf("Object", { o[1] }, {})) end
    for _, o in ipairs(obj[3] or {}) do
        local pts = spawnsOf("Npc", dbGet("Item", o[1], "npcDrops"), {}, 30)
        add(spawnsOf("Object", dbGet("Item", o[1], "objectDrops"), pts, 30))
    end
    local trig = dbGet("Quest", id, "triggerEnd")
    if type(trig) == "table" then add(points(trig[2], {})) end
    return list
end

-- Minutes de trajet : départ, chaque objectif au plus proche, puis celui qui rend la quête.
-- Depuis ta position si la quête est dans le journal (objectifs finis : seulement le retour).
local placeCache = {} -- positions par quête, calculées une fois
local function places(id)
    if not placeCache[id] then
        local sb = dbGet("Quest", id, "startedBy") or {}
        local fb = dbGet("Quest", id, "finishedBy") or {}
        placeCache[id] = {
            start = spawnsOf("Object", sb[2], spawnsOf("Npc", sb[1], {}))[1],
            stops = stops(id),
            finish = spawnsOf("Object", fb[2], spawnsOf("Npc", fb[1], {})),
        }
    end
    return placeCache[id]
end

local function travel(id, fromPlayer, allDone)
    if not libs() then return nil end
    local pl = places(id)
    local cur = pl.start
    if fromPlayer then
        local x, y, inst = HBD:GetPlayerWorldPosition()
        cur = x and { x, y, inst }
    end
    local route = {}
    if not allDone then for i, pts in ipairs(pl.stops) do route[i] = pts end end
    route[#route + 1] = pl.finish
    cur = cur or route[1][1]
    if not cur then return nil end
    local yards = 0
    for _, pts in ipairs(route) do
        local p, d = nearest(cur, pts)
        if p then yards = yards + d; cur = p
        elseif #pts > 0 then return nil end -- autre continent
    end
    local speed = (UnitLevel("player") >= MOUNT_LEVEL and MOUNT or RUN) * 60
    return yards * DETOUR / speed
end

local function mobXP(level) return 45 + 5 * math.max(1, level or UnitLevel("player")) end

-- Estimation pour une quête pas encore rendue.
function P.Estimate(id, q, questXP)
    local players = DB().duo and 2 or 1
    local list, fromLog = objectives(id)
    local kills, objects, pickup = 0, 0, false
    for _, o in ipairs(list) do
        if o.kind == "monster" then kills = kills + o.left
        elseif o.kind == "object" then objects = objects + o.left
        else
            local rate = o.item and dropRate(o.item)
            if rate then kills = kills + math.ceil(players * o.left * 100 / rate)
            else objects = objects + o.left; pickup = true end
        end
    end
    local ok, trip = pcall(travel, id, fromLog, fromLog and kills + objects == 0)
    trip = ok and trip or nil
    local minutes = (trip and trip + TALK or OVERHEAD) + kills * MIN_PER_KILL + objects * MIN_PER_OBJECT * players
    local m = mobXP(q.level)
    local xp = (questXP or 0) + kills * m / players
    local xph = xp / minutes * 60
    local grind = 60 / MIN_PER_KILL * mobXP(UnitLevel("player")) -- grind seul ou à deux : même XP/h par joueur
    local ratio = xph / grind
    local label, color, short
    if ratio >= 2 then label, color, short = "Excellente", "|cff33ff99", "TOP"
    elseif ratio >= 1.4 then label, color, short = "Bonne", "|cff9de05f", "BON"
    elseif ratio >= 1 then label, color, short = "Correcte", "|cffffd100", "OK"
    else label, color, short = "Mieux vaut grind", "|cffff6b5b", "BOF" end
    return { xph = xph, minutes = minutes, kills = kills, objects = objects, ratio = ratio, label = label, color = color, short = short,
        exact = fromLog, players = players, pickup = pickup, trip = trip }
end

function P.Run(id) return DB().runs[id] end

-------------------------------------------------------------------------------- chrono
-- Temps passé en jeu entre la prise et le rendu (pas pendant la déconnexion), sans rien à faire.
-- XP, argent et butin sont comptés sur les mêmes périodes ; la récompense de rendu est ajoutée à la fin.
local live = {} -- id -> compteurs au début de la période en cours (en mémoire seulement)
local lastXP, lastMax, lastLevel
local function xpSnapshot() lastXP, lastMax, lastLevel = UnitXP("player"), UnitXPMax("player"), UnitLevel("player") end

local function start(id)
    local d = DB()
    live[id] = { t = GetTime(), xp = d.xpCounter, money = GetMoney(), loot = d.lootCounter }
end
local function stop(id)
    local s, a, d = live[id], DB().active[id], DB()
    live[id] = nil
    if not (s and a) then return end
    a.spent = a.spent + (GetTime() - s.t)
    a.xp = a.xp + (d.xpCounter - s.xp)
    a.money = a.money + (GetMoney() - s.money)
    a.loot = a.loot + (d.lootCounter - s.loot)
end
local function sync()
    local d = DB()
    for id in pairs(d.active) do if not live[id] then start(id) end end
    for id in pairs(live) do if not d.active[id] then live[id] = nil end end
end

local SELF = {}
local ev = CreateFrame("Frame")
for _, e in ipairs({ "PLAYER_LOGIN", "PLAYER_LOGOUT", "PLAYER_XP_UPDATE", "QUEST_ACCEPTED", "QUEST_TURNED_IN", "QUEST_REMOVED",
    "CHAT_MSG_LOOT" }) do
    pcall(ev.RegisterEvent, ev, e)
end
ev:SetScript("OnEvent", function(_, event, a1, a2, a3)
    local d = DB()
    if event == "PLAYER_LOGIN" then
        xpSnapshot()
        for _, g in ipairs({ LOOT_ITEM_SELF, LOOT_ITEM_SELF_MULTIPLE, LOOT_ITEM_PUSHED_SELF, LOOT_ITEM_PUSHED_SELF_MULTIPLE }) do
            if type(g) == "string" then SELF[#SELF + 1] = g:match("^(.-)%%") end
        end
        -- ancien format (heure de départ) : on repart de zéro
        for id, a in pairs(d.active) do
            if a.spent == nil then d.active[id] = { spent = 0, xp = 0, money = 0, loot = 0 } end
        end
        sync()
    elseif event == "PLAYER_LOGOUT" then
        for id in pairs(live) do stop(id) end
    elseif event == "PLAYER_XP_UPDATE" then
        local xp, lvl = UnitXP("player"), UnitLevel("player")
        if lastXP then
            local delta = (lvl > lastLevel) and (lastMax - lastXP + xp) or (xp - lastXP)
            if delta > 0 then d.xpCounter = d.xpCounter + delta end
        end
        xpSnapshot()
    elseif event == "CHAT_MSG_LOOT" then
        local msg = a1 or ""
        local mine = false
        for _, p in ipairs(SELF) do if p ~= "" and msg:sub(1, #p) == p then mine = true break end end
        if not mine then return end
        local link = msg:match("|c%x+|Hitem:.-|h.-|h|r")
        local n = tonumber(msg:match("|rx(%d+)") or msg:match("x(%d+)%s*%.?$")) or 1
        local price = link and select(11, GetItemInfo(link))
        if price and price > 0 then d.lootCounter = d.lootCounter + price * n end
    elseif event == "QUEST_ACCEPTED" then
        local id = a2 or a1 -- (index, id) sur les clients classiques, (id) sur les récents
        if a2 == nil and GetQuestLogTitle and a1 and a1 < 100 then id = select(8, GetQuestLogTitle(a1)) end
        if id and id > 0 then
            d.active[id] = { spent = 0, xp = 0, money = 0, loot = 0 }
            sync()
        end
    elseif event == "QUEST_TURNED_IN" then
        local id, xpR, moneyR = a1, a2 or 0, a3 or 0
        local a = id and d.active[id]
        if not a then return end
        local wasLive = live[id] ~= nil
        stop(id); d.active[id] = nil
        -- la récompense arrive avant ou après cet événement selon le client : on regarde une seconde plus tard
        local xp0, money0 = d.xpCounter, GetMoney()
        C_Timer.After(1, function()
            local xpAfter = d.xpCounter - xp0 >= xpR * 0.9
            local moneyAfter = GetMoney() - money0 >= moneyR
            -- arrivée avant et chrono actif : déjà comptée dans la période
            local xp = a.xp + ((wasLive and not xpAfter) and 0 or xpR)
            local money = a.money + ((wasLive and not moneyAfter) and 0 or moneyR)
            d.runs[id] = { min = a.spent / 60, xp = xp, money = money, loot = a.loot, when = time(), duo = d.duo }
            if ns.OnRun then ns.OnRun(id) end
        end)
    elseif event == "QUEST_REMOVED" then
        local id = a1
        -- QUEST_REMOVED arrive aussi au rendu : on ne garde que les abandons, une seconde plus tard
        if id and d.active[id] then
            C_Timer.After(1, function()
                if d.active[id] and not (C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted and C_QuestLog.IsQuestFlaggedCompleted(id))
                    and not ((C_QuestLog and C_QuestLog.GetLogIndexForQuestID and C_QuestLog.GetLogIndexForQuestID(id))) then
                    live[id] = nil
                    d.active[id] = nil
                end
            end)
        end
    end
end)

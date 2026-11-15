-- Frères d'Épée : hub QOL. Automatisations (ce fichier) et Quest Chain (QuestChain.lua, Profit.lua, Data.lua).
-- Maintenir Maj (Shift) suspend toutes les automatisations le temps de l'interaction.
-- /fdp ouvre la fenêtre d'options ; /fdp <id>, /fdp duo, /fdp solo pilotent Quest Chain.

local _, ns = ...

local DEFAULTS = {
    sellJunk = true, repair = true, guildRepair = false, summary = true,
    questAccept = false, questTurnIn = false, acceptRes = true,
    qcEnabled = true, qcNpc = true, qcLog = true,
}

local TABS = { -- onglets de la fenêtre et leurs cases, dans l'ordre d'affichage
    { "Auto", {
        { "sellJunk", "Vendre les objets gris" },
        { "repair", "Réparer l'équipement" },
        { "guildRepair", "Avec la banque de guilde", indent = true },
        { "acceptRes", "Accepter les résurrections hors combat" },
        { "summary", "Bilan dans le chat" },
        { "questAccept", "Accepter les quêtes" },
        { "questTurnIn", "Rendre les quêtes terminées" },
    } },
    { "Quest Chain", {
        { "qcEnabled", "Afficher le panneau Quest Chain" },
        { "qcNpc", "À côté de la fenêtre du PNJ", indent = true },
        { "qcLog", "À côté du journal de quêtes", indent = true },
        { "duo", "Rentabilité calculée en duo", tbl = function() return ns.Profit.DB() end },
        { button = "Réinitialiser la position", run = function() ns.ResetQuestChainPos() end },
    } },
}

local db
local function say(msg) if db.summary then print("|cffffd100Frères d'Épée|r " .. msg) end end
local function money(c) return C_CurrencyInfo.GetCoinText(c) end
local function paused() return IsShiftKeyDown() end

-- Marchand ----------------------------------------------------------------

local sellTicker

local function stopSelling()
    if sellTicker then sellTicker:Cancel(); sellTicker = nil end
end

local function sellJunk()
    local items, total = {}, 0
    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local info = C_Container.GetContainerItemInfo(bag, slot)
            if info and info.quality == Enum.ItemQuality.Poor and not info.hasNoValue then
                local price = select(11, C_Item.GetItemInfo(info.itemID)) or 0
                if price > 0 then
                    items[#items + 1] = { bag, slot }
                    total = total + price * info.stackCount
                end
            end
        end
    end
    if #items == 0 then return end
    -- Un objet tous les 0,1 s : vendre tout d'un coup en fait sauter une partie.
    local i = 0
    sellTicker = C_Timer.NewTicker(0.1, function()
        i = i + 1
        if not MerchantFrame:IsShown() then return stopSelling() end
        -- l'emplacement a pu changer depuis la liste (objet déplacé) : on ne vend que s'il est encore gris
        local info = C_Container.GetContainerItemInfo(items[i][1], items[i][2])
        if info and info.quality == Enum.ItemQuality.Poor then C_Container.UseContainerItem(items[i][1], items[i][2]) end
        if i == #items then
            sellTicker = nil
            say("Gris vendus pour " .. money(total) .. ".")
        end
    end, #items)
end

local function repair()
    if not CanMerchantRepair() then return end
    local cost, canRepair = GetRepairAllCost()
    if not canRepair or cost == 0 then return end
    if db.guildRepair and IsInGuild() and CanGuildBankRepair() then
        RepairAllItems(true) -- fonds de guilde, puis le reste sur l'or perso si la limite est atteinte
    end
    RepairAllItems()
    say("Réparé pour " .. money(cost) .. ".")
end

-- Quêtes ------------------------------------------------------------------

local function onQuestEvent(event, arg1)
    if event == "QUEST_DETAIL" and db.questAccept then
        if QuestGetAutoAccept() then CloseQuest() else AcceptQuest() end
    elseif event == "QUEST_ACCEPT_CONFIRM" and db.questAccept then
        ConfirmAcceptQuest()
        StaticPopup_Hide("QUEST_ACCEPT")
    elseif event == "QUEST_PROGRESS" and db.questTurnIn then
        if IsQuestCompletable() and not QuestRequiresGold() then CompleteQuest() end
    elseif event == "QUEST_COMPLETE" and db.questTurnIn then
        if GetNumQuestChoices() <= 1 then GetQuestReward(GetNumQuestChoices()) end
    elseif event == "QUEST_GREETING" then
        if db.questTurnIn then
            for i = 1, GetNumActiveQuests() do
                if select(2, GetActiveTitle(i)) then return SelectActiveQuest(i) end
            end
        end
        if db.questAccept and GetNumAvailableQuests() > 0 then SelectAvailableQuest(1) end
    elseif event == "GOSSIP_SHOW" then
        if db.questTurnIn then
            for _, q in ipairs(C_GossipInfo.GetActiveQuests()) do
                if q.isComplete then return C_GossipInfo.SelectActiveQuest(q.questID) end
            end
        end
        if db.questAccept then
            local q = C_GossipInfo.GetAvailableQuests()[1]
            if q then C_GossipInfo.SelectAvailableQuest(q.questID) end
        end
    end
end

-- Événements --------------------------------------------------------------

local f = CreateFrame("Frame")
for _, e in ipairs({ "ADDON_LOADED", "MERCHANT_SHOW", "MERCHANT_CLOSED", "RESURRECT_REQUEST",
    "QUEST_DETAIL", "QUEST_ACCEPT_CONFIRM", "QUEST_PROGRESS", "QUEST_COMPLETE", "QUEST_GREETING", "GOSSIP_SHOW" }) do
    f:RegisterEvent(e)
end

f:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 ~= "FreresDEpee" then return end
        FreresDEpeeDB = FreresDEpeeDB or {}
        db = FreresDEpeeDB
        ns.db = db
        for k, v in pairs(DEFAULTS) do if db[k] == nil then db[k] = v end end
        f:UnregisterEvent("ADDON_LOADED")
    elseif event == "MERCHANT_CLOSED" then
        stopSelling()
    elseif paused() then
        return
    elseif event == "MERCHANT_SHOW" then
        if db.sellJunk then sellJunk() end
        if db.repair then repair() end
    elseif event == "RESURRECT_REQUEST" then
        if db.acceptRes and not UnitAffectingCombat(arg1) then
            AcceptResurrect()
            StaticPopup_Hide("RESURRECT_NO_TIMER")
        end
    else
        onQuestEvent(event, arg1)
    end
end)

-- Fenêtre d'options (/fdp) -------------------------------------------------
-- Construite au premier /fdp. Déplaçable, Échap la ferme.

local win

-- Même style que le panneau Quest Chain : fond sombre plat, bordure et accents dorés.
local FLAT = "Interface\\Buttons\\WHITE8x8"
local C = {
    bg = { 0.05, 0.05, 0.07, 0.96 }, border = { 0.85, 0.65, 0.25, 0.55 }, header = { 0.11, 0.09, 0.06, 1 },
    accent = { 1, 0.82, 0.2 }, kicker = { 0.85, 0.65, 0.25 }, muted = { 0.54, 0.54, 0.59 },
}
local W, HEAD, TABH, ROW, PAD = 320, 52, 26, 26, 12

local function tex(parent, layer, color, a)
    local t = parent:CreateTexture(nil, layer)
    t:SetTexture(FLAT); t:SetVertexColor(color[1], color[2], color[3], a or color[4] or 1)
    return t
end

local function flatFrame(f, bg, border)
    if not f.SetBackdrop then Mixin(f, BackdropTemplateMixin) end
    f:SetBackdrop({ bgFile = FLAT, edgeFile = FLAT, edgeSize = 1 })
    f:SetBackdropColor(unpack(bg)); f:SetBackdropBorderColor(unpack(border))
end

-- Ligne cliquable : case plate + libellé.
local function checkRow(page, y, opt)
    local key, tbl = opt[1], opt.tbl or function() return db end
    local row = CreateFrame("Button", nil, page)
    row:SetPoint("TOPLEFT", 0, y); row:SetPoint("RIGHT"); row:SetHeight(ROW - 2)
    local hl = tex(row, "BACKGROUND", { 1, 1, 1 }, 0.05); hl:SetAllPoints(); hl:Hide()
    local box = CreateFrame("Frame", nil, row, "BackdropTemplate")
    box:SetSize(14, 14); box:SetPoint("LEFT", opt.indent and 24 or 6, 0)
    flatFrame(box, { 0, 0, 0, 0.5 }, C.border)
    local mark = tex(box, "ARTWORK", C.accent); mark:SetPoint("TOPLEFT", 3, -3); mark:SetPoint("BOTTOMRIGHT", -3, 3)
    local label = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("LEFT", box, "RIGHT", 8, 0); label:SetText(opt[2])
    local function refresh() mark:SetShown(tbl()[key] and true or false) end
    row:SetScript("OnShow", refresh)
    row:SetScript("OnEnter", function() hl:Show() end)
    row:SetScript("OnLeave", function() hl:Hide() end)
    row:SetScript("OnClick", function() tbl()[key] = not tbl()[key]; refresh(); if ns.Update then ns.Update() end end)
    refresh()
end

local function actionRow(page, y, opt)
    local b = CreateFrame("Button", nil, page, "BackdropTemplate")
    b:SetSize(190, ROW - 6); b:SetPoint("TOPLEFT", 6, y - 4)
    flatFrame(b, { 1, 0.82, 0.2, 0.08 }, C.border)
    local t = b:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"); t:SetPoint("CENTER"); t:SetText(opt.button)
    b:SetScript("OnEnter", function() b:SetBackdropColor(1, 0.82, 0.2, 0.18) end)
    b:SetScript("OnLeave", function() b:SetBackdropColor(1, 0.82, 0.2, 0.08) end)
    b:SetScript("OnClick", opt.run)
end

local function buildWindow()
    local rows = 0
    for _, tab in ipairs(TABS) do rows = math.max(rows, #tab[2]) end

    win = CreateFrame("Frame", "FreresDEpeeFrame", UIParent, "BackdropTemplate")
    win:SetSize(W, HEAD + TABH + PAD + rows * ROW + 30)
    win:SetPoint("CENTER")
    win:SetFrameStrata("HIGH")
    win:SetClampedToScreen(true)
    win:SetMovable(true)
    flatFrame(win, C.bg, C.border)
    tinsert(UISpecialFrames, "FreresDEpeeFrame")

    -- en-tête déplaçable
    local head = CreateFrame("Frame", nil, win)
    head:SetPoint("TOPLEFT", 1, -1); head:SetPoint("TOPRIGHT", -1, -1); head:SetHeight(HEAD)
    tex(head, "BACKGROUND", C.header):SetAllPoints()
    local shine = tex(head, "BORDER", { 1, 0.85, 0.4 }, 0.04); shine:SetPoint("TOPLEFT"); shine:SetPoint("TOPRIGHT"); shine:SetHeight(HEAD / 2)
    local line = tex(head, "ARTWORK", C.border); line:SetPoint("BOTTOMLEFT"); line:SetPoint("BOTTOMRIGHT"); line:SetHeight(1)
    local kicker = head:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    kicker:SetPoint("TOPLEFT", PAD, -9); kicker:SetText("FRÈRES D'ÉPÉE"); kicker:SetTextColor(unpack(C.kicker))
    local title = head:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOPLEFT", PAD, -23); title:SetText("Options")
    head:EnableMouse(true); head:RegisterForDrag("LeftButton")
    head:SetScript("OnDragStart", function() win:StartMoving() end)
    head:SetScript("OnDragStop", function() win:StopMovingOrSizing() end)
    local close = CreateFrame("Button", nil, win, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", 1, 1); close:SetScale(0.8); close:SetFrameLevel(head:GetFrameLevel() + 5)

    -- onglets : texte doré et soulignement pour l'actif
    local tabs, pages = {}, {}
    local tabW = (W - 2) / #TABS
    local function show(n)
        for i, t in ipairs(tabs) do
            local on = i == n
            pages[i]:SetShown(on); t.under:SetShown(on)
            t.label:SetTextColor(unpack(on and C.accent or C.muted))
        end
    end
    local tline = tex(win, "ARTWORK", C.border, 0.25)
    tline:SetPoint("TOPLEFT", 1, -HEAD - TABH); tline:SetPoint("TOPRIGHT", -1, -HEAD - TABH); tline:SetHeight(1)

    for i, tab in ipairs(TABS) do
        local t = CreateFrame("Button", nil, win)
        t:SetSize(tabW, TABH); t:SetPoint("TOPLEFT", 1 + (i - 1) * tabW, -HEAD)
        local hl = tex(t, "BACKGROUND", { 1, 1, 1 }, 0.04); hl:SetAllPoints(); hl:Hide()
        t.label = t:CreateFontString(nil, "OVERLAY", "GameFontNormal"); t.label:SetPoint("CENTER"); t.label:SetText(tab[1])
        t.under = tex(t, "OVERLAY", C.accent); t.under:SetPoint("BOTTOMLEFT", 10, 0); t.under:SetPoint("BOTTOMRIGHT", -10, 0); t.under:SetHeight(2)
        t:SetScript("OnEnter", function() hl:Show() end)
        t:SetScript("OnLeave", function() hl:Hide() end)
        t:SetScript("OnClick", function() show(i) end)
        tabs[i] = t

        local page = CreateFrame("Frame", nil, win)
        page:SetPoint("TOPLEFT", PAD - 4, -HEAD - TABH - PAD / 2)
        page:SetPoint("BOTTOMRIGHT", -PAD + 4, 28)
        pages[i] = page
        for j, opt in ipairs(tab[2]) do
            local y = -(j - 1) * ROW
            if opt.button then actionRow(page, y, opt) else checkRow(page, y, opt) end
        end
    end

    local hint = win:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    hint:SetPoint("BOTTOMLEFT", PAD, 10)
    hint:SetText("Maj (Shift) enfoncé : rien d'automatique")
    show(1)
end

SLASH_FRERESDEPEE1 = "/fdp"
SlashCmdList.FRERESDEPEE = function(msg)
    msg = strtrim(msg or ""):lower()
    if msg ~= "" then return ns.QuestChainCommand(msg) end
    if not win then buildWindow() return end
    win:SetShown(not win:IsShown())
end

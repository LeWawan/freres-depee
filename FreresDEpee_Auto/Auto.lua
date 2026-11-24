-- Frères d'Épée - Auto : vend les gris, répare, accepte quêtes et résurrections.
-- Maintenir Maj (Shift) suspend toutes les automatisations le temps de l'interaction.

local ns = FreresDEpee

local db = ns.Register("FreresDEpee_Auto", {
    defaults = {
        sellJunk = true, repair = true, guildRepair = false, summary = true,
        questAccept = false, questTurnIn = false, acceptRes = true,
    },
    rows = {
        { "sellJunk", "Vendre les objets gris" },
        { "repair", "Réparer l'équipement" },
        { "guildRepair", "Avec la banque de guilde", indent = true },
        { "acceptRes", "Accepter les résurrections hors combat" },
        { "summary", "Bilan dans le chat" },
        { "questAccept", "Accepter les quêtes" },
        { "questTurnIn", "Rendre les quêtes terminées" },
        { note = "Maj (Shift) enfoncé : rien d'automatique" },
    },
})

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
for _, e in ipairs({ "MERCHANT_SHOW", "MERCHANT_CLOSED", "RESURRECT_REQUEST",
    "QUEST_DETAIL", "QUEST_ACCEPT_CONFIRM", "QUEST_PROGRESS", "QUEST_COMPLETE", "QUEST_GREETING", "GOSSIP_SHOW" }) do
    f:RegisterEvent(e)
end

f:SetScript("OnEvent", function(_, event, arg1)
    if event == "MERCHANT_CLOSED" then
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

-- Test de fumée hors du jeu : charge l'addon dans une fausse API WoW et déroule le cycle du panneau
-- Quest Chain (PNJ ouvert, quête choisie, rafraîchissement, PNJ fermé).
-- Lancer depuis la racine du dépôt : lua5.1 tests/smoke.lua .

local root = arg[1] or "."

---------------------------------------------------------------- fausse API

-- Cadre factice : accepte n'importe quelle méthode, renvoie des nombres plausibles pour les mesures.
local NUMBERS = {
    GetHeight = 500, GetWidth = 500, GetEffectiveScale = 1, GetScale = 1, GetBottom = 500, GetTop = 100,
    GetLeft = 100, GetRight = 600, GetVerticalScroll = 0, GetVerticalScrollRange = 500, GetFrameLevel = 1,
    GetStringHeight = 12, GetStringWidth = 100,
}
local function Frame()
    local f = { visible = false, scripts = {} }
    function f:Show() self.visible = true end
    function f:Hide() self.visible = false end
    function f:SetShown(v) self.visible = v and true or false end
    function f:IsShown() return self.visible end
    function f:IsVisible() return self.visible end
    function f:SetScript(k, fn) self.scripts[k] = fn end
    function f:GetFrameStrata() return "MEDIUM" end
    function f:GetHitRectInsets() return 0, 0, 0, 0 end
    return setmetatable(f, { __index = function(_, k)
        if NUMBERS[k] then return function() return NUMBERS[k] end end
        return function() return Frame() end
    end })
end

local frames = {}
CreateFrame = function() local f = Frame(); frames[#frames + 1] = f; return f end

local timers = {}
C_Timer = {
    After = function(_, fn) timers[#timers + 1] = fn end,
    NewTicker = function() return { Cancel = function() end } end,
}
local function flush() while #timers > 0 do table.remove(timers, 1)() end end

-- Faux QuestieDB : une suite de deux quêtes chez un PNJ.
local QDB = {
    Quest = {
        [58] = { name = "The Night Watch", questLevel = 14, requiredLevel = 10, startedBy = { { 264 } },
                 reputationReward = { { 72, 250 } }, nextQuestInChain = 59 },
        [59] = { name = "The Night Watch II", questLevel = 16, requiredLevel = 10, startedBy = { { 264 } },
                 preQuestSingle = { 58 } },
    },
    Npc = { [264] = { name = "Commander Althea", spawns = { [10] = { { 73.6, 46.8 } } } } },
}
local function tableOf(kind)
    return { Get = function(id, field) local r = QDB[kind] and QDB[kind][id]; return r and r[field] end }
end
LibQuestieDB = { Quest = tableOf("Quest"), Npc = tableOf("Npc"), Object = tableOf("Object"), Item = tableOf("Item") }

QuestFrame = Frame()
UIParent, WorldMapFrame, GameTooltip = Frame(), Frame(), Frame()
Enum = { ItemQuality = { Poor = 0 } }
BackdropTemplateMixin, UISpecialFrames, SlashCmdList = {}, {}, {}
GetTime = function() return 100 end
GetQuestID = function() return 58 end
GetQuestDifficultyColor = function() return { r = 1, g = 1, b = 1 } end
UnitClass = function() return "Guerrier", "WARRIOR", 1 end
UnitRace = function() return "Troll", "Troll", 8 end
UnitLevel = function() return 30 end
BreakUpLargeNumbers, strtrim = tostring, function(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

-- Toute autre fonction globale ou espace C_* renvoie nil : le code doit le supporter.
local nilspace = setmetatable({}, { __index = function() return function() return nil end end })
local NIL = { FreresDEpeeDB = true, QuestieLoader = true, QuestMapFrame = true,
    QuestLogExFrame = true, ClassicQuestLog = true, QuestLogFrame = true }
setmetatable(_G, { __index = function(_, k)
    if NIL[k] then return nil end
    if k:match("^C_") then return nilspace end
    return function() return nil end
end })

---------------------------------------------------------------- chargement

local toc = assert(io.open(root .. "/FreresDEpee.toc")):read("*a")
local ns = {}
for file in toc:gmatch("\n([%w_]+%.lua)") do
    assert(loadfile(root .. "/" .. file))("FreresDEpee", ns)
end
local function fire(event, ...)
    for _, f in ipairs(frames) do
        local h = f.scripts.OnEvent
        if h then h(f, event, ...) end
    end
end
fire("ADDON_LOADED", "FreresDEpee")
fire("PLAYER_LOGIN")

---------------------------------------------------------------- scénario

local log = {}
print = function(...) log[#log + 1] = table.concat({ ... }, " ") end
ns.debugQC = true

local function expect(step, pattern)
    local last = log[#log] or ""
    if not last:find(pattern, 1, true) then
        io.stderr:write(("ÉCHEC %s : attendu « %s », obtenu « %s »\n"):format(step, pattern, last))
        os.exit(1)
    end
    io.stdout:write("ok   ", step, "\n")
end

QuestFrame.visible = true
ns.Update(); flush()
expect("PNJ ouvert", "PNJ 58 affiché The Night Watch")

ns.Show(59); flush()
expect("quête choisie dans la liste", "choisie 59 affiché The Night Watch")

ns.Refresh()
expect("rafraîchissement", "choisie 59 affiché")

QuestFrame.visible = false
ns.Update(); flush()
expect("PNJ fermé", "rien d'ouvert")

for _, l in ipairs(log) do
    if l:find("erreur", 1, true) then io.stderr:write("ÉCHEC erreur Lua : ", l, "\n"); os.exit(1) end
end
io.stdout:write("tout est bon\n")

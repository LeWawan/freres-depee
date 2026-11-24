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

-- Le noyau, puis chaque module (FreresDEpee_*) comme le jeu : ils partagent le global FreresDEpee.
-- Les fichiers dans un sous-dossier (guides/) sont sautés : RestedXP n'est pas simulé.
-- Comme le jeu : ADDON_LOADED de chaque addon juste après ses fichiers, avant le module suivant.
local ns = {}
local function fire(event, ...)
    for _, f in ipairs(frames) do
        local h = f.scripts.OnEvent
        if h then h(f, event, ...) end
    end
end
local function loadToc(dir, name)
    local toc = assert(io.open(root .. dir .. name .. ".toc")):read("*a")
    for file in toc:gmatch("\n([%w_]+%.lua)") do
        assert(loadfile(root .. dir .. file))(name, ns)
    end
    fire("ADDON_LOADED", name)
end
loadToc("/", "FreresDEpee")
for _, m in ipairs({ "FreresDEpee_Auto", "FreresDEpee_QuestChain", "FreresDEpee_Macros", "FreresDEpee_Guides" }) do
    loadToc("/" .. m .. "/", m)
end
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

-- Macros : un pack s'importe sans jeton restant.
local created = {}
GetMacroIndexByName = function() return 0 end
CreateMacro = function(name, _, body) created[#created + 1] = body; return 1 end
InCombatLockdown = function() return false end
C_Spell = { GetSpellName = function(id) return "Sort" .. id end }
C_Item = setmetatable({ GetItemSubClassInfo = function() return "Boucliers" end }, { __index = nilspace })
ns.ImportMacros(ns.MacroPacks.WARRIOR[2][2], { dps = "DPS Fast", tank = "Tank" })
expect("import d'un pack de macros", "4 créée(s)")
for _, body in ipairs(created) do
    if body:find("{", 1, true) then io.stderr:write("ÉCHEC jeton non remplacé : ", body, "\n"); os.exit(1) end
end
if not created[1]:find("/equipset [equipped:Boucliers] DPS Fast", 1, true) then
    io.stderr:write("ÉCHEC variable {dps} : ", created[1], "\n"); os.exit(1)
end
ns.ImportMacros("### Test\n/equipset {pvp}", {})
expect("variable sans valeur refusée", "non importée : Test ({pvp} sans valeur)")
ns.AskImportMacros(ns.MacroPacks.WARRIOR[1][2]) -- défauts connus, rien d'écrasé : import direct
expect("import direct sans formulaire", "3 créée(s)")
if not created[#created]:find("/equipset tank", 1, true) then
    io.stderr:write("ÉCHEC défaut de {tank} : ", created[#created], "\n"); os.exit(1)
end
GetMacroIndexByName = function() return 1 end
ns.AskImportMacros(ns.MacroPacks.WARRIOR[1][2]) -- remplace des macros : ouvre le formulaire
io.stdout:write("ok   formulaire des variables\n")

-- Fenêtres : /fdp (modules à gauche) et /fdp macros se construisent sans erreur.
SlashCmdList.FRERESDEPEE("")
SlashCmdList.FRERESDEPEE("macros")
io.stdout:write("ok   fenêtres /fdp et /fdp macros\n")

for _, l in ipairs(log) do
    if l:find("erreur", 1, true) then io.stderr:write("ÉCHEC erreur Lua : ", l, "\n"); os.exit(1) end
end
io.stdout:write("tout est bon\n")

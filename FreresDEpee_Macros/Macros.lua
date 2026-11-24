-- Frères d'Épée - Macros : import et export de macros en texte (/fdp macros).
-- Format décrit en tête de Packs.lua. Les variables {nom} sont libres : à l'import, un formulaire
-- demande leur valeur (pré-remplie avec la dernière utilisée, sinon celle du @var) et la retient.
-- Il ne s'ouvre que s'il manque une valeur ou si l'import remplace des macros existantes.
-- Une macro du même nom est réécrite (elle reste où elle est et garde son icône), sinon elle est
-- créée dans l'onglet personnage ou compte selon le réglage.

local ns = FreresDEpee
local BUILTIN = { shields = true } -- {nom} réservés, traduits par l'addon

local function say(msg) print("|cffffd100Frères d'Épée|r " .. msg) end

local function saved()
    local db = ns.DB()
    db.macroVars = db.macroVars or {}
    return db.macroVars
end

local function spellName(id)
    if not id then return end
    if C_Spell and C_Spell.GetSpellName then return C_Spell.GetSpellName(id) end
    return GetSpellInfo and (GetSpellInfo(id))
end

local function shields() -- Armure (4) / Boucliers (6), traduit par le client
    local get = (C_Item and C_Item.GetItemSubClassInfo) or GetItemSubClassInfo
    return get and get(4, 6)
end

-- Remplace les jetons ; ceux qu'on ne sait pas traduire restent et sont listés dans missing.
local function expand(body, values, missing)
    return (body:gsub("{(%w+)(:?)(%w*)}", function(name, colon, arg)
        local v
        if colon == ":" then
            if name == "spell" then v = spellName(tonumber(arg)) end
        elseif name == "shields" then v = shields()
        else v = values[name] end
        if v and v ~= "" then return v end
        missing[#missing + 1] = "{" .. name .. colon .. arg .. "}"
    end))
end

-- Renvoie les macros { name, body } et les variables déclarées { name, default, desc }.
local function parse(text)
    local list, decl, cur = {}, {}, nil
    for line in (text .. "\n"):gmatch("(.-)\r?\n") do
        local name = line:match("^###%s*(.-)%s*$")
        local var, rest = line:match("^@var%s+(%w+)%s*=%s*(.-)%s*$")
        if name then
            cur = { name = name, lines = {} }; list[#list + 1] = cur
        elseif var then
            local def, desc = rest:match("^(.-)%s*|%s*(.-)$")
            decl[#decl + 1] = { name = var, default = def or rest, desc = desc }
        elseif cur and not line:match("^%s*%-%-") then
            cur.lines[#cur.lines + 1] = line
        end
    end
    for _, m in ipairs(list) do
        while m.lines[1] and m.lines[1]:match("^%s*$") do table.remove(m.lines, 1) end
        while #m.lines > 0 and m.lines[#m.lines]:match("^%s*$") do table.remove(m.lines) end
        m.body = table.concat(m.lines, "\n")
    end
    return list, decl
end

-- Variables utilisées par les macros, dans l'ordre d'apparition, avec leur déclaration s'il y en a une.
local function used(list, decl)
    local byName, seen, out = {}, {}, {}
    for _, d in ipairs(decl) do byName[d.name] = d end
    for _, m in ipairs(list) do
        for name in m.body:gmatch("{(%w+)}") do
            if not BUILTIN[name] and not seen[name] then
                seen[name] = true
                out[#out + 1] = byName[name] or { name = name }
            end
        end
    end
    return out
end

local function import(text, values)
    if InCombatLockdown() then return say("import impossible en combat.") end
    local perChar = ns.DB().macroPerChar
    local made, updated, failed = 0, 0, {}
    for _, m in ipairs((parse(text))) do
        local missing = {}
        local body = expand(m.body, values or {}, missing)
        local why
        if #missing > 0 then why = table.concat(missing, ", ") .. " sans valeur"
        elseif m.name == "" or #m.name > 16 then why = "nom vide ou trop long (16 max)"
        elseif #body > 255 then why = "plus de 255 caractères" end
        if not why then
            local i = GetMacroIndexByName(m.name)
            if i > 0 then
                EditMacro(i, nil, nil, body); updated = updated + 1
            elseif pcall(CreateMacro, m.name, "INV_MISC_QUESTIONMARK", body, perChar) then
                made = made + 1
            else
                why = "plus de place"
            end
        end
        if why then failed[#failed + 1] = m.name .. " (" .. why .. ")" end
    end
    say(("macros : %d créée(s), %d mise(s) à jour."):format(made, updated))
    for _, f in ipairs(failed) do say("non importée : " .. f) end
end
ns.ImportMacros = import -- pour tests/smoke.lua

local function export(perChar)
    local global, char = GetNumMacros()
    local first = perChar and (MAX_ACCOUNT_MACROS or 120) + 1 or 1
    local out = {}
    for i = first, first + (perChar and char or global) - 1 do
        local name, _, body = GetMacroInfo(i)
        if name then out[#out + 1] = "### " .. name .. "\n" .. (body or ""):gsub("%s+$", "") end
    end
    return table.concat(out, "\n\n")
end

-- Formulaire des variables --------------------------------------------------
-- Un champ par variable ; les sets d'équipement du personnage sont proposés en boutons.

local form, rows = nil, {}
local FW, RH, PAD = 440, 52, 12

local function equipmentSets()
    local E, out = C_EquipmentSet, {}
    if not (E and E.GetEquipmentSetIDs) then return out end
    for _, id in ipairs(E.GetEquipmentSetIDs() or {}) do
        local name = E.GetEquipmentSetInfo(id)
        if name then out[#out + 1] = name end
    end
    return out
end

local function buildForm()
    local C = ns.C
    form = CreateFrame("Frame", "FreresDEpeeMacroVars", UIParent, "BackdropTemplate")
    form:SetWidth(FW); form:SetPoint("CENTER"); form:SetFrameStrata("FULLSCREEN_DIALOG")
    form:SetClampedToScreen(true); form:SetMovable(true); form:EnableMouse(true)
    form:RegisterForDrag("LeftButton")
    form:SetScript("OnDragStart", form.StartMoving)
    form:SetScript("OnDragStop", form.StopMovingOrSizing)
    ns.flatFrame(form, C.bg, C.border)
    tinsert(UISpecialFrames, "FreresDEpeeMacroVars")
    form.title = form:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    form.title:SetPoint("TOPLEFT", PAD, -PAD)
    form.note = form:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    form.note:SetWidth(FW - 2 * PAD); form.note:SetJustifyH("LEFT")
    form.ok = ns.Button(form, "", 120, nil); form.ok:SetPoint("BOTTOMLEFT", PAD, PAD)
    ns.Button(form, "Annuler", 90, function() form:Hide() end):SetPoint("BOTTOMLEFT", PAD + 128, PAD)
end

local function row(i)
    if rows[i] then return rows[i] end
    local r = CreateFrame("Frame", nil, form)
    r:SetSize(FW - 2 * PAD, RH)
    r.label = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    r.label:SetPoint("TOPLEFT"); r.label:SetPoint("RIGHT"); r.label:SetJustifyH("LEFT")
    r.edit = CreateFrame("EditBox", nil, r, "BackdropTemplate")
    r.edit:SetSize(150, 20); r.edit:SetPoint("TOPLEFT", 0, -18)
    ns.flatFrame(r.edit, { 0, 0, 0, 0.5 }, ns.C.border)
    r.edit:SetFontObject("GameFontHighlightSmall"); r.edit:SetTextInsets(6, 6, 0, 0); r.edit:SetAutoFocus(false)
    r.edit:SetScript("OnEnterPressed", r.edit.ClearFocus)
    r.edit:SetScript("OnEscapePressed", r.edit.ClearFocus)
    r.sets = {}
    rows[i] = r
    return r
end

-- fields : { name, default, desc } ; onOk reçoit { nom = valeur }.
local function showForm(title, fields, note, okLabel, onOk)
    if not form then buildForm() end
    local sets = equipmentSets()
    form.title:SetText(title)
    for i, f in ipairs(fields) do
        local r = row(i)
        r:SetPoint("TOPLEFT", PAD, -44 - (i - 1) * RH); r:Show()
        r.label:SetText(f.name .. (f.desc and ("  |cff8a8a96" .. f.desc .. "|r") or ""))
        r.edit:SetText(saved()[f.name] or f.default or "")
        local x = 158
        for j, name in ipairs(sets) do
            local b = r.sets[j] or ns.Button(r, "", 80, nil)
            r.sets[j] = b
            b:ClearAllPoints(); b:SetPoint("TOPLEFT", x, -17)
            b.label:SetText(name)
            b:SetScript("OnClick", function() r.edit:SetText(name) end)
            b:SetShown(x + 80 <= FW - 2 * PAD)
            x = x + 86
        end
        for j = #sets + 1, #r.sets do r.sets[j]:Hide() end
    end
    for i = #fields + 1, #rows do rows[i]:Hide() end
    local y = -44 - #fields * RH
    form.note:SetPoint("TOPLEFT", PAD, y - 4); form.note:SetText(note or "")
    form:SetHeight(-y + (note and 40 or 8) + 40)
    form.ok.label:SetText(okLabel)
    form.ok:SetScript("OnClick", function()
        local values = {}
        for i, f in ipairs(fields) do values[f.name] = strtrim(rows[i].edit:GetText()) end
        form:Hide()
        onOk(values)
    end)
    form:Show()
end

-- Importer : demande les variables et liste les macros remplacées avant d'écrire quoi que ce soit.
local function askImport(text)
    local list, decl = parse(text)
    if #list == 0 then return say("aucune macro trouvée, chaque macro commence par ### Nom.") end
    local fields, replaced = used(list, decl), {}
    for _, m in ipairs(list) do
        if GetMacroIndexByName(m.name) > 0 then replaced[#replaced + 1] = m.name end
    end
    -- tout est connu (valeur retenue ou défaut du pack) et rien n'est écrasé : pas de formulaire
    local known = {}
    for _, f in ipairs(fields) do
        local v = saved()[f.name] or f.default
        if v and v ~= "" then known[f.name] = v end
    end
    local complete = true
    for _, f in ipairs(fields) do if not known[f.name] then complete = false end end
    if complete and #replaced == 0 then
        for name, v in pairs(known) do saved()[name] = v end
        return import(text, known)
    end
    local note = #replaced > 0 and ("Remplacera : " .. table.concat(replaced, ", ")) or nil
    showForm(("Importer %d macro(s)"):format(#list), fields, note, "Importer", function(values)
        for name, v in pairs(values) do saved()[name] = v ~= "" and v or nil end
        import(text, values)
    end)
end
ns.AskImportMacros = askImport -- pour tests/smoke.lua

local function editVars()
    local fields = {}
    for name in pairs(saved()) do fields[#fields + 1] = { name = name } end
    if #fields == 0 then return say("aucune variable enregistrée, elles le sont au premier import qui en utilise.") end
    table.sort(fields, function(a, b) return a.name < b.name end)
    showForm("Variables enregistrées", fields, "Vide un champ pour supprimer la variable.", "Enregistrer", function(values)
        for name, v in pairs(values) do saved()[name] = v ~= "" and v or nil end
    end)
end

-- Fenêtre d'import/export ---------------------------------------------------

local frame, edit

local function build()
    local C = ns.C
    frame = CreateFrame("Frame", "FreresDEpeeMacrosFrame", UIParent, "BackdropTemplate")
    frame:SetSize(480, 420); frame:SetPoint("CENTER"); frame:SetFrameStrata("DIALOG")
    frame:SetClampedToScreen(true); frame:SetMovable(true); frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    ns.flatFrame(frame, C.bg, C.border)
    tinsert(UISpecialFrames, "FreresDEpeeMacrosFrame")

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOPLEFT", PAD, -PAD); title:SetText("Macros : importer / exporter")
    local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", 1, 1); close:SetScale(0.8)

    local area = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    area:SetPoint("TOPLEFT", PAD, -40); area:SetPoint("BOTTOMRIGHT", -PAD, 44)
    ns.flatFrame(area, { 0, 0, 0, 0.5 }, C.border)
    local scroll = CreateFrame("ScrollFrame", nil, area, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 6, -6); scroll:SetPoint("BOTTOMRIGHT", -26, 6)
    edit = CreateFrame("EditBox", nil, scroll)
    edit:SetMultiLine(true); edit:SetAutoFocus(false); edit:SetFontObject("ChatFontNormal")
    edit:SetWidth(420); edit:SetScript("OnEscapePressed", edit.ClearFocus)
    scroll:SetScrollChild(edit)
    area:EnableMouse(true); area:SetScript("OnMouseDown", function() edit:SetFocus() end)

    local x = PAD
    for _, b in ipairs({
        { "Importer", 100, function() askImport(edit:GetText()) end },
        { "Exporter perso", 110, function() edit:SetText(export(true)) end },
        { "Exporter compte", 115, function() edit:SetText(export(false)) end },
        { "Vider", 70, function() edit:SetText("") end },
    }) do
        local btn = ns.Button(frame, b[1], b[2], b[3]); btn:SetPoint("BOTTOMLEFT", x, 12)
        x = x + b[2] + 8
    end
end

local function open(text)
    if not frame then build() end
    if text then edit:SetText(text) end
    frame:Show()
end

local opts = {
    { "macroPerChar", "Créer dans l'onglet du personnage" },
    { button = "Importer / exporter", run = function() open() end },
    { button = "Variables enregistrées", run = editVars },
}
for _, p in ipairs(ns.MacroPacks[select(2, UnitClass("player"))] or {}) do
    opts[#opts + 1] = { button = p[1], run = function() open(p[2]) end }
end
opts[#opts + 1] = { note = "Un pack s'ouvre dans la fenêtre. Relis-le, ajuste-le, puis Importer." }

local db = ns.Register("FreresDEpee_Macros", {
    defaults = { macroPerChar = true },
    rows = opts,
    commands = { macros = function() open() end },
})

-- anciens champs fixes {set:dps} / {set:tank} : deviennent les variables dps et tank
for old, name in pairs({ macroSetDps = "dps", macroSetTank = "tank" }) do
    if db[old] then saved()[name] = saved()[name] or db[old]; db[old] = nil end
end

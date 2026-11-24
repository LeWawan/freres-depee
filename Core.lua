-- Frères d'Épée : noyau. Fenêtre d'options (/fdp), réglages partagés (FreresDEpeeDB) et
-- activation des modules. Chaque module est un addon à part (FreresDEpee_*) : on le coupe dans
-- la colonne de gauche de /fdp ou dans la liste des addons du jeu, puis on recharge l'interface.

local _, ns = ...
FreresDEpee = ns -- les modules s'y enregistrent avec ns.Register

local MODULES = { -- dossier de l'addon et libellé, dans l'ordre de la fenêtre
    { "FreresDEpee_Auto", "Auto" },
    { "FreresDEpee_QuestChain", "Quest Chain" },
    { "FreresDEpee_Macros", "Macros" },
    { "FreresDEpee_Guides", "Guides" },
}

local registered, commands, fallback = {}, {}, nil

-- Lu à la demande : les SavedVariables du noyau sont chargées avant les modules, pas avant ce fichier.
function ns.DB()
    FreresDEpeeDB = FreresDEpeeDB or {}
    return FreresDEpeeDB
end

-- spec = { defaults = {...}, rows = {...}, commands = { mot = fn(reste) }, fallback = fn(msg) }
-- rows : { clé, libellé [, indent, tbl] }, { button, run }, { edit = clé, label }, { note }
function ns.Register(addon, spec)
    local db = ns.DB()
    for k, v in pairs(spec.defaults or {}) do if db[k] == nil then db[k] = v end end
    for word, fn in pairs(spec.commands or {}) do commands[word] = fn end
    fallback = spec.fallback or fallback
    registered[addon] = spec
    return db
end

-- API des addons : C_AddOns sur ce client, globales sur les plus anciens.
local A = C_AddOns or {}
local function me() return UnitName("player") end
local function exists(name)
    local ok, _, _, _, _, reason = pcall(A.GetAddOnInfo or GetAddOnInfo, name)
    return ok and reason ~= "MISSING"
end
local function isLoaded(name) return (A.IsAddOnLoaded or IsAddOnLoaded)(name) and true or false end
local function isEnabled(name)
    local state
    if A.GetAddOnEnableState then state = A.GetAddOnEnableState(name, me())
    else state = GetAddOnEnableState(me(), name) end
    return (tonumber(state) or 0) > 0
end
local function setEnabled(name, on)
    if on then (A.EnableAddOn or EnableAddOn)(name, me()) else (A.DisableAddOn or DisableAddOn)(name, me()) end
end

-- Fenêtre d'options (/fdp) -------------------------------------------------
-- Construite au premier /fdp. Déplaçable, Échap la ferme.

local win

-- Même style que le panneau Quest Chain : fond sombre plat, bordure et accents dorés.
local FLAT = "Interface\\Buttons\\WHITE8x8"
local C = {
    bg = { 0.05, 0.05, 0.07, 0.96 }, border = { 0.85, 0.65, 0.25, 0.55 }, header = { 0.11, 0.09, 0.06, 1 },
    accent = { 1, 0.82, 0.2 }, kicker = { 0.85, 0.65, 0.25 }, muted = { 0.54, 0.54, 0.59 },
    text = { 0.9, 0.9, 0.9 }, off = { 0.35, 0.35, 0.38 },
}
local SIDE, MAIN, HEAD, ROW, PAD = 140, 320, 52, 26, 12

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
ns.flatFrame, ns.tex, ns.C = flatFrame, tex, C -- réutilisés par les fenêtres des modules

-- Case plate 14×14 avec marque dorée ; renvoie la marque.
local function box(parent)
    local b = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    b:SetSize(14, 14)
    flatFrame(b, { 0, 0, 0, 0.5 }, C.border)
    local mark = tex(b, "ARTWORK", C.accent); mark:SetPoint("TOPLEFT", 3, -3); mark:SetPoint("BOTTOMRIGHT", -3, 3)
    return b, mark
end

-- Ligne cliquable : case plate + libellé.
local function checkRow(page, y, opt)
    local key, tbl = opt[1], opt.tbl or ns.DB
    local row = CreateFrame("Button", nil, page)
    row:SetPoint("TOPLEFT", 0, y); row:SetPoint("RIGHT"); row:SetHeight(ROW - 2)
    local hl = tex(row, "BACKGROUND", { 1, 1, 1 }, 0.05); hl:SetAllPoints(); hl:Hide()
    local b, mark = box(row); b:SetPoint("LEFT", opt.indent and 24 or 6, 0)
    local label = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("LEFT", b, "RIGHT", 8, 0); label:SetText(opt[2])
    local function refresh() mark:SetShown(tbl()[key] and true or false) end
    row:SetScript("OnShow", refresh)
    row:SetScript("OnEnter", function() hl:Show() end)
    row:SetScript("OnLeave", function() hl:Hide() end)
    row:SetScript("OnClick", function() tbl()[key] = not tbl()[key]; refresh(); if ns.Update then ns.Update() end end)
    refresh()
end

local function button(parent, text, w, run)
    local b = CreateFrame("Button", nil, parent, "BackdropTemplate")
    b:SetSize(w, ROW - 6)
    flatFrame(b, { 1, 0.82, 0.2, 0.08 }, C.border)
    local t = b:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"); t:SetPoint("CENTER"); t:SetText(text)
    b.label = t
    b:SetScript("OnEnter", function() b:SetBackdropColor(1, 0.82, 0.2, 0.18) end)
    b:SetScript("OnLeave", function() b:SetBackdropColor(1, 0.82, 0.2, 0.08) end)
    b:SetScript("OnClick", run)
    return b
end
ns.Button = button

local function actionRow(page, y, opt)
    button(page, opt.button, 190, opt.run):SetPoint("TOPLEFT", 6, y - 4)
end

-- Libellé + champ texte enregistré dans la clé opt.edit.
local function editRow(page, y, opt)
    local label = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("TOPLEFT", 6, y - 6); label:SetText(opt.label)
    local e = CreateFrame("EditBox", nil, page, "BackdropTemplate")
    e:SetSize(150, ROW - 6); e:SetPoint("TOPRIGHT", -6, y - 2)
    flatFrame(e, { 0, 0, 0, 0.5 }, C.border)
    e:SetFontObject("GameFontHighlightSmall"); e:SetTextInsets(6, 6, 0, 0); e:SetAutoFocus(false)
    e:SetScript("OnShow", function() e:SetText(ns.DB()[opt.edit] or "") end)
    e:SetScript("OnTextChanged", function(_, user) if user then ns.DB()[opt.edit] = e:GetText() end end)
    e:SetScript("OnEnterPressed", e.ClearFocus)
    e:SetScript("OnEscapePressed", e.ClearFocus)
    e:SetText(ns.DB()[opt.edit] or "")
end

local function noteRow(page, y, text)
    local t = page:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    t:SetPoint("TOPLEFT", 6, y - 6); t:SetPoint("RIGHT", -6, 0); t:SetJustifyH("LEFT"); t:SetText(text)
end

local function buildPage(page, addon)
    local spec = registered[addon]
    if not spec then
        noteRow(page, 0, isEnabled(addon) and "Recharge l'interface pour charger ce module."
            or "Module désactivé. Active-le à gauche, puis recharge l'interface.")
        return
    end
    for j, opt in ipairs(spec.rows or {}) do
        local y = -(j - 1) * ROW
        if opt.button then actionRow(page, y, opt)
        elseif opt.edit then editRow(page, y, opt)
        elseif opt.note then noteRow(page, y, opt.note)
        else checkRow(page, y, opt) end
    end
end

local function buildWindow()
    local mods, rows = {}, 6
    for _, m in ipairs(MODULES) do
        if exists(m[1]) then
            mods[#mods + 1] = m
            if registered[m[1]] then rows = math.max(rows, #(registered[m[1]].rows or {})) end
        end
    end

    win = CreateFrame("Frame", "FreresDEpeeFrame", UIParent, "BackdropTemplate")
    win:SetSize(SIDE + MAIN, HEAD + PAD + rows * ROW + 40)
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

    -- colonne de gauche : un module par ligne, case = activé (prend effet au rechargement)
    local sep = tex(win, "ARTWORK", C.border, 0.25)
    sep:SetPoint("TOPLEFT", SIDE, -HEAD); sep:SetPoint("BOTTOMLEFT", SIDE, 1); sep:SetWidth(1)
    local reload = button(win, "Recharger pour appliquer", 170, ReloadUI)
    reload:SetPoint("BOTTOMRIGHT", -PAD, 8)

    local items, pages, current = {}, {}, nil
    local function refresh()
        local pending = false
        for i, m in ipairs(mods) do
            local it, on = items[i], isEnabled(m[1])
            it.mark:SetShown(on)
            if on ~= isLoaded(m[1]) then pending = true end
            local col = i == current and C.accent or (on and isLoaded(m[1])) and C.text or C.off
            it.label:SetTextColor(unpack(col))
            it.under:SetShown(i == current)
        end
        reload:SetShown(pending)
    end
    local function show(n)
        current = n
        for i, m in ipairs(mods) do
            if i == n and not pages[i] then
                pages[i] = CreateFrame("Frame", nil, win)
                pages[i]:SetPoint("TOPLEFT", SIDE + PAD - 4, -HEAD - PAD / 2)
                pages[i]:SetPoint("BOTTOMRIGHT", -PAD + 4, 36)
                buildPage(pages[i], m[1])
            end
            if pages[i] then pages[i]:SetShown(i == n) end
        end
        refresh()
    end

    for i, m in ipairs(mods) do
        local it = CreateFrame("Button", nil, win)
        it:SetSize(SIDE - 2, ROW); it:SetPoint("TOPLEFT", 1, -HEAD - PAD / 2 - (i - 1) * ROW)
        local hl = tex(it, "BACKGROUND", { 1, 1, 1 }, 0.04); hl:SetAllPoints(); hl:Hide()
        it.label = it:CreateFontString(nil, "OVERLAY", "GameFontNormal"); it.label:SetPoint("LEFT", PAD, 0); it.label:SetText(m[2])
        it.under = tex(it, "OVERLAY", C.accent); it.under:SetPoint("TOPLEFT", 0, -3); it.under:SetPoint("BOTTOMLEFT", 0, 3); it.under:SetWidth(2)
        it:SetScript("OnEnter", function() hl:Show() end)
        it:SetScript("OnLeave", function() hl:Hide() end)
        it:SetScript("OnClick", function() show(i) end)
        local power = CreateFrame("Button", nil, it)
        power:SetSize(20, 20); power:SetPoint("RIGHT", -8, 0)
        local b; b, it.mark = box(power); b:SetPoint("CENTER")
        power:SetScript("OnClick", function() setEnabled(m[1], not isEnabled(m[1])); refresh() end)
        power:SetScript("OnEnter", function()
            GameTooltip:SetOwner(power, "ANCHOR_RIGHT")
            GameTooltip:SetText("Activer ou désactiver le module")
            GameTooltip:AddLine("Prend effet au rechargement de l'interface.", 1, 1, 1)
            GameTooltip:Show()
        end)
        power:SetScript("OnLeave", function() GameTooltip:Hide() end)
        items[i] = it
    end

    local hint = win:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    hint:SetPoint("BOTTOMLEFT", PAD, 14)
    hint:SetText("Case : module activé")
    win:SetScript("OnShow", refresh)
    show(1)
end

SLASH_FRERESDEPEE1 = "/fdp"
SlashCmdList.FRERESDEPEE = function(msg)
    msg = strtrim(msg or "")
    local word, rest = msg:match("^(%S*)%s*(.-)$")
    word = word:lower()
    if word == "" then
        if not win then buildWindow() return end
        win:SetShown(not win:IsShown())
    elseif commands[word] then
        commands[word](rest)
    elseif fallback then
        fallback(msg:lower())
    else
        print("|cffffd100Frères d'Épée|r /fdp ouvre les options.")
    end
end

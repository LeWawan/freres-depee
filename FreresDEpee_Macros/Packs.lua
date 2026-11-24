-- Packs de macros par classe, au format d'import de /fdp macros (voir Macros.lua) :
--   ### Nom                         début d'une macro (16 caractères au plus)
--   -- texte                        commentaire, ignoré
--   @var nom = défaut | aide         déclare une variable : valeur proposée et explication
--   {nom}                           valeur de la variable, demandée à l'import puis retenue
--   {spell:ID}                      nom du sort dans la langue du client
--   {shields}                       catégorie « Boucliers » dans la langue du client, pour [equipped:...]
-- Convention des packs : sets d'équipement nommés en minuscules (dps, tank).

local ns = FreresDEpee

ns.MacroPacks = {
    WARRIOR = {
        { "Guerrier : postures", [[
-- Change de posture et équipe le set qui va avec. Les messages d'erreur sont masqués.
@var dps = dps | set équipé en Combat et en Berserker
@var tank = tank | set avec le bouclier, équipé en Défensive

### Posture Combat
#showtooltip {spell:2457}
/run UIErrorsFrame:Hide()
/cast {spell:2457}
/equipset {dps}
/run UIErrorsFrame:Clear() UIErrorsFrame:Show()

### Posture Berserk
#showtooltip {spell:2458}
/run UIErrorsFrame:Hide()
/cast {spell:2458}
/equipset {dps}
/run UIErrorsFrame:Clear() UIErrorsFrame:Show()

### Posture Def
#showtooltip {spell:71}
/run UIErrorsFrame:Hide()
/cast {spell:71}
/equipset {tank}
/run UIErrorsFrame:Clear() UIErrorsFrame:Show()
]] },
        { "Guerrier : combat", [[
@var dps = dps | set équipé en Combat et en Berserker
@var tank = tank | set avec le bouclier

-- Bouclier : 1er appui équipe le set tank, 2e appui frappe puis remet le set DPS.
### Bouclier
#showtooltip {spell:72}
/cast [equipped:{shields}] {spell:72}
/equipset [equipped:{shields}] {dps}
/equipset [noequipped:{shields}] {tank}

-- Burst : Souhait mortel et les deux bijoux. Troll : ajoute /cast {spell:20554} en premier.
### Burst
#showtooltip {spell:12328}
/cast {spell:12328}
/use 13
/use 14

-- Charge hors combat, Interception en combat, avec la posture qu'il faut.
### Charge
#showtooltip
/cast [nocombat,stance:1] {spell:100}; [nocombat] {spell:2457}; [stance:3] {spell:20252}; {spell:2458}

-- Coupe l'auto-attaque pour que les coups ne cassent pas la peur.
### Intimidation
#showtooltip {spell:5246}
/stopattack
/cast {spell:5246}
]] },
    },
}

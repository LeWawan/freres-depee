if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warlock Horde, variante Incube de La dévoreuse d'âmes (niveau 20).
-- Morts-vivants : cœurs d'Avelina (Silverpine) et d'Isaac (Barrens). Orcs, Trolls : Magar
-- (Orgrimmar) et l'Écharpe flétrie des Sombretaillis (Ashenvale).
-- La dévoreuse d'âmes (1472, 1507) est partagée avec le guide « 20 Succube ».

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Warlock
#name 20 Incube
#displayname [FDP] Démoniste 20 : Incube
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 20 >>Monte au niveau 20, requis pour la quête

-- ===== Morts-vivants =====
step << Undead
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r au quartier des Mages
    .accept 1472 >>Accepte La dévoreuse d'âmes
    .target 5675
step << Undead
    .goto Undercity,84.81,14.83
    >>Parle à |cRXP_FRIENDLY_Godrick Farsan|r
    .turnin 1472 >>Rends La dévoreuse d'âmes
    .target 5693
    .isOnQuest 1472
step << Undead
    .goto Undercity,84.81,14.83
    >>Parle à |cRXP_FRIENDLY_Godrick Farsan|r
    .accept 65593 >>Accepte Les cœurs des amoureux
    .target 5693
step << Undead
    .goto Silverpine Forest,61.91,64.11
    >>Tue |cRXP_ENEMY_Avelina Lilly|r près d'Ambermill et prends son |cRXP_LOOT_Cœur|r
    .complete 65593,1 --Cœur d'Avelina (1)
    .mob 185333
step << Undead
    .goto The Barrens,61.00,38.24
    >>Tue |cRXP_ENEMY_Isaac Pearson|r près de Ratchet et prends son |cRXP_LOOT_Cœur|r
    .complete 65593,2 --Cœur d'Isaac (1)
    .mob 185334
step << Undead
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r
    .turnin 65593 >>Rends Les cœurs des amoureux
    .accept 65597 >>Accepte Le lien
    .target 5675
step << Undead
    .goto Undercity,86.62,27.05
    >>Utilise les |cRXP_LOOT_Cœurs des amoureux|r au |cRXP_PICK_Cercle d'invocation|r, puis bats l'|cRXP_ENEMY_Incube invoqué|r
    .complete 65597,1 --Incube invoqué
    .use 190181
    .mob 185335
step << Undead
    #label FinIncubeUC
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r pour apprendre l'invocation de l'incube
    .turnin 65597 >>Rends Le lien
    .target 5675

-- ===== Orcs, Trolls =====
step << !Undead
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r dans la Faille de l'ombre
    .accept 1507 >>Accepte La dévoreuse d'âmes
    .target 5875
step << !Undead
    .goto Orgrimmar,47.06,46.43
    >>Parle à |cRXP_FRIENDLY_Cazul|r, juste à côté
    .turnin 1507 >>Rends La dévoreuse d'âmes
    .target 5909
    .isOnQuest 1507
step << !Undead
    .goto Orgrimmar,47.06,46.43
    >>Parle à |cRXP_FRIENDLY_Cazul|r
    .accept 65601 >>Accepte Les affres de l'amour
    .target 5909
step << !Undead
    .goto Orgrimmar,63.65,49.93
    >>Parle à |cRXP_FRIENDLY_Magar|r dans la vallée de l'Honneur
    .turnin 65601 >>Rends Les affres de l'amour
    .accept 65610 >>Accepte Comme tu me manques
    .target 3363
step << !Undead
    .goto Ashenvale,65.24,80.10
    >>Va à Fallen Sky Lake (Ashenvale) et tue les |cRXP_ENEMY_Sombretaillis|r jusqu'à l'|cRXP_LOOT_Écharpe flétrie|r
    .complete 65610,1 --Écharpe flétrie (1)
    .mob 3782
    .mob 3784
step << !Undead
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r
    .turnin 65610 >>Rends Comme tu me manques
    .accept 65604 >>Accepte Le lien
    .target 5875
step << !Undead
    .goto Orgrimmar,49.43,50.04
    >>Utilise l'|cRXP_LOOT_Écharpe flétrie|r au |cRXP_PICK_Cercle d'invocation|r, puis bats l'|cRXP_ENEMY_Incube invoqué|r
    .complete 65604,1 --Incube invoqué
    .use 190187
    .mob 185335
step << !Undead
    #label FinIncubeOrg
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r pour apprendre l'invocation de l'incube
    .turnin 65604 >>Rends Le lien
    .target 5875
]])

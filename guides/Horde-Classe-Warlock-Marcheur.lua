if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warlock Horde, La créature du Vide (Marcheur du Vide, niveau 10).
-- Morts-vivants : Carendin Halgar (Undercity). Orcs : Gan'rul Bloodeye (Orgrimmar).
-- QuestieDB n'ouvre ces quêtes qu'aux Orcs et aux Morts-vivants : un Troll doit vérifier en jeu.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Warlock
#name 10 Marcheur du Vide
#displayname [FDP] Démoniste 10 : Marcheur du Vide
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 10 >>Monte au niveau 10, requis pour la quête
step << Troll
    #label FinMarcheurTroll
    +|cRXP_WARN_D'après QuestieDB, cette chaîne est réservée aux Orcs et aux Morts-vivants : demande à Gan'rul Bloodeye (Orgrimmar 48,45)|r. Coche pour finir

-- ===== Morts-vivants =====
step << Undead
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r au quartier des Mages
    .turnin 1478 >>Rends Les invocations de Halgar
    .target 5675
    .isOnQuest 1478
step << Undead
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r au quartier des Mages
    .accept 1473 >>Accepte La créature du Vide
    .target 5675
step << Undead
    .goto Tirisfal Glades,51.06,67.57
    >>Ouvre le |cRXP_PICK_Coffre de Perrine|r dans la maison au sud de Tirisfal et prends le |cRXP_LOOT_Grimoire d'Egalin|r
    .complete 1473,1 --Grimoire d'Egalin (1)
step << Undead
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r. Il te donne les |cRXP_LOOT_Runes d'invocation|r
    .turnin 1473 >>Rends La créature du Vide
    .accept 1471 >>Accepte Le lien
    .target 5675
step << Undead
    .goto Undercity,86.62,27.05
    >>Utilise les |cRXP_LOOT_Runes d'invocation|r au |cRXP_PICK_Cercle d'invocation|r, puis bats le |cRXP_ENEMY_Marcheur du Vide invoqué|r
    .complete 1471,1 --Marcheur du Vide invoqué
    .use 6284
    .mob 5676
step << Undead
    #label FinMarcheurUC
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r pour apprendre l'invocation du marcheur du Vide
    .turnin 1471 >>Rends Le lien
    .target 5675

-- ===== Orcs =====
step << Orc
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r dans la Faille de l'ombre
    .turnin 1506 >>Rends Les invocations de Gan'rul
    .target 5875
    .isOnQuest 1506
step << Orc
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r dans la Faille de l'ombre
    .accept 1501 >>Accepte La créature du Vide
    .target 5875
step << Orc
    .goto Durotar,51.62,9.76
    >>Ouvre la |cRXP_PICK_Planque de la Lame ardente|r dans la grotte de Skull Rock, au nord de Durotar, et prends la |cRXP_LOOT_Tablette de Verga|r
    .complete 1501,1 --Tablette de Verga (1)
step << Orc
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r. Il te donne les |cRXP_LOOT_Glyphes d'invocation|r
    .turnin 1501 >>Rends La créature du Vide
    .accept 1504 >>Accepte Le lien
    .target 5875
step << Orc
    .goto Orgrimmar,49.43,50.04
    >>Utilise les |cRXP_LOOT_Glyphes d'invocation|r au |cRXP_PICK_Cercle d'invocation|r, puis bats le |cRXP_ENEMY_Marcheur du Vide invoqué|r
    .complete 1504,1 --Marcheur du Vide invoqué
    .use 7464
    .mob 5676
step << Orc
    #label FinMarcheurOrg
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r pour apprendre l'invocation du marcheur du Vide
    .turnin 1504 >>Rends Le lien
    .target 5875
]])

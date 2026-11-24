if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warlock Horde, La dévoreuse d'âmes (Succube, niveau 20).
-- Morts-vivants : Carendin Halgar (Undercity), cœurs de Dalin (Silverpine) et de Corma (Wetlands).
-- Orcs, Trolls : Gan'rul Bloodeye (Orgrimmar), la chaîne de Dogran dans les Barrens.
-- La variante Incube a son propre guide (« 20 Incube »).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Warlock
#name 20 Succube
#displayname [FDP] Démoniste 20 : Succube
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
    .accept 1476 >>Accepte Des cœurs purs
    .target 5693
step << Undead
    .goto Silverpine Forest,47.60,85.65
    >>Tue |cRXP_ENEMY_Dalin Forgewright|r, au sud de Silverpine, et prends son |cRXP_LOOT_Cœur|r (~44 %)
    .complete 1476,1 --Coeur de Dalin (1)
    .mob 5682
step << Undead
    .goto Wetlands,49.93,12.55
    >>Tue |cRXP_ENEMY_Corma Villard|r au nord des Wetlands et prends son |cRXP_LOOT_Cœur|r
    .complete 1476,2 --Coeur de Corma (1)
    .mob 5683
step << Undead
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r
    .turnin 1476 >>Rends Des cœurs purs
    .accept 1474 >>Accepte Le lien
    .target 5675
step << Undead
    .goto Undercity,86.62,27.05
    >>Utilise les |cRXP_LOOT_Cœurs purs|r au |cRXP_PICK_Cercle d'invocation|r, puis bats la |cRXP_ENEMY_Succube invoquée|r
    .complete 1474,1 --Succube invoquée
    .use 6286
    .mob 5677
step << Undead
    #label FinSuccubeUC
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r pour apprendre l'invocation de la succube
    .turnin 1474 >>Rends Le lien
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
    .accept 1508 >>Accepte Cazul l'aveugle
    .target 5909
step << !Undead
    .goto Orgrimmar,37.04,59.45
    >>Parle à |cRXP_FRIENDLY_Zankaja|r dans la vallée des Esprits
    .turnin 1508 >>Rends Cazul l'aveugle
    .accept 1509 >>Accepte Des nouvelles de Dogran
    .target 5910
step << !Undead
    .goto The Barrens,51.93,30.32
    >>Parle à |cRXP_FRIENDLY_Gazrog|r à la Croisée
    .turnin 1509 >>Rends Des nouvelles de Dogran
    .accept 1510 >>Accepte Des nouvelles de Dogran
    .target 3464
step << !Undead
    .goto Stonetalon Mountains,73.25,95.13
    >>Parle à |cRXP_FRIENDLY_Ken'zigla|r au Malaka'jin, au sud des Serres-Rocheuses
    .turnin 1510 >>Rends Des nouvelles de Dogran
    .accept 1511 >>Accepte Breuvage de Ken'zigla
    .target 4197
step << !Undead
    .goto The Barrens,44.62,59.27
    >>Parle au |cRXP_FRIENDLY_Grunt Logmar|r au camp Taurajo
    .turnin 1511 >>Rends Breuvage de Ken'zigla
    .accept 1515 >>Accepte La captivité de Dogran
    .target 5911
step << !Undead
    .goto The Barrens,43.30,47.89
    >>Donne le breuvage au |cRXP_FRIENDLY_Grunt Dogran|r, retenu prisonnier
    .turnin 1515 >>Rends La captivité de Dogran
    .accept 1512 >>Accepte Le cadeau de l'amour
    .target 5908
step << !Undead
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r
    .turnin 1512 >>Rends Le cadeau de l'amour
    .accept 1513 >>Accepte Le lien
    .target 5875
step << !Undead
    .goto Orgrimmar,49.43,50.04
    >>Utilise le |cRXP_LOOT_Pendentif de Dogran|r au |cRXP_PICK_Cercle d'invocation|r, puis bats la |cRXP_ENEMY_Succube invoquée|r
    .complete 1513,1 --Succube invoquée
    .use 6626
    .mob 5677
step << !Undead
    #label FinSuccubeOrg
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r pour apprendre l'invocation de la succube
    .turnin 1513 >>Rends Le lien
    .target 5875
]])

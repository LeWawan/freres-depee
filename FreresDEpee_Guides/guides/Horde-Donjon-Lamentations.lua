if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde des Cavernes des lamentations (Tarides), toutes classes.
-- Givers : Tonga (La Croisée), Hamuul, Nara et Zamah (Thunder Bluff), Bigglefuzz et Mebok
-- (Cabestan), Ebru (au-dessus de l'entrée). Rendus à Cabestan, à La Croisée puis à Thunder Bluff.
-- Protégées : la chaîne des druides du Croc (1489 demande 880 Source de vie, quête des Tarides)
-- et 1491 Les potions d'intelligence (après 865 Les cornes de raptors).
-- Coupée : 1486 Les peaux communes (20 peaux à ~23 %, ~175 kills en duo).
-- Données : QuestieDB Forever (tools/questiedb.py). Dans l'instance, QuestieDB n'a pas de
-- coordonnées : ordre des boss décrit dans le texte.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 17-22 Wailing Caverns
#displayname [FDP] Cavernes des lamentations (17-22)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== La Croisée et Thunder Bluff : les druides du Croc =====
step
    .goto The Barrens,52.26,31.93
    >>Parle à |cRXP_FRIENDLY_Tonga Runetotem|r à La Croisée
    .accept 1489 >>Accepte Hamuul Runetotem
    .target 3448
    .isQuestTurnedIn 880
step
    #completewith Zamah
    .goto Thunder Bluff,78.62,28.56,40 >>Va à Thunder Bluff (vol depuis La Croisée)
step
    .goto Thunder Bluff,78.62,28.56
    >>Parle à l'|cRXP_FRIENDLY_Archidruide Hamuul Runetotem|r sur la Cime des Anciens
    .turnin 1489 >>Rends Hamuul Runetotem
    .accept 1490 >>Accepte Nara Wildmane
    .target 5769
    .isOnQuest 1489
step
    .goto Thunder Bluff,75.65,31.61
    >>Parle à |cRXP_FRIENDLY_Nara Wildmane|r
    .turnin 1490 >>Rends Nara Wildmane
    .accept 914 >>Accepte Les druides du Croc
    .target 5770
    .isOnQuest 1490
step
    .goto Thunder Bluff,75.65,31.61
    >>Parle à |cRXP_FRIENDLY_Nara Wildmane|r
    .accept 914 >>Accepte Les druides du Croc
    .target 5770
    .isQuestTurnedIn 1490
step
    #label Zamah
    .goto Thunder Bluff,22.81,20.89
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Zamah|r dans la grotte de la Cime des Esprits
    .accept 962 >>Accepte Fleur de serpent
    .target 3419

-- ===== Cabestan =====
step
    #completewith Bigglefuzz
    .goto The Barrens,63.09,37.61,40 >>Va à Cabestan (vol depuis Thunder Bluff)
step
    .goto The Barrens,62.37,37.62
    >>Parle à |cRXP_FRIENDLY_Mebok Mizzyrix|r
    .accept 1491 >>Accepte Les potions d'intelligence
    .target 3446
    .isQuestTurnedIn 865
step
    #label Bigglefuzz
    .goto The Barrens,63.09,37.61
    >>Parle au |cRXP_FRIENDLY_Grutier Bigglefuzz|r sur le quai
    .accept 959 >>Accepte Fuite de porto aux docks
    .target 3665

-- ===== Oasis des lamentations : Ebru et la grotte d'accès =====
step
    #completewith Ebru
    .goto The Barrens,46.01,35.74,40 >>Va à l'oasis des lamentations, à l'ouest de La Croisée. Monte sur la tête de serpent au-dessus de l'entrée
step
    #label Ebru
    .goto The Barrens,46.01,35.74
    >>Parle à |cRXP_FRIENDLY_Ebru|r
    .accept 1487 >>Accepte L'éradication des Déviants
    .target 5768
step
    #completewith FinLamentations
    >>Ramasse les |cRXP_PICK_Fleurs de serpent|r dans la grotte d'accès et dans l'instance
    .complete 962,1 --Fleur de serpent (10)
step
    #completewith FinLamentations
    >>Tue les |cRXP_ENEMY_Ectoplasmes|r pour l'|cRXP_LOOT_Essence de lamentation|r
    .complete 1491,1 --Essence de lamentation (6)
    .mob 3638
    .mob 3640
    .isOnQuest 1491
step
    .goto The Barrens,46.46,35.47,20,0
    .goto The Barrens,46.83,34.66
    >>Tue |cRXP_ENEMY_Magglish le Dingue|r (furtif, dans la grotte d'accès ou près de l'entrée de l'instance) et ramasse le |cRXP_LOOT_Porto vieux de 99 ans|r
    .complete 959,1 --Porto vieux de 99 ans
    .mob 3655

-- ===== Instance =====
step
    #completewith Mutanus
    >>Tue les |cRXP_ENEMY_Ravageurs|r, |cRXP_ENEMY_Vipères|r, |cRXP_ENEMY_Glacials|r et |cRXP_ENEMY_Crocs-d'effroi déviants|r
    .complete 1487,1 --Ravageur déviant (7)
    .complete 1487,2 --Vipère déviante (7)
    .complete 1487,3 --Glacial déviant (7)
    .complete 1487,4 --Croc-d'effroi déviant (7)
    .mob 3636
    .mob 5755
    .mob 5761
    .mob 5056
step
    >>Entre dans l'instance. Tue les quatre druides du Croc et ramasse leurs gemmes : |cRXP_ENEMY_Dame Anacondra|r, |cRXP_ENEMY_Seigneur Cobrahn|r, |cRXP_ENEMY_Seigneur Pythas|r et |cRXP_ENEMY_Seigneur Serpentis|r (au sommet de la cascade)
    .complete 914,1 --Gemme de Cobrahn
    .complete 914,2 --Gemme d'Anacondra
    .complete 914,3 --Gemme de Pythas
    .complete 914,4 --Gemme de Serpentis
    .mob 3669
    .mob 3671
    .mob 3670
    .mob 3673
    .isOnQuest 914
step
    #label Mutanus
    >>Retourne au |cRXP_FRIENDLY_Disciple de Naralex|r à l'entrée de l'instance une fois les quatre druides morts. Suis-le et protège-le pendant le rituel
    >>Tue |cRXP_ENEMY_Mutanus le Dévoreur|r à la fin et ramasse l'|cRXP_LOOT_Eclat luminescent|r. Utilise-le pour lancer la quête
    .collect 10441,1,6981,1 --Eclat luminescent
    .accept 6981 >>Accepte L'Eclat luminescent
    .use 10441
    .mob 3654
step
    >>Finis les déviants et les |cRXP_PICK_Fleurs de serpent|r avant de sortir
    .complete 1487,1 --Ravageur déviant (7)
    .complete 1487,2 --Vipère déviante (7)
    .complete 1487,3 --Glacial déviant (7)
    .complete 1487,4 --Croc-d'effroi déviant (7)
    .complete 962,1 --Fleur de serpent (10)

-- ===== Rendus =====
step
    .goto The Barrens,46.01,35.74
    >>Sors et parle à |cRXP_FRIENDLY_Ebru|r
    .turnin 1487 >>Rends L'éradication des Déviants
    .target 5768
step
    #completewith Sputtervalve
    .goto The Barrens,63.09,37.61,40 >>Va à Cabestan
step
    .goto The Barrens,63.09,37.61
    >>Parle au |cRXP_FRIENDLY_Grutier Bigglefuzz|r
    .turnin 959 >>Rends Fuite de porto aux docks
    .target 3665
step
    .goto The Barrens,62.37,37.62
    >>Parle à |cRXP_FRIENDLY_Mebok Mizzyrix|r
    .turnin 1491 >>Rends Les potions d'intelligence
    .target 3446
    .isQuestComplete 1491
step
    #label Sputtervalve
    .goto The Barrens,62.98,37.22
    >>Parle à |cRXP_FRIENDLY_Sputtervalve|r
    .complete 6981,1 --Parler à Sputtervalve
    .target 3442
    .isOnQuest 6981
step
    .goto The Barrens,48.18,32.78
    >>Parle à |cRXP_FRIENDLY_Falla Sagewind|r, au-dessus de l'oasis, à l'ouest de La Croisée
    .turnin 6981 >>Rends L'Eclat luminescent
    .target 8418
    .isOnQuest 6981
step
    #completewith FinLamentations
    .goto Thunder Bluff,75.65,31.61,40 >>Va à Thunder Bluff (vol depuis La Croisée)
step
    .goto Thunder Bluff,75.65,31.61
    >>Parle à |cRXP_FRIENDLY_Nara Wildmane|r
    .turnin 914 >>Rends Les druides du Croc
    .target 5770
    .isOnQuest 914
step
    #label FinLamentations
    .goto Thunder Bluff,22.81,20.89
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Zamah|r
    .turnin 962 >>Rends Fleur de serpent
    .target 3419
]])

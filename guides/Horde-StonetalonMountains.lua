if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Stonetalon Mountains (Serres-Rocheuses), Horde, toutes classes.
-- Prend la suite du guide RestedXP 1-22 (17-22 Stonetalon/Barrens/Ashenvale) sans le refaire :
-- les quêtes qu'il accepte sans les finir (1068, 1092, 1096, 6301, 6393) sont reprises ici,
-- protégées par .isOnQuest / .isQuestTurnedIn pour qui ne l'a pas suivi.
-- Route : Sun Rock, boucle nord (graines, Cénarius), Vallée calcinée (harpies, élémentaires),
-- puis les Cisailles à l'est et sortie vers les Barrens par Seereth.
-- Données : QuestieDB Forever (tools/questiedb.py). Syntaxe : docs/rxp-custom-guides.md.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 22-23 Stonetalon Mountains
#displayname [FDP] Les Serres-Rocheuses (22-23)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 22 Totem d'eau << Shaman
#next 23-24 Hillsbrad Foothills

-- ===== Alertes : quêtes à forte XP dont le prérequis se fait hors de la région =====
-- Visibles tant que la quête rapporte l'XP pleine (niveau de quête + 5).
step
    #sticky
    #completewith FinSerresRocheuses
    .isQuestAvailable 1096
    .isNotOnQuest 1095
    .isNotOnQuest 1096
    .maxlevel 32
    .xp 33 >>|cRXP_WARN_Chaîne manquée : Gerenzo Wrenchwhistle (~3300 xp). Super-Découpeur 6000 chez Ziz Fizziks (59,62), puis l'enveloppe à Sputtervalve à Ratchet|r
step
    #sticky
    #completewith FinSerresRocheuses
    .isQuestAvailable 1068
    .isNotOnQuest 1068
    .isQuestAvailable 1062
    .isNotOnQuest 1062
    .maxlevel 28
    .xp 29 >>|cRXP_WARN_Quête manquée : Les machines à déchiqueter (~1850 xp). Prérequis Les invasions gobelines chez Seereth Stonebreak, à la frontière des Barrens (35,28)|r

-- ===== Retraite de Roche-Soleil (Sun Rock) =====
step
    #completewith FPSunRock
    .goto Stonetalon Mountains,49.40,61.70,30,0
    .goto Stonetalon Mountains,48.15,63.90,15,0
    .goto Stonetalon Mountains,45.10,59.80,20 >>Monte à la Retraite de Roche-Soleil par le chemin à l'est du plateau
step
    #label FPSunRock
    .goto Stonetalon Mountains,45.10,59.80
    >>Parle à |cRXP_FRIENDLY_Tharm|r
    .fp Sun Rock >>Prends le point de vol de la Retraite de Roche-Soleil
    .target 4312
step
    .goto Stonetalon Mountains,45.90,60.40
    >>Parle à |cRXP_FRIENDLY_Braelyn Firehand|r
    .accept 1087 >>Accepte L'héritage de Cénarius
    .target 4198
step
    .goto Stonetalon Mountains,47.20,61.20
    >>Parle à |cRXP_FRIENDLY_Maggran Earthbinder|r
    .turnin 6284 >>Rends Arachnophobie
    .target 11860
    .isOnQuest 6284
step
    .goto Stonetalon Mountains,47.20,61.20
    >>Parle à |cRXP_FRIENDLY_Maggran Earthbinder|r
    .accept 6282 >>Accepte La menace des harpies
    .target 11860
step
    .goto Stonetalon Mountains,47.50,58.40
    >>Parle à |cRXP_FRIENDLY_Tammra Windfield|r
    .turnin 6401 >>Rends Kaya est en vie
    .target 11864
    .isOnQuest 6401
step
    .goto Stonetalon Mountains,47.50,58.40
    >>Parle à |cRXP_FRIENDLY_Tammra Windfield|r
    .accept 6301 >>Accepte Cycle de la renaissance
    .target 11864
step
    .goto Stonetalon Mountains,47.40,64.20
    >>Parle à |cRXP_FRIENDLY_Tsunaman|r
    .accept 6393 >>Accepte Guerre élémentaire
    .target 11862
step
    #completewith FinVallee
    >>Tue les |cRXP_ENEMY_Esprits flamboyants|r, |cRXP_ENEMY_Ravageurs|r et |cRXP_ENEMY_Destructeurs ardents|r dès que tu en croises
    .complete 6393,1 --Incendrites (10)
    .mob 4036
    .mob 4037
    .mob 4038

-- ===== Boucle nord : lac de Mirkfallon et pic des Serres-Rocheuses =====
step
    #completewith CenariusNord
    .goto Stonetalon Mountains,49.40,61.70,30 >>Redescends du plateau et prends la route du nord
step
    #completewith CenariusNord
    >>Ramasse les |cRXP_LOOT_Cosses de Bourbielle|r au bord du lac pour Tah Winterhoof (Thunder Bluff)
    .complete 97538,1 --Cosses de Bourbielle (30)
    .isOnQuest 97538
step
    .goto Stonetalon Mountains,49.70,45.10,30,0
    .goto Stonetalon Mountains,51.80,42.60,30,0
    .goto Stonetalon Mountains,50.20,39.20,30,0
    .goto Stonetalon Mountains,50.50,36.90,30,0
    .goto Stonetalon Mountains,48.40,35.90,30,0
    .goto Stonetalon Mountains,46.50,38.50,30,0
    .goto Stonetalon Mountains,45.80,43.10,30,0
    .goto Stonetalon Mountains,48.50,44.00
    >>Ramasse les |cRXP_PICK_Graines de Gaea|r au pied des arbres autour du lac
    >>|cRXP_WARN_15 graines pour 20 ramassages en duo : laisse-les réapparaître si besoin|r
    .complete 6301,1 --Graine de Gaea (10)
step
    #completewith CenariusNord
    .goto Stonetalon Mountains,37.50,20.00,40 >>Suis la route vers le nord jusqu'au bosquet des druides
    >>|cRXP_WARN_Reste au sud de y≈9 : le village alliance du pic (Teloren, Faralia) est juste au nord|r
step
    #label CenariusNord
    .goto Stonetalon Mountains,35.40,15.30,30,0
    .goto Stonetalon Mountains,38.20,11.40,30,0
    .goto Stonetalon Mountains,35.40,11.00,30,0
    .goto Stonetalon Mountains,36.50,13.10
    >>Tue les |cRXP_ENEMY_Fils|r et |cRXP_ENEMY_Filles de Cénarius|r et les |cRXP_ENEMY_Botanistes cénariennes|r
    >>|cRXP_WARN_Évite les Druidesses et Conservateurs cénariens (élites) plus à l'ouest, vers 29,15|r
    .complete 1087,1 --Fils de Cénarius (4)
    .complete 1087,2 --Fille de Cénarius (4)
    .complete 1087,3 --Botaniste cénarienne (4)
    .mob 4057
    .mob 4053
    .mob 4051
step
    #completewith RetourNord
    .goto Stonetalon Mountains,49.40,61.70,30,0
    .goto Stonetalon Mountains,48.15,63.90,15 >>Retourne à la Retraite de Roche-Soleil
step
    #label RetourNord
    .goto Stonetalon Mountains,47.50,58.40
    >>Parle à |cRXP_FRIENDLY_Tammra Windfield|r
    .turnin 6301 >>Rends Cycle de la renaissance
    .accept 6381 >>Accepte Nouvelle vie
    .target 11864
step
    .goto Stonetalon Mountains,45.90,60.40
    >>Parle à |cRXP_FRIENDLY_Braelyn Firehand|r
    .turnin 1087 >>Rends L'héritage de Cénarius
    .target 4198

-- ===== Vallée calcinée : harpies, monticules de Gaea, élémentaires =====
step
    #completewith ValleeHarpies
    .goto Stonetalon Mountains,49.40,61.70,30,0
    .goto Stonetalon Mountains,34.50,60.80,40 >>Redescends du plateau et va à l'ouest dans la Vallée calcinée
step
    #completewith FinVallee
    >>Plante les |cRXP_LOOT_Graines de Gaea enchantées|r dans les |cRXP_PICK_Monticules de poussière de Gaea|r
    .complete 6381,1 --Graine de Gaea plantée (10)
    .use 16208
step
    #label ValleeHarpies
    .goto Stonetalon Mountains,32.60,60.70,40,0
    .goto Stonetalon Mountains,30.00,62.20,40,0
    .goto Stonetalon Mountains,30.80,65.30,40,0
    .goto Stonetalon Mountains,29.50,69.00,40,0
    .goto Stonetalon Mountains,27.00,69.50,40,0
    .goto Stonetalon Mountains,30.20,69.60
    >>Tue les |cRXP_ENEMY_Harpies|r, |cRXP_ENEMY_Embusquées|r, |cRXP_ENEMY_Tueuses|r et |cRXP_ENEMY_Volplumes Rougefuries|r
    >>|cRXP_WARN_Laisse la Déchiqueteuse Rougefurie (élite, 30,62) pour plus tard|r
    .complete 6282,1 --Harpie Rougefurie (7)
    .complete 6282,2 --Embusquée Rougefurie (7)
    .complete 6282,3 --Tueuse Rougefurie (7)
    .complete 6282,4 --Volplume Rougefurie (7)
    .mob 4022
    .mob 4025
    .mob 4024
    .mob 4023
step
    .goto Stonetalon Mountains,30.40,73.80,40,0
    .goto Stonetalon Mountains,33.70,73.00,40,0
    .goto Stonetalon Mountains,35.90,70.00,40,0
    .goto Stonetalon Mountains,36.00,65.20,40,0
    .goto Stonetalon Mountains,33.70,67.00,40,0
    .goto Stonetalon Mountains,31.40,68.50
    >>Finis les monticules de Gaea au sud et à l'est de la vallée
    .complete 6381,1 --Graine de Gaea plantée (10)
    .use 16208
step
    #label FinVallee
    .goto Stonetalon Mountains,31.10,67.00,40,0
    .goto Stonetalon Mountains,32.60,73.50,40,0
    .goto Stonetalon Mountains,36.40,72.20,40,0
    .goto Stonetalon Mountains,35.40,66.30,40,0
    .goto Stonetalon Mountains,37.30,60.50,40,0
    .goto Stonetalon Mountains,31.10,67.00
    >>Finis les |cRXP_LOOT_Incendrites|r sur les élémentaires de feu
    .complete 6393,1 --Incendrites (10)
    .mob 4036
    .mob 4037
    .mob 4038
step
    #completewith RetourVallee
    .goto Stonetalon Mountains,49.40,61.70,30,0
    .goto Stonetalon Mountains,48.15,63.90,15 >>Retourne à la Retraite de Roche-Soleil
step
    #label RetourVallee
    .goto Stonetalon Mountains,47.40,64.20
    >>Parle à |cRXP_FRIENDLY_Tsunaman|r
    .turnin 6393 >>Rends Guerre élémentaire
    .target 11862
step
    .goto Stonetalon Mountains,47.20,61.20
    >>Parle à |cRXP_FRIENDLY_Maggran Earthbinder|r
    .turnin 6282 >>Rends La menace des harpies
    .accept 6283 >>Accepte La lignée Rougefurie
    .target 11860
step
    .goto Stonetalon Mountains,47.50,58.40
    >>Parle à |cRXP_FRIENDLY_Tammra Windfield|r
    .turnin 6381 >>Rends Nouvelle vie
    .target 11864

-- ===== La Déchiqueteuse Rougefurie =====
step
    .goto Stonetalon Mountains,30.80,61.90
    >>Tue la |cRXP_ENEMY_Déchiqueteuse Rougefurie|r et prends son |cRXP_LOOT_Cadavre|r
    >>|cRXP_WARN_Élite niveau 26 entourée d'Imploratrices célestes : dégage les alentours avant de l'engager à deux|r
    .complete 6283,1 --Cadavre de Déchiqueteuse Rougefurie
    .mob 12579
    .mob 4026
step
    #completewith RetourRipper
    .goto Stonetalon Mountains,49.40,61.70,30,0
    .goto Stonetalon Mountains,48.15,63.90,15 >>Retourne à la Retraite de Roche-Soleil
step
    #label RetourRipper
    .goto Stonetalon Mountains,47.20,61.20
    >>Parle à |cRXP_FRIENDLY_Maggran Earthbinder|r
    .turnin 6283 >>Rends La lignée Rougefurie
    .target 11860
step
    .goto Stonetalon Mountains,47.20,61.20
    >>Parle à |cRXP_FRIENDLY_Maggran Earthbinder|r. Lettre à rendre au Grand élévateur (Mille pointes), niveau 23 requis
    .accept 5881 >>Accepte Puiser dans les réserves
    .target 11860
    .xp <23,1

-- ===== Les Cisailles : Ziz, Piznik, déchiqueteuses, Gerenzo =====
step
    #completewith Ziz1
    .goto Stonetalon Mountains,49.40,61.70,30,0
    .goto Stonetalon Mountains,59.00,62.60,20 >>Prends la route de l'est vers les Cisailles
step
    #label Ziz1
    .goto Stonetalon Mountains,59.00,62.60
    >>Parle à |cRXP_FRIENDLY_Ziz Fizziks|r
    .turnin -1092 >>Rends Les ordres de Gerenzo
    .turnin -1095 >>Rends D'autres instructions
    .target 4201
    .isOnQuest 1092,1095
step
    .goto Stonetalon Mountains,59.00,62.60
    >>Parle à |cRXP_FRIENDLY_Ziz Fizziks|r
    .accept 1096 >>Accepte Gerenzo Wrenchwhistle
    .target 4201
    .isQuestTurnedIn 1095
step
    .goto Stonetalon Mountains,61.00,52.30,40,0
    .goto Stonetalon Mountains,70.60,56.20,40,0
    .goto Stonetalon Mountains,64.10,56.60
    >>Tue |cRXP_ENEMY_XT:9|r. Il patrouille sur la rive sud de la rivière
    .complete 1068,2 --XT:9
    .unitscan 4074
    .isOnQuest 1068
step
    #completewith Piznik
    .goto Stonetalon Mountains,73.80,59.50,15 >>Entre dans la mine des Cisailles
step
    #label Piznik
    .goto Stonetalon Mountains,71.90,60.00
    >>Parle à |cRXP_FRIENDLY_Piznik|r au fond de la mine
    .accept 1090 >>Accepte Les ordres de Gerenzo
    .target 4276
step
    .goto Stonetalon Mountains,71.90,60.00
    >>Protège |cRXP_FRIENDLY_Piznik|r pendant 5 minutes : trois vagues de kobolds (à 15 s, 2 min 15, 3 min 20)
    .complete 1090,1 --Garder Piznik en vie
    .mob 3998
    .mob 4001
    .mob 4002
step
    .goto Stonetalon Mountains,71.90,60.00
    >>Parle à |cRXP_FRIENDLY_Piznik|r
    .turnin 1090 >>Rends Les ordres de Gerenzo
    .accept 1092 >>Accepte Les ordres de Gerenzo
    .target 4276
step
    .goto Stonetalon Mountains,67.20,46.90,40,0
    .goto Stonetalon Mountains,63.70,45.00,40,0
    .goto Stonetalon Mountains,71.90,45.60,40,0
    .goto Stonetalon Mountains,67.20,46.70
    >>Tue |cRXP_ENEMY_XT:4|r. Il patrouille sur la rive nord de la rivière
    .complete 1068,1 --XT:4
    .unitscan 4073
    .isOnQuest 1068
step
    .goto Stonetalon Mountains,64.50,40.20
    >>Tue |cRXP_ENEMY_Gerenzo Wrenchwhistle|r à la scierie et prends son |cRXP_LOOT_Bras mécanique|r
    .complete 1096,1 --Bras mécanique de Gerenzo
    .mob 4202
    .isOnQuest 1096
step
    #completewith Ziz2
    .goto Stonetalon Mountains,59.00,62.60,20 >>Retourne voir |cRXP_FRIENDLY_Ziz Fizziks|r
step
    #label Ziz2
    .goto Stonetalon Mountains,59.00,62.60
    >>Parle à |cRXP_FRIENDLY_Ziz Fizziks|r
    .turnin 1092 >>Rends Les ordres de Gerenzo
    .turnin -1096 >>Rends Gerenzo Wrenchwhistle
    .target 4201

-- ===== Sortie vers les Barrens : Seereth =====
step
    #completewith Seereth
    .goto Stonetalon Mountains,74.50,97.00,40,0
    .goto Stonetalon Mountains,82.50,98.60,30 >>Descends vers Malaka'jin et prends le col vers les Barrens
    .isQuestComplete 1068
step
    #label Seereth
    .goto The Barrens,35.30,27.90
    >>Parle à |cRXP_FRIENDLY_Seereth Stonebreak|r
    .turnin 1068 >>Rends Les machines à déchiqueter
    .target 4049
    .isQuestComplete 1068
step
    #label FinSerresRocheuses
    +|cRXP_WARN_Niveau conseillé pour la suite : 23. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Desolace (Désolace), Horde, toutes classes.
-- Suite de Thousand Needles (fin aux Salines, niveau 30 conseillé).
-- Indépendant des autres régions : les quêtes venues d'ailleurs sont protégées par
-- .isOnQuest / .isQuestTurnedIn, la chaîne d'Orgrimmar est signalée par une alerte.
-- Les quêtes au-dessus du niveau du joueur sont sautées (.xp <N,1) et leurs trajets gardés
-- par .isOnQuest : un joueur de 30-31 fait la boucle courte, un joueur de 32+ la complète.
-- Données : QuestieDB Forever (tools/questiedb.py). Syntaxe : docs/rxp-custom-guides.md.
-- Coupées : 1366 La prime aux centaures (15 oreilles à 20 % = ~150 kills en duo),
-- 1435/1436 Esprits consumés (15 gemmes, taux inconnu = ~86 kills ; 1436 en dépend),
-- 1482/1484/1488 suite du Corrupteur (cristal d'oracle au nord-ouest déjà quitté, 1488
-- élite niveau 40), 6161 Trésor de Rackmore (clé d'argent au sud-ouest, coffre au
-- nord-ouest, journal au nord : trois passages), 5501 Collectionneur d'os (niveau 33,
-- rendu à la cabane de Kormek hors route), 5386/5421 La prise du jour (échange de
-- crustacés répétable, rendu au poste Ghost Walker hors route), 5821/5943 caravanes de
-- Gizelton (attente imprévisible), 6132/6134 Brimbuzzle (niveau 34, escorte en village
-- maraudine 37-40, spectres à l'extrême sud-est), 1367/1368 et suites centaures
-- (réputation Amical à farmer, chaînes Forever 92xxx/93xxx sans XP connue),
-- 5763 Chasse à Strangleronce (rendu sur un autre continent), 1361 Regthar Deathgate (lettre
-- donnée à Moulin-de-Tarren ou Orgrimmar, rendue dans les Barrens, 640 xp), 1369/1370 et suites
-- 1371, 1373-1375, 1380/1381 (réputation Amical magram ou gelkis à farmer, 1371 demande un
-- objet d'ingénieur), 92743 (suite de 1369, couronne des Badlands), 92754/92755/92814/92817/92818
-- (objets d'artisanat et réputation Amical), 92811/92812 Guerre économique (répétables, sans
-- XP), 94872/94873 Acheter leur amitié (390 xp, rendues aux villages magram et gelkis hors
-- route), 93225 Totems centaures sculptés (5 totems, taux inconnu = ~29 kills en duo pour
-- 2350 xp, à valider en jeu), 93465/93678 Notes sur la draenéthyste (chaîne du guide Swamp of
-- Sorrows), 79229/79235/79236/79242 Crime de grand chemin (Saison de la Découverte, niveau 40,
-- suites rendues à Baie-du-Butin et en Arathi).
-- Les quêtes de Maraudon (7028, 7029, 7044, 7064, 7067) vont dans un guide de donjon.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 30-32 Desolace
#displayname [FDP] Désolace (30-32)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 33-36 Stranglethorn Vale

-- ===== Alertes : quêtes à forte XP dont le prérequis se fait hors de la région =====
step
    #sticky
    #completewith FinDesolace
    .isQuestAvailable 1434
    .isNotOnQuest 1431
    .isNotOnQuest 1432
    .isNotOnQuest 1434
    .maxlevel 35
    .xp 36 >>|cRXP_WARN_Chaîne manquée : Les relations de l'Alliance (~4700 xp). Commence chez Craven Drok à Orgrimmar (51,46)|r

-- ===== Arrivée par Stonetalon =====
step
    #completewith Arrivee
    .zoneskip Desolace
    .fly Sun Rock >>Vole jusqu'à la Retraite de Roche-Soleil (Stonetalon)
step
    #label Arrivee
    .goto Desolace,53.90,8.00,30 >>Prends la route du sud depuis Roche-Soleil jusqu'en Désolace
step
    #completewith Felgur
    .goto Desolace,56.40,21.60,0
    >>Tue les |cRXP_ENEMY_Lame ardente|r au bord de la route : l'un d'eux peut lâcher une |cRXP_LOOT_Peau de démon écorché|r
    >>|cRXP_WARN_Utilise l'objet pour lancer la quête. Ne t'attarde pas si elle ne tombe pas|r
    .collect 20310,1,1480,1 --Peau de démon écorché
    .accept 1480 >>Accepte Le corrupteur
    .use 20310
    .mob 4663
    .mob 4664
    .mob 4666
step
    #completewith Felgur
    .goto Desolace,59.00,14.50,30,0
    .goto Desolace,63.00,25.00,30,0
    .goto Desolace,61.00,35.00,30,0
    .goto Desolace,52.00,40.00,30,0
    .goto Desolace,49.50,54.00,30,0
    .goto Desolace,56.20,59.60,30 >>Suis la route jusqu'au poste Ghost Walker

-- ===== Poste Ghost Walker =====
step
    .goto Desolace,56.20,59.60
    >>Parle à |cRXP_FRIENDLY_Felgur Twocuts|r
    .turnin 1362 >>Rends Les Kolkar de Désolace
    .target 5395
    .isOnQuest 1362
step
    #label Felgur
    .goto Desolace,56.20,59.60
    >>Parle à |cRXP_FRIENDLY_Felgur Twocuts|r
    .accept 1365 >>Accepte Khan Dez'hepah
    .target 5395
step
    .goto Desolace,55.40,55.80
    >>Parle à |cRXP_FRIENDLY_Nataka Longhorn|r
    .turnin 5361 >>Rends Arbre familial
    .target 11259
    .isOnQuest 5361
step
    .goto Desolace,52.60,54.40
    >>Parle à |cRXP_FRIENDLY_Takata Steelblade|r
    .turnin 1432 >>Rends Les relations de l'Alliance
    .target 5641
    .isOnQuest 1432
step
    .goto Desolace,52.60,54.40
    >>Parle à |cRXP_FRIENDLY_Takata Steelblade|r
    .accept 1433 >>Accepte Les relations de l'Alliance
    .accept 1434 >>Accepte Souillé par les satyres
    .target 5641
    .isQuestTurnedIn 1432
step
    .goto Desolace,52.20,53.40
    >>Parle à |cRXP_FRIENDLY_Maurin Bonesplitter|r
    .turnin 1433 >>Rends Les relations de l'Alliance
    .target 4498
    .isOnQuest 1433
step
    .goto Desolace,52.20,53.40
    >>Parle à |cRXP_FRIENDLY_Maurin Bonesplitter|r
    .turnin 1480 >>Rends Le corrupteur
    .target 4498
    .isOnQuest 1480
step
    .goto Desolace,52.20,53.40
    >>Parle à |cRXP_FRIENDLY_Maurin Bonesplitter|r
    .accept 1481 >>Accepte Le corrupteur
    .target 4498
    .isQuestTurnedIn 1480
step
    .goto Desolace,60.90,61.90
    >>Parle à |cRXP_FRIENDLY_Smeed Scrabblescrew|r à l'est du poste
    .accept 5561 >>Accepte Le rassemblement des kodos
    .target 11596

-- ===== Cimetière des kodos =====
step
    .goto Desolace,52.60,57.50,30,0
    .goto Desolace,50.50,56.60,30,0
    .goto Desolace,48.30,60.20,30,0
    .goto Desolace,52.20,60.60
    >>Utilise le |cRXP_LOOT_Kombobulateur Kodo|r sur un |cRXP_ENEMY_kodo|r du cimetière, puis ramène le kodo dompté à |cRXP_FRIENDLY_Smeed|r (60.9,61.9). Recommence 5 fois
    >>|cRXP_WARN_Chacun dompte ses propres kodos|r
    .complete 5561,1 --Kodo dompté (5)
    .use 13892
    .mob 4700
    .mob 4701
    .mob 4702
step
    .goto Desolace,60.90,61.90
    >>Parle à |cRXP_FRIENDLY_Smeed Scrabblescrew|r
    .turnin 5561 >>Rends Le rassemblement des kodos
    .target 11596

-- ===== Village kolkar : Khan Dez'hepah =====
step
    #completewith KhanDez
    .goto Desolace,67.00,58.00,30,0
    .goto Desolace,68.00,47.00,30 >>Va au village kolkar au nord-est
step
    #label KhanDez
    .goto Desolace,73.20,41.80,30,0
    .goto Desolace,74.00,43.60,30,0
    .goto Desolace,73.60,46.60,30,0
    .goto Desolace,73.20,41.80
    >>Tue |cRXP_ENEMY_Khan Dez'hepah|r et prends sa |cRXP_LOOT_Tête|r. Il est entouré de gardes : tire-les un par un
    .complete 1365,1 --Tête du khan Dez'hepah
    .unitscan 5600
    .mob 4636
    .mob 4637
step
    #completewith next
    .goto Desolace,62.00,58.00,30 >>Retourne au poste Ghost Walker
step
    .goto Desolace,56.20,59.60
    >>Parle à |cRXP_FRIENDLY_Felgur Twocuts|r
    .turnin 1365 >>Rends Khan Dez'hepah
    .target 5395

-- ===== Shadowprey =====
step
    #completewith Thalon
    .goto Desolace,48.50,61.00,30,0
    .goto Desolace,44.00,64.00,30,0
    .goto Desolace,34.00,67.00,30,0
    .goto Desolace,26.00,69.00,30 >>Va à l'ouest jusqu'au village de Shadowprey
    >>|cRXP_WARN_Reste au sud : les centaures maraudine (37-40) tiennent la zone au nord de la route|r
step
    #label Thalon
    .goto Desolace,21.60,74.10
    >>Parle à |cRXP_FRIENDLY_Thalon|r
    .fp Shadowprey Village >>Prends le point de vol de Shadowprey
    .target 6726
step
    .goto Desolace,23.30,72.90
    >>Parle à |cRXP_FRIENDLY_Drulzegar Skraghook|r
    .accept 6143 >>Accepte D'autres poissons-chats à fouetter
    .target 12340
    .xp <32,1
step
    .goto Desolace,22.60,72.00
    >>Parle à |cRXP_FRIENDLY_Mai'Lahii|r
    .accept 6142 >>Accepte Des praires comme appât
    .target 12031
    .xp <31,1
step
    .goto Desolace,24.10,68.20
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Sikewa|r
    .home >>Fixe ta pierre de foyer à Shadowprey
    .target 11106
step
    .goto Desolace,25.80,68.20
    >>Parle à |cRXP_FRIENDLY_Taiga Wisemane|r
    .accept 5381 >>Accepte La Main d'Iruxos
    .target 11624
    .xp <32,1
step
    .goto Desolace,25.30,67.00
    >>Parle à |cRXP_FRIENDLY_Aka'rai|r
    .accept 97265 >>Accepte Furie contre les Fielfuries
    .target 268705

-- ===== Côte ouest : praires =====
step
    .goto Desolace,25.40,47.80,40,0
    .goto Desolace,24.60,44.10,40,0
    .goto Desolace,25.70,38.90,40,0
    .goto Desolace,26.20,36.70,40,0
    .goto Desolace,29.70,36.70,40,0
    .goto Desolace,32.50,33.80
    >>Ouvre les |cRXP_PICK_Praires géantes|r sur la plage et tue les |cRXP_ENEMY_Clampants des récifs enragés|r pour la |cRXP_LOOT_Chair de praire|r
    .complete 6142,1 --Chair de praire (10)
    .mob 12347
    .isOnQuest 6142

-- ===== Ethel Rethor et fort de Thunder Axe =====
step
    #completewith Azore1
    .goto Desolace,38.90,27.20,30 >>Va à la tour d'Ethel Rethor
step
    #label Azore1
    .goto Desolace,38.90,27.20
    >>Parle à |cRXP_FRIENDLY_Azore Aldamort|r en haut de la tour
    .accept 5741 >>Accepte Sceptre de lumière
    .target 11863
step
    #completewith Seer
    .goto Desolace,52.50,28.50,0
    >>Tue les |cRXP_ENEMY_Lame ardente|r du fort : l'un d'eux peut lâcher une |cRXP_LOOT_Peau de démon écorché|r
    >>|cRXP_WARN_Utilise l'objet pour lancer la quête|r
    .collect 20310,1,1480,1 --Peau de démon écorché
    .accept 1480 >>Accepte Le corrupteur
    .use 20310
    .mob 4663
    .mob 4664
    .mob 4665
    .mob 4666
    .mob 4667
step
    .goto Desolace,55.00,26.60
    >>Récupère la |cRXP_LOOT_Boîte démoniaque|r dans le fort : tue l'|cRXP_ENEMY_Esprit démon|r (37) qui la garde
    >>|cRXP_WARN_Garde la Pioche démoniaque, elle se rend avec la boîte|r
    .complete 5381,1 --Boîte démoniaque
    .mob 11876
    .isOnQuest 5381
step
    #label Seer
    .goto Desolace,55.20,30.10
    >>Tue le |cRXP_ENEMY_Prophète de la Lame ardente|r et prends le |cRXP_LOOT_Sceptre de lumière|r
    .complete 5741,1 --Sceptre de lumière
    .mob 13019
step
    #completewith Azore2
    .goto Desolace,38.90,27.20,30 >>Retourne à la tour d'Ethel Rethor
step
    #label Azore2
    .goto Desolace,38.90,27.20
    >>Parle à |cRXP_FRIENDLY_Azore Aldamort|r
    .turnin 5741 >>Rends Sceptre de lumière
    .target 11863
step
    .goto Desolace,38.90,27.20
    >>Parle à |cRXP_FRIENDLY_Azore Aldamort|r
    .accept 6027 >>Accepte Le Livre des Anciens
    .target 11863
    .xp <33,1

-- ===== Côte nord-ouest : Ondulames et Kragaru =====
step
    .goto Desolace,32.70,23.90,40,0
    .goto Desolace,31.60,17.00,40,0
    .goto Desolace,32.70,14.70,40,0
    .goto Desolace,33.90,7.70,40,0
    .goto Desolace,32.70,23.90
    >>Tue les |cRXP_ENEMY_Myrmidons|r, |cRXP_ENEMY_Nagas|r et |cRXP_ENEMY_Sorcières Ondulames|r
    .complete 6143,1 --Myrmidon Ondulame (7)
    .complete 6143,2 --Naga Ondulame (7)
    .complete 6143,3 --Sorcière Ondulame (5)
    .mob 4714
    .mob 4711
    .mob 4712
    .isOnQuest 6143
step
    .goto Desolace,28.20,6.70
    >>Tue le |cRXP_ENEMY_Seigneur Kragaru|r (38) et prends le |cRXP_LOOT_Livre des Anciens|r
    .complete 6027,1 --Livre des Anciens
    .mob 12369
    .isOnQuest 6027
step
    .goto Desolace,38.90,27.20
    >>Parle à |cRXP_FRIENDLY_Azore Aldamort|r
    .turnin 6027 >>Rends Le Livre des Anciens
    .target 11863
    .isQuestComplete 6027

-- ===== Sargeron : satyres Fielfurie =====
step
    #completewith Sargeron
    .goto Desolace,60.00,15.00,40,0
    .goto Desolace,70.10,15.60,30 >>Va à Sargeron, au nord-est
step
    #completewith Sargeron
    >>Tue les |cRXP_ENEMY_Traqueurs des ténèbres Fielfurie|r pour un |cRXP_LOOT_Scalp de Traqueur des ténèbres|r
    .complete 1481,1 --Scalp de Traqueur des ténèbres
    .mob 4674
    .isOnQuest 1481
step
    #completewith Sargeron
    >>Tue les |cRXP_ENEMY_Voleurs|r, |cRXP_ENEMY_Liges|r, |cRXP_ENEMY_Traîtres|r et |cRXP_ENEMY_Implorateurs Fielfurie|r
    .complete 1434,1 --Voleur Fielfurie (7)
    .complete 1434,2 --Lige de la corruption Fielfurie (7)
    .complete 1434,3 --Traître Fielfurie (7)
    .complete 1434,4 --Implorateur de l'enfer Fielfurie (7)
    .mob 4670
    .mob 4672
    .mob 4673
    .mob 4675
    .isOnQuest 1434
step
    #label Sargeron
    .goto Desolace,73.70,12.20,40,0
    .goto Desolace,75.20,10.70,40,0
    .goto Desolace,78.20,16.90,40,0
    .goto Desolace,77.30,20.40,40,0
    .goto Desolace,74.50,13.40
    >>Tue les satyres |cRXP_ENEMY_Fielfurie|r de chaque type demandé
    .complete 97265,1 --Entourloupeur Fielfurie
    .complete 97265,2 --Implorateur de l'enfer Fielfurie
    .complete 97265,3 --Traqueur des ténèbres Fielfurie
    .complete 97265,4 --Lige de la corruption Fielfurie
    .complete 97265,5 --Voleur Fielfurie
    .mob 4671
    .mob 4675
    .mob 4674
    .mob 4672
    .mob 4670
step
    .goto Desolace,74.50,13.40
    >>Finis le |cRXP_LOOT_Scalp de Traqueur des ténèbres|r
    .complete 1481,1 --Scalp de Traqueur des ténèbres
    .mob 4674
    .isOnQuest 1481
step
    .goto Desolace,74.50,13.40
    >>Finis les satyres de Souillé par les satyres
    .complete 1434,1 --Voleur Fielfurie (7)
    .complete 1434,2 --Lige de la corruption Fielfurie (7)
    .complete 1434,3 --Traître Fielfurie (7)
    .complete 1434,4 --Implorateur de l'enfer Fielfurie (7)
    .mob 4670
    .mob 4672
    .mob 4673
    .mob 4675
    .isOnQuest 1434

-- ===== Retour : pierre de foyer, ou poste Ghost Walker si une quête y attend =====
step
    .isNotOnQuest 1480
    .isNotOnQuest 1481
    .isNotOnQuest 1434
    .hs >>Utilise ta pierre de foyer vers Shadowprey
step
    #completewith GWPRetour
    .goto Desolace,62.00,19.00,30,0
    .goto Desolace,63.00,29.00,30,0
    .goto Desolace,58.00,38.00,30,0
    .goto Desolace,50.00,47.00,30,0
    .goto Desolace,52.20,53.40,30 >>Descends la route jusqu'au poste Ghost Walker
    .isOnQuest 1480
step
    #completewith GWPRetour
    .goto Desolace,62.00,19.00,30,0
    .goto Desolace,63.00,29.00,30,0
    .goto Desolace,58.00,38.00,30,0
    .goto Desolace,50.00,47.00,30,0
    .goto Desolace,52.20,53.40,30 >>Descends la route jusqu'au poste Ghost Walker
    .isOnQuest 1481
step
    #completewith GWPRetour
    .goto Desolace,62.00,19.00,30,0
    .goto Desolace,63.00,29.00,30,0
    .goto Desolace,58.00,38.00,30,0
    .goto Desolace,50.00,47.00,30,0
    .goto Desolace,52.60,54.40,30 >>Descends la route jusqu'au poste Ghost Walker
    .isOnQuest 1434
step
    .goto Desolace,52.20,53.40
    >>Parle à |cRXP_FRIENDLY_Maurin Bonesplitter|r
    .turnin 1480 >>Rends Le corrupteur
    .target 4498
    .isOnQuest 1480
step
    .goto Desolace,52.20,53.40
    >>Parle à |cRXP_FRIENDLY_Maurin Bonesplitter|r
    .turnin 1481 >>Rends Le corrupteur
    .target 4498
    .isQuestComplete 1481
step
    #label GWPRetour
    .goto Desolace,52.60,54.40
    >>Parle à |cRXP_FRIENDLY_Takata Steelblade|r
    .turnin 1434 >>Rends Souillé par les satyres
    .target 5641
    .isQuestComplete 1434

-- ===== Shadowprey : rendus =====
step
    .goto Desolace,25.30,67.00
    >>Parle à |cRXP_FRIENDLY_Aka'rai|r
    .turnin 97265 >>Rends Furie contre les Fielfuries
    .target 268705
step
    .goto Desolace,25.80,68.20
    >>Parle à |cRXP_FRIENDLY_Taiga Wisemane|r
    .turnin 5381 >>Rends La Main d'Iruxos
    .target 11624
    .isQuestComplete 5381
step
    .goto Desolace,25.80,68.20
    >>Parle à |cRXP_FRIENDLY_Taiga Wisemane|r
    .accept 5581 >>Accepte Les portails de la Légion
    .target 11624
    .isQuestTurnedIn 5381
    .xp <33,1
step
    .goto Desolace,22.60,72.00
    >>Parle à |cRXP_FRIENDLY_Mai'Lahii|r
    .turnin 6142 >>Rends Des praires comme appât
    .target 12031
    .isQuestComplete 6142
step
    .goto Desolace,23.30,72.90
    >>Parle à |cRXP_FRIENDLY_Drulzegar Skraghook|r
    .turnin 6143 >>Rends D'autres poissons-chats à fouetter
    .target 12340
    .isQuestComplete 6143

-- ===== Mannoroc : portails de la Légion =====
step
    #completewith Portails
    .goto Desolace,34.00,70.00,30,0
    .goto Desolace,44.00,75.00,30 >>Va à l'est jusqu'au Convent de Mannoroc
    .isOnQuest 5581
step
    #label Portails
    .goto Desolace,49.60,76.00,30,0
    .goto Desolace,50.20,74.40,30,0
    .goto Desolace,50.00,77.60,30,0
    .goto Desolace,49.60,76.00
    >>Utilise la |cRXP_LOOT_Main d'Iruxos|r près d'un portail, puis tue le |cRXP_ENEMY_Gardien du Portail démoniaque|r (38-39) qui apparaît. Recommence 6 fois
    >>|cRXP_WARN_Seigneur Azrethoc (élite 40) rôde au sud-est du convent (57,76) : ne t'en approche pas|r
    .complete 5581,1 --Portails bannis (6)
    .use 14547
    .mob 11937
    .isOnQuest 5581
step
    .goto Desolace,25.80,68.20
    >>Retourne à Shadowprey et parle à |cRXP_FRIENDLY_Taiga Wisemane|r
    .turnin 5581 >>Rends Les portails de la Légion
    .target 11624
    .isQuestComplete 5581
step
    #label FinDesolace
    +|cRXP_WARN_Niveau conseillé pour la suite : 32. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

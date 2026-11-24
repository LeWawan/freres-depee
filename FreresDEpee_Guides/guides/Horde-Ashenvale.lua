if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Ashenvale, Horde, toutes classes, à partir du niveau 22.
-- Suite du guide officiel RestedXP Forever « 17-22 Stonetalon/Barrens/Ashenvale » : les
-- quêtes que ce guide fait déjà (Vorsha, accepts de Zoram'gar) restent ici en doublon
-- inoffensif (un .accept ou un .complete déjà rendu est validé tout seul).
-- Indépendant des autres régions : les quêtes venues d'ailleurs sont protégées par
-- .isOnQuest / .isQuestComplete.
-- Données : QuestieDB Forever (tools/questiedb.py). Syntaxe : docs/rxp-custom-guides.md.
-- Coupées : 6441 Cornes de satyre (16 cornes à 45 % = ~70 kills en duo pour 2100 xp),
-- 6442 Nagas de Zoram (20 têtes = ~55 kills pour 1450 xp, déjà dans le guide RXP),
-- 6571/6581 Fournitures chanteguerres (cargaison de haches à Strangleronce, tromblon
-- d'ingénieur, corde à 3 %), 6504 Les pages perdues (12 pages en drop aléatoire).
-- Les quêtes des Profondeurs de Brassenoire (6563-6565, 6921, 6922) sont dans le guide
-- de donjon Horde-Donjon-Brassenoire.lua.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 22-26 Ashenvale
#displayname [FDP] Ashenvale (22-26)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 27-33 Thousand Needles

-- ===== Alertes : quêtes dont le départ se fait hors de la région =====
step
    #sticky
    #completewith FinAshenvale
    .isQuestAvailable 6543
    .isNotOnQuest 6543
    .maxlevel 23
    .xp 24 >>|cRXP_WARN_Quête manquée : Les rapports chanteguerres (~1800 xp). Chez Kadrak à la tour nord des Barrens (48,5), sur la route d'Ashenvale|r

-- ===== Poste de Bois-brisé : arrivée =====
step
    #completewith Vhulgra
    .goto Ashenvale,73.18,61.59,40 >>Va au poste de Bois-brisé. Depuis Zoram'gar, prends le vol
step
    #label Vhulgra
    .goto Ashenvale,73.18,61.59
    >>Parle à |cRXP_FRIENDLY_Vhulgra|r
    .fp Splintertree Post >>Prends le point de vol du poste de Bois-brisé
    .target 12616
step
    .goto Ashenvale,73.78,61.46
    >>Parle à |cRXP_FRIENDLY_Senani Thunderheart|r
    .turnin 235 >>Rends La Chasse d'Ashenvale
    .target 12696
    .isOnQuest 235
step
    .goto Ashenvale,73.78,61.46
    >>Parle à |cRXP_FRIENDLY_Senani Thunderheart|r
    .turnin 742 >>Rends La Chasse d'Ashenvale
    .target 12696
    .isOnQuest 742
step
    .goto Ashenvale,73.78,61.46
    >>Parle à |cRXP_FRIENDLY_Senani Thunderheart|r
    .turnin 6382 >>Rends La Chasse d'Ashenvale
    .target 12696
    .isOnQuest 6382
step
    .goto Ashenvale,73.78,61.46
    >>Parle à |cRXP_FRIENDLY_Senani Thunderheart|r
    .accept 6383 >>Accepte La Chasse d'Ashenvale
    .turnin 6383 >>Rends La Chasse d'Ashenvale
    .target 12696
step
    .goto Ashenvale,71.05,68.36
    >>Parle à l'|cRXP_FRIENDLY_Eclaireur chanteguerre|r et donne-lui un |cRXP_LOOT_Rapport du clan Chanteguerre|r
    >>|cRXP_WARN_Ouvre la Liasse de rapports si besoin|r
    .accept 6547 >>Accepte Mise à jour de l'Eclaireur chanteguerre
    .turnin 6547 >>Rends Mise à jour de l'Eclaireur chanteguerre
    .complete 6543,1 --Mise à jour de l'Eclaireur Warsong
    .target 12862
    .isOnQuest 6543
step
    .goto Ashenvale,71.11,68.12
    >>Parle à |cRXP_FRIENDLY_Kuray'bin|r au sud du poste
    .accept 6503 >>Accepte Les estafettes d'Ashenvale
    .target 12867

-- ===== Sud du poste : estafettes et assaut de Torek =====
step
    #completewith TorekFin
    >>Tue les |cRXP_ENEMY_Estafettes d'Ashenvale|r. Elles sont furtives et patrouillent entre le poste et l'avant-poste d'Aile-argent
    .complete 6503,1 --Estafette d'Ashenvale (9)
    .mob 12856
step
    .goto Ashenvale,68.34,75.30
    >>Parle à |cRXP_FRIENDLY_Torek|r pour lancer l'escorte
    >>|cRXP_WARN_Torek met environ 5 min à réapparaître s'il est déjà parti|r
    .accept 6544 >>Accepte L'assaut de Torek
    .target 12858
step
    #label TorekFin
    .goto Ashenvale,66.70,75.30,20,0
    .goto Ashenvale,64.65,75.35
    >>Suis |cRXP_FRIENDLY_Torek|r dans l'avant-poste d'Aile-argent. Laisse ses |cRXP_FRIENDLY_Écumeurs|r prendre l'aggro
    >>|cRXP_WARN_Quand la maison est vidée, monte au balcon : |cRXP_ENEMY_Duriel Moonfire|r arrive, laisse Torek la prendre avant de frapper|r
    .complete 6544,1 --Prendre l'avant-poste d'Aile-argent
    .mob 12896
    .mob 12897
    .unitscan 12860
step
    .goto Ashenvale,71.80,74.60,40,0
    .goto Ashenvale,70.50,76.20,40,0
    .goto Ashenvale,73.60,70.80,40,0
    .goto Ashenvale,74.20,69.50
    >>Finis les |cRXP_ENEMY_Estafettes d'Ashenvale|r
    .complete 6503,1 --Estafette d'Ashenvale (9)
    .mob 12856
step
    .goto Ashenvale,71.11,68.12
    >>Parle à |cRXP_FRIENDLY_Kuray'bin|r
    .turnin 6503 >>Rends Les estafettes d'Ashenvale
    .target 12867

-- ===== Poste de Bois-brisé : rendus =====
step
    .goto Ashenvale,73.03,62.47
    >>Parle à |cRXP_FRIENDLY_Ertog Ragetusk|r
    .turnin 6544 >>Rends L'assaut de Torek
    .target 12877
step
    .xp 23 >>Monte au niveau 23, requis pour les quêtes de Mastok
step
    .goto Ashenvale,73.67,60.00
    >>Parle à |cRXP_FRIENDLY_Mastok Wrilehiss|r
    .accept 25 >>Accepte Impasse aux Serres-Rocheuses
    .target 12737
step
    #completewith ZoramFP
    .goto Ashenvale,73.18,61.59
    >>Parle à |cRXP_FRIENDLY_Vhulgra|r
    .fly Zoram'gar Outpost >>Vole vers l'avant-poste de Zoram'gar
    .target 12616

-- ===== Avant-poste de Zoram'gar =====
step
    #label ZoramFP
    .goto Ashenvale,12.24,33.80
    >>Parle à |cRXP_FRIENDLY_Andruk|r
    .fp Zoram'gar Outpost >>Prends le point de vol de Zoram'gar
    .target 11901
step
    .goto Ashenvale,11.56,34.29
    >>Parle à |cRXP_FRIENDLY_Je'neu Sancrea|r
    .turnin 6562 >>Rends Problèmes dans les profondeurs
    .target 12736
    .isOnQuest 6562
step
    .goto Ashenvale,11.69,34.91
    >>Parle à |cRXP_FRIENDLY_Marukai|r
    .turnin 6442 >>Rends Des nagas sur la grève de Zoram
    .target 12719
    .isQuestComplete 6442
step
    .goto Ashenvale,11.90,34.54
    >>Parle à |cRXP_FRIENDLY_Karang Amakkar|r et |cRXP_FRIENDLY_Mitsuwa|r
    .accept 216 >>Accepte Entre un roc et un Crin-de-Chardon
    .accept 6462 >>Accepte Charme troll
    .target 12757
    .target 12721
step
    .goto Ashenvale,12.06,34.63
    >>Parle à |cRXP_FRIENDLY_Muglash|r pour lancer l'escorte
    >>|cRXP_WARN_Escorte difficile : reste groupé avec ton binôme|r
    .accept 6641 >>Accepte Vorsha la Flagellante
    .target 12717
step
    .goto Ashenvale,9.59,27.58
    >>Suis |cRXP_FRIENDLY_Muglash|r jusqu'au brasero, puis clique sur le |cRXP_PICK_Brasero|r pour l'éteindre
    >>|cRXP_WARN_Des vagues de nagas arrivent, puis |cRXP_ENEMY_Vorsha la Flagellante|r : laisse Muglash prendre l'aggro|r
    .complete 6641,1 --Vaincre Vorsha la Flagellante
    .mob 12940
    .mob 3712
    .mob 3715
step
    .goto Ashenvale,12.22,34.22
    >>Parle au |cRXP_FRIENDLY_Messager chanteguerre|r
    .turnin 6641 >>Rends Vorsha la Flagellante
    .target 12863
step
    .goto Ashenvale,12.22,34.22
    >>Donne un |cRXP_LOOT_Rapport du clan Chanteguerre|r au |cRXP_FRIENDLY_Messager chanteguerre|r
    .accept 6545 >>Accepte Mise à jour du Messager chanteguerre
    .turnin 6545 >>Rends Mise à jour du Messager chanteguerre
    .complete 6543,2 --Mise à jour du Messager Warsong
    .target 12863
    .isOnQuest 6543

-- ===== Village Crin-de-Chardon : furbolgs, coffres, Ruul =====
step
    #completewith Ruul
    .goto Ashenvale,36.50,36.50,40 >>Va au village Crin-de-Chardon, à l'est
step
    #completewith Ruul
    >>Tue les |cRXP_ENEMY_Vengeurs|r et |cRXP_ENEMY_Chamans Crin-de-Chardon|r
    .complete 216,1 --Vengeur Crin-de-Chardon (8)
    .complete 216,2 --Chaman Crin-de-Chardon (8)
    .mob 3925
    .mob 3924
step
    #completewith Ruul
    >>Ouvre les |cRXP_PICK_Coffres de troll|r dans le village pour les |cRXP_LOOT_Charmes troll|r
    >>|cRXP_WARN_Chacun doit ouvrir ses propres coffres (8 chacun)|r
    .complete 6462,1 --Charme troll (8)
step
    #label Ruul
    .goto Ashenvale,41.53,34.49
    >>Parle à |cRXP_FRIENDLY_Ruul Snowhoof|r dans la cage pour lancer l'escorte
    .accept 6482 >>Accepte Liberté pour Ruul
    .target 12818
step
    .goto Ashenvale,38.53,37.32
    >>Escorte |cRXP_FRIENDLY_Ruul Snowhoof|r hors du village. Des furbolgs l'attaquent en route
    .complete 6482,1 --Escorter Ruul hors des Crin-de-Chardon
    .mob 3925
    .mob 3924
    .mob 3926
step
    .goto Ashenvale,40.50,32.20,25,0
    .goto Ashenvale,41.30,34.20,25,0
    .goto Ashenvale,41.70,35.70,25,0
    .goto Ashenvale,40.20,31.00,25,0
    .goto Ashenvale,39.50,36.80
    >>Finis les furbolgs et les |cRXP_PICK_Coffres de troll|r
    .complete 216,1 --Vengeur Crin-de-Chardon (8)
    .complete 216,2 --Chaman Crin-de-Chardon (8)
    .complete 6462,1 --Charme troll (8)
    .mob 3925
    .mob 3924
step
    .goto Ashenvale,11.90,34.54
    >>Retourne à Zoram'gar. Parle à |cRXP_FRIENDLY_Karang Amakkar|r et |cRXP_FRIENDLY_Mitsuwa|r
    .turnin 216 >>Rends Entre un roc et un Crin-de-Chardon
    .accept 6621 >>Accepte Le roi des Vile-sylve
    .turnin 6462 >>Rends Charme troll
    .target 12757
    .target 12721

-- ===== Lac Mystral : Va'xug, Ursangous, élémentaires =====
step
    .goto Ashenvale,40.46,61.42
    >>Parle à |cRXP_FRIENDLY_Va'xug Cendrerage|r, au nord-ouest du lac de la Chute-du-ciel
    .accept 98251 >>Accepte Point de non-retour
    .target 267214
step
    #completewith VaxugRetour
    >>Tue les |cRXP_ENEMY_Cerfs à corne noire|r et |cRXP_ENEMY_Ours d'Ashenvale|r au passage
    .complete 98251,1 --Cerf à corne noire (6)
    .complete 98251,2 --Ours d'Ashenvale (6)
    .mob 3817
    .mob 3809
step
    .goto Ashenvale,39.76,65.21
    >>Tue |cRXP_ENEMY_Ursangous|r et ramasse la |cRXP_LOOT_Patte d'Ursangous|r. Utilise-la pour lancer la quête
    >>|cRXP_WARN_Si une seule patte tombe, attendez la réapparition pour le binôme|r
    .collect 16303,1,23,1 --Patte d'Ursangous
    .accept 23 >>Accepte La patte d'Ursangous
    .use 16303
    .unitscan 12678
step
    #completewith Gazebo
    >>Tue les |cRXP_ENEMY_Elémentaires d'eau souillés|r du lac Mystral
    .complete 25,1 --Elémentaire d'eau souillé (12)
    .mob 3917
step
    .goto Ashenvale,46.00,70.00
    >>Tue |cRXP_ENEMY_Maréen|r sur le lac et ramasse le |cRXP_LOOT_Globe d'eau souillée|r. Utilise-le pour lancer la quête
    .collect 16408,1,1918,1 --Globe d'eau souillée
    .accept 1918 >>Accepte Les éléments souillés
    .use 16408
    .unitscan 12759
step
    #label Gazebo
    .goto Ashenvale,48.92,69.56
    >>Monte sur le kiosque du lac qui surplombe l'avant-poste de l'Alliance
    .complete 25,2 --Observer depuis le kiosque
step
    .goto Ashenvale,45.10,69.30,30,0
    .goto Ashenvale,48.40,72.80,30,0
    .goto Ashenvale,51.20,73.40,30,0
    .goto Ashenvale,46.30,70.70
    >>Finis les |cRXP_ENEMY_Elémentaires d'eau souillés|r
    .complete 25,1 --Elémentaire d'eau souillé (12)
    .mob 3917
step
    .goto Ashenvale,39.80,67.20,40,0
    .goto Ashenvale,41.50,59.30,40,0
    .goto Ashenvale,45.00,58.00,40,0
    .goto Ashenvale,40.46,61.42
    >>Finis les |cRXP_ENEMY_Cerfs|r et |cRXP_ENEMY_Ours|r en revenant vers Va'xug
    .complete 98251,1 --Cerf à corne noire (6)
    .complete 98251,2 --Ours d'Ashenvale (6)
    .mob 3817
    .mob 3809
step
    #label VaxugRetour
    .goto Ashenvale,40.46,61.42
    >>Parle à |cRXP_FRIENDLY_Va'xug Cendrerage|r
    .turnin 98251 >>Rends Point de non-retour
    .accept 98252 >>Accepte La voie du Vide
    .target 267214
step
    .goto Ashenvale,44.37,56.48
    >>Guide l'|cRXP_FRIENDLY_Oeil de Kilrogg|r de Va'xug jusqu'à la route principale, au nord-est
    .complete 98252,1 --Oeil de Kilrogg guidé jusqu'à la route
step
    .goto Ashenvale,44.37,56.48
    >>Parle à l'|cRXP_FRIENDLY_Oeil de Kilrogg|r
    .turnin 98252 >>Rends La voie du Vide
    .target 271181

-- ===== Vile-sylve : Murgut et Shadumbra =====
step
    .goto Ashenvale,56.37,63.49
    >>Utilise la |cRXP_LOOT_Bannière de Karang|r sur le |cRXP_PICK_Tertre totémique Vile-sylve|r. Protège-la des vagues de furbolgs
    >>Tue le |cRXP_ENEMY_Chef Murgut|r et prends le |cRXP_LOOT_Totem de Murgut|r (sur lui ou dans le |cRXP_PICK_Panier à Totems|r à côté)
    .complete 6621,1 --Totem de Murgut
    .use 16972
    .mob 12918
    .mob 3743
    .mob 3750
step
    .goto Ashenvale,57.50,56.05
    >>Tue |cRXP_ENEMY_Shadumbra|r (niveau 28) et ramasse la |cRXP_LOOT_Tête de Shadumbra|r. Utilise-la pour lancer la quête
    >>|cRXP_WARN_Elle rôde dans le coin. Si une seule tête tombe, attendez la réapparition pour le binôme|r
    .collect 16304,1,24,1 --Tête de Shadumbra
    .accept 24 >>Accepte La tête de Shadumbra
    .use 16304
    .unitscan 12677
step
    .goto Ashenvale,81.83,53.51
    >>Détour à l'est : donne un |cRXP_LOOT_Rapport du clan Chanteguerre|r au |cRXP_FRIENDLY_Voltigeur chanteguerre|r
    .accept 6546 >>Accepte Mise à jour du voltigeur chanteguerre
    .turnin 6546 >>Rends Mise à jour du voltigeur chanteguerre
    .complete 6543,3 --Mise à jour du Voltigeur Warsong
    .target 12864
    .isOnQuest 6543

-- ===== Poste de Bois-brisé : rendus =====
step
    #completewith Mastok2
    .goto Ashenvale,73.18,61.59,40 >>Retourne au poste de Bois-brisé
step
    #label Mastok2
    .goto Ashenvale,73.67,60.00
    >>Parle à |cRXP_FRIENDLY_Mastok Wrilehiss|r
    .turnin 25 >>Rends Impasse aux Serres-Rocheuses
    .turnin 1918 >>Rends Les éléments souillés
    .accept 824 >>Accepte Je'neu du Cercle terrestre
    .target 12737
step
    .goto Ashenvale,74.11,60.92
    >>Parle à |cRXP_FRIENDLY_Yama Snowhoof|r
    .turnin 6482 >>Rends Liberté pour Ruul
    .target 12837
step
    .goto Ashenvale,73.78,61.46
    >>Parle à |cRXP_FRIENDLY_Senani Thunderheart|r
    .turnin 23 >>Rends La patte d'Ursangous
    .turnin 24 >>Rends La tête de Shadumbra
    .target 12696

-- ===== Serres-tranchantes puis La chasse achevée =====
step
    .goto Ashenvale,74.98,70.06
    >>Tue |cRXP_ENEMY_Serres-tranchantes|r (hippogriffe niveau 31) et ramasse sa |cRXP_LOOT_Griffe|r. Utilise-la pour lancer la quête
    >>|cRXP_WARN_Il frappe fort : à faire en duo, vies pleines. Si une seule griffe tombe, attendez la réapparition pour le binôme|r
    .collect 16305,1,2,1 --Griffe de Serres-tranchantes
    .accept 2 >>Accepte La griffe de Serres-tranchantes
    .use 16305
    .unitscan 12676
    .xp <26,1
step
    .goto Ashenvale,73.78,61.46
    >>Parle à |cRXP_FRIENDLY_Senani Thunderheart|r
    .turnin 2 >>Rends La griffe de Serres-tranchantes
    .accept 247 >>Accepte La chasse achevée
    .turnin 247 >>Rends La chasse achevée
    .target 12696
    .isOnQuest 2

-- ===== Zoram'gar : derniers rendus =====
step
    #completewith Jeneu
    .goto Ashenvale,73.18,61.59
    >>Parle à |cRXP_FRIENDLY_Vhulgra|r
    .fly Zoram'gar Outpost >>Vole vers l'avant-poste de Zoram'gar
    .target 12616
step
    #label Jeneu
    .goto Ashenvale,11.56,34.29
    >>Parle à |cRXP_FRIENDLY_Je'neu Sancrea|r
    .turnin 824 >>Rends Je'neu du Cercle terrestre
    .target 12736
step
    .goto Ashenvale,11.90,34.54
    >>Parle à |cRXP_FRIENDLY_Karang Amakkar|r
    .turnin 6621 >>Rends Le roi des Vile-sylve
    .target 12757
step
    #label FinAshenvale
    +|cRXP_WARN_Niveau conseillé pour la suite : 27. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer

]])

if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Stranglethorn Vale (Strangleronce), Horde, toutes classes.
-- Indépendant des autres régions : les quêtes venues d'ailleurs sont protégées par
-- .isOnQuest / .isQuestTurnedIn, la chaîne gobeline manquée est signalée en tête de guide.
-- Données : QuestieDB Forever (tools/questiedb.py). Syntaxe : docs/rxp-custom-guides.md.
-- Itinéraire : zeppelin -> Grom'gol -> Baie-du-Butin (prise des quêtes, vol) -> Grom'gol ->
-- boucle nord (Nesingwary, Zul'Kunda, camp de la KapitalRisk) -> pierre de foyer ->
-- Grom'gol (Récif infâme, Mosh'Ogg, Ombregueules) -> vol vers Baie-du-Butin (rendus).
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   581/582 La chasse pour Yenniku / La chasse aux têtes (49 + 50 kills, chaîne < 100 xp/kill,
--     suites 584+ niveau 41-46), 596 Colliers d'os (25 à 17 % = ~294 kills), 598 (suite),
--   572/571/573 Mok'thardin 2-4 (plumes 25 % = 80 kills, tendon 5 %, niveau 41-44),
--   577/628 Drizzlik (rendu à Baie-du-Butin avant les Gueules d'acier : 3e aller-retour, croco élite),
--   338-342 pages des Vertes collines (1-3 %), 193/196/197/208 Nesingwary (élites 40-43, niveau 41+),
--   95773 Tridents d'écaille-de-mer (taux inconnu, 35 % = ~57 kills, suite en donjon),
--   97386 L'offensive de Grom'gol (ogres élites 41-44), 606 Abats de Valbrume (20 % = 50 kills),
--   600, 209, 587, 576, 604, 609 (niveau 41+), 638 Trollbane et 95141 Rapport à Rog'mar
--   (envois vers Arathi / Riverglades), 97331/97332 (prérequis 97329 Alliance seulement),
--   95322-95327 (chaîne commencée aux Riverglades), 1116 Poussière de rêve (Marais des chagrins),
--   1261 Marg parle (Marécage d'Âprefange, 5 %).
-- Donjon (Cité submergée, guide de donjon à faire) : 95775, 95776, 95789, 95791 et la suite 96078.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 33-36 Stranglethorn Vale
#displayname [FDP] Stranglethorn Vale (33-36)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 35 Orbe d'Orahil << Warlock
#next 35-37 Arathi Highlands

-- ===== Alertes : quêtes à forte XP dont le départ se fait hors de la région =====
-- Visibles tant que la quête rapporte l'XP pleine (niveau de quête + 5).
step
    #sticky
    #completewith FinStrangleronce
    .isQuestAvailable 1182
    .isNotOnQuest 1178
    .isNotOnQuest 1180
    .isNotOnQuest 1181
    .isNotOnQuest 1182
    .maxlevel 42
    .xp 43 >>|cRXP_WARN_Chaîne manquée : Mécénat gobelin (~4550 xp). Commence chez Pozzik aux Salines de Miroitement (Mille pointes 80,76) après « Allégement de la structure », puis Gazlowe à Ratchet|r

-- ===== Voyage : Orgrimmar -> Ratchet (si besoin) -> zeppelin -> Grom'gol =====
step
    .goto The Barrens,62.68,36.23
    >>Parle à |cRXP_FRIENDLY_Gazlowe|r à Ratchet avant de prendre le zeppelin
    .turnin 1178 >>Rends Mécénat gobelin
    .accept 1180 >>Accepte Mécénat gobelin
    .target 3391
    .isOnQuest 1178
    .zoneskip Stranglethorn Vale
step
    #completewith ArriveeGromgol
    .goto Durotar,50.69,12.89,15 >>Monte à la tour des zeppelins devant Orgrimmar et parle à |cRXP_FRIENDLY_Snurk Bucksquick|r : prends le zeppelin pour Grom'gol
    .target 12136
    .zoneskip Stranglethorn Vale
step
    #label ArriveeGromgol
    .goto Stranglethorn Vale,32.54,29.35
    >>Descends du zeppelin et parle à |cRXP_FRIENDLY_Thysta|r
    .fp Grom'gol >>Prends le point de vol de Grom'gol
    .target 1387

-- ===== Camp de base de Grom'gol =====
step
    .goto Stranglethorn Vale,31.49,29.75
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Thulbek|r
    .home >>Fixe ta pierre de foyer à Grom'gol : tu y reviendras depuis le camp de Nesingwary
    .target 5814
step
    .goto Stranglethorn Vale,32.17,28.90
    >>Parle au |cRXP_FRIENDLY_Commandant Aggro'gosh|r
    .accept 568 >>Accepte La défense de Grom'gol
    .target 2464
step
    .goto Stranglethorn Vale,32.27,27.71
    >>Parle à |cRXP_FRIENDLY_Kin'weelay|r
    .turnin 1240 >>Rends Le Sorcier-docteur troll
    .target 2519
    .isOnQuest 1240
step
    .goto Stranglethorn Vale,32.27,27.71
    >>Parle à |cRXP_FRIENDLY_Kin'weelay|r
    .accept 629 >>Accepte Le Récif infâme
    .target 2519
step
    .goto Stranglethorn Vale,32.77,28.43
    >>Parle à |cRXP_FRIENDLY_Gemmil|r
    .accept 97453 >>Accepte Tonte des mauvaises herbes
    .target 269166
step
    .goto Stranglethorn Vale,32.40,26.80,30,0
    .goto Stranglethorn Vale,32.80,23.90,30,0
    .goto Stranglethorn Vale,32.60,32.90,30,0
    .goto Stranglethorn Vale,31.80,30.30
    >>Tue les |cRXP_ENEMY_Herbes carnivores|r autour du camp
    .complete 97453,1 --Herbe carnivore (6)
    .mob 269175
step
    .goto Stranglethorn Vale,32.70,29.23
    >>Parle à |cRXP_FRIENDLY_Nerrist|r, la mère de Gemmil
    .turnin 97453 >>Rends Tonte des mauvaises herbes
    .target 1148
step
    .goto Stranglethorn Vale,24.82,23.03
    >>Plonge au Récif infâme et clique sur |cRXP_PICK_Gri'lek le Vagabond|r au fond pour l'|cRXP_LOOT_Eclat de tablette|r
    >>|cRXP_WARN_Surveille ton souffle|r
    .complete 629,1 --Eclat de tablette
step
    .goto Stranglethorn Vale,32.27,27.71
    >>Parle à |cRXP_FRIENDLY_Kin'weelay|r
    .turnin 629 >>Rends Le Récif infâme
    .accept 95748 >>Accepte Les anciennes légendes des Gurubashi
    .target 2519

-- ===== Baie-du-Butin : prise des quêtes =====
step
    #completewith Gringer
    .goto Stranglethorn Vale,27.00,72.00,50 >>Suis la route vers le sud jusqu'à Baie-du-Butin
step
    #label Gringer
    .goto Stranglethorn Vale,26.87,77.10
    >>Parle à |cRXP_FRIENDLY_Gringer|r
    .fp Booty Bay >>Prends le point de vol de Baie-du-Butin
    .target 2858
step
    .goto Stranglethorn Vale,26.35,73.56
    >>Parle à |cRXP_FRIENDLY_Maître Lozgil|r sur les quais
    .turnin 1180 >>Rends Mécénat gobelin
    .accept 1181 >>Accepte Mécénat gobelin
    .target 4631
    .isOnQuest 1180
step
    .goto Stranglethorn Vale,27.23,76.87
    >>Parle au |cRXP_FRIENDLY_Baron Revilgaz|r en haut de l'auberge
    .turnin 1181 >>Rends Mécénat gobelin
    .accept 1182 >>Accepte Mécénat gobelin
    .target 2496
    .isOnQuest 1181
step
    .goto Stranglethorn Vale,26.95,77.21
    >>Parle à |cRXP_FRIENDLY_Krazek|r
    .turnin 1115 >>Rends Le marchand de rumeurs
    .target 773
    .isOnQuest 1115
step
    .goto Stranglethorn Vale,26.95,77.21
    >>Parle à |cRXP_FRIENDLY_Krazek|r
    .accept 201 >>Accepte L'enquête au camp
    .target 773
step
    .goto Stranglethorn Vale,27.00,77.13
    >>Parle à |cRXP_FRIENDLY_Kebok|r
    .accept 189 >>Accepte Oreilles de Bloodscalp
    .accept 213 >>Accepte Une ponction musclée
    .target 737
step
    .goto Stranglethorn Vale,27.12,77.21
    >>Parle à |cRXP_FRIENDLY_Crank Fizzlebub|r
    .accept 605 >>Accepte Les éclats bleus chantants
    .target 2498
step
    .goto Stranglethorn Vale,28.29,77.59
    >>Parle à |cRXP_FRIENDLY_Drizzlik|r
    .accept 575 >>Accepte L'offre et la demande
    .target 2495
step
    .goto Stranglethorn Vale,26.87,77.10
    >>Parle à |cRXP_FRIENDLY_Gringer|r
    .fly Grom'gol >>Vole vers Grom'gol
    .target 2858

-- ===== Camp de Nesingwary =====
step
    #completewith Barnil
    .goto Stranglethorn Vale,35.66,10.53,30 >>Monte vers le nord jusqu'au camp de Nesingwary
step
    #label Barnil
    .goto Stranglethorn Vale,35.66,10.53
    >>Parle à |cRXP_FRIENDLY_Barnil Stonepot|r
    .complete 201,1 --Trouver le camp des chasseurs
    .accept 583 >>Accepte Bienvenue dans la jungle
    .target 716
step
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .turnin 5762 >>Rends Hemet Nesingwary
    .target 715
    .isOnQuest 5762
step
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .turnin 5763 >>Rends Chasse à Strangleronce
    .target 715
    .isOnQuest 5763
step
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .turnin 583 >>Rends Bienvenue dans la jungle
    .accept 194 >>Accepte Contrôler la population des raptors
    .target 715
step
    .goto Stranglethorn Vale,35.62,10.62
    >>Parle à |cRXP_FRIENDLY_Ajeck Rouack|r et |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .accept 185 >>Accepte Maîtrise de la chasse au tigre
    .accept 190 >>Accepte Maîtrise de la chasse à la panthère
    .target 717
    .target 718

-- ===== Autour du camp : jeunes tigres et panthères, crocos, basilics =====
step
    .goto Stranglethorn Vale,37.30,8.20,30,0
    .goto Stranglethorn Vale,40.00,12.00,30,0
    .goto Stranglethorn Vale,36.80,10.50,30,0
    .goto Stranglethorn Vale,34.60,8.10,30,0
    .goto Stranglethorn Vale,35.50,6.80,30,0
    .goto Stranglethorn Vale,32.00,9.50
    >>Tue les |cRXP_ENEMY_Jeunes tigres|r et |cRXP_ENEMY_Jeunes panthères|r, les |cRXP_ENEMY_Crocilisques des rivières|r et les |cRXP_ENEMY_Basilics de pierre|r autour du camp
    .complete 185,1 --Jeune tigre de Strangleronce (10)
    .complete 190,1 --Jeune panthère (10)
    .complete 575,1 --Grande peau de crocilisque des rivières (2)
    .mob 681
    .mob 683
    .mob 1150
    .mob 688
step
    #completewith ZulKunda
    >>Ramasse les |cRXP_LOOT_Eclats de cristal chantant|r sur les basilics
    .complete 605,1 --Eclat de cristal chantant (10)
    .mob 688
    .mob 689
step
    .goto Stranglethorn Vale,35.62,10.62
    >>Parle à |cRXP_FRIENDLY_Ajeck Rouack|r et |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .turnin 185 >>Rends Maîtrise de la chasse au tigre
    .turnin 190 >>Rends Maîtrise de la chasse à la panthère
    .accept 186 >>Accepte Maîtrise de la chasse au tigre
    .accept 191 >>Accepte Maîtrise de la chasse à la panthère
    .target 717
    .target 718

-- ===== Ouest : raptors, Zul'Kunda =====
step
    #completewith Nesingwary2
    >>Tue les |cRXP_ENEMY_Tigres|r et |cRXP_ENEMY_Panthères|r sur le chemin
    .complete 186,1 --Tigre de Strangleronce (10)
    .complete 191,1 --Panthère (10)
    .mob 682
    .mob 736
step
    .goto Stranglethorn Vale,31.50,12.85
    >>Clique sur les |cRXP_PICK_Fournitures soigneusement récupérées|r
    .accept 97328 >>Accepte Tout ce qui vaut cher
step
    .goto Stranglethorn Vale,24.20,16.20,30,0
    .goto Stranglethorn Vale,26.50,17.00,30,0
    .goto Stranglethorn Vale,24.00,16.80
    >>Tue les |cRXP_ENEMY_Raptors de Strangleronce|r et les |cRXP_ENEMY_Basilics de cristal|r du coin
    .complete 194,1 --Raptor de Strangleronce (10)
    .mob 685
    .mob 689
step
    #completewith ZulKunda
    >>Tue les |cRXP_ENEMY_trolls Bloodscalp|r pour leurs |cRXP_LOOT_Oreilles|r
    .complete 189,1 --Oreille de Bloodscalp (15)
    .mob 587
    .mob 588
    .mob 595
    .mob 597
    .mob 660
    .mob 671
step
    .goto Stranglethorn Vale,22.95,12.02
    >>Clique sur la tablette |cRXP_PICK_Chute des Gurubashi|r et fais le frottis de |cRXP_LOOT_La troisième légende des trolls|r
    >>|cRXP_WARN_Si tu n'as pas la peau et le charbon, retourne voir Kin'weelay|r
    .complete 95748,1 --La troisième légende des trolls
step
    #label ZulKunda
    .goto Stranglethorn Vale,25.50,10.50,30,0
    .goto Stranglethorn Vale,22.50,12.80,30,0
    .goto Stranglethorn Vale,20.20,12.00,30,0
    .goto Stranglethorn Vale,24.70,10.50
    >>Ramasse les |cRXP_LOOT_Cargaisons volées|r dans les ruines de Zul'Kunda et finis les |cRXP_LOOT_Oreilles de Bloodscalp|r
    >>|cRXP_WARN_Emplacement des caisses non documenté dans Questie : fouille les ruines|r
    .complete 97328,1 --Cargaison volée (8)
    .complete 189,1 --Oreille de Bloodscalp (15)
    .mob 587
    .mob 588
    .mob 595
    .mob 597
    .mob 660
    .mob 671
step
    .goto Stranglethorn Vale,28.40,10.60,40,0
    .goto Stranglethorn Vale,28.20,14.00,40,0
    .goto Stranglethorn Vale,32.00,13.00
    >>Finis les |cRXP_ENEMY_Tigres|r et |cRXP_ENEMY_Panthères|r en revenant au camp
    .complete 186,1 --Tigre de Strangleronce (10)
    .complete 191,1 --Panthère (10)
    .mob 682
    .mob 736
step
    #label Nesingwary2
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .turnin 194 >>Rends Contrôler la population des raptors
    .accept 195 >>Accepte Contrôler la population des raptors
    .target 715
step
    .goto Stranglethorn Vale,35.62,10.62
    >>Parle à |cRXP_FRIENDLY_Ajeck Rouack|r
    .turnin 186 >>Rends Maîtrise de la chasse au tigre
    .accept 187 >>Accepte Maîtrise de la chasse au tigre
    .target 717
step
    .goto Stranglethorn Vale,35.55,10.55
    >>Parle à |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .turnin 191 >>Rends Maîtrise de la chasse à la panthère
    .target 718
step
    .goto Stranglethorn Vale,35.55,10.55
    >>Parle à |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .accept 192 >>Accepte Maîtrise de la chasse à la panthère
    .target 718
    .xp <35,1

-- ===== Est et sud : basilics, camp de la KapitalRisk, Ombregueules, raptors flagellants =====
step
    .goto Stranglethorn Vale,48.20,8.20,30,0
    .goto Stranglethorn Vale,47.40,5.90,30,0
    .goto Stranglethorn Vale,48.70,10.40
    >>Finis les |cRXP_LOOT_Eclats de cristal chantant|r sur les |cRXP_ENEMY_Basilics de cristal|r
    .complete 605,1 --Eclat de cristal chantant (10)
    .mob 689
step
    #completewith Footlocker
    >>Tue les |cRXP_ENEMY_Géologues de la KapitalRisk|r pour leurs |cRXP_LOOT_Cristaux réduits|r
    .complete 213,1 --Cristal réduit (8)
    .mob 1096
step
    .goto Stranglethorn Vale,42.64,18.35
    >>Tue le |cRXP_ENEMY_Contremaître Cozzle|r dans la maison et prends la |cRXP_LOOT_Clé de Cozzle|r
    .collect 5851,1,1182,1 --Clé de Cozzle
    .mob 4723
    .isOnQuest 1182
step
    #label Footlocker
    .goto Stranglethorn Vale,43.33,20.33
    >>Ouvre la |cRXP_PICK_Cantine de Cozzle|r et prends le |cRXP_LOOT_Plan de régulateur de fuel|r
    .complete 1182,1 --Plan de régulateur de fuel
    .isOnQuest 1182
step
    .goto Stranglethorn Vale,43.10,19.50,30,0
    .goto Stranglethorn Vale,44.70,22.20,30,0
    .goto Stranglethorn Vale,47.70,19.00,30,0
    .goto Stranglethorn Vale,44.20,20.10
    >>Finis les |cRXP_ENEMY_Géologues de la KapitalRisk|r autour du camp
    .complete 213,1 --Cristal réduit (8)
    .mob 1096
step
    .goto Stranglethorn Vale,41.30,34.80,40,0
    .goto Stranglethorn Vale,36.20,35.70,40,0
    .goto Stranglethorn Vale,40.00,30.00
    >>Tue les |cRXP_ENEMY_Panthères Ombregueules|r
    .complete 192,1 --Panthère Ombregueule (10)
    .mob 684
    .isOnQuest 192
step
    .goto Stranglethorn Vale,39.30,19.10,40,0
    .goto Stranglethorn Vale,39.10,22.10,40,0
    .goto Stranglethorn Vale,35.00,24.00,40,0
    .goto Stranglethorn Vale,32.00,22.00,40,0
    .goto Stranglethorn Vale,36.00,21.00
    >>Tue les |cRXP_ENEMY_Raptors flagellants|r : chaque kill compte pour les deux quêtes
    .complete 195,1 --Raptor flagellant (10)
    .complete 568,1 --Raptor flagellant (15)
    .mob 686
step
    .goto Stranglethorn Vale,34.00,19.40,30,0
    .goto Stranglethorn Vale,36.00,18.90,30,0
    .goto Stranglethorn Vale,32.50,17.50
    >>Tue les |cRXP_ENEMY_Anciens tigres de Strangleronce|r au sud du camp
    .complete 187,1 --Ancien tigre de Strangleronce (10)
    .mob 1085
step
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .turnin 195 >>Rends Contrôler la population des raptors
    .target 715
step
    .goto Stranglethorn Vale,35.55,10.55
    >>Parle à |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .turnin 192 >>Rends Maîtrise de la chasse à la panthère
    .target 718
    .isQuestComplete 192
step
    .goto Stranglethorn Vale,35.62,10.62
    >>Parle à |cRXP_FRIENDLY_Ajeck Rouack|r
    .turnin 187 >>Rends Maîtrise de la chasse au tigre
    .accept 188 >>Accepte Maîtrise de la chasse au tigre
    .target 717
step
    .goto Stranglethorn Vale,32.21,17.39,30,0
    .goto Stranglethorn Vale,31.47,15.50
    >>Tue |cRXP_ENEMY_Sin'Dall|r et prends la |cRXP_LOOT_Patte de Sin'Dall|r
    >>|cRXP_WARN_Duo : si une seule patte tombe, attendez la réapparition|r
    .complete 188,1 --Patte de Sin'Dall
    .unitscan 729
step
    .goto Stranglethorn Vale,35.62,10.62
    >>Parle à |cRXP_FRIENDLY_Ajeck Rouack|r
    .turnin 188 >>Rends Maîtrise de la chasse au tigre
    .target 717

-- ===== Retour à Grom'gol =====
step
    #completewith RetourGromgol
    .hs >>Utilise ta pierre de foyer pour Grom'gol
step
    #label RetourGromgol
    .goto Stranglethorn Vale,32.17,28.90
    >>Parle au |cRXP_FRIENDLY_Commandant Aggro'gosh|r
    .turnin 568 >>Rends La défense de Grom'gol
    .accept 569 >>Accepte La défense de Grom'gol
    .target 2464
step
    .goto Stranglethorn Vale,32.12,29.24
    >>Parle au |cRXP_FRIENDLY_Prophète Mok'thardin|r
    .accept 570 >>Accepte Enchantement de Mok'thardin
    .target 2465
    .xp <35,1
step
    .goto Stranglethorn Vale,32.27,27.71
    >>Parle à |cRXP_FRIENDLY_Kin'weelay|r
    .turnin 95748 >>Rends Les anciennes légendes des Gurubashi
    .accept 95770 >>Accepte À la recherche de la cité perdue
    .target 2519
step
    .goto Stranglethorn Vale,22.43,27.25
    >>Plonge au Récif infâme et trouve l'entrée de la caverne
    >>|cRXP_WARN_N'entre pas : la Cité submergée se fait en groupe|r
    .complete 95770,1 --Trouver l'entrée de la Cité submergée
step
    .goto Stranglethorn Vale,32.27,27.71
    >>Parle à |cRXP_FRIENDLY_Kin'weelay|r
    .turnin 95770 >>Rends À la recherche de la cité perdue
    .target 2519

-- ===== Est de Grom'gol : Mosh'Ogg, Ombregueules =====
step
    .goto Stranglethorn Vale,35.50,30.90,25,0
    .goto Stranglethorn Vale,37.90,30.20,25,0
    .goto Stranglethorn Vale,37.00,28.70,25,0
    .goto Stranglethorn Vale,37.50,31.00
    >>Tue les |cRXP_ENEMY_Brutes|r et |cRXP_ENEMY_Sorciers-docteurs Mosh'Ogg|r
    .complete 569,1 --Brute Mosh'Ogg (10)
    .complete 569,2 --Sorcier-docteur Mosh'Ogg (5)
    .mob 1142
    .mob 1144
step
    .goto Stranglethorn Vale,36.20,35.70,40,0
    .goto Stranglethorn Vale,41.30,34.80,40,0
    .goto Stranglethorn Vale,39.30,45.50,40,0
    .goto Stranglethorn Vale,37.30,45.30,40,0
    .goto Stranglethorn Vale,38.50,38.00
    >>Tue les |cRXP_ENEMY_Panthères Ombregueules|r et les |cRXP_ENEMY_Tigresses de Strangleronce|r
    >>|cRXP_WARN_Croc de tigresse à 15 % : ~13 tigresses en duo, chacun doit looter le sien|r
    .complete 570,1 --Griffe d'Ombregueule (8)
    .complete 570,2 --Croc de tigresse en parfait état (1)
    .mob 684
    .mob 772
    .isOnQuest 570
step
    .goto Stranglethorn Vale,32.17,28.90
    >>Parle au |cRXP_FRIENDLY_Commandant Aggro'gosh|r
    .turnin 569 >>Rends La défense de Grom'gol
    .target 2464
step
    .goto Stranglethorn Vale,32.12,29.24
    >>Parle au |cRXP_FRIENDLY_Prophète Mok'thardin|r
    .turnin 570 >>Rends Enchantement de Mok'thardin
    .target 2465
    .isQuestComplete 570

-- ===== Baie-du-Butin : rendus =====
step
    #completewith RendusBaie
    .goto Stranglethorn Vale,32.54,29.35
    >>Parle à |cRXP_FRIENDLY_Thysta|r
    .fly Booty Bay >>Vole vers Baie-du-Butin
    .target 1387
step
    #label RendusBaie
    .goto Stranglethorn Vale,27.00,77.13
    >>Parle à |cRXP_FRIENDLY_Kebok|r
    .turnin 189 >>Rends Oreilles de Bloodscalp
    .turnin 213 >>Rends Une ponction musclée
    .target 737
step
    .goto Stranglethorn Vale,26.95,77.21
    >>Parle à |cRXP_FRIENDLY_Krazek|r
    .turnin 201 >>Rends L'enquête au camp
    .target 773
step
    .goto Stranglethorn Vale,27.12,77.21
    >>Parle à |cRXP_FRIENDLY_Crank Fizzlebub|r
    .turnin 605 >>Rends Les éclats bleus chantants
    .target 2498
step
    .goto Stranglethorn Vale,28.29,77.59
    >>Parle à |cRXP_FRIENDLY_Drizzlik|r
    .turnin 575 >>Rends L'offre et la demande
    .target 2495
step
    .goto Stranglethorn Vale,27.23,76.87
    >>Parle au |cRXP_FRIENDLY_Baron Revilgaz|r en haut de l'auberge
    .turnin 1182 >>Rends Mécénat gobelin
    .target 2496
    .isQuestComplete 1182
step
    .goto Stranglethorn Vale,26.35,73.56
    >>Parle à |cRXP_FRIENDLY_Maître Lozgil|r sur les quais
    .turnin 97328 >>Rends Tout ce qui vaut cher
    .target 4631

-- ===== Boucaniers de la Voile sanglante (niveau 37) =====
step
    .goto Stranglethorn Vale,28.10,76.22
    >>Parle au |cRXP_FRIENDLY_Premier officier Crazz|r
    .accept 595 >>Accepte Les boucaniers de la Voile sanglante
    .target 2490
    .xp <37,1
step
    .goto Stranglethorn Vale,27.28,69.52
    >>Lis la |cRXP_PICK_Correspondance de la Voile sanglante|r dans la crique au nord de Baie-du-Butin
    .turnin 595 >>Rends Les boucaniers de la Voile sanglante
    .accept 597 >>Accepte Les boucaniers de la Voile sanglante
    .isOnQuest 595
step
    .goto Stranglethorn Vale,28.10,76.22
    >>Parle au |cRXP_FRIENDLY_Premier officier Crazz|r
    .turnin 597 >>Rends Les boucaniers de la Voile sanglante
    .accept 599 >>Accepte Les boucaniers de la Voile sanglante
    .target 2490
    .isOnQuest 597
step
    .goto Stranglethorn Vale,27.17,77.01
    >>Parle à l'|cRXP_FRIENDLY_Amiral Seahorn|r
    .turnin 599 >>Rends Les boucaniers de la Voile sanglante
    .target 2487
    .isOnQuest 599

step
    #label FinStrangleronce
    +|cRXP_WARN_Niveau conseillé pour la suite : 36. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

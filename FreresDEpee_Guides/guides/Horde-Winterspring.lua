if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Winterspring (Berceau-de-l'Hiver), Horde, toutes classes, en duo.
-- Indépendant des autres régions : les quêtes venues d'ailleurs sont protégées par
-- .isOnQuest / .isQuestTurnedIn (3908 et 980 d'Un'Goro, 4808 des Steppes ardentes, 92008 et
-- 93197 du mont Hyjal). Les Tombe-hiver s'agitent (8464) n'est proposée qu'après Les
-- Mort-bois du nord (8461, Gangrebois) : Salfa exige une réputation Grumegueule Neutre en
-- jeu (absente de QuestieDB) : 8461 sert de garde, sa chaîne de Gangrebois donne cette réputation.
-- Gare à la grêle (97490, requis 56) n'est proposée qu'au niveau 58 : Givremousse est un élite 60.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-traces.lua puis
-- xpDB-classic.lua. Taux de drop wowheadData : fourrure de yéti 55-66 %, corne de yéti
-- ~24 %, corne de Noroît 6-28 %, gouttelette d'Horreur toxique ~7 %, caisse des Tombe-hiver
-- ~9.5 %, viande de sabre-de-givre sacrée 0.3-2 %. Flacon d'eau de feu, courrier manquant,
-- fourrure de chimère et plumes de chouette sans taux : 35 % supposés.
-- Itinéraire : Gangrebois -> tunnel des Grumegueules -> Salfa -> Donova Snowden (camps
-- Tombe-hiver de l'ouest, aller-retour au chaudron Mort-bois) -> Long-guet -> nord (Ursius,
-- yétis, camp de Sarna) -> Long-guet -> est (collines Chardon de glace, village Tombe-hiver)
-- -> Long-guet -> sud (Brumeran, Vexegrêle, éclats Cognegivre, gorge du Murmure noir) ->
-- Long-guet -> retour à l'ouest (Donova, Salfa) si une quête protégée y attend.
-- XP gardée : ~70600 en quêtes sans les protégées (jusqu'à ~103500 avec), un demi-niveau
-- environ avec les kills.
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   5086 Horreurs toxiques (3 gouttelettes à ~7 % = ~86 kills, au Gangrebois), donc 5087
--   (caisse à ~9.5 % sur une patrouille de 3 messagers, ~21 kills), 5121, 5123, 5128 (rendue
--   au sud du Gangrebois), 4809 Cornes de Noroît (8 cornes = ~58 kills, 94 xp/kill) et 4810
--   (Steppes ardentes), 975 Cache de Mau'ari (pas d'XP), 4801-4807 (E'ko, répétables),
--   6606 Un peu de chance (liste noire Questie), 5163 Yéti ? Y es-tu ? (Tanaris et Un'Goro)
--   et 8798 (ingénierie), 5056 Shy-Rotam (viande sacrée à 0.3-2 %, élite 60) et 5057,
--   3909 et 3912 (chaîne de Linken, Féralas et Gadgetzan), 6603 (fermée par 5082),
--   6605 (envoi vers Gangrebois), 6029, 6030 (Maleterres), 4882, 4883 (prérequis 4741 coupé
--   au Gangrebois), 92859, 98462 Le voile des étendues sauvages hivernales (~57 kills pour
--   3300 xp), 92009, 93269 (envois vers Hyjal), 84146, 84212, 84138 (Saison de la Découverte),
--   9266 (réparation de réputation), 8469, 8471 (réputation Grumegueule), 5063, 5067, 5068,
--   5124 (artisanat, Scholomance), 5161 (vol bleu, raid), 4861, 4863, 4864, 4901, 4902,
--   4970, 5201, 5981, 5244, 5245, 5252, 5253, 6028, 6604 (Alliance).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 55-56 Winterspring
#displayname [FDP] Berceau-de-l'Hiver (55-56)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 56-60 Mount Hyjal

-- ===== Arrivée par le tunnel des Grumegueules =====
step
    #completewith ArriveeTunnel
    .goto Felwood,64.77,8.13,30 >>Va au nord du Gangrebois, à l'entrée du repaire des Grumegueules (vol vers le poste de la Vénéneuse si besoin)
step
    #label ArriveeTunnel
    .goto Winterspring,27.73,34.50,30 >>Traverse le tunnel jusqu'au Berceau-de-l'Hiver. |cRXP_WARN_Passage non vérifié en jeu avec une réputation Grumegueule basse|r
step
    .goto Winterspring,27.73,34.50
    >>Parle à |cRXP_FRIENDLY_Salfa|r à la sortie du tunnel
    .accept 8464 >>Accepte Les Tombe-hiver s'agitent
    .target 11556
    .isQuestTurnedIn 8461

-- ===== Donova Snowden et les camps de l'ouest =====
step
    .goto Winterspring,31.27,45.16
    >>Parle à |cRXP_FRIENDLY_Donova Snowden|r près des sources chaudes
    .turnin 3908 >>Rends C'est un Secret pour tout le monde
    .target 9298
    .isOnQuest 3908
step
    .goto Winterspring,31.27,45.16
    >>Parle à |cRXP_FRIENDLY_Donova Snowden|r
    .turnin 980 >>Rends Les nouvelles sources
    .target 9298
    .isOnQuest 980
step
    .goto Winterspring,31.27,45.16
    >>Parle à |cRXP_FRIENDLY_Donova Snowden|r
    .accept 4842 >>Accepte Sources étranges
    .target 9298
    .isQuestTurnedIn 980
step
    .goto Winterspring,31.27,45.16
    >>Parle à |cRXP_FRIENDLY_Donova Snowden|r
    .accept 5082 >>Accepte La menace des Tombe-hiver
    .target 9298
step
    #completewith FinCampsOuest
    >>Ramasse le |cRXP_LOOT_Flacon d'eau de feu vide|r s'il tombe d'un furbolg Tombe-hiver
    >>|cRXP_WARN_Utilise l'objet pour lancer la quête|r
    .collect 12771,1,5083,1
    .accept 5083 >>Accepte L'eau de feu de Tombe-hiver
    .use 12771
step
    .goto Winterspring,31.80,36.30
    >>Au nord de Donova, tue les |cRXP_ENEMY_Guides|r, |cRXP_ENEMY_Protecteurs|r et |cRXP_ENEMY_Totémiques Tombe-hiver|r
    .complete 5082,1 --Guide Tombe-hiver (8)
    .complete 5082,2 --Protecteur Tombe-hiver (8)
    .complete 5082,3 --Totémique Tombe-hiver (8)
    .mob 7442
    .mob 7440
    .mob 7441
step
    #label FinCampsOuest
    .goto Winterspring,40.60,43.40
    >>Finis au camp à l'est de Donova. |cRXP_WARN_Peu de protecteurs à l'ouest : attends leur réapparition ou finis-les au village Tombe-hiver (67,35)|r
    .complete 5082,1 --Guide Tombe-hiver (8)
    .complete 5082,2 --Protecteur Tombe-hiver (8)
    .complete 5082,3 --Totémique Tombe-hiver (8)
    .mob 7442
    .mob 7440
    .mob 7441
step
    .goto Winterspring,31.27,45.16
    >>Retourne voir |cRXP_FRIENDLY_Donova Snowden|r
    .turnin 5082 >>Rends La menace des Tombe-hiver
    .turnin -5083 >>Rends L'eau de feu de Tombe-hiver
    .target 9298
step
    .goto Winterspring,31.27,45.16
    >>Parle à |cRXP_FRIENDLY_Donova Snowden|r
    .accept 5084 >>Accepte Corrompu
    .target 9298
    .isQuestTurnedIn 5083
step
    .goto Felwood,60.20,5.84
    >>Repasse le tunnel et fouille le |cRXP_PICK_Chaudron des Mort-bois|r, juste à l'ouest de la sortie côté Gangrebois
    .turnin 5084 >>Rends Corrompu
    .accept 5085 >>Accepte Gelée mystère
    .isOnQuest 5084
step
    .goto Winterspring,31.27,45.16
    >>Reviens voir |cRXP_FRIENDLY_Donova Snowden|r
    .turnin 5085 >>Rends Gelée mystère
    .target 9298
    .isOnQuest 5085

-- ===== Long-guet =====
step
    #completewith ArriveeLongGuet
    .goto Winterspring,60.47,36.30,40 >>Suis la route vers l'est jusqu'à Long-guet
step
    #label ArriveeLongGuet
    .goto Winterspring,60.47,36.30
    >>Parle à |cRXP_FRIENDLY_Yugrek|r
    .fp Everlook >>Prends le point de vol de Long-guet
    .target 11139
step
    .goto Winterspring,61.33,36.92
    >>Parle à |cRXP_FRIENDLY_Nami|r
    .turnin 92008 >>Rends Pièces de premier choix
    .target 228216
    .isOnQuest 92008
step
    .goto Winterspring,60.88,37.62
    >>Parle à |cRXP_FRIENDLY_Umi Rumplesnicker|r
    .accept 3783 >>Accepte Yéti ? Y es-tu ?
    .target 10305
step
    .goto Winterspring,61.92,38.30
    >>Parle au |cRXP_FRIENDLY_Sorcier-docteur Mau'ari|r
    .accept 969 >>Accepte Que la chance soit avec vous
    .target 10307
step
    .goto Winterspring,61.93,38.38
    >>Parle à |cRXP_FRIENDLY_Storm Shadowhoof|r
    .accept 5054 >>Accepte Ursius des Crocs acérés
    .target 10303
step
    .goto Winterspring,61.63,38.61
    >>Parle à |cRXP_FRIENDLY_Felnok Steelspring|r
    .turnin 4808 >>Rends Felnok Steelspring
    .target 10468
    .isOnQuest 4808
step
    .goto Winterspring,61.36,38.83
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Vizzie|r
    .turnin 93197 >>Rends Rétablissement des communications
    .target 11118
    .isOnQuest 93197
step
    .goto Winterspring,61.36,38.83
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Vizzie|r
    .accept 93406 >>Accepte Livraison décongelée
    .target 11118
    .isQuestTurnedIn 93197
    .xp <56,1

-- ===== Nord : Ursius, yétis, camp de Sarna =====
step
    #completewith FinYetisNord
    >>Ramasse le |cRXP_LOOT_Courrier manquant|r sur les yétis
    .complete 93406,1 --Courrier manquant (4)
    .isOnQuest 93406
step
    .goto Winterspring,60.92,32.90
    >>Au nord de Long-guet, tue |cRXP_ENEMY_Ursius|r. |cRXP_WARN_Élite 56 : en duo|r
    .complete 5054,1 --Ursius
    .mob 10806
    .unitscan 10806
step
    #label FinYetisNord
    .goto Winterspring,59.50,31.80
    >>Tue les |cRXP_ENEMY_Yétis Chardon de glace|r autour de la grotte pour leur |cRXP_LOOT_Fourrure épaisse|r
    >>|cRXP_WARN_~33 kills en duo : chacun doit looter ses fourrures|r
    .complete 3783,1 --Fourrure épaisse de yéti (10)
    .mob 7458
step
    .goto Winterspring,58.30,12.79
    >>Monte au nord jusqu'au camp de |cRXP_FRIENDLY_Sarna Corne-Brune|r et |cRXP_FRIENDLY_Rilan Howard|r
    .accept 97264 >>Accepte Arrachage de crocs acérés
    .accept 97403 >>Accepte Ravageurs à deux têtes
    .target 11718
    .target 11751
step
    .goto Winterspring,58.80,18.50
    >>Tue les |cRXP_ENEMY_Anciens Crocs acérés|r et les |cRXP_ENEMY_Ravageurs Noroît|r au sud du camp
    .complete 97264,1 --Ancien Croc acéré (12)
    .complete 97403,1 --Ravageur Noroît (15)
    .mob 7445
    .mob 7449
step
    .goto Winterspring,58.30,12.79
    >>Retourne au camp
    .turnin 97264 >>Rends Arrachage de crocs acérés
    .accept 97404 >>Accepte Les ourses ou la vie
    .turnin 97403 >>Rends Ravageurs à deux têtes
    .target 11718
    .target 11751
step
    .goto Winterspring,58.90,11.90
    >>Tue |cRXP_ENEMY_Kuroma|r et |cRXP_ENEMY_Kamuro|r près du camp et prends leurs |cRXP_LOOT_Têtes|r
    .complete 97404,1 --Tête de Kuroma
    .complete 97404,2 --Tête de Kamuro
    .mob 269275
    .mob 269276
step
    .goto Winterspring,58.30,12.79
    >>Retourne voir |cRXP_FRIENDLY_Sarna Corne-Brune|r
    .turnin 97404 >>Rends Les ourses ou la vie
    .target 11718

-- ===== Long-guet, puis l'est =====
step
    .goto Winterspring,60.88,37.62
    >>Rentre à Long-guet et parle à |cRXP_FRIENDLY_Umi Rumplesnicker|r
    .turnin 3783 >>Rends Yéti ? Y es-tu ?
    .accept 977 >>Accepte Yéti ? Y es-tu ?
    .target 10305
step
    .goto Winterspring,61.93,38.38
    >>Parle à |cRXP_FRIENDLY_Storm Shadowhoof|r
    .turnin 5054 >>Rends Ursius des Crocs acérés
    .accept 5055 >>Accepte Brumeran des Noroît
    .target 10303
step
    #completewith FinEst
    >>Ramasse le |cRXP_LOOT_Courrier manquant|r sur les yétis
    .complete 93406,1 --Courrier manquant (4)
    .isOnQuest 93406
step
    .goto Winterspring,67.20,37.00
    >>Au village Tombe-hiver, à l'est, tue les |cRXP_ENEMY_Chamans|r, |cRXP_ENEMY_Protecteurs|r et |cRXP_ENEMY_Ursas Tombe-hiver|r
    .complete 8464,1 --Chaman Tombe-hiver (8)
    .complete 8464,2 --Protecteur Tombe-hiver (8)
    .complete 8464,3 --Ursa Tombe-hiver (8)
    .mob 7439
    .mob 7440
    .mob 7438
    .isOnQuest 8464
step
    #label FinEst
    .goto Winterspring,69.80,40.50
    >>Dans les collines Chardon de glace, tue les |cRXP_ENEMY_Matriarches|r et |cRXP_ENEMY_Patriarches Chardon de glace|r pour leurs |cRXP_LOOT_Cornes|r
    >>|cRXP_WARN_~17 kills en duo : chacun doit looter ses cornes|r
    .complete 977,1 --Corne de yéti en parfait état (2)
    .mob 7459
    .mob 7460
step
    .goto Winterspring,60.88,37.62
    >>Rentre à Long-guet et parle à |cRXP_FRIENDLY_Umi Rumplesnicker|r
    .turnin 977 >>Rends Yéti ? Y es-tu ?
    .target 10305
step
    .goto Winterspring,61.36,38.83
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Vizzie|r
    .turnin 93406 >>Rends Livraison décongelée
    .target 11118
    .isOnQuest 93406
step
    .goto Winterspring,61.86,38.23
    >>Parle à |cRXP_FRIENDLY_Umaron Stragarelm|r
    .accept 97490 >>Accepte Gare à la grêle
    .target 11757
    .xp <58,1

-- ===== Sud : Brumeran, Vexegrêle, éclats Cognegivre =====
step
    #completewith FinSud
    >>Tue |cRXP_ENEMY_Vexegrêle|r s'il passe et prends sa |cRXP_LOOT_Givremousse|r. |cRXP_WARN_Élite 60 qui patrouille de Long-guet aux collines du sud : en duo|r
    .complete 97490,1 --Givremousse vexegrêle
    .unitscan 269213
    .isOnQuest 97490
step
    .goto Winterspring,62.54,57.90
    >>Tue |cRXP_ENEMY_Brumeran|r. |cRXP_WARN_Élite 58 : en duo, passe-le si vous êtes trop bas|r
    .complete 5055,1 --Brumeran
    .mob 10807
    .unitscan 10807
step
    .goto Winterspring,63.00,68.40
    >>Ramasse les |cRXP_PICK_Eclats cognegivre|r au sol. |cRXP_WARN_Géants élites 59-60 autour : ne les tire pas, chacun ramasse ses 4 éclats|r
    .complete 969,1 --Eclats cognegivre (4)
    .mob 7428
    .mob 7429
step
    .goto Winterspring,59.82,74.25,15
    >>Va jusqu'à la gorge du Murmure noir, au sud
    .complete 4842,1 --Découvrir la gorge du Murmure noir
    .isOnQuest 4842
step
    #label FinSud
    .goto Winterspring,65.50,57.00
    >>Finis |cRXP_ENEMY_Vexegrêle|r dans les collines du sud
    .complete 97490,1 --Givremousse vexegrêle
    .mob 269213
    .isOnQuest 97490
step
    .goto Winterspring,61.92,38.30
    >>Rentre à Long-guet et parle au |cRXP_FRIENDLY_Sorcier-docteur Mau'ari|r
    .turnin 969 >>Rends Que la chance soit avec vous
    .target 10307
step
    .goto Winterspring,61.93,38.38
    >>Parle à |cRXP_FRIENDLY_Storm Shadowhoof|r
    .turnin 5055 >>Rends Brumeran des Noroît
    .target 10303
    .isOnQuest 5055
step
    .goto Winterspring,61.86,38.23
    >>Parle à |cRXP_FRIENDLY_Umaron Stragarelm|r
    .turnin 97490 >>Rends Gare à la grêle
    .target 11757
    .isOnQuest 97490

-- ===== Retour à l'ouest pour les quêtes protégées =====
step
    .goto Winterspring,31.27,45.16
    >>Retourne à l'ouest voir |cRXP_FRIENDLY_Donova Snowden|r
    .turnin 4842 >>Rends Sources étranges
    .turnin -5083 >>Rends L'eau de feu de Tombe-hiver
    .target 9298
    .isOnQuest 4842
step
    .goto Winterspring,31.27,45.16
    >>Parle à |cRXP_FRIENDLY_Donova Snowden|r
    .turnin 5083 >>Rends L'eau de feu de Tombe-hiver
    .target 9298
    .isOnQuest 5083
step
    .goto Winterspring,27.73,34.50
    >>Parle à |cRXP_FRIENDLY_Salfa|r à l'entrée du tunnel
    .turnin 8464 >>Rends Les Tombe-hiver s'agitent
    .target 11556
    .isOnQuest 8464
step
    .goto Winterspring,67.81,27.43
    >>Si tu as fait le temple d'Atal'Hakkar, porte le message d'Eranikus à |cRXP_FRIENDLY_Umbranse l'Implorateur d'esprits|r, au nord-est de Long-guet
    .turnin 3512 >>Rends Par les mots d'Eranikus
    .target 8588
    .isOnQuest 3512
step
    #label FinBerceau
    +|cRXP_WARN_Niveau conseillé pour la suite : 56. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

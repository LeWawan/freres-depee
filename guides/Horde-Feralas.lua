if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Féralas (Feralas), Horde, toutes classes, en duo, base camp
-- Mojache. Indépendant des autres régions : les envois venus d'ailleurs (95033 depuis les
-- Rives Claires, 2981 depuis Orgrimmar) sont protégés par .isOnQuest.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua et xpDB-traces.lua
-- (92878, 95033, 95599). Taux de drop du bloc wowheadData de classicItemDrops.lua. Duo : kills =
-- 2 x nombre x 100 / taux. Gardées malgré plus de 40 kills : 2862 (10 crinières à 45 % =
-- ~44 kills, chaîne 2862-2903 à ~217 xp/kill) et 7730 (20 carapaces à 89 % = ~45 kills,
-- avec 7731 ~176 xp/kill). 2979 : orbe à 16 % sur les Seigneurs-mages (~13 kills).
-- Itinéraire : camp Mojache -> nord (Namida, gnolls Griffebois, avant-poste ogre) -> Mojache
-- -> Alphas Griffebois (chrono 1 h) -> Mojache -> plan de bataille, ogres du sud, yétis
-- Griffe farouche -> Mojache -> Zukk'ash et Fouet-cuisant -> Mojache -> yétis Griffe
-- féroce au nord-ouest (niveau 46) -> Mojache.
-- Coupées :
--   2973 Une nouvelle cape (10 ailes à 41 % = ~49 kills, 80 xp/kill), 2974 Une découverte
--   sinistre (20 cornes à 42 % = ~95 kills) et 2976 (suite, rendue à Orgrimmar),
--   2766/2767 OOX-22/FE (balise lâchée au hasard sans taux connu, escorte rendue à
--   Baie-du-Butin, autre continent), 3002 L'Orbe Gordunni et 7732 Le rapport sur les
--   Zukk'ash (rendues à Orgrimmar), 3121/3122 (aller-retour à Orgrimmar) et toute la chaîne
--   d'Uzer'i qui en dépend, 3123-3129 (3123 part dans les Hinterlands), 3380 (temple
--   d'Atal'Hakkar, donjon), 7003/7725 Géants rétrécis (géants élites clairsemés sur la côte
--   ouest, ~33 kills, niveau 48), 7721/7726 Du carburant pour la zappette (10 noyaux à 37 %
--   = ~54 kills, côte ouest), 3062 Coeur noir (élite 50, extrême nord-ouest) et 3063 Se
--   venger des Ruissenord (niveau 50, harpies 48-50 au nord-ouest), 4120 (Gangrebois),
--   4041 L'élixir de Videre (niveau 52, requis 47, sans XP dans les deux xpDB), 95599 La vieille clé (clé sans source dans QuestieDB),
--   3567 (niveau 25, sans XP), 7489/7492/7441/7481 (niveau 54+, Hache-tripes), 2854-2860 et
--   82656 (Travail du cuir), 94260/94272/94284/94296 (commissions d'artisan), 81855-81874,
--   81951, 82068 (Saison de la Découverte), 8679/8685 (liste noire, fête lunaire).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 44-47 Feralas
#displayname [FDP] Féralas (44-47)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 45-48 Tanaris

-- ===== Arrivée au camp Mojache =====
step
    #completewith ArriveeMojache
    .goto Feralas,75.45,44.36,40 >>Va au camp Mojache, à l'est de Féralas. Si tu n'as pas encore le vol, la route part de Mille pointes vers l'ouest. |cRXP_WARN_Contourne Thalanaar (89,46), avant-poste Alliance gardé|r
step
    #label ArriveeMojache
    .goto Feralas,75.45,44.36
    >>Parle à |cRXP_FRIENDLY_Shyn|r
    .fp Camp Mojache >>Prends le point de vol du camp Mojache
    .target 8020
step
    .goto Feralas,74.80,45.18
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Greul|r
    .home >>Fixe ta pierre de foyer au camp Mojache
    .target 7737
step
    .goto Feralas,75.70,44.31
    >>Parle à |cRXP_FRIENDLY_Orwin Gizzmick|r
    .accept 2987 >>Accepte Cobalt Gordunni
    .target 8021
step
    .goto Feralas,75.80,43.58
    >>Parle à |cRXP_FRIENDLY_Rok Orhan|r
    .turnin 2981 >>Rends Menace sur Feralas
    .target 7777
    .isOnQuest 2981
step
    .goto Feralas,75.80,43.58
    >>Parle à |cRXP_FRIENDLY_Rok Orhan|r
    .accept 2975 >>Accepte Les ogres de Feralas
    .target 7777
step
    .goto Feralas,74.91,42.46
    >>Parle à |cRXP_FRIENDLY_Hadoken Swiftstrider|r
    .accept 2862 >>Accepte La guerre avec les Griffebois
    .target 7875
step
    .goto Feralas,74.43,42.91
    >>Parle à |cRXP_FRIENDLY_Jangdor Swiftstrider|r
    .accept 2822 >>Accepte La marque de la qualité
    .target 7854
step
    .goto Feralas,74.42,43.36
    >>Parle au |cRXP_FRIENDLY_Sorcier-docteur Uzer'i|r
    .turnin 95033 >>Rends De l’autre côté
    .target 8115
    .isOnQuest 95033
step
    .goto Feralas,74.91,44.02
    >>Parle à |cRXP_FRIENDLY_Blaise Montgomery|r
    .accept 92878 >>Accepte Réduit au silence
    .target 11752

-- ===== Nord : Namida, gnolls Griffebois, avant-poste ogre =====
step
    .goto Feralas,67.72,39.16
    >>À l'ouest du camp, tue |cRXP_ENEMY_Namida Totem-sinistre|r et prends son |cRXP_LOOT_Sabot|r. Elle se promène entre 66,38 et 69,40. |cRXP_WARN_Élite 43 : en duo|r
    .complete 92878,1 --Sabot de Namida
    .mob 222286
    .unitscan 222286
step
    .goto Feralas,72.60,37.00
    >>Au camp Griffebois au nord, tue les |cRXP_ENEMY_Bâtards|r, |cRXP_ENEMY_Trappeurs|r et |cRXP_ENEMY_Brutes Griffebois|r pour leurs |cRXP_LOOT_Crinières|r
    >>|cRXP_WARN_Farm long en duo (~44 kills) : chacun doit looter ses objets|r
    .complete 2862,1 --Crinière de gnoll Griffebois (10)
    .mob 5249
    .mob 5251
    .mob 5253
step
    #completewith OgresNord
    >>Tue les |cRXP_ENEMY_Ogres|r, |cRXP_ENEMY_Ogres-mages|r et |cRXP_ENEMY_Brutes Gordunni|r de l'avant-poste
    .complete 2975,1 --Ogre Gordunni (10)
    .complete 2975,2 --Ogre-mage Gordunni (10)
    .complete 2975,3 --Brute Gordunni (5)
    .mob 5229
    .mob 5237
    .mob 5232
step
    .goto Feralas,75.10,29.70
    >>Ramasse le |cRXP_PICK_Parchemin Gordunni|r au sol dans l'avant-poste (aussi en 74.5,27.9 et 80.5,34.3)
    >>|cRXP_WARN_Utilise-le pour lancer la quête|r
    .collect 9370,1,2978,1 --Parchemin Gordunni
    .accept 2978 >>Accepte Le parchemin Gordunni
    .use 9370
step
    .goto Feralas,75.50,30.50
    >>Creuse les |cRXP_PICK_Monticules de poussière de Gordunni|r avec la |cRXP_LOOT_Pelle d'Orwin|r pour le |cRXP_LOOT_Cobalt|r. |cRXP_WARN_Une douzaine de monticules pour deux : attends la réapparition s'il le faut|r
    .complete 2987,1 --Cobalt Gordunni (12)
    .use 9466
step
    #label OgresNord
    .goto Feralas,75.50,30.50
    >>Finis les |cRXP_ENEMY_Ogres|r, |cRXP_ENEMY_Ogres-mages|r et |cRXP_ENEMY_Brutes Gordunni|r
    .complete 2975,1 --Ogre Gordunni (10)
    .complete 2975,2 --Ogre-mage Gordunni (10)
    .complete 2975,3 --Brute Gordunni (5)
    .mob 5229
    .mob 5237
    .mob 5232
step
    .goto Feralas,74.91,44.02
    >>Retourne au camp Mojache. Parle à |cRXP_FRIENDLY_Blaise Montgomery|r
    .turnin 92878 >>Rends Réduit au silence
    .target 11752
step
    .goto Feralas,75.80,43.58
    >>Parle à |cRXP_FRIENDLY_Rok Orhan|r
    .turnin 2975 >>Rends Les ogres de Feralas
    .turnin 2978 >>Rends Le parchemin Gordunni
    .accept 2980 >>Accepte Les ogres de Feralas
    .accept 2979 >>Accepte Sombre cérémonie
    .target 7777
step
    .goto Feralas,75.70,44.31
    >>Parle à |cRXP_FRIENDLY_Orwin Gizzmick|r
    .turnin 2987 >>Rends Cobalt Gordunni
    .target 8021
step
    .goto Feralas,74.91,42.46
    >>Parle à |cRXP_FRIENDLY_Hadoken Swiftstrider|r
    .turnin 2862 >>Rends La guerre avec les Griffebois
    .accept 2863 >>Accepte Frappe sur les Alphas
    .target 7875

-- ===== Sud : Alphas (chrono), plan de bataille, ogres et yétis =====
step
    .goto Feralas,65.70,52.60
    >>|cRXP_WARN_Chrono d'une heure : va tout de suite au sud-ouest|r. Tue les |cRXP_ENEMY_Alphas Griffebois|r dans les camps gnolls (65,52 et 69-75,55)
    .complete 2863,1 --Alpha Griffebois (5)
    .mob 5258
step
    .goto Feralas,74.91,42.46
    >>Rentre tout de suite au camp. Parle à |cRXP_FRIENDLY_Hadoken Swiftstrider|r
    .turnin 2863 >>Rends Frappe sur les Alphas
    .accept 2902 >>Accepte Enquête chez les Griffebois
    .target 7875
step
    .goto Feralas,71.60,55.90
    >>Retourne au camp gnoll du sud et lis le |cRXP_PICK_Plan de bataille des Griffebois|r
    .turnin 2902 >>Rends Enquête chez les Griffebois
    .accept 2903 >>Accepte Les plans de bataille
step
    #completewith OgresSud
    >>Tue les |cRXP_ENEMY_Seigneurs-mages Gordunni|r pour l'|cRXP_LOOT_Orbe Gordunni|r. |cRXP_WARN_16 % de chance : ~13 kills en duo|r
    .complete 2979,1 --Orbe Gordunni
    .mob 5239
step
    .goto Feralas,60.50,56.50
    >>À l'ouest, dans les ruines ogres, tue les |cRXP_ENEMY_Marteleurs|r et les |cRXP_ENEMY_Démonistes Gordunni|r
    .complete 2980,3 --Marteleur Gordunni (5)
    .complete 2980,2 --Démoniste Gordunni (10)
    .mob 5234
    .mob 5240
step
    #label OgresSud
    .goto Feralas,60.30,68.50
    >>Plus au sud, tue les |cRXP_ENEMY_Chamans|r, finis les |cRXP_ENEMY_Démonistes|r et les |cRXP_ENEMY_Seigneurs-mages Gordunni|r pour l'|cRXP_LOOT_Orbe|r
    .complete 2980,1 --Chaman Gordunni (10)
    .complete 2980,2 --Démoniste Gordunni (10)
    .complete 2979,1 --Orbe Gordunni
    .mob 5236
    .mob 5240
    .mob 5239
step
    .goto Feralas,52.50,57.50
    >>À l'ouest, tue les |cRXP_ENEMY_Yétis Griffe farouche|r pour leurs |cRXP_LOOT_Peaux épaisses|r
    .complete 2822,1 --Peau de yéti épaisse (10)
    .mob 5292
    .mob 5293
    .mob 5295
step
    .goto Feralas,74.91,42.46
    >>Retourne au camp Mojache. Parle à |cRXP_FRIENDLY_Hadoken Swiftstrider|r
    .turnin 2903 >>Rends Les plans de bataille
    .accept 7730 >>Accepte Infestation de Zukk'ash
    .accept 7731 >>Accepte Fouet-cuisant
    .target 7875
step
    .goto Feralas,74.43,42.91
    >>Parle à |cRXP_FRIENDLY_Jangdor Swiftstrider|r
    .turnin 2822 >>Rends La marque de la qualité
    .target 7854
step
    .goto Feralas,75.80,43.58
    >>Parle à |cRXP_FRIENDLY_Rok Orhan|r
    .turnin 2980 >>Rends Les ogres de Feralas
    .turnin 2979 >>Rends Sombre cérémonie
    .target 7777

-- ===== Sud : ruche des Zukk'ash =====
step
    #completewith Ruche
    >>Tue les |cRXP_ENEMY_Ouvrières|r et |cRXP_ENEMY_Guêpes Zukk'ash|r pour leurs |cRXP_LOOT_Carapaces|r
    >>|cRXP_WARN_Farm long en duo (~45 kills) : chacun doit looter ses objets|r
    .complete 7730,1 --Carapace de Zukk'ash (20)
    .mob 5246
    .mob 5245
step
    .goto Feralas,75.58,60.85
    >>Au fond de la ruche au sud, tue |cRXP_ENEMY_Fouet-cuisant|r et prends ses |cRXP_LOOT_Glandes|r
    .complete 7731,1 --Glandes de Fouet-cuisant
    .mob 14661
    .unitscan 14661
step
    #label Ruche
    .goto Feralas,72.50,60.50
    >>Finis les |cRXP_LOOT_Carapaces de Zukk'ash|r
    .complete 7730,1 --Carapace de Zukk'ash (20)
    .mob 5246
    .mob 5245
step
    .goto Feralas,74.91,42.46
    >>Retourne au camp Mojache. Parle à |cRXP_FRIENDLY_Hadoken Swiftstrider|r
    .turnin 7730 >>Rends Infestation de Zukk'ash
    .turnin 7731 >>Rends Fouet-cuisant
    .target 7875

-- ===== Nord-ouest : yétis Griffe féroce (niveau 46) =====
step
    .goto Feralas,74.43,42.91
    >>Parle à |cRXP_FRIENDLY_Jangdor Swiftstrider|r
    .accept 7734 >>Accepte Qualité améliorée
    .target 7854
    .isQuestTurnedIn 2822
    .xp <46,1
step
    #completewith RetourJangdor
    >>Si un yéti lâche une |cRXP_LOOT_Peau de yéti parfaite|r, utilise-la pour lancer la quête
    .collect 18972,1,7738,1 --Peau de yéti parfaite
    .accept 7738 >>Accepte Une peau de yéti parfaite
    .use 18972
    .isOnQuest 7734
step
    .goto Feralas,53.40,31.60
    >>Au nord-ouest, tue les |cRXP_ENEMY_Yétis Griffe féroce|r pour leurs |cRXP_LOOT_Peaux|r. |cRXP_WARN_Une quinzaine de yétis seulement : attends la réapparition s'il le faut|r
    .complete 7734,1 --Peau de yéti Griffe féroce (10)
    .mob 5296
    .mob 5297
    .mob 5299
    .isOnQuest 7734
step
    #label RetourJangdor
    .goto Feralas,74.43,42.91
    >>Retourne au camp Mojache. Parle à |cRXP_FRIENDLY_Jangdor Swiftstrider|r
    .turnin 7734 >>Rends Qualité améliorée
    .turnin -7738 >>Rends Une peau de yéti parfaite
    .target 7854
    .isOnQuest 7734
step
    #label FinFeralas
    +|cRXP_WARN_Niveau conseillé pour la suite : 47. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

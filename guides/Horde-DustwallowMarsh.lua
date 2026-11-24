if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Dustwallow Marsh (Marécage d'Âprefange), Horde, toutes classes.
-- Indépendant des autres régions : Marg parle (1261, Strangleronce) et Mortebourbe (1205,
-- Thunder Bluff) sont protégées par .isOnQuest. Les quêtes de classe (Tabetha, mage et
-- démoniste) vivent dans leurs propres guides.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua et xpDB-traces.lua
-- (quêtes de Drazzit). Taux de drop de classicItemDrops.lua, 35 % supposés quand absents.
-- Itinéraire : entrée par la route des Tarides -> auberge du Repos ombragé (trois objets) ->
-- Mur-de-Fougères (vol, quêtes) -> Ogron -> sud (affaires de Mok'Morokk, camp de Drazzit,
-- farm des dragonnets et des Crins-de-feu) -> Mur-de-Fougères (chaîne de la portée) ->
-- Tourbière du Ver (oeufs, Mortebourbe en passant) -> Mur-de-Fougères (défi de Mok'Morokk).
-- La chaîne 1169-1173 garde le farm des langues et coeurs (~120 kills en duo) : 15 770 xp,
-- ~131 xp par kill. 98215 (20 écailles) reste : ses écailles tombent pendant ce même farm et
-- traînent aussi au sol.
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   98192 Main prudente et lame affûtée (8 peaux à 35 % supposés = ~46 kills, ~78 xp/kill),
--   1322/1323 Le Bouclier noir (6 sacs de venin à 25 % = ~48 kills, quête 37 à XP réduite)
--     et sa suite 1276 (rendue à Thunder Bluff),
--   1177 Faim ! (12 têtes à 33 % = ~73 kills, niveau 36),
--   1201/1202 Les espions de Theramore / Les docks de Theramore (niveau 35, XP réduite,
--     docks de Theramore gardés par l'Alliance),
--   1238/1239/1240 Le rapport perdu / La tête coupée / Le Sorcier-docteur troll (niveau 35,
--     détour au manoir des Flammeroles, suite rendue à Strangleronce),
--   1262 Rapport à Zor et 7541 Un service pour la Horde (rendues à Orgrimmar),
--   1270 Sauvetage du Puant (escorte niveau 37 rendue à Cabestan),
--   1218/1206/1203/81570 chaîne de Jarl (épices achetées, 40 yeux, épée de forge),
--   95283-95285, 95309, 96332, 96334 Kor'krons d'Alcaz (niveau 48 requis, prison d'Alcaz),
--   6570-6601 Braise-de-colère et épreuves des crânes (harmonisation d'Onyxia, niveau 55+).
-- Quêtes de classe ignorées ici : 1947-1958 (mage), 1799/4961/4976 (démoniste). Donjon :
-- 2861/2846 La tiare des abysses (Zul'Farrak). Pêche : 6607/6608 Nat Pagle.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 42-44 Dustwallow Marsh
#displayname [FDP] Marécage d'Âprefange (42-44)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 42-45 Shen'dralas

-- ===== Arrivée : auberge du Repos ombragé =====
step
    .goto Dustwallow Marsh,29.70,48.00,30 >>Entre dans le marécage par la route de l'ouest, depuis les Tarides, jusqu'aux ruines de l'|cRXP_PICK_Auberge du Repos ombragé|r. |cRXP_WARN_Si tu as déjà le vol de Mur-de-Fougères, vole là-bas puis descends au sud-ouest|r
step
    .goto Dustwallow Marsh,29.70,47.60
    >>Examine les |cRXP_PICK_Traces de sabot|r dans les ruines de l'auberge
    .accept 1268 >>Accepte Des empreintes de sabots suspectes
    .maxlevel 42
step
    .goto Dustwallow Marsh,29.80,48.20
    >>Ramasse l'|cRXP_PICK_Insigne de la garde de Theramore|r
    .accept 1269 >>Accepte Lieutenant Paval Reethe
    .maxlevel 44
step
    .goto Dustwallow Marsh,29.60,48.60
    >>Ramasse le |cRXP_PICK_Bouclier noir|r
    .accept 1251 >>Accepte Le bouclier noir
    .maxlevel 42

-- ===== Mur-de-Fougères =====
step
    #completewith ArriveeMur
    .goto Dustwallow Marsh,35.56,31.88,40 >>Remonte au nord jusqu'à Mur-de-Fougères
step
    #label ArriveeMur
    .goto Dustwallow Marsh,35.56,31.88
    >>Parle à |cRXP_FRIENDLY_Shardi|r
    .fp Brackenwall Village >>Prends le point de vol de Mur-de-Fougères
    .target 11899
step
    .goto Dustwallow Marsh,35.21,30.66
    >>Parle à |cRXP_FRIENDLY_Nazeer Bloodpike|r
    .turnin 1261 >>Rends Marg parle
    .target 4791
    .isOnQuest 1261
step
    .goto Dustwallow Marsh,36.42,31.88
    >>Parle à |cRXP_FRIENDLY_Krog|r
    .turnin 1268 >>Rends Des empreintes de sabots suspectes
    .target 4926
    .isOnQuest 1268
step
    .goto Dustwallow Marsh,36.42,31.88
    >>Parle à |cRXP_FRIENDLY_Krog|r
    .turnin 1269 >>Rends Lieutenant Paval Reethe
    .target 4926
    .isOnQuest 1269
step
    .goto Dustwallow Marsh,36.42,31.88
    >>Parle à |cRXP_FRIENDLY_Krog|r
    .turnin 1251 >>Rends Le bouclier noir
    .target 4926
    .isOnQuest 1251
step
    .goto Dustwallow Marsh,36.42,31.88
    >>Parle à |cRXP_FRIENDLY_Krog|r
    .accept 1321 >>Accepte Le Bouclier noir
    .target 4926
    .isQuestTurnedIn 1251
step
    .goto Dustwallow Marsh,36.53,30.79
    >>Parle à |cRXP_FRIENDLY_Do'gol|r. |cRXP_WARN_Ne prends pas la suite (sacs de venin)|r
    .turnin 1321 >>Rends Le Bouclier noir
    .target 5087
    .isOnQuest 1321
step
    .goto Dustwallow Marsh,36.29,31.41
    >>Parle au |cRXP_FRIENDLY_Seigneur Mok'Morokk|r
    .accept 1166 >>Accepte Les soucis du Seigneur Mok'Morokk
    .target 4500
step
    .goto Dustwallow Marsh,37.37,31.39
    >>Parle à |cRXP_FRIENDLY_Tharg|r
    .accept 1168 >>Accepte L'armée des dragons noirs
    .target 4502
step
    .goto Dustwallow Marsh,37.15,33.09
    >>Parle à |cRXP_FRIENDLY_Draz'Zilb|r
    .accept 1169 >>Accepte Identification de la portée
    .target 4501

-- ===== Ogron : Questionner Reethe =====
step
    .goto Dustwallow Marsh,40.96,36.69
    >>Parle à |cRXP_FRIENDLY_Ogron|r, au sud-est du village, pour lancer l'escorte
    .accept 1273 >>Accepte Questionner Reethe
    .target 4983
    .isQuestTurnedIn 1269
    .maxlevel 44
step
    .goto Dustwallow Marsh,42.47,38.07
    >>Suis |cRXP_FRIENDLY_Ogron|r jusqu'à |cRXP_FRIENDLY_Paval Reethe|r et protège-le quand les gardes attaquent
    .complete 1273,1
    .mob 4979
    .isOnQuest 1273

-- ===== Sud : affaires de Mok'Morokk et camp de Drazzit =====
step
    #completewith CampDrazzit
    >>Tue les |cRXP_ENEMY_Crins-de-feu|r et les |cRXP_ENEMY_incendiaires|r que tu croises en route
    .complete 1168,1 --Eclaireur Crins-de-feu (10)
    .complete 1168,2 --Queue-cendrée Crins-de-feu (10)
    .complete 1168,3 --Plaiedécaille Crins-de-feu (5)
    .complete 1169,1 --Langue d'incendiaire (15)
    .complete 1169,2 --Coeur d'incendiaire (15)
step
    .goto Dustwallow Marsh,44.50,66.00
    >>Ramasse le |cRXP_PICK_Tabac de Mok'Morokk|r
    .complete 1166,1 --Tabac de Mok'Morokk
step
    .goto Dustwallow Marsh,38.70,65.60
    >>Ramasse le |cRXP_PICK_Tafia de Mok'Morokk|r
    .complete 1166,2 --Tafia de Mok'Morokk
step
    .goto Dustwallow Marsh,36.60,69.60
    >>Ramasse le |cRXP_PICK_Coffre de Mok'Morokk|r
    .complete 1166,3 --Coffre de Mok'Morokk
step
    #label CampDrazzit
    .goto Dustwallow Marsh,41.01,75.73
    >>Parle à |cRXP_FRIENDLY_Drazzit Suintevalve|r, au camp des kodos. |cRXP_WARN_Brimgore, rare élite 45, rôde juste à côté (42,76) : évitez-le|r
    .accept 98205 >>Accepte Les dragonnets, c'est la plaie !
    .accept 98215 >>Accepte Écailles de dragon, queues bien grillées
    .target 270723
step
    .goto Dustwallow Marsh,40.97,75.68
    >>Parle à |cRXP_FRIENDLY_Gizzix Glougloutache|r
    .accept 98231 >>Accepte Principe actif
    .target 270727
step
    #completewith FarmDragonnets
    >>Ramasse les |cRXP_PICK_Queues de wyrm|r et les |cRXP_PICK_Écailles de dragon sombre tombées|r au sol pendant le farm
    .complete 98231,1 --Queue de wyrm (10)
    .complete 98215,1 --Écaille de dragon sombre tombée (20)
step
    #label FarmDragonnets
    .goto Dustwallow Marsh,45.50,73.50
    >>Tue les |cRXP_ENEMY_Jeunes incendiaires|r, les |cRXP_ENEMY_Dragonnets incendiaires|r et les |cRXP_ENEMY_Crins-de-feu|r au sud du marécage
    >>|cRXP_WARN_Farm long en duo (~120 kills) : chacun doit looter ses langues, coeurs et écailles|r
    .complete 1169,1 --Langue d'incendiaire (15)
    .complete 1169,2 --Coeur d'incendiaire (15)
    .complete 98205,1 --Jeune incendiaire (8)
    .complete 98205,2 --Dragonnet incendiaire (8)
    .complete 1168,1 --Eclaireur Crins-de-feu (10)
    .complete 1168,2 --Queue-cendrée Crins-de-feu (10)
    .complete 1168,3 --Plaiedécaille Crins-de-feu (5)
    .mob 4323
    .mob 4324
    .mob 4329
    .mob 4331
    .mob 4328
step
    .goto Dustwallow Marsh,46.40,75.20
    >>Finis les |cRXP_PICK_Queues de wyrm|r et les |cRXP_LOOT_Écailles de dragon sombre tombées|r
    .complete 98231,1 --Queue de wyrm (10)
    .complete 98215,1 --Écaille de dragon sombre tombée (20)
    .mob 4323
    .mob 4324
step
    .goto Dustwallow Marsh,41.01,75.73
    >>Retourne voir |cRXP_FRIENDLY_Drazzit Suintevalve|r
    .turnin 98205 >>Rends Les dragonnets, c'est la plaie !
    .turnin 98215 >>Rends Écailles de dragon, queues bien grillées
    .target 270723
step
    .goto Dustwallow Marsh,40.97,75.68
    >>Parle à |cRXP_FRIENDLY_Gizzix Glougloutache|r
    .turnin 98231 >>Rends Principe actif
    .target 270727

-- ===== Mur-de-Fougères : la portée d'Onyxia =====
step
    #completewith RetourMur
    .goto Dustwallow Marsh,37.15,33.09,40 >>Remonte à Mur-de-Fougères
step
    #label RetourMur
    .goto Dustwallow Marsh,37.15,33.09
    >>Parle à |cRXP_FRIENDLY_Draz'Zilb|r
    .turnin 1169 >>Rends Identification de la portée
    .accept 1170 >>Accepte La portée d'Onyxia
    .target 4501
step
    .goto Dustwallow Marsh,36.29,31.41
    >>Parle au |cRXP_FRIENDLY_Seigneur Mok'Morokk|r
    .turnin 1166 >>Rends Les soucis du Seigneur Mok'Morokk
    .turnin 1170 >>Rends La portée d'Onyxia
    .accept 1171 >>Accepte La portée d'Onyxia
    .target 4500
step
    .goto Dustwallow Marsh,37.37,31.39
    >>Parle à |cRXP_FRIENDLY_Tharg|r
    .turnin 1168 >>Rends L'armée des dragons noirs
    .target 4502
step
    .goto Dustwallow Marsh,36.42,31.88
    >>Parle à |cRXP_FRIENDLY_Krog|r
    .turnin 1273 >>Rends Questionner Reethe
    .target 4926
    .isOnQuest 1273
step
    .goto Dustwallow Marsh,37.15,33.09
    >>Parle à |cRXP_FRIENDLY_Draz'Zilb|r
    .turnin 1171 >>Rends La portée d'Onyxia
    .accept 1172 >>Accepte La portée d'Onyxia
    .target 4501

-- ===== Tourbière du Ver : les oeufs =====
step
    .goto Dustwallow Marsh,50.20,52.70
    >>Tue |cRXP_ENEMY_Mortebourbe|r, le crocilisque du lac, et prends sa |cRXP_LOOT_Dent|r. |cRXP_WARN_Quête rendue à Thunder Bluff|r
    .complete 1205,1 --Dent de Mortebourbe
    .mob 4841
    .unitscan 4841
    .isOnQuest 1205
step
    .goto Dustwallow Marsh,52.60,77.20
    >>Détruis les |cRXP_PICK_Oeufs d'Onyxia|r dans la Tourbière du Ver. |cRXP_WARN_N'entre pas dans le Repaire d'Onyxia|r
    .complete 1172,1 --Oeuf d'Onyxia détruit (5)
    .mob 4323
    .mob 4324

-- ===== Mur-de-Fougères : défi de Mok'Morokk =====
step
    #completewith RetourMur2
    .goto Dustwallow Marsh,37.15,33.09,40 >>Remonte à Mur-de-Fougères
step
    #label RetourMur2
    .goto Dustwallow Marsh,37.15,33.09
    >>Parle à |cRXP_FRIENDLY_Draz'Zilb|r
    .turnin 1172 >>Rends La portée d'Onyxia
    .target 4501
step
    .goto Dustwallow Marsh,36.29,31.41
    >>Parle au |cRXP_FRIENDLY_Seigneur Mok'Morokk|r et lance le défi
    .accept 1173 >>Accepte Défier le Seigneur Mok'Morokk
    .target 4500
step
    .goto Dustwallow Marsh,36.29,31.41
    >>Bats le |cRXP_ENEMY_Seigneur Mok'Morokk|r jusqu'à ce qu'il quitte le village. |cRXP_WARN_Élite 45 : en duo|r
    .complete 1173,1
    .mob 4500
step
    .goto Dustwallow Marsh,37.15,33.09
    >>Parle à |cRXP_FRIENDLY_Draz'Zilb|r
    .turnin 1173 >>Rends Défier le Seigneur Mok'Morokk
    .target 4501
step
    #label FinAprefange
    +|cRXP_WARN_Niveau conseillé pour la suite : 44. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

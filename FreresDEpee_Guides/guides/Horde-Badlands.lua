if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Terres ingrates (Badlands), Horde, toutes classes, en duo.
-- Indépendant des autres régions : les envois venus d'ailleurs (687 depuis Arathi, 1106
-- depuis Mille pointes, 1418 depuis Pierrêche) sont protégés par .isOnQuest.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua et
-- xpDB-traces.lua (97663, 97821), taux de drop du bloc wowheadData de classicItemDrops.lua
-- (35 % supposés quand il manque). Les gravures de 97663 n'ont pas de position dans
-- QuestieDB, 97821 n'a pas de donneur (quête lancée par le Miroir du mirage, 278744).
-- Itinéraire : Kargath (prises) -> sud-ouest (Boss Tho'grun, Mirages malveillants) ->
-- ogres Crache-poussières (29,57) -> camp de Rigglefuzz et Martek (42,52) -> busards du
-- centre, Theldurin (51,77), ogres de l'est (62,69) -> Rigglefuzz -> pierre de foyer,
-- rendus à Kargath. 1420 part vers Pierrêche (Marais des Chagrins).
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   2258 Les réactifs des Terres ingrates (5 gésiers à ~24 % = 42 kills, 10 crocs à 7-25 %
--   = 80 à 120 kills, 5 fragments à 2,8-5,5 % = 180 à 360 kills ; 2202 suit dans le guide Uldaman),
--   2203 (Alchimie 210, après 2202), 1419 Les coyotes voleurs (30 mâchoires à 10-53 % = 110 à 600
--   kills), 692 Les fragments perdus (3 fragments à 2,3 % = ~260 kills), 656 (suite de 692,
--   Arathi, niveau 50), 705 Pêche aux perles (palourdes à Strangleronce), 1559 (suite de
--   705, Ingénierie), 710/711/712 Étude des éléments : la roche (éclats 19 % = ~103 kills,
--   dalles 4,8 % = ~125 kills, brassards 11 % = ~90 kills), 713 (Huile de givre,
--   Alchimie), 714 (Gyrochronatome, après 713), 715 (potions), 716 (Brassards en bronze à motifs,
--   Forge, après 712), 734/777/778 Grandes difficultés (après 712 et 714), 793 Alliances
--   rompues (suite de 782, élites 50 Cinglenoir et Hematus), 795 Sceau de la Terre (niveau 55),
--   728 Pour le « Sommaire de Yagyin » (après 709 d'Uldaman, rendu à Undercity) et la chaîne
--   735/736/737 qui en découle (Le savoir perdu, rendue à Theldurin), 1108 Indurium (10 flocons à ~45 % = ~44 kills pour 3000
--   xp, 68 xp/kill), 1137 (suite de 1108, rendu à Mille pointes, Kalimdor), 2418 (pierres
--   d'Uldaman, coupée dans le guide Uldaman), 3821 (faite dans le guide Burning Steppes) et 4062 (niveau 52),
--   78823/78830/81900 (Saison de la découverte).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 42-43 Badlands
#displayname [FDP] Terres ingrates (42-43)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 43-46 Swamp of Sorrows

-- ===== Kargath =====
step
    #completewith ArriveeKargath
    .goto Badlands,3.99,44.78,40 >>Va à Kargath, à l'ouest des Terres ingrates
step
    #label ArriveeKargath
    .goto Badlands,3.99,44.78
    >>Parle à |cRXP_FRIENDLY_Gorrik|r
    .fp Kargath >>Prends le point de vol de Kargath
    .target 2861
step
    .goto Badlands,2.82,45.86
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Shul'kar|r
    .home >>Fixe ta pierre de foyer à Kargath
    .target 9356
step
    .goto Badlands,2.91,45.60
    >>Parle à |cRXP_FRIENDLY_Gorn|r
    .accept 782 >>Accepte Alliances rompues
    .target 1068
step
    .goto Badlands,4.09,46.22
    >>Parle à |cRXP_FRIENDLY_Mus'hale|r
    .accept 97663 >>Accepte Fournitures et études
    .target 269647
step
    .goto Badlands,6.49,47.20
    >>Parle à |cRXP_FRIENDLY_Neeka Bloodscar|r
    .turnin 1418 >>Rends Neeka Bloodscar
    .target 5394
    .isOnQuest 1418
step
    .goto Badlands,6.49,47.20
    >>Parle à |cRXP_FRIENDLY_Neeka Bloodscar|r
    .accept 1420 >>Accepte Le rapport à Helgrum
    >>|cRXP_WARN_À rendre à Pierrêche (Marais des Chagrins), plus tard sur la route|r
    .target 5394

-- ===== Mirage malveillant : quête lancée par un objet =====
step
    #completewith RetourKargath
    >>Tue les |cRXP_ENEMY_Mirages malveillants|r que tu croises et ramasse le |cRXP_LOOT_Miroir du mirage|r
    >>|cRXP_WARN_Élite 42, en duo. Chacun doit looter son miroir, puis l'utiliser pour lancer la quête|r
    .collect 278744,1,97821,1 --Miroir du mirage
    .accept 97821 >>Accepte Miroir du mirage
    .use 278744
    .unitscan 269756

-- ===== Sud-ouest : Boss Tho'grun =====
step
    #completewith ThoGrun
    .goto Badlands,11.50,70.00,40 >>Descends vers le camp d'ogres du sud-ouest
step
    #completewith ThoGrun
    .goto Badlands,12.00,75.46,0
    >>Les |cRXP_ENEMY_Mirages malveillants|r rôdent autour du camp : tues-en pour le |cRXP_LOOT_Miroir du mirage|r, puis utilise-le
    >>|cRXP_WARN_Élite 42, en duo. Taux de drop inconnu : chacun doit looter le sien|r
    .collect 278744,1,97821,1 --Miroir du mirage
    .accept 97821 >>Accepte Miroir du mirage
    .use 278744
    .mob 269756
step
    #label ThoGrun
    .goto Badlands,12.62,75.49
    >>Tue |cRXP_ENEMY_Boss Tho'grun|r et prends le |cRXP_LOOT_Signe de la Terre|r. Il patrouille dans le camp
    >>|cRXP_WARN_Les ogres du camp sont de niveau 40 à 43 : tirez-les un par un|r
    .complete 782,1 --Signe de la Terre
    .mob 2944
    .unitscan 2944

-- ===== Ogres Crache-poussières : fournitures de Mus'hale =====
step
    #completewith OgresEst
    .goto Badlands,29.65,57.42,0
    >>Tue les |cRXP_ENEMY_Ogres|r et |cRXP_ENEMY_Brutes Crache-poussières|r du camp à l'ouest du centre pour les |cRXP_LOOT_Fournitures volées de Mus'hale|r, puis utilise-les sur les gravures de pierre voisines
    >>|cRXP_WARN_Gravures absentes de QuestieDB : cherche-les autour des ogres. Si la quête n'est pas finie ici, tu la finis aux ogres de l'est (62,69)|r
    .complete 97663,1 --Fournitures et études
    .mob 2701
    .mob 2715
    .use 278515

-- ===== Camp de Rigglefuzz et Martek =====
step
    .goto Badlands,42.22,52.69
    >>Parle à |cRXP_FRIENDLY_Martek l'Exilé|r
    .turnin 1106 >>Rends Martek l'Exilé
    .target 4618
    .isOnQuest 1106
step
    .goto Badlands,42.39,52.93
    >>Parle à |cRXP_FRIENDLY_Rigglefuzz|r
    .accept 703 >>Accepte Ailes de busard grillées
    .target 2817

-- ===== Centre et sud : busards, Theldurin, ogres de l'est =====
step
    #completewith AilesBusard
    >>Tue les |cRXP_ENEMY_Busards|r pour leurs |cRXP_LOOT_Ailes de busard|r
    >>|cRXP_WARN_Aile à ~33 % : ~24 busards en duo, chacun doit looter les siennes|r
    .complete 703,1 --Aile de busard (4)
    .mob 2830
    .mob 2831
step
    .goto Badlands,51.39,76.87
    >>Parle à |cRXP_FRIENDLY_Theldurin l'Egaré|r
    .turnin 687 >>Rends Theldurin l'Egaré
    .target 2785
    .isOnQuest 687
step
    #label OgresEst
    .goto Badlands,62.52,68.44,30,0
    .goto Badlands,61.95,70.18,30,0
    .goto Badlands,62.91,69.57
    >>Finis les |cRXP_LOOT_Fournitures volées de Mus'hale|r et les gravures sur les |cRXP_ENEMY_Ogres Crache-poussières|r de l'est
    .complete 97663,1 --Fournitures et études
    .mob 2701
    .mob 2715
    .use 278515
step
    #label AilesBusard
    .goto Badlands,57.96,73.76,40,0
    .goto Badlands,50.13,77.87,40,0
    .goto Badlands,49.54,63.79,40,0
    .goto Badlands,50.28,59.96,40,0
    .goto Badlands,61.82,55.62,40,0
    .goto Badlands,48.63,55.45
    >>Finis les |cRXP_LOOT_Ailes de busard|r en remontant vers le camp de Rigglefuzz
    .complete 703,1 --Aile de busard (4)
    .mob 2830
step
    .goto Badlands,42.39,52.93
    >>Parle à |cRXP_FRIENDLY_Rigglefuzz|r
    .turnin 703 >>Rends Ailes de busard grillées
    .target 2817

-- ===== Retour à Kargath =====
step
    #completewith RetourKargath
    .hs >>Utilise ta pierre de foyer pour rentrer à Kargath
step
    #label RetourKargath
    .goto Badlands,2.91,45.60
    >>Parle à |cRXP_FRIENDLY_Gorn|r
    .turnin 782 >>Rends Alliances rompues
    .target 1068
step
    .goto Badlands,4.09,46.22
    >>Parle à |cRXP_FRIENDLY_Mus'hale|r
    .turnin 97663 >>Rends Fournitures et études
    .turnin -97821 >>Rends Miroir du mirage
    .target 269647
step
    #label FinTerresIngrates
    +|cRXP_WARN_Niveau conseillé pour la suite : 43. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Steppes ardentes (Burning Steppes), Horde, toutes classes, en
-- duo. Zone pauvre en quêtes Horde hors donjon : le guide part de Kargath (Terres ingrates),
-- où commencent 3821 et 4061 (coupées par le guide des Terres ingrates pour leur niveau), et
-- y revient en vol pour les rendus. Base dans la zone : la Crête de la flamme (nom français non sourcé, point de vol
-- de Vahgruk, gobelins neutres, pas d'aubergiste).
-- Indépendant des autres régions : 4022 (suite de 3481, Gorge des Vents brûlants) est
-- protégée par .isQuestTurnedIn 3481, 4324 (envoi de Yorba Screwspigot, Tanaris) par
-- .isOnQuest 4324.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua, taux de drop du bloc wowheadData de classicItemDrops.lua (Fragment d'élémentaire
-- fracturé 48,9 % sur les Ravageurs de guerre et 7,9 % sur les Grands élémentaires
-- d'obsidienne, Anneau de nez de Sha'ni 76,3 % sur Krom'Grul). 4061 demande ~41 kills en duo
-- (2 x 10 x 100 / 48,9) : gardée, 133 xp par kill.
-- Itinéraire : Kargath (prises) -> Gorge des Vents brûlants et Mont Rochenoire -> Crête de la
-- flamme (prises) -> centre (Tablette des Sept, Ravageurs de guerre) -> est (Rejetons noirs,
-- Cyrus) -> Rocher des Cognepeurs (Sha'ni, Krom'Grul) -> Crête de la flamme (rendus) -> vol
-- vers Kargath (rendus).
-- Coupées :
--   4023 Un goût de flammes (variante sans 3481 : le Cuir de dragon noir tombe du Drake noir
--   frénétique, élite 54 seul, taux inconnu), 4024 (Profondeurs de Rochenoire, suite de 4022),
--   4062 La révolte des machines (1350 xp, rendu à Lotwil Veriatus au centre-ouest des Terres
--   ingrates : détour hors zone, sa suite 4063 est en Profondeurs de Rochenoire), 4063 (Profondeurs de
--   Rochenoire), 4808 Felnok Steelspring (suite de 4726, Berceau-de-l'Hiver, Kalimdor) et 4810
--   (rendue ici après 4809 en Berceau-de-l'Hiver), 4463/4481/4482/4483/4484 (libram, composants
--   de donjon et de niveau 60), 4136 Ribbly Screwspigot (Profondeurs de Rochenoire),
--   3801/3802 Héritage Sombrefer, 4123 Le Coeur de la montagne, 4121/4122 (Grark Lorkrub,
--   après 4082 des Profondeurs de Rochenoire), 4729/4734/4735/4862/4866/4907 (Pic
--   Rochenoire, niveau 55 à 60), 5522 (niveau 57 requis), 82062 (Profondeurs de Rochenoire),
--   84146 (niveau 55 à 60, hors route), 84211 (quête de
--   guerrier), 7562-7631 (quêtes de démoniste), 8636/8683 (Fête lunaire), 81953/84396 (Saison
--   de la découverte), 94318/94336/94354 (commandes d'artisan niveau 60), quêtes Alliance :
--   3823, 3824, 3825, 4182-4186, 4223, 4224, 4241, 4242, 4262, 4263, 4283, 4286, 4322, 4701.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 52-53 Burning Steppes
#displayname [FDP] Steppes ardentes (52-53)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 53-55 Blasted Lands

-- ===== Kargath =====
step
    #completewith ArriveeKargath
    .goto Badlands,3.99,44.78,40 >>Va à Kargath, à l'ouest des Terres ingrates. Deux quêtes des Steppes ardentes y commencent
step
    #label ArriveeKargath
    .goto Badlands,3.99,44.78
    >>Parle à |cRXP_FRIENDLY_Gorrik|r
    .fp Kargath >>Prends le point de vol de Kargath, utile pour revenir à la fin
    .target 2861
step
    .goto Badlands,3.36,48.06
    >>Parle à |cRXP_FRIENDLY_Thal'trak Proudtusk|r
    .accept 3821 >>Accepte Le Rocher des Cognepeurs
    .target 9082
step
    .goto Badlands,3.02,47.81
    >>Parle à la |cRXP_FRIENDLY_Hiérophante Theodora Mulvadania|r
    .accept 4061 >>Accepte La révolte des machines
    .target 9079

-- ===== Voyage vers la Crête de la flamme =====
step
    #completewith ArriveeCrete
    .goto Searing Gorge,34.80,83.80,40 >>Vole vers la Halte du Thorium (Gorge des Vents brûlants) si tu as le point de vol, puis descends au sud jusqu'à l'entrée du Mont Rochenoire. |cRXP_WARN_Accès non vérifié en jeu : vole directement à la Crête de la flamme si tu as déjà ce point de vol|r
step
    #completewith ArriveeCrete
    .goto Burning Steppes,65.69,24.22,40 >>Traverse le Mont Rochenoire et sors dans les Steppes ardentes, puis va à l'est jusqu'à la Crête de la flamme
step
    #label ArriveeCrete
    .goto Burning Steppes,65.69,24.22
    >>Parle à |cRXP_FRIENDLY_Vahgruk|r
    .fp Flame Crest >>Prends le point de vol de la Crête de la flamme
    .target 13177

-- ===== Crête de la flamme =====
step
    .goto Burning Steppes,65.15,23.91
    >>Parle à |cRXP_FRIENDLY_Maxwort Uberglint|r
    .accept 4296 >>Accepte Tablette des Sept
    .target 9536
step
    .goto Burning Steppes,65.24,24.00
    >>Parle à |cRXP_FRIENDLY_Tinkee Steamboil|r
    .accept 4726 >>Accepte L'essence de rejeton
    .target 10267
step
    .goto Burning Steppes,66.06,21.95
    >>Parle à |cRXP_FRIENDLY_Yuka Screwspigot|r
    .turnin 4324 >>Rends Yuka Screwspigot
    .target 9544
    .isOnQuest 4324

-- ===== Centre : tablette et ravageurs =====
step
    #completewith Tablette
    >>Tue les |cRXP_ENEMY_Ravageurs de guerre|r sur la route et ramasse leurs |cRXP_LOOT_Fragments d'élémentaire fracturés|r
    .complete 4061,1 --Fragment d'élémentaire fracturé (10)
    .mob 7039
    .mob 7032
step
    #label Tablette
    .goto Burning Steppes,54.12,40.76
    >>Clique sur la |cRXP_PICK_Tablette des Sept|r pour obtenir la |cRXP_LOOT_Transcription de la tablette|r. |cRXP_WARN_Chaque joueur doit cliquer|r
    .complete 4296,1 --Transcription de la tablette
step
    .goto Burning Steppes,60.79,38.50
    >>Tue les |cRXP_ENEMY_Ravageurs de guerre|r pour leurs |cRXP_LOOT_Fragments d'élémentaire fracturés|r. Les |cRXP_ENEMY_Grands élémentaires d'obsidienne|r en donnent rarement
    >>|cRXP_WARN_Farm long en duo (~41 kills) : chacun doit looter ses objets|r
    .complete 4061,1 --Fragment d'élémentaire fracturé (10)
    .mob 7039
    .mob 7032

-- ===== Est : rejetons et Cyrus =====
step
    .goto Burning Steppes,86.00,31.50
    >>Utilise le |cRXP_LOOT_Draco-Incarcinatrix 900|r sur un |cRXP_ENEMY_Rejeton noir|r, tue-le puis ramasse l'|cRXP_PICK_Essence de rejeton|r qui apparaît. |cRXP_WARN_Chacun utilise son propre appareil|r
    .complete 4726,1 --Essence de rejeton (8)
    .use 12284
    .mob 7047
step
    .goto Burning Steppes,95.09,31.56
    >>Parle à |cRXP_FRIENDLY_Cyrus Therepentous|r et montre-lui le |cRXP_LOOT_Cuir de dragon noir|r. |cRXP_WARN_Le Drake noir frénétique (élite 54) rôde à côté|r
    .accept 4022 >>Accepte Un goût de flammes
    .turnin 4022 >>Rends Un goût de flammes
    .target 9459
    .isQuestTurnedIn 3481

-- ===== Rocher des Cognepeurs =====
step
    .goto Burning Steppes,79.95,45.40
    >>Trouve la dépouille de |cRXP_FRIENDLY_Sha'ni Proudtusk|r au pied du Rocher des Cognepeurs
    .turnin 3821 >>Rends Le Rocher des Cognepeurs
    .accept 3822 >>Accepte Krom'Grul
    .target 9136
step
    .goto Burning Steppes,79.66,47.43
    >>Tue |cRXP_ENEMY_Krom'Grul|r dans les grottes du Rocher des Cognepeurs et ramasse l'|cRXP_LOOT_Anneau de nez de Sha'ni|r. |cRXP_WARN_Un seul Krom'Grul : attends sa réapparition si ton partenaire n'a pas eu l'anneau|r
    .complete 3822,1 --Anneau de nez de Sha'ni
    .mob 8977
    .unitscan 8977

-- ===== Retour à la Crête de la flamme =====
step
    .goto Burning Steppes,65.15,23.91
    >>Retourne voir |cRXP_FRIENDLY_Maxwort Uberglint|r
    .turnin 4296 >>Rends Tablette des Sept
    .target 9536
step
    .goto Burning Steppes,65.24,24.00
    >>Parle à |cRXP_FRIENDLY_Tinkee Steamboil|r. |cRXP_WARN_N'accepte pas Felnok Steelspring (Berceau-de-l'Hiver)|r
    .turnin 4726 >>Rends L'essence de rejeton
    .target 10267

-- ===== Kargath =====
step
    .goto Burning Steppes,65.69,24.22
    >>Parle à |cRXP_FRIENDLY_Vahgruk|r
    .fly Kargath >>Vole vers Kargath
    .target 13177
step
    .goto Badlands,3.36,48.06
    >>Parle à |cRXP_FRIENDLY_Thal'trak Proudtusk|r
    .turnin 3822 >>Rends Krom'Grul
    .target 9082
step
    .goto Badlands,3.02,47.81
    >>Parle à la |cRXP_FRIENDLY_Hiérophante Theodora Mulvadania|r. |cRXP_WARN_N'accepte pas la suite (Profondeurs de Rochenoire)|r
    .turnin 4061 >>Rends La révolte des machines
    .target 9079
step
    #label FinSteppes
    +|cRXP_WARN_Niveau conseillé pour la suite : 53. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

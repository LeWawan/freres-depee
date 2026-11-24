if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde de Stratholme (nord des Maleterres de l'est), toutes classes.
-- Givers : Tirion Fordring (maison de Tirion), Artiste Renfray et Magistrat Marduke (Caer
-- Darrow), Leonid Barthalomew, Smokey LaRue, Duc Nicholas Zverenhoff, Conservateur Alen et
-- Seigneur Maxwell Tyrosus (chapelle de l'Espoir de Lumière), Nathanos le Flétrisseur (ferme
-- des Marris), Egan (Terreval), Aurius (dans l'instance, côté vivant).
-- Données : QuestieDB Forever (tools/questiedb.py), zone 2017 (quêtes et PNJ de l'instance).
-- XP de xpDB-classic.lua. Entrées : porte principale 26.5,10.4 et entrée de service 41.5,17.7
-- (QuestieDB dungeons.lua, entrées Classic).
-- Dans l'instance, QuestieDB n'a pas de coordonnées : ordre des salles décrit dans le texte.
-- Itinéraire : Tirion -> Caer Darrow -> Stromgarde (Arathi) -> Caer Darrow -> Espoir de
-- Lumière -> Nathanos -> Egan -> côté vivant jusqu'à Balnazzar -> Espoir de Lumière -> côté
-- mort-vivant jusqu'au baron Rivendare -> Espoir de Lumière -> Nathanos -> Egan -> Tirion (fin).
-- Protégées (quêtes venues d'autres guides) :
--   5846 L'amour et la famille (après 5845, Maleterres de l'est), accept protégé par
--   .isQuestTurnedIn 5845 ;
--   5461 L'humain, Ras Murmegivre (après 5384, Scholomance), accept protégé par
--   .isQuestTurnedIn 5384, puis 5462 et 5463/5464 (le cadeau de Menethil) protégées par
--   .isOnQuest. Chaîne 5461-5464 : ~26 450 xp, et 5464 ouvre 5465/5466 dans Scholomance ;
--   5282 Âmes tourmentées (après 5281, prise à l'Espoir de Lumière, rendue à Egan par le guide
--   des Maleterres de l'est) ;
--   6163 Ramstein (après 6135 et 6136, Maleterres de l'est), accept protégé par les deux.
-- Taux : Eau sacrée de Stratholme dans les Caisses de fournitures, taux inconnu ;
-- Tabac de Grimm 63 % sur Ezra Grimm (wowheadData).
-- Coupées :
--   5212 La chair ne ment pas (10 échantillons à 0,6-11 %, ~420 kills en duo en moyenne, ~180 sur
--   les meilleurs mobs, chaîne 13 200 xp,
--   66 xp/kill) et 5213 L'agent actif (suite de 5212),
--   8945 La supplique du mort et 8946 (course chronométrée du baron, chaîne d'Anthion),
--   8968 et 8991 Morceaux de l'amulette du seigneur Valthalak (ensemble de donjon 2),
--   8929, 8930, 8947-8959, 9016-9022 et An Earnest Proposition / Just Compensation (Anthion,
--   ensemble de donjon 2),
--   5465 Souvenir lié et 5466 (suite de 5464, rendue à Caer Darrow, chaîne de Scholomance),
--   5861 Trouver Myranda (suite de 5848, Maleterres de l'Ouest puis Âtre-du-Roi, chaîne d'élites),
--   5305, 5307, 8869 (forge), 9121 et suivantes (accès à Naxxramas), 5508, 5509 et pierres du
--   Fléau (réputation Aube d'argent), quêtes de classe (aucune Horde dans la zone 2017).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 58-60 Stratholme
#displayname [FDP] Stratholme (58-60)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Tirion et Caer Darrow =====
step
    .goto Eastern Plaguelands,5.16,35.57
    >>Parle à |cRXP_FRIENDLY_Tirion Fordring|r, dans sa maison à l'ouest des Maleterres de l'est
    .accept 5846 >>Accepte L'amour et la famille
    .target 1855
    .isQuestTurnedIn 5845
step
    #completewith Renfray
    .goto Western Plaguelands,65.77,75.37,40 >>Va à Caer Darrow, l'île du lac au sud-est des Maleterres de l'Ouest
step
    #label Renfray
    .goto Western Plaguelands,65.77,75.37
    >>Parle à l'|cRXP_FRIENDLY_Artiste Renfray|r
    .turnin 5846 >>Rends L'amour et la famille
    .accept 5848 >>Accepte De l'amour et de la famille
    .target 11936
    .isOnQuest 5846
step
    .goto Western Plaguelands,70.57,74.11
    >>Parle au |cRXP_FRIENDLY_Magistrat Marduke|r
    .accept 5461 >>Accepte L'humain, Ras Murmegivre
    .target 11286
    .isQuestTurnedIn 5384

-- ===== Stromgarde (Hautes-terres d'Arathi) =====
step
    #completewith Souvenir
    .goto Arathi Highlands,27.60,66.00,40 >>Va aux ruines de Stromgarde, au sud-ouest des Hautes-terres d'Arathi (à cheval par Moulin-de-Tarren et le Mur de Thoradin)
    .isOnQuest 5461
step
    #label Souvenir
    .goto Arathi Highlands,27.60,66.00
    >>Fouille les ruines de Stromgarde et ramasse le |cRXP_PICK_Livre du souvenir|r (plusieurs emplacements possibles dans la ville)
    .complete 5461,1 --Livre du souvenir
    .isOnQuest 5461
step
    #completewith Marduke
    .goto Western Plaguelands,70.57,74.11,40 >>Retourne à Caer Darrow
    .isQuestComplete 5461
step
    #label Marduke
    .goto Western Plaguelands,70.57,74.11
    >>Parle au |cRXP_FRIENDLY_Magistrat Marduke|r
    .turnin 5461 >>Rends L'humain, Ras Murmegivre
    .accept 5462 >>Accepte Le moribond, Ras Murmegivre
    .target 11286
    .isQuestComplete 5461

-- ===== Chapelle de l'Espoir de Lumière =====
step
    #completewith Leonid
    .goto Eastern Plaguelands,71.89,48.29,40 >>Va à la chapelle de l'Espoir de Lumière, à l'est des Maleterres de l'est
step
    .goto Eastern Plaguelands,71.89,48.29
    >>Parle à |cRXP_FRIENDLY_Leonid Barthalomew le Révéré|r, dans la chapelle
    .turnin 5462 >>Rends Le moribond, Ras Murmegivre
    .target 11036
    .isOnQuest 5462
step
    #label Leonid
    .goto Eastern Plaguelands,71.89,48.29
    >>Parle à |cRXP_FRIENDLY_Leonid Barthalomew le Révéré|r
    .accept 5243 >>Accepte Les demeures du Sacré
    .target 11036
step
    .goto Eastern Plaguelands,71.89,48.29
    >>Parle à |cRXP_FRIENDLY_Leonid Barthalomew le Révéré|r
    .accept 5463 >>Accepte Le cadeau de Menethil
    .target 11036
    .isQuestTurnedIn 5462
step
    .goto Eastern Plaguelands,70.88,48.43
    >>Parle à |cRXP_FRIENDLY_Smokey LaRue|r
    .accept 5214 >>Accepte Le grand Ezra Grimm
    .target 11033
step
    .goto Eastern Plaguelands,71.63,50.09
    >>Parle au |cRXP_FRIENDLY_Duc Nicholas Zverenhoff|r
    .accept 5251 >>Accepte L'archiviste
    .target 11039
step
    .goto Eastern Plaguelands,69.93,53.72
    >>Parle au |cRXP_FRIENDLY_Conservateur Alen|r, au sud de la chapelle
    .accept 5281 >>Accepte Âmes tourmentées
    .target 11038

-- ===== Nathanos et Egan =====
step
    .goto Eastern Plaguelands,22.23,63.51
    >>Va voir |cRXP_FRIENDLY_Nathanos le Flétrisseur|r à la ferme des Marris, au sud-ouest
    .accept 6163 >>Accepte Ramstein
    .target 11878
    .isQuestTurnedIn 6135
    .isQuestTurnedIn 6136
step
    .goto Eastern Plaguelands,11.36,26.60
    >>Parle à |cRXP_FRIENDLY_Egan|r, à Terreval au nord-ouest
    .turnin 5281 >>Rends Âmes tourmentées
    .target 11140
    .isOnQuest 5281
step
    .goto Eastern Plaguelands,11.36,26.60
    >>Parle à |cRXP_FRIENDLY_Egan|r : il te donne son |cRXP_LOOT_Libérateur|r
    .accept 5282 >>Accepte Âmes tourmentées
    .target 11140
    .isQuestTurnedIn 5281

-- ===== Stratholme, côté vivant =====
step
    #sticky
    >>Ouvre les |cRXP_PICK_Caisses de fournitures|r dans les rues pour l'|cRXP_LOOT_Eau sacrée de Stratholme|r. Certaines lâchent des rats ou des insectes
    >>|cRXP_WARN_Pas toutes les caisses en ont : chacun doit ouvrir ses caisses. Finis côté mort-vivant si besoin|r
    .complete 5243,1 --Eau sacrée de Stratholme (5)
    .isOnQuest 5243
step
    #sticky
    >>Utilise le |cRXP_LOOT_Libérateur d'Egan|r sur les |cRXP_ENEMY_Citoyens spectraux|r et |cRXP_ENEMY_Citoyens fantomatiques|r, puis encore sur l'|cRXP_ENEMY_Ame sans repos|r qui en sort
    >>|cRXP_WARN_Chacun doit libérer ses âmes|r
    .complete 5282,1 --Âme libérée (15)
    .use 13289
    .mob 10384
    .mob 10385
    .mob 11122
    .isOnQuest 5282
step
    #label EntreeVivant
    .goto Eastern Plaguelands,26.52,10.36,20 >>Va à la porte principale de Stratholme, au nord des Maleterres de l'est, et entre dans l'instance
step
    >>Côté vivant, parle à |cRXP_FRIENDLY_Aurius|r, un paladin caché dans la ville écarlate
    .accept 5122 >>Accepte Le médaillon de foi
    .target 10917
step
    >>Trouve la boutique d'|cRXP_FRIENDLY_Ezra Grimm|r et ouvre la boîte de |cRXP_PICK_Tabac de Grimm|r. Si |cRXP_ENEMY_Ezra Grimm|r apparaît, tue-le pour le |cRXP_LOOT_Tabac de Grimm|r
    .complete 5214,1 --Tabac de Grimm
    .mob 11058
    .isOnQuest 5214
step
    >>Dans les archives écarlates, tue l'|cRXP_ENEMY_Archiviste Galford|r et mets le feu aux |cRXP_PICK_Archives écarlates|r
    .complete 5251,1 --Archiviste Galford
    .complete 5251,2 --Archives brûlées
    .mob 10811
    .isOnQuest 5251
step
    >>Dans le Bastion écarlate, tue |cRXP_ENEMY_Malor le Zélé|r et ouvre le |cRXP_PICK_Coffre de Malor|r pour le |cRXP_LOOT_Médaillon de foi|r
    .complete 5122,1 --Médaillon de foi
    .mob 11032
    .isOnQuest 5122
step
    >>Toujours dans le Bastion, trouve la |cRXP_PICK_Peinture inachevée|r (un tableau des deux lunes) : derrière se cache |cRXP_LOOT_De l'amour et de la famille|r
    .complete 5848,1 --De l'amour et de la famille
    .isOnQuest 5848
step
    >>Retourne voir |cRXP_FRIENDLY_Aurius|r
    .turnin 5122 >>Rends Le médaillon de foi
    .accept 5125 >>Accepte L'estimation d'Aurius
    .target 10917
    .isQuestComplete 5122
step
    >>Tue le |cRXP_ENEMY_Grand croisé Dathrohan|r, qui devient |cRXP_ENEMY_Balnazzar|r, dernier boss du côté vivant, et ramasse la |cRXP_LOOT_Tête de Balnazzar|r. Garde-la : elle lance sa quête une fois L'archiviste rendue
    .collect 13250,1 --Tête de Balnazzar
    .mob 10812
    .mob 10813
    .isQuestAvailable 5262

-- ===== Espoir de Lumière, entre les deux côtés =====
step
    +|cRXP_WARN_Ne réinitialise pas l'instance : Aurius doit t'attendre chez le baron, côté mort-vivant|r. Coche pour continuer
    .isOnQuest 5125
step
    #completewith Zverenhoff1
    .goto Eastern Plaguelands,71.63,50.09,40 >>Retourne à la chapelle de l'Espoir de Lumière
step
    #label Zverenhoff1
    .goto Eastern Plaguelands,71.63,50.09
    >>Parle au |cRXP_FRIENDLY_Duc Nicholas Zverenhoff|r
    .turnin 5251 >>Rends L'archiviste
    .target 11039
    .isQuestComplete 5251
step
    .goto Eastern Plaguelands,71.63,50.09
    >>Utilise la |cRXP_LOOT_Tête de Balnazzar|r pour lancer la quête, puis rends-la au |cRXP_FRIENDLY_Duc Nicholas Zverenhoff|r
    .accept 5262 >>Accepte La vérité vient du ciel
    .turnin 5262 >>Rends La vérité vient du ciel
    .accept 5263 >>Accepte Au-dessus et au-delà
    .use 13250
    .target 11039
    .isQuestTurnedIn 5251
step
    .goto Eastern Plaguelands,70.88,48.43
    >>Parle à |cRXP_FRIENDLY_Smokey LaRue|r
    .turnin 5214 >>Rends Le grand Ezra Grimm
    .target 11033
    .isQuestComplete 5214
step
    .goto Eastern Plaguelands,71.89,48.29
    >>Parle à |cRXP_FRIENDLY_Leonid Barthalomew le Révéré|r
    .turnin 5243 >>Rends Les demeures du Sacré
    .target 11036
    .isQuestComplete 5243

-- ===== Stratholme, côté mort-vivant =====
step
    #label EntreeMort
    .goto Eastern Plaguelands,41.45,17.74,20 >>Va à l'entrée de service de Stratholme, au nord-est de la ville, et entre dans l'instance
step
    >>Passe le |cRXP_ENEMY_Magistrat Barthilas|r, puis, dans les rues des ziggourats, trouve le |cRXP_PICK_Don de Menethil|r, une tache de terre impie au sol. Pose-y le |cRXP_LOOT_Livre du souvenir|r, puis reprends la quête qui apparaît
    .turnin 5463 >>Rends Le cadeau de Menethil
    .accept 5464 >>Accepte Le cadeau de Menethil
    .isOnQuest 5463
step
    >>Tue les trois gardiens des ziggourats pour ouvrir l'abattoir. Tue |cRXP_ENEMY_Ramstein Grandgosier|r et ramasse sa |cRXP_LOOT_Tête|r
    .complete 6163,1 --Tête de Ramstein Grandgosier
    .mob 10439
    .isOnQuest 6163
step
    >>Tue le |cRXP_ENEMY_Baron Rivendare|r, dernier boss, et ramasse sa |cRXP_LOOT_Tête|r
    .complete 5263,1 --Tête du baron Rivendare
    .mob 10440
    .isOnQuest 5263
step
    >>Après le combat, parle au corps d'|cRXP_FRIENDLY_Aurius|r, venu t'aider contre le baron
    .turnin 5125 >>Rends L'estimation d'Aurius
    .target 10917
    .isOnQuest 5125

-- ===== Rendus : Espoir de Lumière =====
step
    #completewith Zverenhoff2
    .goto Eastern Plaguelands,71.63,50.09,40 >>Retourne à la chapelle de l'Espoir de Lumière
step
    #label Zverenhoff2
    .goto Eastern Plaguelands,71.63,50.09
    >>Parle au |cRXP_FRIENDLY_Duc Nicholas Zverenhoff|r
    .turnin 5263 >>Rends Au-dessus et au-delà
    .accept 5264 >>Accepte Seigneur Maxwell Tyrosus
    .target 11039
    .isQuestComplete 5263
step
    .goto Eastern Plaguelands,71.90,48.41
    >>Parle au |cRXP_FRIENDLY_Seigneur Maxwell Tyrosus|r, dans la chapelle
    .turnin 5264 >>Rends Seigneur Maxwell Tyrosus
    .accept 5265 >>Accepte Siège de l’Aube d'argent
    .target 11034
    .isOnQuest 5264
step
    .goto Eastern Plaguelands,71.96,48.41
    >>Ouvre le |cRXP_PICK_Siège de l'Aube d'argent|r à côté de Maxwell et choisis ta récompense
    .turnin 5265 >>Rends Siège de l’Aube d'argent
    .isOnQuest 5265
step
    .goto Eastern Plaguelands,71.89,48.29
    >>Parle à |cRXP_FRIENDLY_Leonid Barthalomew le Révéré|r
    .turnin 5464 >>Rends Le cadeau de Menethil
    .target 11036
    .isOnQuest 5464
step
    .goto Eastern Plaguelands,71.89,48.29
    >>Parle à |cRXP_FRIENDLY_Leonid Barthalomew le Révéré|r. |cRXP_WARN_Eau sacrée pas finie : ouvre d'autres caisses lors d'une prochaine run, puis reviens|r
    .turnin 5243 >>Rends Les demeures du Sacré
    .target 11036
    .isOnQuest 5243

-- ===== Rendus : Nathanos, Egan et Tirion =====
step
    .goto Eastern Plaguelands,22.23,63.51
    >>Retourne voir |cRXP_FRIENDLY_Nathanos le Flétrisseur|r à la ferme des Marris
    .turnin 6163 >>Rends Ramstein
    .target 11878
    .isQuestComplete 6163
step
    .goto Eastern Plaguelands,11.36,26.60
    >>Retourne voir |cRXP_FRIENDLY_Egan|r à Terreval. |cRXP_WARN_Âmes pas finies : refais une run côté vivant puis reviens, ou passe l'étape|r
    .turnin 5282 >>Rends Âmes tourmentées
    .target 11140
    .isOnQuest 5282
step
    #label FinStratholme
    .goto Eastern Plaguelands,5.16,35.57
    >>Rapporte le tableau à |cRXP_FRIENDLY_Tirion Fordring|r
    .turnin 5848 >>Rends De l'amour et de la famille
    .target 1855
    .isOnQuest 5848
]])

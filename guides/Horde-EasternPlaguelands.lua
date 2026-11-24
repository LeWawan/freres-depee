if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Eastern Plaguelands (Maleterres de l'est), Horde, toutes
-- classes, en duo. Fin de la route FDP (vers le niveau 60).
-- Indépendant des autres régions : La petite Pamela (5142, Maleterres de l'Ouest), Pamela,
-- ma soeur (5601, Berceau-de-l'Hiver), Frère Carlin (5210, Chromie à Andorhal), Le champion
-- de la reine banshee (5961, Undercity) et Le duc Nicholas Zverenhoff (6030,
-- Berceau-de-l'Hiver) sont protégées par .isOnQuest. Vilains de Darrowshire (5181) n'est
-- proposée que si Frère Carlin est rendue.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua. Taux de drop
-- wowheadData : Chair de ver putride 34 % sur les Larves putrides (15 x 2 x 100 / 34 = ~88
-- kills, gardée car la chaîne de Tirion rapporte ~18 600 xp, ~210 xp/kill), Pourriture
-- vivante 18-27 % à la Croisée de Corin (7 x 2 x 100 / 25 = ~56 kills, gardée : ~110 xp/kill
-- pour la quête seule, plus les deux suites de Nathanos). Taux d'apparition des Esprits de
-- Darrowshire inconnu.
-- Itinéraire : depuis les Maleterres de l'Ouest, maison de Tirion -> Terreval (Augustus) ->
-- sud-ouest (chiens, chauves-souris, larves) -> Nathanos et la Basse-crypte -> Darrowshire
-- -> chapelle de l'Espoir de Lumière (vol) -> Croisée de Corin et centre -> nord-est (Hameya),
-- pavillon de Quel'Lithien, nord -> bois de la Peste et Terreval (Egan) -> Tirion ->
-- Basse-crypte et Nathanos (Crépuscaile) -> Tirion -> Creusechair et Bourg-du-Nord ->
-- chapelle -> Nathanos -> Tirion.
-- Coupées :
--   5152, 5153 (chaîne de Marlene et Chromie, Maleterres de l'Ouest), 5168 (Libram de Davil
--   et Bouclier de Redpath dans les Maleterres de l'Ouest), 5206, 5941, 5721, 5942 (suites
--   de 5168, retour chez Chromie et événement de Darrowshire), 5846 (Caer Darrow, puis
--   Stratholme), 6026, 6041 (forge et ingénierie), 5264, 5265 (après 5263, Stratholme),
--   5464 (Scholomance), 5282, 6163 (Stratholme), 6144-6148 (Undercity puis Main de Tyr,
--   Demetria élite de groupe), 9665 (capture des tours, JcJ sauvage), 8930, 8946, 8947
--   (Anthion, Stratholme et ensemble de donjon), 5065 (Tanaris), 97988 (chaîne Skyborne
--   venue des Maleterres de l'Ouest, rendue à Orgrimmar), 7790 (Skyborne, Maleterres de
--   l'Ouest, 600 xp), 5503, 5508, 5509, 5510 (pierres du Fléau, réputation Aube d'argent),
--   5513, 5517, 9141, 9142, 9165, 9211, 9213, 9221-9228, 9124-9137 (réputation, insignes et
--   jetons de l'Aube d'argent, Naxxramas), 9121, 9122, 9123, 9378 (accès à Naxxramas, 9378
--   sur liste noire), 9178-9206 (commissions d'artisan, métiers, sans XP).
--   Alliance : 5246, 5247, 5248, 97987, 6185, 6187, 8929, 9664.

-- 6135/6136 (requis 56) ne sont proposées qu'au niveau 58 : Crépuscaile et Creusechair sont élites 60 et 61.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 57-60 Eastern Plaguelands
#displayname [FDP] Maleterres de l'est (57-60)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 57-60 Silithus

-- ===== Arrivée : maison de Tirion et Terreval =====
step
    #completewith ArriveeTirion
    .goto Eastern Plaguelands,5.20,35.60,30 >>Depuis les Maleterres de l'Ouest, passe la rivière Thondroril : la maison de Tirion est juste à l'est du pont
step
    #label ArriveeTirion
    .goto Eastern Plaguelands,5.20,35.60
    >>Parle à |cRXP_FRIENDLY_Tirion Fordring|r
    .accept 5542 >>Accepte Chiens-démons
    .accept 5543 >>Accepte Ciel couleur de sang
    .accept 5544 >>Accepte Larve putride
    .target 1855
step
    #completewith TirionRendu
    >>Tue les |cRXP_ENEMY_Larves putrides|r et les |cRXP_ENEMY_Dévoreurs putrides|r croisés en route pour leur |cRXP_LOOT_Chair|r. |cRXP_WARN_Farm long en duo (~88 kills) : chacun doit looter ses objets|r
    .complete 5544,1 --Chair de Ver putride (15)
    .mob 8603
    .mob 8605
step
    .goto Eastern Plaguelands,11.40,26.40
    >>Parle à |cRXP_FRIENDLY_Augustus le Touché|r, à Terreval au nord
    .accept 6164 >>Accepte Le livre de compte d'Augustus
    .target 12384
step
    .goto Eastern Plaguelands,14.00,24.20
    >>Ramasse le |cRXP_PICK_Livre de compte d'Augustus|r dans la maison
    .complete 6164,1 --Livre de compte d'Augustus
step
    .goto Eastern Plaguelands,11.40,26.40
    >>Retourne voir |cRXP_FRIENDLY_Augustus le Touché|r
    .turnin 6164 >>Rends Le livre de compte d'Augustus
    .target 12384

-- ===== Sud-ouest : Nathanos, Basse-crypte, Darrowshire =====
step
    .goto Eastern Plaguelands,15.00,58.00
    >>Au sud de la maison de Tirion, tue les |cRXP_ENEMY_Chiens pestiférés chétifs|r et les |cRXP_ENEMY_Chauves-souris pestiférées|r
    .complete 5542,1 --Chien pestiféré chétif (20)
    .complete 5543,1 --Chauve-souris pestiférée (30)
    .mob 8596
    .mob 8600
    .mob 8603
step
    .goto Eastern Plaguelands,22.20,63.50
    >>Parle à |cRXP_FRIENDLY_Nathanos le Flétrisseur|r à la ferme de Marris
    .turnin 5961 >>Rends Le champion de la reine banshee
    .target 11878
    .isOnQuest 5961
step
    .goto Eastern Plaguelands,22.20,63.50
    >>Parle à |cRXP_FRIENDLY_Nathanos le Flétrisseur|r
    .accept 6022 >>Accepte Tuer utile
    .accept 6042 >>Accepte Les petits soucis de la non-vie
    .accept 6133 >>Accepte L'ordre du seigneur forestier
    .target 11878
step
    .goto Eastern Plaguelands,22.90,73.00
    >>Lis le |cRXP_PICK_Parchemin déchiré|r près de l'entrée de la Basse-crypte
    .accept 6024 >>Accepte L'appel d'Hameya
step
    .goto Eastern Plaguelands,31.10,78.00
    >>Parle à |cRXP_FRIENDLY_Pamela Redpath|r à Darrowshire
    .turnin 5142 >>Rends La petite Pamela
    .target 10926
    .isOnQuest 5142
step
    .goto Eastern Plaguelands,31.10,78.00
    >>Parle à |cRXP_FRIENDLY_Pamela Redpath|r
    .turnin 5601 >>Rends Pamela, ma sœur
    .target 10926
    .isOnQuest 5601
step
    .goto Eastern Plaguelands,31.10,78.00
    >>Parle à |cRXP_FRIENDLY_Pamela Redpath|r
    .accept 5149 >>Accepte Poupée de Pamela
    .target 10926
step
    .goto Eastern Plaguelands,33.50,78.50
    >>Fouille les maisons de Darrowshire : ramasse la |cRXP_PICK_Tête|r, le |cRXP_PICK_Flanc gauche|r et le |cRXP_PICK_Flanc droit|r de la poupée, puis assemble-les
    .complete 5149,1 --Poupée de Pamela
step
    .goto Eastern Plaguelands,31.10,78.00
    >>Retourne voir |cRXP_FRIENDLY_Pamela Redpath|r
    .turnin 5149 >>Rends Poupée de Pamela
    .accept 5241 >>Accepte Oncle Carlin
    .target 10926

-- ===== Chapelle de l'Espoir de Lumière =====
step
    #completewith ArriveeChapelle
    .goto Eastern Plaguelands,70.50,47.50,40 >>Prends la route de l'est jusqu'à la chapelle de l'Espoir de Lumière
step
    #label ArriveeChapelle
    .goto Eastern Plaguelands,70.50,47.50
    >>Parle à |cRXP_FRIENDLY_Georgia|r
    .fp Light's Hope >>Prends le point de vol de la chapelle de l'Espoir de Lumière
    .target 12636
step
    .goto Eastern Plaguelands,71.70,50.00
    >>Parle à |cRXP_FRIENDLY_Carlin Redpath|r
    .turnin 5241 >>Rends Oncle Carlin
    .accept 5211 >>Accepte Défenseurs de Darrowshire
    .target 11063
step
    .goto Eastern Plaguelands,71.70,50.00
    >>Parle à |cRXP_FRIENDLY_Carlin Redpath|r
    .turnin 5210 >>Rends Frère Carlin
    .target 11063
    .isOnQuest 5210
step
    .goto Eastern Plaguelands,71.70,50.00
    >>Parle à |cRXP_FRIENDLY_Carlin Redpath|r
    .accept 5181 >>Accepte Vilains de Darrowshire
    .target 11063
    .isQuestTurnedIn 5210
step
    .goto Eastern Plaguelands,71.60,50.10
    >>Parle au |cRXP_FRIENDLY_Duc Nicholas Zverenhoff|r
    .turnin 6030 >>Rends Le duc Nicholas Zverenhoff
    .target 11039
    .isOnQuest 6030
step
    .goto Eastern Plaguelands,69.90,53.70
    >>Parle au |cRXP_FRIENDLY_Conservateur Alen|r, au sud de la chapelle
    .accept 6021 >>Accepte Zaeldarr le Banni
    .accept 5281 >>Accepte Âmes tourmentées
    .target 11038
step
    #completewith CarlinRendu
    >>Tue les |cRXP_ENEMY_Goules cannibales|r et |cRXP_ENEMY_Goules bredouillantes|r et parle aux |cRXP_FRIENDLY_Esprits de Darrowshire|r qui apparaissent. |cRXP_WARN_Chacun doit parler à ses esprits|r
    .complete 5211,1 --Esprit de Darrowshire libéré (15)
    .mob 8530
    .mob 8531

-- ===== Centre : Croisée de Corin =====
step
    .goto Eastern Plaguelands,46.90,55.40
    >>Ramasse l'|cRXP_PICK_Epée brisée de Marduk|r
    .complete 5181,2 --Epée brisée de Marduk
    .isOnQuest 5181
step
    .goto Eastern Plaguelands,52.50,57.50
    >>À la Croisée de Corin, tue les |cRXP_ENEMY_Magiciens noirs|r, |cRXP_ENEMY_Goules bredouillantes|r et |cRXP_ENEMY_Serviteurs invisibles|r pour 7 |cRXP_LOOT_Pourritures vivantes|r, puis utilise le |cRXP_LOOT_Mortier et pilon|r. |cRXP_WARN_La pourriture disparaît après 10 minutes : farmez l'un après l'autre (~28 kills chacun)|r
    .complete 6022,1 --Pourriture coagulée
    .use 15454
    .mob 8526
    .mob 8531
    .mob 8538
step
    .goto Eastern Plaguelands,50.00,48.00
    >>Tue les |cRXP_ENEMY_Chiens pestiférés|r et les |cRXP_ENEMY_Chauves-souris pestiférées nuisibles|r au centre de la zone
    .complete 5542,2 --Chien pestiféré (5)
    .complete 6042,1 --Chauve-souris pestiférée nuisible (20)
    .mob 8597
    .mob 8601
    .mob 8603
step
    .goto Eastern Plaguelands,44.30,41.20
    >>Ramasse le |cRXP_PICK_Crâne d'Horgus|r
    .complete 5181,1 --Crâne d'Horgus
    .isOnQuest 5181

-- ===== Nord : Hameya, pavillon de Quel'Lithien =====
step
    .goto Eastern Plaguelands,62.00,11.10
    >>Au nord-est, tue l'|cRXP_ENEMY_Infiltrateur Hameya|r et prends sa |cRXP_LOOT_Clé|r
    .complete 6024,1 --Clé d'Hameya
    .mob 12248
    .unitscan 12248
step
    .goto Eastern Plaguelands,45.30,12.70
    >>Au pavillon de Quel'Lithien, tue les |cRXP_ENEMY_Forestiers|r, |cRXP_ENEMY_Eclaireurs|r et |cRXP_ENEMY_Bûcherons|r et ramasse le |cRXP_PICK_Registre de Quel'Thalas|r dans le pavillon
    .complete 6133,1
    .complete 6133,2
    .complete 6133,3
    .complete 6133,4
    .mob 8564
    .mob 8565
    .mob 8563
step
    .goto Eastern Plaguelands,45.00,27.00
    >>Tue les |cRXP_ENEMY_Chiens pestiférés frénétiques|r et les |cRXP_ENEMY_Chauves-souris pestiférées monstrueuses|r
    .complete 5542,3 --Chien pestiféré frénétique (5)
    .complete 6042,2 --Chauve-souris pestiférée monstrueuse (10)
    .mob 8598
    .mob 8602
    .mob 8605

-- ===== Bois de la Peste, Terreval et Tirion =====
step
    .goto Eastern Plaguelands,11.40,26.60
    >>Traverse le bois de la Peste (|cRXP_ENEMY_Goules cannibales|r pour les esprits) jusqu'à Terreval et parle à |cRXP_FRIENDLY_Egan|r
    .turnin 5281 >>Rends Âmes tourmentées
    .target 11140
step
    #label TirionRendu
    .goto Eastern Plaguelands,5.20,35.60
    >>Retourne voir |cRXP_FRIENDLY_Tirion Fordring|r
    .turnin 5542 >>Rends Chiens-démons
    .turnin 5543 >>Rends Ciel couleur de sang
    .turnin 5544 >>Rends Larve putride
    .accept 5742 >>Accepte Rédemption
    .target 1855
step
    .goto Eastern Plaguelands,5.20,35.60
    >>Écoute l'histoire de |cRXP_FRIENDLY_Tirion Fordring|r
    .complete 5742,1
    .target 1855
step
    .goto Eastern Plaguelands,5.20,35.60
    >>Parle à |cRXP_FRIENDLY_Tirion Fordring|r
    .turnin 5742 >>Rends Rédemption
    .accept 5781 >>Accepte Aux mémoires perdues
    .target 1855

-- ===== Basse-crypte et Nathanos =====
step
    .goto Eastern Plaguelands,23.90,74.20
    >>À la Basse-crypte, tue |cRXP_ENEMY_Mercutio Filthgorger|r pour le |cRXP_LOOT_Marteau de Taelan|r et |cRXP_ENEMY_Zaeldarr le Banni|r pour sa |cRXP_LOOT_Tête|r
    .complete 5781,1 --Marteau de Taelan
    .complete 6021,1 --Tête de Zaeldarr
    .mob 11886
    .mob 12250
step
    .goto Eastern Plaguelands,23.60,73.80
    >>Utilise la clé d'Hameya sur le |cRXP_PICK_Monticule de poussière|r derrière la Basse-crypte
    .turnin 6024 >>Rends L'appel d'Hameya
step
    .goto Eastern Plaguelands,22.20,63.50
    >>Retourne voir |cRXP_FRIENDLY_Nathanos le Flétrisseur|r
    .turnin 6022 >>Rends Tuer utile
    .turnin 6042 >>Rends Les petits soucis de la non-vie
    .turnin 6133 >>Rends L'ordre du seigneur forestier
    .target 11878
step
    .goto Eastern Plaguelands,22.20,63.50
    >>Parle à |cRXP_FRIENDLY_Nathanos le Flétrisseur|r. |cRXP_WARN_Deux élites (60 et 61) : en duo|r
    .accept 6135 >>Accepte Crépuscaile, oh comme je te hais !
    .accept 6136 >>Accepte Le corpulent
    .target 11878
    .xp <58,1
step
    .goto Eastern Plaguelands,26.10,59.00
    >>Tue |cRXP_ENEMY_Crépuscaile|r au nord de la ferme et prends sa |cRXP_LOOT_Fourrure|r. |cRXP_WARN_Élite 60 : en duo|r
    .complete 6135,1 --Touffe de fourrure de Crépuscaile
    .mob 11897
    .unitscan 11897
    .isOnQuest 6135
step
    .goto Eastern Plaguelands,22.20,63.50
    >>Retourne voir |cRXP_FRIENDLY_Nathanos le Flétrisseur|r
    .turnin 6135 >>Rends Crépuscaile, oh comme je te hais !
    .target 11878
    .isOnQuest 6135
step
    .goto Eastern Plaguelands,5.20,35.60
    >>Retourne voir |cRXP_FRIENDLY_Tirion Fordring|r
    .turnin 5781 >>Rends Aux mémoires perdues
    .accept 5845 >>Accepte De l'honneur perdu
    .target 1855

-- ===== Nord-est : Creusechair et Bourg-du-Nord =====
step
    .goto Eastern Plaguelands,47.70,24.90
    >>Tue |cRXP_ENEMY_Creusechair|r. |cRXP_WARN_Élite 61 : en duo|r
    .complete 6136,1 --Creusechair
    .mob 11896
    .unitscan 11896
    .isOnQuest 6136
step
    .goto Eastern Plaguelands,62.50,26.80
    >>À Bourg-du-Nord, ramasse le |cRXP_PICK_Symbole de l'honneur perdu|r
    .complete 5845,1 --Symbole de l'honneur perdu
step
    #label CarlinRendu
    .goto Eastern Plaguelands,71.70,50.00
    >>Retourne à la chapelle et parle à |cRXP_FRIENDLY_Carlin Redpath|r
    .turnin 5211 >>Rends Défenseurs de Darrowshire
    .turnin -5181 >>Rends Vilains de Darrowshire
    .target 11063
step
    .goto Eastern Plaguelands,69.90,53.70
    >>Parle au |cRXP_FRIENDLY_Conservateur Alen|r
    .turnin 6021 >>Rends Zaeldarr le Banni
    .target 11038

-- ===== Retour à l'ouest =====
step
    .goto Eastern Plaguelands,22.20,63.50
    >>Retourne voir |cRXP_FRIENDLY_Nathanos le Flétrisseur|r
    .turnin 6136 >>Rends Le corpulent
    .target 11878
    .isOnQuest 6136
step
    .goto Eastern Plaguelands,5.20,35.60
    >>Retourne voir |cRXP_FRIENDLY_Tirion Fordring|r
    .turnin 5845 >>Rends De l'honneur perdu
    .target 1855
step
    #label FinMaleterresEst
    +|cRXP_WARN_Niveau conseillé pour la suite : 58. Suite et fin de la route : Silithus. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

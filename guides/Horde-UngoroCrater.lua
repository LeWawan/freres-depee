if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Un'Goro Crater (Cratère d'Un'Goro), Horde, toutes classes,
-- en duo. Indépendant des autres régions : aucune quête venue d'ailleurs n'est requise.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-traces.lua (valeurs Forever :
-- 3881 = 5250, 3883 = 5100, 87492 et 87494 = 5650). Taux de drop wowheadData : peaux de
-- gorille ~20 %, écailles étoilées ~25 %, cendres d'Un'Goro ~18 %, glandes de phéromone
-- ~87 %. Écaille imprégnée de cristaux (87494) et journal abîmé (3884) sans taux : 35 %
-- supposés, étapes opportunistes ou courtes.
-- Itinéraire : rampe de Tanaris -> Torwa (sud-est, chaîne de Lar'korwi, cristal, radeau)
-- -> Refuge de l'Ornithologue -> nord-est (A-mi 01) -> est (caisse, pétales-de-sang) ->
-- ruche Gorishi (sud) -> sud-ouest (os, équipement) -> ouest (Krakle) -> crête de la
-- Fournaise (point chaud, escorte de Ringo) -> Refuge -> tournée des pylônes (ouest avec
-- Krakle, est avec Lar'korwi, Torwa, U'cha, nord) -> Refuge -> Torwa (fin, au bas de la
-- rampe de Tanaris).
-- Cristaux de puissance (4284) : 7 de chaque couleur par joueur, ~56 ramassages en duo,
-- gardée car la chaîne avec les pylônes donne ~17600 xp (plus de 300 xp par ramassage).
-- Gorilles (4289) : 6 peaux à ~20 % = ~60 kills, gardée car la chaîne avec U'cha (4301)
-- donne 11300 xp (~190 xp/kill), au prix d'un dernier trajet Refuge -> Torwa.
-- XP gardée : ~107000 en quêtes (+3550 si le journal tombe), environ un niveau avec les kills.
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   4503 La machine volante de Shizzle (16 écailles à ~25 % = ~130 kills), 4502 Activité
--   volcanique (rendue à Ratchet, 9 cendres à ~18 % = ~100 kills), 4244 et 4245 À la
--   poursuite d'A-mi 01 (caisse en mithril : ingénierie ou hôtel des ventes, pas de drop
--   dans la zone), 980 Les nouvelles sources et 3908 (envois vers Berceau-de-l'Hiver),
--   chaîne de Linken 3909, 3912, 3913, 3914, 3941, 3942, 4084, 4005, 3961, 3962 (Féralas,
--   Gadgetzan, Gangrebois, Berceau-de-l'Hiver), 4147 Atelier de Marvon, 4146 et 4148
--   (Ratchet, brouillard du Temple englouti), 4381-4386 (cristaux des pylônes, buffs sans
--   XP), 5150 Dadanga a faim ! (pas d'XP), 92020 (envoi vers Hyjal, 560 xp), 94399
--   (niveau 58), 4141-4144 (Alliance), 9051-9053 et 9063 (quêtes de druide).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 51-52 Un'Goro Crater
#displayname [FDP] Cratère d'Un'Goro (51-52)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 51-54 Felwood

-- ===== Arrivée : Torwa et le sud-est =====
step
    #completewith ArriveeTorwa
    .goto Un'Goro Crater,71.64,75.96,40 >>Depuis Gadgetzan, va au sud-ouest de Tanaris et descends la rampe dans le cratère. |cRXP_FRIENDLY_Torwa Pathfinder|r campe en bas, au sud-est. |cRXP_WARN_Rampe non vérifiée en jeu. Attention aux diablosaures élites qui patrouillent|r
step
    #label ArriveeTorwa
    .goto Un'Goro Crater,71.64,75.96
    >>Parle à |cRXP_FRIENDLY_Torwa Pathfinder|r
    .accept 4290 >>Accepte La nourriture de Lar'korwi
    .accept 87492 >>Accepte Cristal insolite
    .accept 4289 >>Accepte Les gorilles d'Un'Goro
    .target 9619
step
    .goto Un'Goro Crater,71.64,75.96
    >>Parle encore à |cRXP_FRIENDLY_Torwa Pathfinder|r. |cRXP_WARN_Quête Forever : si elle n'est pas proposée, passe l'étape|r
    .accept 87494 >>Accepte Contamination microcristalline
    .target 9619
step
    #completewith Glandes
    >>Tue les |cRXP_ENEMY_Ravasaures|r croisés en route pour une |cRXP_LOOT_Écaille imprégnée de cristaux|r
    .complete 87494,1 --Écaille imprégnée de cristaux
    .mob 6505
    .mob 6506
    .isOnQuest 87494
step
    .goto Un'Goro Crater,66.20,75.10
    >>Ramasse le |cRXP_PICK_Cristal bleu abîmé|r
    .complete 87492,1 --Cristal bleu abîmé
step
    .goto Un'Goro Crater,63.02,68.60
    >>Fouille l'|cRXP_PICK_Épave de radeau|r dans la mare
    .accept 3844 >>Accepte C'est un Secret pour tout le monde
step
    .goto Un'Goro Crater,63.11,69.06
    >>Ouvre le |cRXP_PICK_Petit paquet|r juste à côté
    .turnin 3844 >>Rends C'est un Secret pour tout le monde
    .accept 3845 >>Accepte C'est un secret pour tout le monde
step
    .goto Un'Goro Crater,68.70,56.70
    >>Prends un |cRXP_LOOT_Morceau de carcasse|r sur la |cRXP_PICK_Carcasse fraîche de battrodon|r
    .complete 4290,1 --Morceau de carcasse d'un battrodon
step
    .goto Un'Goro Crater,71.64,75.96
    >>Retourne voir |cRXP_FRIENDLY_Torwa Pathfinder|r
    .turnin 4290 >>Rends La nourriture de Lar'korwi
    .turnin 87492 >>Rends Cristal insolite
    .accept 4291 >>Accepte Un parfum pour Lar'korwi
    .target 9619
step
    #label Glandes
    .goto Un'Goro Crater,64.90,68.20
    >>Tue les |cRXP_ENEMY_Compagnes de Lar'korwi|r pour leurs |cRXP_LOOT_Glandes de phéromone|r
    .complete 4291,1 --Glande de phéromone de ravasaure (2)
    .mob 9683
step
    .goto Un'Goro Crater,63.10,72.40
    >>Finis l'|cRXP_LOOT_Écaille imprégnée de cristaux|r sur les |cRXP_ENEMY_Ravasaures|r
    .complete 87494,1 --Écaille imprégnée de cristaux
    .mob 6505
    .mob 6506
    .isOnQuest 87494
step
    .goto Un'Goro Crater,71.64,75.96
    >>Retourne voir |cRXP_FRIENDLY_Torwa Pathfinder|r
    .turnin 4291 >>Rends Un parfum pour Lar'korwi
    .turnin -87494 >>Rends Contamination microcristalline
    .accept 4292 >>Accepte Un appât pour Lar'korwi
    .target 9619

-- ===== Refuge de l'Ornithologue =====
step
    #completewith ArriveeRefuge
    .goto Un'Goro Crater,45.22,5.84,40 >>Remonte au nord par l'est jusqu'au Refuge de l'Ornithologue. |cRXP_WARN_Garde Lar'korwi pour plus tard : il se fait près du pylône est|r
step
    #label ArriveeRefuge
    .goto Un'Goro Crater,45.22,5.84
    >>Parle à |cRXP_FRIENDLY_Gryfe|r
    .fp Marshal's Refuge >>Prends le point de vol du Refuge de l'Ornithologue
    .target 10583
step
    .goto Un'Goro Crater,44.66,8.10
    >>Parle à |cRXP_FRIENDLY_Linken|r
    .turnin 3845 >>Rends C'est un secret pour tout le monde
    .target 8737
step
    .goto Un'Goro Crater,43.62,8.50
    >>Parle à |cRXP_FRIENDLY_Spraggle Frock|r
    .accept 4492 >>Accepte Perdu !
    .target 9997
step
    .goto Un'Goro Crater,43.53,8.44
    >>Lis l'affiche |cRXP_PICK_Attention aux pterreurdactyles|r à côté
    .accept 4501 >>Accepte Attention aux pterreurdactyles
step
    .goto Un'Goro Crater,43.95,7.14
    >>Parle à |cRXP_FRIENDLY_Williden Marshal|r, |cRXP_FRIENDLY_Hol'anyee Marshal|r et |cRXP_FRIENDLY_Spark Nilminer|r
    .accept 3881 >>Accepte Le sauvetage de l'expédition
    .target 9270
    .accept 3883 >>Accepte Ecologie étrangère
    .target 9271
    .accept 3882 >>Accepte Faites rouler les os
    .target 9272
step
    .goto Un'Goro Crater,45.54,8.72
    >>Parle à |cRXP_FRIENDLY_Larion|r
    .accept 4145 >>Accepte Larion et Muigin
    .target 9118
step
    .goto Un'Goro Crater,41.92,2.70
    >>Entre dans la grotte au nord du Refuge et parle à |cRXP_FRIENDLY_J.D. Collie|r
    .accept 4284 >>Accepte Cristaux de puissance
    .target 9117
step
    .goto Un'Goro Crater,46.38,13.44
    >>Parle à |cRXP_FRIENDLY_Karna Remtravel|r, au sud du Refuge
    .accept 4243 >>Accepte À la poursuite d'A-mi 01
    .target 9618

-- ===== Tâches de fond sur toute la boucle =====
step
    #completewith RetourRefuge
    >>Ramasse les |cRXP_PICK_Cristaux de puissance|r partout sur la route (amas de cristaux colorés au sol). |cRXP_WARN_Farm long en duo (~56 cristaux) : chacun doit ramasser les siens|r
    .complete 4284,1 --Cristal de puissance rouge (7)
    .complete 4284,2 --Cristal de puissance jaune (7)
    .complete 4284,3 --Cristal de puissance vert (7)
    .complete 4284,4 --Cristal de puissance bleu (7)
step
    #completewith FinUngoro
    >>Si un mob lâche un |cRXP_LOOT_Journal abîmé|r, utilise-le pour lancer la quête
    .collect 11116,1,3884,1
    .accept 3884 >>Accepte Le journal de Williden
    .use 11116
    .isQuestAvailable 3884

-- ===== Nord-est : A-mi 01 =====
step
    #completewith AMi
    .goto Un'Goro Crater,54.00,14.00,0
    >>Tue les |cRXP_ENEMY_Pterreurdactyles|r et les |cRXP_ENEMY_Ecorcheurs Pétale-de-sang|r croisés au nord
    .complete 4501,1 --Pterreurdactyle (10)
    .complete 4145,3 --Ecorcheur Pétale-de-sang (5)
    .mob 9166
    .mob 6510
step
    .goto Un'Goro Crater,67.66,16.76
    >>Trouve |cRXP_FRIENDLY_A-mi 01|r parmi les gorilles, au nord-est
    .turnin 4243 >>Rends À la poursuite d'A-mi 01
    .target 9623
step
    #label AMi
    .goto Un'Goro Crater,66.10,16.10
    >>Tue les |cRXP_ENEMY_Gorilles|r, |cRXP_ENEMY_Marteleurs|r et |cRXP_ENEMY_Foudroyeurs d'Un'Goro|r pour leurs |cRXP_LOOT_Peaux|r. |cRXP_WARN_Farm long en duo (~60 kills) : chacun doit looter ses objets. Laisse U'cha dans la grotte pour plus tard|r
    .complete 4289,1 --Peau de gorille d'Un'Goro (2)
    .complete 4289,2 --Peau de Marteleur d'Un'Goro (2)
    .complete 4289,3 --Peau de Foudroyeur d'Un'Goro (2)
    .mob 6514
    .mob 6513
    .mob 6516

-- ===== Est : caisse et pétales-de-sang =====
step
    #completewith Caisse
    .goto Un'Goro Crater,64.00,30.00,0
    >>En descendant vers le sud, tue les |cRXP_ENEMY_Flagellants|r et les |cRXP_ENEMY_Batteurs Pétale-de-sang|r
    .complete 4145,1 --Flagellant Pétale-de-sang (5)
    .complete 4145,4 --Batteur Pétale-de-sang (5)
    .mob 6509
    .mob 6511
step
    #label Caisse
    .goto Un'Goro Crater,68.50,36.50
    >>Ramasse la |cRXP_PICK_Caisse de nourriture|r
    .complete 3881,1 --Caisse de nourriture
step
    .goto Un'Goro Crater,64.00,30.00
    >>Finis les |cRXP_ENEMY_Flagellants|r et les |cRXP_ENEMY_Batteurs Pétale-de-sang|r
    .complete 4145,1 --Flagellant Pétale-de-sang (5)
    .complete 4145,4 --Batteur Pétale-de-sang (5)
    .mob 6509
    .mob 6511

-- ===== Sud : ruche Gorishi =====
step
    #completewith Ruche
    .goto Un'Goro Crater,55.00,65.00,0
    >>En route vers le sud, finis les |cRXP_ENEMY_Ecorcheurs Pétale-de-sang|r et les |cRXP_ENEMY_Pterreurdactyles|r
    .complete 4145,3 --Ecorcheur Pétale-de-sang (5)
    .complete 4501,1 --Pterreurdactyle (10)
    .mob 6510
    .mob 9166
step
    #label Ruche
    .goto Un'Goro Crater,48.70,85.30
    >>Entre dans la ruche Gorishi (le Repli sinueux) et utilise la |cRXP_LOOT_Fiole de raclage|r dans la salle aux larves suspendues
    .complete 3883,1 --Echantillon de paroi de la ruche
    .use 11132
step
    .goto Un'Goro Crater,50.00,82.00
    >>Si besoin, finis les |cRXP_ENEMY_Pterreurdactyles|r autour de la ruche
    .complete 4501,1 --Pterreurdactyle (10)
    .mob 9166

-- ===== Sud-ouest : équipement et os =====
step
    .goto Un'Goro Crater,38.50,66.10
    >>Ramasse l'|cRXP_PICK_Equipement de recherches|r
    .complete 3881,2 --Equipement de recherche
step
    .goto Un'Goro Crater,33.30,73.20
    >>Ramasse les |cRXP_PICK_Os de dinosaure|r au sol. Les |cRXP_ENEMY_Stégodons|r en lâchent aussi. |cRXP_WARN_Stégodons élites : évite-les ou tirez-les un par un en duo|r
    .complete 3882,1 --Os de dinosaure (8)
    .mob 6501
    .mob 6502

-- ===== Ouest : Krakle et pterreurdactyles frénétiques =====
step
    #completewith Krakle
    .goto Un'Goro Crater,32.00,46.00,0
    >>Tue les |cRXP_ENEMY_Pterreurdactyles frénétiques|r et les |cRXP_ENEMY_Trappeurs Pétale-de-sang|r de l'ouest
    .complete 4501,2 --Pterreurdactyle frénétique (15)
    .complete 4145,2 --Trappeur Pétale-de-sang (5)
    .mob 9167
    .mob 6512
step
    #label Krakle
    .goto Un'Goro Crater,30.93,50.44
    >>Parle à |cRXP_FRIENDLY_Krakle|r, aux sources chaudes de Golakka
    .accept 974 >>Accepte À la recherche de la source
    .target 10302
    .xp <51,1
step
    .goto Un'Goro Crater,32.00,46.00
    >>Finis les |cRXP_ENEMY_Pterreurdactyles frénétiques|r et les |cRXP_ENEMY_Trappeurs Pétale-de-sang|r
    .complete 4501,2 --Pterreurdactyle frénétique (15)
    .complete 4145,2 --Trappeur Pétale-de-sang (5)
    .mob 9167
    .mob 6512

-- ===== Crête de la Fournaise : point chaud et Ringo =====
step
    .goto Un'Goro Crater,49.69,45.64
    >>Monte sur la crête de la Fournaise et utilise le |cRXP_LOOT_Thermomètre|r au point le plus chaud
    .complete 974,1 --Point chaud
    .use 12472
    .isOnQuest 974
step
    .goto Un'Goro Crater,51.90,49.85
    >>Trouve |cRXP_FRIENDLY_Ringo|r sur le flanc de la crête
    .turnin 4492 >>Rends Perdu !
    .target 9999
step
    .goto Un'Goro Crater,51.90,49.85
    >>Parle à |cRXP_FRIENDLY_Ringo|r pour lancer l'escorte
    .accept 4491 >>Accepte Un peu d'aide de mes amis
    .target 9999
step
    #label RetourRefuge
    .goto Un'Goro Crater,43.71,8.29
    >>Escorte |cRXP_FRIENDLY_Ringo|r jusqu'à Spraggle au Refuge. |cRXP_WARN_S'il s'évanouit, utilise la Gourde de Spraggle sur lui|r
    .complete 4491,1
    .use 11804

-- ===== Refuge : rendus =====
step
    .goto Un'Goro Crater,43.62,8.50
    >>Parle à |cRXP_FRIENDLY_Spraggle Frock|r
    .turnin 4491 >>Rends Un peu d'aide de mes amis
    .turnin 4501 >>Rends Attention aux pterreurdactyles
    .target 9997
step
    .goto Un'Goro Crater,43.95,7.14
    >>Parle à |cRXP_FRIENDLY_Williden Marshal|r, |cRXP_FRIENDLY_Hol'anyee Marshal|r et |cRXP_FRIENDLY_Spark Nilminer|r
    .turnin 3881 >>Rends Le sauvetage de l'expédition
    .target 9270
    .turnin 3883 >>Rends Ecologie étrangère
    .target 9271
    .turnin 3882 >>Rends Faites rouler les os
    .target 9272
step
    .goto Un'Goro Crater,45.54,8.72
    >>Parle à |cRXP_FRIENDLY_Larion|r
    .turnin 4145 >>Rends Larion et Muigin
    .target 9118
step
    .goto Un'Goro Crater,41.92,2.70
    >>Retourne voir |cRXP_FRIENDLY_J.D. Collie|r dans la grotte. |cRXP_WARN_S'il manque des cristaux, finis-les autour du Refuge|r
    .turnin 4284 >>Rends Cristaux de puissance
    .accept 4285 >>Accepte Le Pylône nord
    .accept 4287 >>Accepte Le Pylône est
    .accept 4288 >>Accepte Le Pylône ouest
    .target 9117

-- ===== Tournée des pylônes =====
step
    .goto Un'Goro Crater,23.86,59.19
    >>Traverse le cratère au sud-ouest jusqu'au |cRXP_PICK_Pylône de cristal ouest|r
    .complete 4288,1 --Pylône ouest découvert
step
    .goto Un'Goro Crater,30.93,50.44
    >>Retourne voir |cRXP_FRIENDLY_Krakle|r
    .turnin 974 >>Rends À la recherche de la source
    .target 10302
    .isOnQuest 974
step
    .goto Un'Goro Crater,77.16,49.98
    >>Contourne la crête de la Fournaise jusqu'au |cRXP_PICK_Pylône de cristal est|r
    .complete 4287,1 --Pylône est découvert
step
    .goto Un'Goro Crater,79.92,49.90
    >>Ouvre la |cRXP_LOOT_Sacoche de Torwa|r. Pose la viande sur le |cRXP_PICK_Rocher plat|r et les phéromones sur la carcasse : |cRXP_ENEMY_Lar'korwi|r arrive. Tue-le et prends sa |cRXP_LOOT_Tête|r. |cRXP_WARN_Niveau 56 : en duo|r
    .complete 4292,1 --Tête de Lar'korwi
    .use 11568
    .mob 9684
step
    .goto Un'Goro Crater,71.64,75.96
    >>Descends voir |cRXP_FRIENDLY_Torwa Pathfinder|r au sud
    .turnin 4292 >>Rends Un appât pour Lar'korwi
    .turnin 4289 >>Rends Les gorilles d'Un'Goro
    .accept 4301 >>Accepte Le puissant U'cha
    .target 9619
step
    .goto Un'Goro Crater,68.14,12.56
    >>Remonte au nord-est. Dans la grotte des gorilles, tue |cRXP_ENEMY_U'cha|r et prends sa |cRXP_LOOT_Peau|r. |cRXP_WARN_Niveau 55, entouré de gorilles : en duo. Uhk'loc, rare, peut traîner là aussi|r
    .complete 4301,1 --Peau d'U'cha
    .mob 9622
step
    .goto Un'Goro Crater,56.52,12.54
    >>Va au |cRXP_PICK_Pylône de cristal nord|r, à l'ouest
    .complete 4285,1 --Pylône nord découvert
step
    .goto Un'Goro Crater,41.92,2.70
    >>Retourne au Refuge et parle à |cRXP_FRIENDLY_J.D. Collie|r dans la grotte. |cRXP_WARN_Ceci explique cela : attends quelques secondes qu'il finisse avant de la rendre|r
    .turnin 4285 >>Rends Le Pylône nord
    .turnin 4287 >>Rends Le Pylône est
    .turnin 4288 >>Rends Le Pylône ouest
    .accept 4321 >>Accepte Ceci explique cela
    .turnin 4321 >>Rends Ceci explique cela
    .target 9117
step
    .goto Un'Goro Crater,43.95,7.14
    >>Rends le journal à |cRXP_FRIENDLY_Williden Marshal|r
    .turnin 3884 >>Rends Le journal de Williden
    .target 9270
    .isOnQuest 3884
step
    .goto Un'Goro Crater,71.64,75.96
    >>Redescends voir |cRXP_FRIENDLY_Torwa Pathfinder|r au sud-est, en bas de la rampe de Tanaris
    .turnin 4301 >>Rends Le puissant U'cha
    .target 9619
step
    #label FinUngoro
    +|cRXP_WARN_Niveau conseillé pour la suite : 52. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

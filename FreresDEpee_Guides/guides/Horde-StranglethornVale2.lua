if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Stranglethorn Vale (Strangleronce), deuxième passage, Horde,
-- toutes classes, duo. Reprend les quêtes 40+ laissées par le guide 33-36.
-- Indépendant des autres régions : les suites des quêtes du guide 33-36 sont protégées par
-- .isQuestTurnedIn (192, 195, 188, 599), 1116 (prise à Baie-du-Butin, faite au Marais des
-- chagrins) par .isQuestComplete.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-traces.lua et xpDB-classic.lua,
-- taux de drop de classicItemDrops.lua (35 % si absent). Duo : kills = 2 x nombre x 100 / taux.
-- XP réduite selon Questie (QuestieXP.lua) : pleine jusqu'au niveau de quête + 5, puis 80, 60,
-- 40, 20 %, plancher 10 %.
-- Itinéraire : Grom'gol -> camp de Nesingwary (quatre passages : traqueurs et Bhag'thera,
-- Téthis, roi Bangalash) avec le camp de Kurzen au nord-est -> vol vers Baie-du-Butin ->
-- côte sud (Voile sanglante, camp puis navires) -> Valbrume (Mokk, abats, Gorlash, bouteille)
-- -> ruines de Zanzil (gages vaudou) -> Baie-du-Butin.
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   Chaîne de Yenniku 581/582 (9 défenses à 17 % = ~106 kills, 20 têtes à 48 % = ~83 kills,
--     quêtes de niveau 34/37 : 10 % et 60 % d'XP au niveau 44), donc 584, 585, 586, 588, 589, 591
--     (Mai'Zoth, élite 47 au sommet du mont Mosh'Ogg, au milieu des ogres élites) et 592 ;
--     sans 591/592 la chaîne tombe à ~65 xp/kill,
--   Mok'thardin 572 (10 plumes à 18 % = ~111 kills), 571 (tendon à 1,5 % = ~133 kills), 573,
--     chaîne à ~37 xp/kill,
--   600 La mauvaise mine (10 cristaux à 41 % = ~49 kills, 67 xp/kill), 209 Les défenses
--     Skullsplitter (18 défenses à ~25 % = ~144 kills), 587 Faire un tabac (15 tabacs à ~40 % =
--     ~75 kills), 576 Gardez un œil dehors (œil à ~2 %), 617 De derrière les fagots (10 roseaux à
--     39 % = ~52 kills, 69 xp/kill ; suite 623 Alliance), 621 Le secret de Zanzil (12 mixtures à
--     42 % = ~57 kills, 66 xp/kill),
--   613 Le pied-bot de Maury (clé à ~9 % sur les ogres élites Mosh'Ogg = ~22 élites),
--   97386 L'offensive de Grom'gol (ogres élites 41-45 en groupes, nombre de kills inconnu),
--   577/628 Drizzlik (niveau 36/38 : 577 à 40 % au niveau 44, 32 kills pour ~560 xp),
--   338-342 pages des Vertes collines (1-3 %), 580 La bibine perdue (1,7 %),
--   630 Message dans une bouteille (roi Mukla, élite 51), 624/625/626 Devinette de Cortello
--     (départ sur un drop rare, suite au Marais des chagrins, au Marécage d'Âprefange et en
--     Hinterlands), 8552/8553/8554 L'écharpe à monogramme et suites (départ sur un drop, niveau
--     50, ailes de busard cuisinées), 3721 (pièces d'OOX de trois zones, niveau 50),
--   95773 Des adversaires sous les flots (niveau 37, suite en donjon), 96078 (suite de donjon),
--   598 Collier d'os brisés (demande 596, coupée : 25 colliers à 17 % = ~294 kills),
--   95384 (pas de donneur dans QuestieDB), 593, 619, 9259 (répétables sans XP), 349 (invocation de Mokk
--     pour 348, sans XP : décrite dans l'étape de 348, pas suivie),
--   1127 et 618 (liste noire Questie), 638 Trollbane et 95141 (envois vers Arathi / Riverglades),
--   3625/3626 (Terres foudroyées, niveau 58), 7810/7838 (arène de Gurubashi),
--   97329/97331/97332 (Zimmix, fait dans le guide 33-36),
--   Alliance : 200, 202, 205, 206, 207, 210, 215, 328-331, 574, 578, 601, 602, 603, 610, 611,
--     616, 622, 623, 627, 95786, 97405, 97420.
-- Faites dans le guide 33-36 : 188, 192, 195, 569, 570, 595, 597, 599, 629, 95748, 95770.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 44-46 Stranglethorn Vale 2
#displayname [FDP] Vallée de Strangleronce, suite (44-46)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 42-44 Dustwallow Marsh

-- ===== Arrivée à Grom'gol =====
step
    .goto Stranglethorn Vale,32.54,29.35,40 >>Va à Grom'gol : vol si tu connais le point, sinon zeppelin depuis Orgrimmar ou Fossoyeuse
step
    .goto Stranglethorn Vale,32.54,29.35
    >>Parle à |cRXP_FRIENDLY_Thysta|r
    .fp Grom'gol >>Prends le point de vol de Grom'gol
    .target 1387

-- ===== Camp de Nesingwary, premier passage =====
step
    #completewith Nesingwary1
    .goto Stranglethorn Vale,35.66,10.81,30 >>Monte vers le nord jusqu'au camp de Nesingwary
step
    #label Nesingwary1
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .accept 196 >>Accepte Contrôler la population des raptors
    .target 715
    .isQuestTurnedIn 195
step
    .goto Stranglethorn Vale,35.55,10.55
    >>Parle à |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .turnin 192 >>Rends Maîtrise de la chasse à la panthère
    .target 718
    .isQuestComplete 192
step
    .goto Stranglethorn Vale,35.55,10.55
    >>Parle à |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .accept 193 >>Accepte Maîtrise de la chasse à la panthère
    .target 718
    .isQuestTurnedIn 192

-- ===== Camp de Kurzen : le cuistot en cage =====
step
    .goto Stranglethorn Vale,44.27,7.90
    >>Parle à |cRXP_FRIENDLY_Wendel Mathers|r, en cage dans le camp de Kurzen
    .accept 97047 >>Accepte Un cuistot en cage
    .target 218230
step
    .goto Stranglethorn Vale,46.80,6.50,25,0
    .goto Stranglethorn Vale,47.90,6.40,25,0
    .goto Stranglethorn Vale,49.30,4.10,25,0
    .goto Stranglethorn Vale,49.60,7.75
    >>Tue les |cRXP_ENEMY_Troupes d'élite|r et |cRXP_ENEMY_Lieutenants de Kurzen|r pour la |cRXP_LOOT_Clé de cage|r et ouvre la |cRXP_PICK_Caisse de fournitures de Kurzen|r pour l'|cRXP_LOOT_Uniforme|r
    >>|cRXP_WARN_Taux de la clé inconnu. Évite le Colonel Kurzen (élite) au nord-est du camp|r
    .complete 97047,1 --Clé de cage de la base
    .complete 97047,2 --Uniforme de combat de Kurzen
    .mob 939
    .mob 978
step
    .goto Stranglethorn Vale,44.27,7.90
    >>Parle à |cRXP_FRIENDLY_Wendel Mathers|r
    .turnin 97047 >>Rends Un cuistot en cage
    .accept 97048 >>Accepte Retour à bon port
    .target 218230

-- ===== Bhag'thera, panthères, traqueurs de la jungle =====
step
    .goto Stranglethorn Vale,47.20,28.40
    >>Tue |cRXP_ENEMY_Bhag'thera|r et prends son |cRXP_LOOT_Croc|r
    >>|cRXP_WARN_Élite 40 : à deux, elle rôde autour de ce point|r
    .complete 193,1 --Croc de Bhag'thera
    .unitscan 728
    .isOnQuest 193
step
    .goto Stranglethorn Vale,41.30,34.80,40,0
    .goto Stranglethorn Vale,36.20,35.70,40,0
    .goto Stranglethorn Vale,38.50,38.00
    >>Si tu as encore la quête des |cRXP_ENEMY_Panthères Ombregueules|r du guide 33-36, finis-la
    .complete 192,1 --Panthère Ombregueule (10)
    .mob 684
    .isOnQuest 192
step
    .goto Stranglethorn Vale,32.56,37.21,30,0
    .goto Stranglethorn Vale,34.65,38.92,30,0
    .goto Stranglethorn Vale,28.28,46.47,30,0
    .goto Stranglethorn Vale,27.31,43.38
    >>Tue les |cRXP_ENEMY_Traqueurs de la jungle|r
    .complete 196,1 --Traqueur de la jungle (10)
    .mob 687
    .isOnQuest 196

-- ===== Camp de Nesingwary, deuxième passage =====
step
    #completewith Nesingwary2
    .goto Stranglethorn Vale,35.66,10.81,30 >>Remonte au camp de Nesingwary
step
    #label Nesingwary2
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .turnin 196 >>Rends Contrôler la population des raptors
    .accept 197 >>Accepte Contrôler la population des raptors
    .target 715
    .isOnQuest 196
step
    .goto Stranglethorn Vale,35.55,10.55
    >>Parle à |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .turnin 192 >>Rends Maîtrise de la chasse à la panthère
    .target 718
    .isQuestComplete 192
step
    .goto Stranglethorn Vale,35.55,10.55
    >>Parle à |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .turnin 193 >>Rends Maîtrise de la chasse à la panthère
    .target 718
    .isQuestComplete 193
step
    .goto Stranglethorn Vale,35.55,10.55
    >>Parle à |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .accept 193 >>Accepte Maîtrise de la chasse à la panthère
    .target 718
    .isQuestTurnedIn 192

-- ===== Téthis (et Bhag'thera si la quête vient d'être prise) =====
step
    .goto Stranglethorn Vale,31.50,41.20,30,0
    .goto Stranglethorn Vale,32.20,42.80,30,0
    .goto Stranglethorn Vale,28.74,44.85
    >>Tue |cRXP_ENEMY_Téthis|r et prends sa |cRXP_LOOT_Serre|r
    >>|cRXP_WARN_Élite 43 : à deux, elle patrouille entre ces points|r
    .complete 197,1 --Serre de Téthis
    .unitscan 730
    .isOnQuest 197
step
    .goto Stranglethorn Vale,47.20,28.40
    >>Tue |cRXP_ENEMY_Bhag'thera|r et prends son |cRXP_LOOT_Croc|r
    >>|cRXP_WARN_Élite 40 : à deux, elle rôde autour de ce point|r
    .complete 193,1 --Croc de Bhag'thera
    .unitscan 728
    .isOnQuest 193

-- ===== Camp de Nesingwary, troisième passage =====
step
    #completewith Nesingwary3
    .goto Stranglethorn Vale,35.66,10.81,30 >>Remonte au camp de Nesingwary
step
    .goto Stranglethorn Vale,35.55,10.55
    >>Parle à |cRXP_FRIENDLY_Sire S. J. Erlgadin|r
    .turnin 193 >>Rends Maîtrise de la chasse à la panthère
    .target 718
    .isQuestComplete 193
step
    #label Nesingwary3
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .turnin 197 >>Rends Contrôler la population des raptors
    .target 715
    .isQuestComplete 197
step
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .accept 208 >>Accepte La chasse au gros gibier
    .target 715
    .isQuestTurnedIn 188
    .isQuestTurnedIn 193
    .isQuestTurnedIn 197

-- ===== Roi Bangalash =====
step
    .goto Stranglethorn Vale,38.21,35.58
    >>Tue le |cRXP_ENEMY_Roi Bangalash|r et prends sa |cRXP_LOOT_Tête|r
    >>|cRXP_WARN_Élite 43 : à deux, il peut appeler des renforts|r
    .complete 208,1 --Tête de Bangalash
    .unitscan 731
    .isOnQuest 208
step
    #completewith Nesingwary4
    .goto Stranglethorn Vale,35.66,10.81,30 >>Remonte au camp de Nesingwary
    .isOnQuest 208
step
    #label Nesingwary4
    .goto Stranglethorn Vale,35.66,10.81
    >>Parle à |cRXP_FRIENDLY_Hemet Nesingwary|r
    .turnin 208 >>Rends La chasse au gros gibier
    .target 715
    .isOnQuest 208

-- ===== Vol vers Baie-du-Butin =====
step
    #completewith ArriveeBaie
    .goto Stranglethorn Vale,32.54,29.35,30 >>Redescends à Grom'gol
step
    #label ArriveeBaie
    .goto Stranglethorn Vale,32.54,29.35
    >>Parle à |cRXP_FRIENDLY_Thysta|r
    .fly Booty Bay >>Vole vers Baie-du-Butin. |cRXP_WARN_Sans le point de vol, suis la route vers le sud|r
    .target 1387
step
    .goto Stranglethorn Vale,27.69,76.66
    >>Parle au |cRXP_FRIENDLY_Capitaine Aransas|r
    .turnin 97048 >>Rends Retour à bon port
    .target 218229
step
    .goto Stranglethorn Vale,26.95,77.21
    >>Parle à |cRXP_FRIENDLY_Krazek|r
    .turnin 1116 >>Rends De la Poussière de rêve dans les marécages
    .target 773
    .isQuestComplete 1116
step
    .goto Stranglethorn Vale,27.17,77.01
    >>Parle à l'|cRXP_FRIENDLY_Amiral Seahorn|r
    .accept 604 >>Accepte Les boucaniers de la Voile sanglante
    .target 2487
    .isQuestTurnedIn 599

-- ===== Côte sud : camp de la Voile sanglante =====
step
    .goto Stranglethorn Vale,26.96,82.50,20,0
    .goto Stranglethorn Vale,27.73,83.10,20,0
    .goto Stranglethorn Vale,26.53,83.51,20,0
    .goto Stranglethorn Vale,29.59,80.84
    >>Tue les |cRXP_ENEMY_Bretteurs de la Voile sanglante|r du camp au sud de Baie-du-Butin et ramasse les |cRXP_PICK_Cartes|r et les |cRXP_PICK_Ordres de la Voile sanglante|r dans le camp
    .complete 604,1 --Bretteur de la Voile sanglante (10)
    .complete 604,2 --Cartes de la Voile sanglante
    .complete 604,3 --Ordres de la Voile sanglante
    .mob 1563
    .isOnQuest 604
step
    .goto Stranglethorn Vale,27.17,77.01
    >>Parle à l'|cRXP_FRIENDLY_Amiral Seahorn|r
    .turnin 604 >>Rends Les boucaniers de la Voile sanglante
    .accept 608 >>Accepte Les boucaniers de la Voile sanglante
    .target 2487
    .isOnQuest 604

-- ===== Côte sud : navires de la Voile sanglante =====
step
    .goto Stranglethorn Vale,32.87,88.20,15,0
    .goto Stranglethorn Vale,29.32,88.29,15,0
    .goto Stranglethorn Vale,30.58,90.63
    >>Monte sur les trois navires et tue le |cRXP_ENEMY_Capitaine Stillwater|r, le |cRXP_ENEMY_Capitaine Keelhaul|r et l'|cRXP_ENEMY_Amiral Firallon|r
    >>|cRXP_WARN_Firallon est niveau 48, entouré de loups de mer : nettoyez le pont avant|r
    .complete 608,1 --Capitaine Stillwater
    .complete 608,2 --Capitaine Keelhaul
    .complete 608,3 --Amiral Firallon
    .mob 2550
    .mob 2548
    .mob 2546
    .mob 1565
    .isOnQuest 608
step
    .goto Stranglethorn Vale,27.17,77.01
    >>Parle à l'|cRXP_FRIENDLY_Amiral Seahorn|r
    .turnin 608 >>Rends Les boucaniers de la Voile sanglante
    .target 2487
    .isOnQuest 608

-- ===== Baie-du-Butin : quêtes de Valbrume =====
step
    .goto Stranglethorn Vale,27.78,77.07
    >>Parle à |cRXP_FRIENDLY_MacKinley "Loup des mers"|r
    .accept 606 >>Accepte Effrayer Philippe le Chancelant
    .target 2501
step
    .goto Stranglethorn Vale,27.61,76.74
    >>Parle à |cRXP_FRIENDLY_Fin Fizracket|r
    .accept 348 >>Accepte La fièvre de Strangleronce
    >>|cRXP_WARN_Prenez-la tous les deux : le Coeur de Mokk ne tombe que pour ceux qui ont la quête|r
    .target 2486
step
    .goto Stranglethorn Vale,26.69,73.61
    >>Parle au |cRXP_FRIENDLY_Capitaine Hecklebury Smotts|r sur le quai nord
    .accept 8551 >>Accepte Le coffre du capitaine
    .target 2500
    .xp <45,1

-- ===== Valbrume : gorilles, Mokk, Gorlash =====
step
    #completewith FinValbrume
    .goto Stranglethorn Vale,37.41,64.50,0
    >>Si tu croises une |cRXP_PICK_Bouteille à moitié ensevelie|r sur la plage, ramasse la |cRXP_LOOT_Note soigneusement pliée|r
    >>|cRXP_WARN_Utilise l'objet pour lancer la quête|r
    .collect 4098,1,594,1
    .accept 594 >>Accepte Message dans une bouteille
    .use 4098
    .xp <45,1
step
    .goto Stranglethorn Vale,35.27,60.41,10
    >>L'un de vous deux prend maintenant la quête du |cRXP_FRIENDLY_Sorcier-docteur Unbagwa|r : les |cRXP_LOOT_Crocs de gorille|r ne tombent qu'une fois la quête acceptée
    .target 1449
    .isOnQuest 348
step
    .goto Stranglethorn Vale,34.40,62.52,30,0
    .goto Stranglethorn Vale,31.35,60.70,30,0
    .goto Stranglethorn Vale,34.99,64.44,30,0
    .goto Stranglethorn Vale,34.46,66.73
    >>Tue les |cRXP_ENEMY_Anciens gorilles de Valbrume|r pour les |cRXP_LOOT_Abats de Valbrume|r et les |cRXP_LOOT_Crocs de gorille|r
    >>|cRXP_WARN_Farm long en duo (~53 kills) : chacun doit looter ses abats. Un seul de vous deux a besoin des crocs|r
    .complete 606,1 --Abats de Valbrume (5)
    .mob 1557
step
    .goto Stranglethorn Vale,35.27,60.41
    >>Celui qui a la quête du |cRXP_FRIENDLY_Sorcier-docteur Unbagwa|r lui rend les |cRXP_LOOT_Crocs de gorille|r demandés : il appelle des vagues de gorilles, puis |cRXP_ENEMY_Mokk le Sauvage|r. Tuez-les et prenez le |cRXP_LOOT_Coeur de Mokk|r
    >>|cRXP_WARN_La quête d'Unbagwa ne rapporte pas d'XP. Si un seul Coeur tombe, il faut refaire les crocs et l'invocation|r
    .complete 348,1 --Coeur de Mokk
    .target 1449
    .mob 1511
    .mob 1516
    .mob 1514
    .isOnQuest 348
step
    #label FinValbrume
    .goto Stranglethorn Vale,36.95,69.73
    >>Tue |cRXP_ENEMY_Gorlash|r et prends le |cRXP_LOOT_Coffre de Smotts|r
    >>|cRXP_WARN_Élite 47 : à deux, soignez-vous avant le pull|r
    .complete 8551,1 --Coffre de Smotts
    .unitscan 1492
    .isOnQuest 8551
step
    .goto Stranglethorn Vale,38.53,80.58
    >>Nage jusqu'à l'île de Jaguero et parle à la |cRXP_FRIENDLY_Princesse Poobah|r
    .turnin 594 >>Rends Message dans une bouteille
    .target 2634
    .isOnQuest 594

-- ===== Baie-du-Butin : rendus de Valbrume =====
step
    .goto Stranglethorn Vale,26.90,73.59
    >>Parle à |cRXP_FRIENDLY_Phillippe le Chancelant|r sur le quai nord
    .turnin 606 >>Rends Effrayer Philippe le Chancelant
    .accept 607 >>Accepte De retour chez MacKinley
    .target 2502
step
    .goto Stranglethorn Vale,26.69,73.61
    >>Parle au |cRXP_FRIENDLY_Capitaine Hecklebury Smotts|r
    .turnin 8551 >>Rends Le coffre du capitaine
    .target 2500
    .isOnQuest 8551
step
    .goto Stranglethorn Vale,27.61,76.74
    >>Parle à |cRXP_FRIENDLY_Fin Fizracket|r
    .turnin 348 >>Rends La fièvre de Strangleronce
    .target 2486
    .isQuestComplete 348
step
    .goto Stranglethorn Vale,27.78,77.07
    >>Parle à |cRXP_FRIENDLY_MacKinley "Loup des mers"|r
    .turnin 607 >>Rends De retour chez MacKinley
    .accept 609 >>Accepte Gages vaudou
    .target 2501

-- ===== Ruines de Zanzil : gages vaudou =====
step
    .goto Stranglethorn Vale,35.26,51.27,20,0
    .goto Stranglethorn Vale,34.92,51.84
    >>Tue |cRXP_ENEMY_Maury "Pied bot" Wilkins|r et |cRXP_ENEMY_Jon-Jon le Corbeau|r pour le |cRXP_LOOT_Fléau de Maury|r et la |cRXP_LOOT_Longue-vue dorée de Jon-Jon|r
    .complete 609,1 --Fléau de Maury
    .complete 609,2 --Longue-vue dorée de Jon-Jon
    .mob 2535
    .mob 2536
step
    .goto Stranglethorn Vale,40.00,58.24
    >>Tue |cRXP_ENEMY_Chucky "Dix pouces"|r pour le |cRXP_LOOT_Grand anneau de Chucky|r
    .complete 609,3 --Grand anneau de Chucky
    .mob 2537
step
    .goto Stranglethorn Vale,27.78,77.07
    >>Retourne à Baie-du-Butin et parle à |cRXP_FRIENDLY_MacKinley "Loup des mers"|r
    .turnin 609 >>Rends Gages vaudou
    .target 2501

step
    #label FinStrangleronce2
    +|cRXP_WARN_Niveau conseillé pour la suite : 46. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

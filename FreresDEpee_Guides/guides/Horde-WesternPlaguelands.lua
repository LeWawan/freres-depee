if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Maleterres de l'Ouest (Western Plaguelands, area 28), Horde,
-- toutes classes, en duo. Base : la Barricade (Tirisfal 83,69), au bord des Maleterres, et
-- Undercity. Pas de point de vol ni d'auberge à la Barricade : le camp du Noroît est
-- Alliance. Indépendant des autres régions : l'appel aux armes pris à Orgrimmar (5093) ou
-- Thunder Bluff (5095) est rendu sous .isOnQuest, celui d'Undercity (5094) n'est proposé que
-- sans les deux autres (quêtes exclusives).
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua. Taux de drop
-- (wowheadData) : demi-charme 61 % (Goule jacassante), clé des toilettes 66 %, clé du
-- cabinet 97 %, clés des chaudrons 87 à 94 %. Les Seigneurs du Chaudron, le Squelette errant
-- et le Fermier Dalson sont uniques : le second joueur attend parfois la réapparition.
-- Itinéraire : Undercity -> Barricade -> camp écarlate et ferme de Felstone -> Barricade ->
-- Undercity (colis de Janice) -> champ de Felstone et Andorhal (tours, Chromie) -> Barricade
-- -> Larmes de Dalson, puis Kirsta au nord (Pinède, Âtreval) -> Barricade -> Repaire putride
-- (Mulgris) -> Barricade -> Flétrissure de Gahrron -> Barricade.
-- XP de quêtes gardée : ~119 000 (dont ~43 900 pour la chaîne des chaudrons).
-- Un travail inachevé (6025, niveau 58) n'est proposé qu'à partir du niveau 55 : écarlates 58-60 à
-- l'Âtreval.
-- Coupées :
--   105 Hélas, Andorhal (Araj l'Invocateur, élite 61), 838, 964, 5514, 5802, 5804, 5511
--   (chaîne de la clé de Scholomance, guide de donjon), 5342 Le dernier Barov (après 5341,
--   Scholomance), 5461, 5462, 5465 (Ras Murmegivre, Scholomance), 5162, 5164, 5166, 5167
--   (vol bleu et Guide de l'Indocile, Berceau-de-l'Hiver et Rochenoire), 5504, 5524 (mantelets,
--   réputation Aube d'argent), 5401-5408 (brevets et pierres du Fléau, réputation Aube
--   d'argent), 5218, 5221, 5224, 5227 et 4973 (répétables, peu d'XP), 5059 Enfermé (toilettes,
--   répétable sans XP, fait en passant pour faire sortir le Fermier Dalson), 5058 Journal de
--   Mme Dalson (pas d'XP), 4987 La branche de chêne à glyphes (rendu à Thunder Bluff),
--   97319 Un cousin à l'étranger (rendu au mont Hyjal), 5901, 5902, 6390 Une Plaie sur la
--   Croisade (termites des Maleterres de l'Est), 5154 Les annales de Darrowshire (après
--   5153, chaîne des Maleterres de l'Est), 5861, 5862, 5944 (chaîne de Myranda, commence
--   chez Tirion dans les Maleterres de l'Est), 93030 Le chevalier du deuil (ouest de
--   Tirisfal, hors zone).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 53-55 Western Plaguelands
#displayname [FDP] Maleterres de l'ouest (53-55)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 55-56 Winterspring

-- ===== Undercity et la Barricade =====
step
    .goto Undercity,63.90,44.08
    >>À Undercity (zeppelin depuis Orgrimmar ou Grom'gol), parle au |cRXP_FRIENDLY_Messager Balthazad|r
    .accept 5094 >>Accepte Un appel aux armes : les Maleterres
    .target 10879
    .isQuestAvailable 5093
    .isQuestAvailable 5095
    .isNotOnQuest 5093
    .isNotOnQuest 5095
step
    #completewith Barricade
    .goto Tirisfal Glades,83.10,69.50,30 >>Sors d'Undercity et suis la route à l'est jusqu'à la Barricade
step
    .goto Tirisfal Glades,83.13,68.94
    >>Parle au |cRXP_FRIENDLY_Grand exécuteur Derrington|r
    .turnin 5094 >>Rends Un appel aux armes : les Maleterres
    .target 10837
    .isOnQuest 5094
step
    .goto Tirisfal Glades,83.13,68.94
    >>Parle au |cRXP_FRIENDLY_Grand exécuteur Derrington|r
    .turnin 5093 >>Rends Un appel aux armes : les Maleterres
    .target 10837
    .isOnQuest 5093
step
    .goto Tirisfal Glades,83.13,68.94
    >>Parle au |cRXP_FRIENDLY_Grand exécuteur Derrington|r
    .turnin 5095 >>Rends Un appel aux armes : les Maleterres
    .target 10837
    .isOnQuest 5095
step
    #label Barricade
    .goto Tirisfal Glades,83.13,68.94
    >>Parle au |cRXP_FRIENDLY_Grand exécuteur Derrington|r
    .accept 5096 >>Accepte Diversions écarlates
    .target 10837
step
    .goto Tirisfal Glades,83.17,69.09
    >>Prends des |cRXP_LOOT_Flammes en bouteille|r dans la |cRXP_PICK_Boîte d'inflammables|r à côté de Derrington
    .collect 12814,1

-- ===== Ferme de Felstone et camp écarlate =====
step
    .goto Western Plaguelands,38.40,54.05
    >>Entre dans les Maleterres et parle à |cRXP_FRIENDLY_Janice Felstone|r, à la ferme de Felstone
    .accept 5021 >>Accepte Mieux vaut tard que jamais
    .target 10778
step
    .goto Western Plaguelands,38.73,55.24
    >>Ouvre le |cRXP_PICK_Colis de Janice|r dans l'écurie
    .turnin 5021 >>Rends Mieux vaut tard que jamais
    .accept 5023 >>Accepte Mieux vaut tard que jamais
step
    .goto Western Plaguelands,40.72,52.04
    >>Au camp avancé écarlate, au nord-est de la ferme, mets le feu à la |cRXP_PICK_Tente de commandement|r puis plante la |cRXP_LOOT_Bannière du Fléau|r
    .complete 5096,1
    .use 12807
    .mob 10605
    .mob 1831

-- ===== Barricade et Undercity =====
step
    .goto Tirisfal Glades,83.13,68.94
    >>Retourne à la Barricade et parle au |cRXP_FRIENDLY_Grand exécuteur Derrington|r
    .turnin 5096 >>Rends Diversions écarlates
    .accept 5098 >>Accepte Tout au long des tours de guet
    .accept 5228 >>Accepte Les chaudrons du Fléau
    .target 10837
step
    .goto Tirisfal Glades,83.04,71.91
    >>Parle à la |cRXP_FRIENDLY_Prêtresse des ombres Vandis|r
    .turnin 5228 >>Rends Les chaudrons du Fléau
    .accept 5229 >>Accepte Cible : le Champ de Felstone
    .target 11055
step
    .goto Undercity,69.79,43.16
    >>Retourne à Undercity par la route de l'ouest et parle au |cRXP_FRIENDLY_Surveillant royal Bauhaus|r, près du registre des guildes
    .turnin 5023 >>Rends Mieux vaut tard que jamais
    .accept 5049 >>Accepte Le blues de Jeremiah
    .target 10781
step
    .goto Undercity,67.60,44.16
    >>Parle à |cRXP_FRIENDLY_Jeremiah Payson|r, sous l'escalier
    .turnin 5049 >>Rends Le blues de Jeremiah
    .accept 5050 >>Accepte Charme porte-bonheur
    .target 8403

-- ===== Champ de Felstone =====
step
    .goto Western Plaguelands,38.40,54.05
    >>Retourne voir |cRXP_FRIENDLY_Janice Felstone|r
    .turnin 5050 >>Rends Charme porte-bonheur
    .accept 5051 >>Accepte Deux moitiés deviennent Une
    .target 10778
step
    .goto Western Plaguelands,37.60,56.30
    >>Tue les |cRXP_ENEMY_Goules jacassantes|r du champ pour l'|cRXP_LOOT_Autre demi-charme|r, puis utilise le |cRXP_LOOT_Demi-charme|r pour les assembler
    .complete 5051,1 --Charme porte-bonheur
    .use 12721
    .use 12722
    .mob 10801
step
    .goto Western Plaguelands,36.93,57.41
    >>Tue le |cRXP_ENEMY_Seigneur du Chaudron Bilegueule|r et prends sa |cRXP_LOOT_Clé|r. |cRXP_WARN_Unique : attendez sa réapparition si un seul joueur a la clé|r
    .complete 5229,1 --Clé du chaudron du Champ de Felstone
    .mob 11075
step
    .goto Western Plaguelands,37.25,56.78
    >>Ouvre le |cRXP_PICK_Chaudron du Fléau|r
    .turnin 5229 >>Rends Cible : le Champ de Felstone
    .accept 5230 >>Accepte Retour à la Barricade
step
    .goto Western Plaguelands,38.40,54.05
    >>Rends le charme à |cRXP_FRIENDLY_Janice Felstone|r
    .turnin 5051 >>Rends Deux moitiés deviennent Une
    .target 10778

-- ===== Andorhal : Chromie et les tours =====
step
    .goto Western Plaguelands,39.46,66.76
    >>Parle à |cRXP_FRIENDLY_Chromie|r, dans l'auberge d'Andorhal
    .accept 4971 >>Accepte Une question de temps
    .target 10667
step
    .goto Western Plaguelands,42.33,66.24
    >>Marque la |cRXP_PICK_Tour deux|r en te tenant dans l'entrée
    .complete 5098,2
step
    .goto Western Plaguelands,44.30,63.25
    >>Marque la |cRXP_PICK_Tour trois|r
    .complete 5098,3
step
    .goto Western Plaguelands,46.40,62.50
    >>Utilise le |cRXP_LOOT_Déplaceur temporel|r près des silos et tue les |cRXP_ENEMY_Parasites temporels|r qui sortent
    .complete 4971,1 --Parasite temporel (10)
    .use 12627
    .mob 10717
step
    .goto Western Plaguelands,46.62,71.05
    >>Marque la |cRXP_PICK_Tour quatre|r
    .complete 5098,4
step
    .goto Western Plaguelands,40.05,71.60
    >>Marque la |cRXP_PICK_Tour un|r
    .complete 5098,1
step
    .goto Western Plaguelands,39.46,66.76
    >>Retourne voir |cRXP_FRIENDLY_Chromie|r
    .turnin 4971 >>Rends Une question de temps
    .accept 4972 >>Accepte Arrêt du temps
    .target 10667
step
    .goto Western Plaguelands,42.00,69.50
    >>Ouvre les |cRXP_PICK_Petits coffrets|r dans les décombres d'Andorhal pour les |cRXP_LOOT_Montres|r
    .complete 4972,1 --Montre d'Andorhal (5)
step
    .goto Western Plaguelands,39.46,66.76
    >>Retourne voir |cRXP_FRIENDLY_Chromie|r
    .turnin 4972 >>Rends Arrêt du temps
    .target 10667

-- ===== Barricade =====
step
    .goto Tirisfal Glades,83.13,68.94
    >>Retourne à la Barricade et parle au |cRXP_FRIENDLY_Grand exécuteur Derrington|r
    .turnin 5098 >>Rends Tout au long des tours de guet
    .target 10837
step
    .goto Tirisfal Glades,83.04,71.91
    >>Parle à la |cRXP_FRIENDLY_Prêtresse des ombres Vandis|r
    .turnin 5230 >>Rends Retour à la Barricade
    .accept 5231 >>Accepte Cible : les Larmes de Dalson
    .target 11055

-- ===== Larmes de Dalson =====
step
    .goto Western Plaguelands,46.11,52.61
    >>Tue le |cRXP_ENEMY_Seigneur du Chaudron Malvinious|r et prends sa |cRXP_LOOT_Clé|r
    .complete 5231,1 --Clé du chaudron des Larmes de Dalson
    .mob 11077
step
    .goto Western Plaguelands,46.18,51.90
    >>Ouvre le |cRXP_PICK_Chaudron du Fléau|r
    .turnin 5231 >>Rends Cible : les Larmes de Dalson
    .accept 5232 >>Accepte Retour à la Barricade
step
    .goto Western Plaguelands,47.71,49.87
    >>Tue le |cRXP_ENEMY_Squelette errant|r autour de la ferme et prends la |cRXP_LOOT_Clé des toilettes|r
    .collect 12738,1
    .mob 10816
step
    .goto Western Plaguelands,48.23,49.67
    >>Ouvre les |cRXP_PICK_Toilettes|r derrière la ferme avec la clé (accepte et rends Enfermé), le |cRXP_ENEMY_Fermier Dalson|r en sort. Tue-le |cRXP_ENEMY_Fermier Dalson|r et prends la |cRXP_LOOT_Clé du cabinet|r. |cRXP_WARN_Si un seul joueur l'a, refaites squelette et toilettes|r
    .collect 12739,1
    .mob 10836
step
    .goto Western Plaguelands,47.35,49.63
    >>Ouvre le |cRXP_PICK_Cabinet verrouillé|r à l'étage de la ferme
    .accept 5060 >>Accepte Enfermé
    .turnin 5060 >>Rends Enfermé

-- ===== Nord : Kirsta Deepshadow =====
step
    .goto Western Plaguelands,51.92,28.06
    >>Monte au nord et parle à |cRXP_FRIENDLY_Kirsta Deepshadow|r, sur la colline à l'est de l'Âtreval
    .accept 6004 >>Accepte Un travail inachevé
    .target 11610
step
    .goto Western Plaguelands,51.70,44.40
    >>Au sud de la scierie de la Pinède, tue 2 |cRXP_ENEMY_Médecins|r et 2 |cRXP_ENEMY_Chasseresses écarlates|r
    .complete 6004,1 --Médecin écarlate (2)
    .complete 6004,2 --Chasseresse écarlate (2)
    .mob 10605
    .mob 1831
step
    .goto Western Plaguelands,52.80,37.50
    >>À la scierie de la Pinède, tue 2 |cRXP_ENEMY_Mages|r et 2 |cRXP_ENEMY_Chevaliers écarlates|r
    .complete 6004,3 --Mage écarlate (2)
    .complete 6004,4 --Chevalier écarlate (2)
    .mob 1826
    .mob 1833
step
    .goto Western Plaguelands,51.92,28.06
    >>Retourne voir |cRXP_FRIENDLY_Kirsta Deepshadow|r
    .turnin 6004 >>Rends Un travail inachevé
    .accept 6023 >>Accepte Un travail inachevé
    .target 11610
step
    .goto Western Plaguelands,57.83,36.10
    >>Tue le |cRXP_ENEMY_Veneur Radley|r, à l'est de la scierie
    .complete 6023,1 --Veneur Radley
    .mob 11613
step
    .goto Western Plaguelands,55.15,23.62
    >>Tue le |cRXP_ENEMY_Cavalier Durgen|r, en haut de la tour de Mardenholde
    .complete 6023,2 --Cavalier Durgen
    .mob 11611
step
    .goto Western Plaguelands,51.92,28.06
    >>Retourne voir |cRXP_FRIENDLY_Kirsta Deepshadow|r
    .turnin 6023 >>Rends Un travail inachevé
    .target 11610
step
    .goto Western Plaguelands,51.92,28.06
    >>Parle à |cRXP_FRIENDLY_Kirsta Deepshadow|r
    .accept 6025 >>Accepte Un travail inachevé
    .target 11610
    .xp <55,1
step
    .goto Western Plaguelands,45.81,18.25
    >>Entre dans l'Âtreval et monte sur un point haut pour observer la ville. |cRXP_WARN_Écarlates de niveau 58 à 60 : évitez les groupes|r
    .complete 6025,1
    .isOnQuest 6025
step
    .goto Western Plaguelands,51.92,28.06
    >>Retourne voir |cRXP_FRIENDLY_Kirsta Deepshadow|r
    .turnin 6025 >>Rends Un travail inachevé
    .target 11610
    .isOnQuest 6025

-- ===== Barricade =====
step
    .goto Tirisfal Glades,83.04,71.91
    >>Retourne à la Barricade et parle à la |cRXP_FRIENDLY_Prêtresse des ombres Vandis|r
    .turnin 5232 >>Rends Retour à la Barricade
    .accept 5233 >>Accepte Cible : le Repaire putride
    .target 11055

-- ===== Repaire putride : Mulgris =====
step
    .goto Western Plaguelands,53.73,64.66
    >>Parle à |cRXP_FRIENDLY_Mulgris Deepriver|r, au Repaire putride
    .accept 4984 >>Accepte La faune et la flore souffrent aussi
    .target 10739
step
    .goto Western Plaguelands,52.88,66.08
    >>Tue le |cRXP_ENEMY_Seigneur du Chaudron Razarch|r et prends sa |cRXP_LOOT_Clé|r
    .complete 5233,1 --Clé du chaudron du Repaire putride
    .mob 11076
step
    .goto Western Plaguelands,53.02,65.61
    >>Ouvre le |cRXP_PICK_Chaudron du Fléau|r
    .turnin 5233 >>Rends Cible : le Repaire putride
    .accept 5234 >>Accepte Retour à la Barricade
step
    .goto Western Plaguelands,47.00,59.50
    >>Tue les |cRXP_ENEMY_Loups malades|r à l'ouest, entre le Repaire et Andorhal. S'il en manque, remonte vers le nord (46,46), où ils sont plus nombreux
    .complete 4984,1 --Loup malade (8)
    .mob 1817
step
    .goto Western Plaguelands,53.73,64.66
    >>Retourne voir |cRXP_FRIENDLY_Mulgris Deepriver|r
    .turnin 4984 >>Rends La faune et la flore souffrent aussi
    .accept 4985 >>Accepte La faune et la flore en souffrent aussi
    .target 10739
step
    .goto Western Plaguelands,55.80,60.50
    >>Tue les |cRXP_ENEMY_Grizzlys malades|r autour du Repaire
    .complete 4985,1 --Grizzly malade (8)
    .mob 1816
step
    .goto Western Plaguelands,53.73,64.66
    >>Retourne voir |cRXP_FRIENDLY_Mulgris Deepriver|r
    .turnin 4985 >>Rends La faune et la flore en souffrent aussi
    .target 10739

-- ===== Barricade =====
step
    .goto Tirisfal Glades,83.04,71.91
    >>Retourne à la Barricade et parle à la |cRXP_FRIENDLY_Prêtresse des ombres Vandis|r
    .turnin 5234 >>Rends Retour à la Barricade
    .accept 5235 >>Accepte Cible : la Flétrissure de Gahrron
    .target 11055

-- ===== Flétrissure de Gahrron =====
step
    .goto Western Plaguelands,62.18,59.06
    >>À l'est, tue le |cRXP_ENEMY_Seigneur du Chaudron Irâme|r et prends sa |cRXP_LOOT_Clé|r. |cRXP_WARN_Niveau 58 : en duo|r
    .complete 5235,1 --Clé du chaudron de la Flétrissure de Gahrron
    .mob 11078
step
    .goto Western Plaguelands,62.54,58.47
    >>Ouvre le |cRXP_PICK_Chaudron du Fléau|r
    .turnin 5235 >>Rends Cible : la Flétrissure de Gahrron
    .accept 5236 >>Accepte Retour à la Barricade

-- ===== Barricade : fin =====
step
    .goto Tirisfal Glades,83.04,71.91
    >>Retourne à la Barricade et parle à la |cRXP_FRIENDLY_Prêtresse des ombres Vandis|r
    .turnin 5236 >>Rends Retour à la Barricade
    .target 11055
step
    .goto Tirisfal Glades,83.13,68.94
    >>Parle au |cRXP_FRIENDLY_Grand exécuteur Derrington|r
    .accept 5238 >>Accepte Mission accomplie !
    .turnin 5238 >>Rends Mission accomplie !
    .target 10837
step
    #label FinMaleterresOuest
    +|cRXP_WARN_Niveau conseillé pour la suite : 55. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

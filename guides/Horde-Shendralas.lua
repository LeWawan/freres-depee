if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Shen'dralas (zone Forever reliée à la Désolace, uiMap 2652,
-- area 16651), Horde, toutes classes. Indépendant des autres régions : aucune quête n'y
-- arrive d'ailleurs, les chaînes centaures restent coupées (voir plus bas).
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-traces.lua. Taux de drop
-- inconnus dans la zone : 35 % supposés. Beaucoup de quêtes n'ont pas d'objectifs dans
-- QuestieDB (96018, 96060) : RXP les lit dans le jeu.
-- Accès non vérifié en jeu : pas de point de vol dans la zone (flightData.lua). On vole au
-- village de Shadowprey, puis on longe le sud de la Désolace jusqu'à Orgrul (Désolace
-- 65.4,84.2 = Shen'dralas 35.7,12.7 dans QuestieDB), entrée nord de la vallée des Ossements.
-- Les sites de fans confirment une entrée par la vallée des Ossements, au sud de la Désolace.
-- Itinéraire : pylône (43,34) -> pylône est (73,23) -> Mordent Ombrégale (35,47) ->
-- fragments aux villages magram et gelkis (Désolace) -> Mordent -> temple et pylônes pour
-- 96018 -> Mordent -> temple (Biraxas, Vindael, Mithéra) -> jardins Lugubres -> nord du
-- temple (rôdeurs, protecteurs décrépits, Liranne) -> temple.
-- Coupées :
--   Chaîne magram d'Orgrul et Hagiak : 92841 et 92846 (masque de races Alliance dans
--   QuestieDB), 92844, 92847, 92873, 92893, 92894, 93066, 93072, 93129, 93188, 93196 (en
--   dépendent ; 92841 demande aussi 92743, lui-même derrière 1369 et la réputation Amical
--   magram, coupés en Désolace).
--   Chaîne gelkis de Nerlokh : 93034 (demande 1373 Ongeku, réputation Amical gelkis coupée
--   en Désolace), 93035, 93037, 93041, 93044 (masque Alliance), 93045, 93058, 93062, 93122,
--   93128 (en dépendent). Une alerte en tête signale 93034 à qui a rendu 1373.
--   93125 Retour à la maison (escorte au point d'arrivée inconnu, rendu chez Nerlokh au
--   nord-ouest, hors route), 93574 La carapace de Nécrobi (Nécrobi élite 45, ~6 kills en
--   duo, rendu chez Kog'thug, Dos-hirsute à l'accueil incertain), 93404 Pourriture et
--   regret (Maraudon, donjon), 93601, 93604 et 93606 (suite de 93404, Souilles de
--   Tranchebauge).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 42-45 Shen'dralas
#displayname [FDP] Shen’dralas (42-45)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 44-47 Feralas

-- ===== Alerte : chaîne gelkis, pour qui a fait Ongeku (1373) en Désolace =====
step
    #sticky
    #completewith FinShendralas
    .isQuestTurnedIn 1373
    .isQuestAvailable 93034
    .isNotOnQuest 93034
    .maxlevel 43
    .xp 44 >>|cRXP_WARN_Chaîne possible : Vallée des Ossements (gelkis, ~4800 xp). Chez Uthek la Sage au village gelkis (Désolace 36,79), à côté de l'Éclat de pylône. Non incluse dans ce guide|r

-- ===== Voyage : Désolace puis vallée des Ossements =====
step
    #completewith ArriveeShen
    .zoneskip Desolace/2652
    .fly Shadowprey Village >>Vole jusqu'au village de Shadowprey (Désolace)
step
    #completewith ArriveeShen
    .goto Desolace,65.41,84.21,30 >>Longe le sud de la Désolace vers l'est jusqu'à |cRXP_FRIENDLY_Orgrul|r, au sud du village magram. |cRXP_WARN_Route non vérifiée en jeu : l'entrée de la vallée des Ossements est là d'après QuestieDB|r
    .zoneskip 2652
step
    #label ArriveeShen
    .goto 2652,35.71,12.66,30 >>Entre dans Shen'dralas par la vallée des Ossements
step
    #completewith CoeurCristal
    .goto 2652,34.20,15.50,0
    >>Tue les |cRXP_ENEMY_Nécromanciens magram|r sur ta route : l'un d'eux peut lâcher un |cRXP_LOOT_Journal en lambeaux|r
    >>|cRXP_WARN_Utilise l'objet pour lancer la quête. Ne farme pas|r
    .collect 260347,1,93644,1 --Journal en lambeaux
    .accept 93644 >>Accepte Le journal en lambeaux
    .use 260347
    .mob 253272

-- ===== Les pylônes =====
step
    .goto 2652,43.66,34.36
    >>Clique sur le |cRXP_PICK_Pylône shen'dralar|r au sud de la vallée
    .accept 92914 >>Accepte D'étranges pylônes
step
    .goto 2652,72.76,23.11,15
    >>Va à l'est trouver l'autre pylône. |cRXP_WARN_Les Nécrobis sont élites 45 : contourne-les|r
    .complete 92914,1 --Pylône de l'est trouvé
step
    .goto 2652,35.17,46.61
    >>Va au sud-ouest voir |cRXP_FRIENDLY_Mordent Ombrégale|r. |cRXP_WARN_Des Protecteurs de pylône naissants (élites 43) rôdent autour de lui|r
    .turnin 92914 >>Rends D'étranges pylônes
    .accept 96010 >>Accepte Des fragments de pylône
    .turnin -93644 >>Rends Le journal en lambeaux
    .target 253471

-- ===== Fragments de pylône : villages centaures de la Désolace =====
step
    #completewith FragmentMagram
    .goto 2652,35.71,12.66,30 >>Remonte au nord par la vallée des Ossements et ressors en Désolace
step
    #label FragmentMagram
    .goto Desolace,68.00,78.90
    >>Au village magram, ramasse le |cRXP_LOOT_Fragment de pylône|r gardé par les centaures
    .complete 96010,1 --Fragment de pylône
step
    .goto Desolace,36.20,85.60
    >>Va à l'ouest jusqu'au village gelkis et ramasse l'|cRXP_LOOT_Éclat de pylône|r gardé par les centaures
    .complete 96010,2 --Éclat de pylône
step
    .goto Desolace,65.41,84.21,30 >>Retourne à l'est jusqu'à l'entrée de la vallée des Ossements, près d'|cRXP_FRIENDLY_Orgrul|r
step
    .goto 2652,35.17,46.61
    >>Retourne voir |cRXP_FRIENDLY_Mordent Ombrégale|r
    .turnin 96010 >>Rends Des fragments de pylône
    .accept 96018 >>Accepte Alimenter les pylônes
    .turnin -93644 >>Rends Le journal en lambeaux
    .target 253471

-- ===== Alimenter les pylônes =====
step
    .goto 2652,47.40,76.50,20 >>Va au sud jusqu'au temple de Shen'dralas
step
    .goto 2652,47.40,76.50,0
    .goto 2652,43.66,34.36,15,0
    .goto 2652,72.76,23.11,15,0
    >>Prends le |cRXP_PICK_Tamis à mana|r dans le temple, utilise-le pour recueillir les |cRXP_PICK_Cristaux de mana anciens|r, puis charge les pylônes (43,34 et 73,23)
    >>|cRXP_WARN_Emplacements absents de QuestieDB : suis le texte de la quête et la carte du jeu|r
    .complete 96018,1
step
    .goto 2652,35.17,46.61
    >>Retourne voir |cRXP_FRIENDLY_Mordent Ombrégale|r
    .turnin 96018 >>Rends Alimenter les pylônes
    .accept 93016 >>Accepte Une courte leçon d'histoire
    .turnin 93016 >>Rends Une courte leçon d'histoire
    .accept 93394 >>Accepte Rencontre avec le magistère
    .turnin -93644 >>Rends Le journal en lambeaux
    .target 253471

-- ===== Temple de Shen'dralas =====
step
    .goto 2652,47.40,76.50
    >>Dans le temple, parle au |cRXP_FRIENDLY_Magistère Kirandis|r
    .turnin 93394 >>Rends Rencontre avec le magistère
    .target 254656
step
    .goto 2652,46.00,78.22
    >>Parle à l'|cRXP_FRIENDLY_Historien Biraxas|r
    .accept 99257 >>Accepte Un cœur de cristal
    .target 255486
step
    .goto 2652,42.00,79.02
    >>Parle à |cRXP_FRIENDLY_Vindael|r
    .accept 93450 >>Accepte Problèmes fantasmatiques
    .target 254717
step
    .goto 2652,42.00,79.02
    >>Fais passer l'épée inachevée de |cRXP_FRIENDLY_Vindael|r dans le monde des esprits et récupère la |cRXP_LOOT_Lame fantasmatique|r. |cRXP_WARN_Méthode absente de QuestieDB : suis le texte de la quête|r
    .complete 93450,1 --Lame fantasmatique
step
    .goto 2652,42.00,79.02
    >>Retourne voir |cRXP_FRIENDLY_Vindael|r
    .turnin 93450 >>Rends Problèmes fantasmatiques
    .accept 93546 >>Accepte Du minerai de fer spectral
    .target 254717
step
    .goto 2652,53.32,76.02
    >>Parle à |cRXP_FRIENDLY_Mithéra|r
    .accept 93341 >>Accepte Les jardins Lugubres
    .target 254578

-- ===== Jardins Lugubres =====
step
    #completewith Minerai
    >>Mine les |cRXP_PICK_Gisements de fer spectral|r autour du temple, avec la pioche de Vindael
    .complete 93546,1 --Minerai de fer spectral (10)
    .use 259229
step
    .goto 2652,70.21,79.71
    >>À l'est, examine le |cRXP_PICK_Piédestal|r des jardins Lugubres
    .complete 93341,1 --Piédestal examiné
step
    .goto 2652,53.32,76.02
    >>Retourne voir |cRXP_FRIENDLY_Mithéra|r au temple
    .turnin 93341 >>Rends Les jardins Lugubres
    .accept 93362 >>Accepte Ce qu'ils ont fait à mes pivoines
    .accept 93594 >>Accepte Des nouvelles du jardin
    .target 254578
step
    #completewith Pivoines
    >>Si un |cRXP_LOOT_Collier de la mélancolie|r tombe dans les jardins, utilise-le pour lancer la quête
    .collect 260247,1,93609,1 --Collier de la mélancolie
    .accept 93609 >>Accepte Le collier de la mélancolie
    .use 260247
step
    .goto 2652,69.66,71.78
    >>Parle à |cRXP_FRIENDLY_Astrebois|r dans les jardins. |cRXP_WARN_Ne prends pas Pourriture et regret (Maraudon)|r
    .turnin 93594 >>Rends Des nouvelles du jardin
    .target 254674
step
    .goto 2652,63.30,67.00,30,0
    .goto 2652,59.00,76.00
    >>Tue les |cRXP_ENEMY_Soucis sadiques|r au nord des jardins, puis les |cRXP_ENEMY_Roses rebelles|r et les |cRXP_ENEMY_Tulipes terribles|r à l'ouest
    .complete 93362,1 --Rose rebelle
    .complete 93362,2 --Tulipe terrible
    .complete 93362,3 --Souci sadique
    .mob 254566
    .mob 254567
    .mob 254572
step
    #label Pivoines
    .goto 2652,53.32,76.02
    >>Retourne voir |cRXP_FRIENDLY_Mithéra|r
    .turnin 93362 >>Rends Ce qu'ils ont fait à mes pivoines
    .turnin -93609 >>Rends Le collier de la mélancolie
    .target 254578
step
    #label Minerai
    .goto 2652,45.00,70.00
    >>Finis les |cRXP_PICK_Gisements de fer spectral|r au nord et à l'ouest du temple
    .complete 93546,1 --Minerai de fer spectral (10)
    .use 259229
step
    .goto 2652,42.00,79.02
    >>Retourne voir |cRXP_FRIENDLY_Vindael|r
    .turnin 93546 >>Rends Du minerai de fer spectral
    .accept 96060 >>Accepte Calmer les attentes
    .target 254717

-- ===== Nord du temple : rôdeurs et protecteurs décrépits =====
step
    #completewith Liranne
    .goto 2652,47.70,52.50,0
    >>Un |cRXP_ENEMY_Rôdeur|r peut lâcher un |cRXP_LOOT_Collier partiellement digéré|r : utilise-le pour lancer la quête
    .collect 259461,1,93568,1 --Collier partiellement digéré
    .accept 93568 >>Accepte Un collier partiellement digéré
    .use 259461
    .mob 255207
step
    .goto 2652,47.70,52.50
    >>Au nord du temple, achève 8 |cRXP_ENEMY_Rôdeurs|r avec la |cRXP_LOOT_Lame fantasmatique|r
    .complete 96060,1 --Bête achevée (8)
    .use 271992
    .mob 255207
step
    #label CoeurCristal
    .goto 2652,46.40,38.60
    >>Plus au nord, tue les |cRXP_ENEMY_Protecteurs de pylône décrépits|r pour un |cRXP_LOOT_Cœur de cristal épuisé|r
    .complete 99257,1 --Cœur de cristal épuisé
    .mob 252711
step
    .goto 2652,35.17,46.61
    >>Si tu as le journal, rends-le à |cRXP_FRIENDLY_Mordent Ombrégale|r
    .turnin 93644 >>Rends Le journal en lambeaux
    .target 253471
    .isOnQuest 93644
step
    #label Liranne
    .goto 2652,47.50,65.60
    >>Si tu as le collier, parle à |cRXP_FRIENDLY_Liranne|r en redescendant vers le temple
    .turnin 93568 >>Rends Un collier partiellement digéré
    .target 255385
    .isOnQuest 93568

-- ===== Temple : rendus et faille de mana =====
step
    .goto 2652,42.00,79.02
    >>Retourne voir |cRXP_FRIENDLY_Vindael|r
    .turnin 96060 >>Rends Calmer les attentes
    .target 254717
step
    .goto 2652,46.00,78.22
    >>Parle à l'|cRXP_FRIENDLY_Historien Biraxas|r
    .turnin 99257 >>Rends Un cœur de cristal
    .accept 99258 >>Accepte Le mana et ses manies
    .target 255486
step
    .goto 2652,48.50,64.50
    >>Jette le |cRXP_LOOT_Cœur de cristal épuisé|r dans une |cRXP_PICK_Faille de mana instable|r et tue le |cRXP_ENEMY_Protecteur de pylône naissant|r qui en sort. |cRXP_WARN_Élite 43 : en duo. Faille absente de QuestieDB : cherche-la près des protecteurs naissants|r
    .complete 99258,1 --Protecteur de pylône naissant
    .use 286648
    .mob 276401
step
    .goto 2652,46.00,78.22
    >>Retourne voir l'|cRXP_FRIENDLY_Historien Biraxas|r
    .turnin 99258 >>Rends Le mana et ses manies
    .target 255486
step
    #label FinShendralas
    +|cRXP_WARN_Niveau conseillé pour la suite : 45. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

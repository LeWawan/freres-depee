if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Marais des Chagrins (Swamp of Sorrows), Horde, toutes classes,
-- base Pierrêche. Indépendant des autres régions : les quêtes venues d'ailleurs (1391
-- Bois de la Pénombre, 1420 Terres ingrates, 624 Strangleronce, 93678 Désolace, 1116 Baie-du-Butin)
-- sont protégées par .isOnQuest.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-traces.lua et xpDB-classic.lua
-- (1422 absente des deux), taux de drop de classicItemDrops.lua. Duo : kills = 2 x nombre x
-- 100 / taux. XP réduite selon Questie (QuestieXP.lua) : une quête de niveau 35 ne rapporte
-- que 40 % au niveau 43, 20 % au 44.
-- Itinéraire : Pierrêche -> havre Boueux (trio de niveau 35, seulement jusqu'au niveau 43)
-- -> crocilisques et sanctuaire des Friches (Noboru, Galen) -> havre Boueux -> Héros déchu
-- (niveau 45) -> Pierrêche -> bassin des Larmes -> côte sud-est (Tok'Kar et Katar, murlocs)
-- -> Pierrêche -> chaîne du Héros déchu si le niveau 45 arrive en route.
-- Coupées :
--   1430 Viande fraîche (10 pattes à 33 % = ~61 kills, 61 xp/kill), 93663 Livraison perdue
--   (messager sans emplacement dans QuestieDB, 550 xp au niveau 43), 1418 Neeka Bloodscar et
--   1420 (envoi vers les Terres ingrates ; 1420 rendu ici si déjà en cours), 93464 Un mage de
--   passage (Désolace, Kalimdor) et la suite 93465, 93679 Les visions d'un autre (560 xp) et
--   93684 (Terres foudroyées), 93176 Mes petits amis (insectes en Strangleronce, Désolace et
--   Arathi), 625 Devinette de Cortello (suite au Marécage d'Âprefange), 1444/1445 (retour des
--   Hinterlands puis temple d'Atal'Hakkar, donjon), 3374/3512 (donjon, temple englouti),
--   87451 (pas de donneur), 2681, 2701, 2702, 2721, 2743, 2744, 2801, 3626, 3627, 3628
--   (suite du Héros déchu, Terres foudroyées, niveau 57+), 7562, 8417, 8423, 8424, 8425
--   (quêtes de classe), 94264, 94276, 94288, 94300, 94312 (commissions d'artisan), 79953,
--   81947 (Saison de la Découverte), 1396, 1398, 1421, 1423, 1425, 2783, 93585, 94929 (Alliance).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 43-46 Swamp of Sorrows
#displayname [FDP] Marais des Chagrins (43-46)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 44-46 Stranglethorn Vale 2

-- ===== Arrivée à Pierrêche =====
step
    #completewith ArriveePierreche
    .goto Swamp of Sorrows,46.07,54.83,40 >>Va à Pierrêche : vol si tu connais le point, sinon à cheval par le col. |cRXP_WARN_Chemin depuis les Rives Claires non vérifié|r
step
    #label ArriveePierreche
    .goto Swamp of Sorrows,46.07,54.83
    >>Parle à |cRXP_FRIENDLY_Breyk|r
    .fp Stonard >>Prends le point de vol de Pierrêche
    .target 6026
step
    .goto Swamp of Sorrows,45.16,56.66
    >>Parle à |cRXP_FRIENDLY_Karakul l'aubergiste|r
    .home >>Fixe ta pierre de foyer à Pierrêche
    .target 6930
step
    .goto Swamp of Sorrows,44.70,57.21
    >>Parle à |cRXP_FRIENDLY_Dar|r
    .accept 698 >>Accepte Petit bonus du soir
    .target 5591
step
    .goto Swamp of Sorrows,47.93,54.78
    >>Parle à |cRXP_FRIENDLY_Fel'zerul|r
    .accept 1424 >>Accepte Le bassin des larmes
    .target 1443
step
    .goto Swamp of Sorrows,47.74,55.20
    >>Parle à |cRXP_FRIENDLY_Helgrum l'Agile|r
    .turnin 1420 >>Rends Le rapport à Helgrum
    .target 1442
    .isOnQuest 1420
step
    .goto Swamp of Sorrows,44.29,52.43
    >>Parle à l'|cRXP_FRIENDLY_Infiltrateur Marksen|r
    .turnin 1391 >>Rends La vérité, rien que la vérité
    .target 5416
    .isOnQuest 1391

-- ===== Havre boueux (trio de niveau 35, rentable jusqu'au niveau 43) =====
step
    .goto Swamp of Sorrows,25.98,31.40
    >>Va à l'ouest au havre Boueux. Parle à |cRXP_FRIENDLY_Magtoor|r, |cRXP_FRIENDLY_Pelluk|r et |cRXP_FRIENDLY_Karana|r
    .accept 1389 >>Accepte Les cristaux de draenéthyste
    .accept 93430 >>Accepte Récupération de l'appât
    .accept 93429 >>Accepte Le sang de mon sang
    .target 1776
    .target 254770
    .target 254775
    .maxlevel 43

-- ===== Crocilisques et sanctuaire des Friches =====
step
    #completewith FinCrocs
    >>Tue les |cRXP_ENEMY_Crocilisques Dents-de-scie|r entre Pierrêche et le sanctuaire des Friches pour leurs |cRXP_LOOT_Flancs|r
    >>|cRXP_WARN_Farm long en duo (~67 kills) : chacun doit looter ses objets|r
    .complete 698,1 --Flanc de Dents-de-scie non préparé (8)
    .mob 1082
step
    #completewith HavreRendus
    >>Tue |cRXP_ENEMY_Noboru le Gourdin|r s'il passe (il patrouille entre le havre Boueux et le sanctuaire) et ramasse son |cRXP_LOOT_Gourdin|r
    >>|cRXP_WARN_Utilise l'objet pour lancer la quête. S'il n'en tombe qu'un, l'autre attend le respawn ou s'en passe|r
    .collect 6196,1,1392,1
    .accept 1392 >>Accepte Noboru le Gourdin
    .use 6196
    .unitscan 5477
step
    #completewith FinCrocs
    >>Si tu as |cRXP_LOOT_De la Poussière de rêve dans les marécages|r, tue les |cRXP_ENEMY_Plaiedécailles verts|r et leurs capitaines pour la |cRXP_LOOT_Poussière de rêve|r. |cRXP_WARN_À rendre à Krazek, Baie-du-Butin : peu d'XP à ton niveau, abandonne-la si tu n'y repasses pas|r
    .complete 1116,1 --Grain de poussière de rêve (10)
    .mob 744
    .mob 745
    .isOnQuest 1116
step
    .goto Swamp of Sorrows,50.50,31.00
    >>Tue les |cRXP_ENEMY_Pêcheurs Perdus|r jusqu'à récupérer l'|cRXP_LOOT_Appât porte-bonheur|r
    .complete 93430,1 --Appât porte-bonheur
    .mob 757
    .isOnQuest 93430
step
    .goto Swamp of Sorrows,61.00,24.00
    >>Au sanctuaire des Friches, tue les |cRXP_ENEMY_Perdus|r et ramasse les |cRXP_PICK_Cristaux de draenéthyste|r (aussi vers 55,29)
    .complete 93429,1 --Perdus (10)
    .complete 1389,1 --Cristal de draenéthyste (6)
    .mob 759
    .mob 760
    .mob 761
    .mob 762
    .isOnQuest 93429
step
    .goto Swamp of Sorrows,65.47,18.16
    >>Parle à |cRXP_FRIENDLY_Galen Goodward|r au nord du sanctuaire pour lancer l'escorte. |cRXP_WARN_Acceptez-la tous les deux avant qu'il parte|r
    .accept 1393 >>Accepte L'évasion de Galen
    .target 5391
step
    .goto Swamp of Sorrows,53.08,29.55
    >>Escorte |cRXP_FRIENDLY_Galen|r hors du sanctuaire. Tue ce qui l'attaque
    .complete 1393,1
step
    .goto Swamp of Sorrows,47.81,39.76
    >>Ouvre le |cRXP_PICK_Coffre de Galen|r à son camp, au sud-ouest
    .turnin 1393 >>Rends L'évasion de Galen

-- ===== Havre boueux : rendus =====
step
    #label HavreRendus
    .goto Swamp of Sorrows,25.98,31.40
    >>Va au havre Boueux et parle à |cRXP_FRIENDLY_Magtoor|r
    .turnin -1392 >>Rends Noboru le Gourdin
    .turnin -1389 >>Rends Les cristaux de draenéthyste
    .target 1776
step
    .goto Swamp of Sorrows,25.98,31.40
    >>Parle à |cRXP_FRIENDLY_Magtoor|r
    .turnin 93678 >>Rends Résumé des notes sur la draenéthyste
    .target 1776
    .isOnQuest 93678
step
    .goto Swamp of Sorrows,26.51,30.35
    >>Parle à |cRXP_FRIENDLY_Pelluk|r
    .turnin 93430 >>Rends Récupération de l'appât
    .target 254770
    .isOnQuest 93430
step
    .goto Swamp of Sorrows,24.72,32.64
    >>Parle à |cRXP_FRIENDLY_Karana|r
    .turnin 93429 >>Rends Le sang de mon sang
    .target 254775
    .isOnQuest 93429
step
    .goto Swamp of Sorrows,22.87,48.19
    >>Au sud, clique sur le |cRXP_PICK_Parchemin trempé|r. |cRXP_WARN_Ne prends pas la suite : elle part au marécage d'Âprefange|r
    .turnin 624 >>Rends Devinette de Cortello
    .isOnQuest 624

-- ===== Héros déchu de la Horde (niveau 45) =====
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Au sud, à l'entrée des Terres foudroyées, parle au |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .accept 2784 >>Accepte Perte d'honneur
    .target 7572
    .xp <45,1
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Écoute l'histoire du |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .complete 2784,1
    .turnin 2784 >>Rends Perte d'honneur
    .accept 2621 >>Accepte Le déshonoré
    .target 7572
    .isOnQuest 2784
step
    .goto Swamp of Sorrows,47.79,54.94
    >>Retourne à Pierrêche. Parle au |cRXP_FRIENDLY_Commandant d'ordonnance Ruag|r
    .turnin 2621 >>Rends Le déshonoré
    .accept 2622 >>Accepte Les ordres disparus
    .target 7623
    .isOnQuest 2621
step
    .goto Swamp of Sorrows,44.97,57.37
    >>Parle à |cRXP_FRIENDLY_Bengor|r
    .turnin 2622 >>Rends Les ordres disparus
    .accept 2623 >>Accepte Le Parleur des marécages
    .target 7643
    .isOnQuest 2622

-- ===== Bassin des larmes =====
step
    #label FinCrocs
    .goto Swamp of Sorrows,55.50,47.00
    >>Finis les |cRXP_ENEMY_Crocilisques Dents-de-scie|r au nord-est de Pierrêche
    >>|cRXP_WARN_Farm long en duo (~67 kills) : chacun doit looter ses objets|r
    .complete 698,1 --Flanc de Dents-de-scie non préparé (8)
    .mob 1082
step
    .goto Swamp of Sorrows,70.00,52.00
    >>Ramasse les |cRXP_PICK_Artefacts atal'ai|r autour du bassin des larmes, à l'est
    .complete 1424,1 --Artefact atal'ai (10)

-- ===== Côte sud-est : Tok'Kar et Katar =====
step
    .goto Swamp of Sorrows,81.32,80.97
    >>Va au sud-est, sur la grève. Parle à |cRXP_FRIENDLY_Tok'Kar|r
    .turnin 698 >>Rends Petit bonus du soir
    .accept 699 >>Accepte Petit bonus du soir
    .target 5592
step
    .goto Swamp of Sorrows,79.50,97.50
    >>Tue les |cRXP_ENEMY_Mordeurs Dents-de-scie|r sur la côte sud pour leurs |cRXP_LOOT_Griffes|r. S'ils manquent, remonte la côte est (85,63)
    >>|cRXP_WARN_Farm long en duo (~57 kills) : chacun doit looter ses objets|r
    .complete 699,1 --Griffe de Mordeur Dents-de-scie (6)
    .mob 1087
step
    .goto Swamp of Sorrows,81.32,80.97
    >>Retourne voir |cRXP_FRIENDLY_Tok'Kar|r
    .turnin 699 >>Rends Petit bonus du soir
    .accept 1422 >>Accepte Le danger venu des flots
    .target 5592
step
    .goto Swamp of Sorrows,83.76,80.41
    >>Parle à |cRXP_FRIENDLY_Katar|r
    .turnin 1422 >>Rends Le danger venu des flots
    .accept 1426 >>Accepte Le danger venu des flots
    .target 5593
step
    .goto Swamp of Sorrows,85.50,87.00
    >>Tue les |cRXP_ENEMY_Murlocs|r et les |cRXP_ENEMY_Cracheurs des marais|r sur la grève
    .complete 1426,1 --Murloc des marais (10)
    .complete 1426,2 --Cracheur des marais (10)
    .mob 747
    .mob 750
step
    .goto Swamp of Sorrows,63.00,84.00
    >>À l'ouest, au camp murloc, tue les |cRXP_ENEMY_Dévoreurs des marais|r. |cRXP_WARN_Évite les Parleurs des marécages (niveau 50) pour l'instant|r
    .complete 1426,3 --Dévoreur des marais (10)
    .complete 1426,2 --Cracheur des marais (10)
    .mob 751
    .mob 750
step
    .goto Swamp of Sorrows,83.76,80.41
    >>Retourne voir |cRXP_FRIENDLY_Katar|r
    .turnin 1426 >>Rends Le danger venu des flots
    .accept 1427 >>Accepte Le danger venu des flots
    .target 5593
step
    .goto Swamp of Sorrows,81.32,80.97
    >>Parle à |cRXP_FRIENDLY_Tok'Kar|r
    .turnin 1427 >>Rends Le danger venu des flots
    .target 5592
step
    .goto Swamp of Sorrows,83.76,80.41
    >>Parle à |cRXP_FRIENDLY_Katar|r
    .accept 1428 >>Accepte Le danger permanent
    .target 5593
step
    .goto Swamp of Sorrows,62.50,84.00
    >>Retourne au camp murloc à l'ouest. Tue les |cRXP_ENEMY_Cracheurs|r, |cRXP_ENEMY_Dévoreurs|r et |cRXP_ENEMY_Oracles des marais|r
    .complete 1428,1 --Cracheur des marais (10)
    .complete 1428,2 --Dévoreur des marais (10)
    .complete 1428,3 --Oracle des marais (10)
    .mob 750
    .mob 751
    .mob 752
step
    .goto Swamp of Sorrows,62.50,84.00
    >>Tue un |cRXP_ENEMY_Parleur des marécages|r et prends les |cRXP_LOOT_Ordres du chef de guerre|r. |cRXP_WARN_Niveau 50 : en duo, un à la fois|r
    .complete 2623,1 --Ordres du chef de guerre
    .mob 950
    .isOnQuest 2623
step
    .goto Swamp of Sorrows,83.76,80.41
    >>Retourne voir |cRXP_FRIENDLY_Katar|r
    .turnin 1428 >>Rends Le danger permanent
    .target 5593

-- ===== Pierrêche : rendus =====
step
    .goto Swamp of Sorrows,47.93,54.78
    >>Retourne à Pierrêche (pierre de foyer si elle est prête). Parle à |cRXP_FRIENDLY_Fel'zerul|r
    .turnin 1424 >>Rends Le bassin des larmes
    .accept 1429 >>Accepte L'Exilé atal'ai. |cRXP_WARN_Garde-la : elle se rend dans les Hinterlands|r
    .target 1443

-- ===== Héros déchu, si le niveau 45 est venu en route =====
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Va au sud-ouest, à l'entrée des Terres foudroyées. Parle au |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .accept 2784 >>Accepte Perte d'honneur
    .target 7572
    .xp <45,1
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Écoute l'histoire du |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .complete 2784,1
    .turnin 2784 >>Rends Perte d'honneur
    .accept 2621 >>Accepte Le déshonoré
    .target 7572
    .isOnQuest 2784
step
    .goto Swamp of Sorrows,47.79,54.94
    >>Retourne à Pierrêche. Parle au |cRXP_FRIENDLY_Commandant d'ordonnance Ruag|r
    .turnin 2621 >>Rends Le déshonoré
    .accept 2622 >>Accepte Les ordres disparus
    .target 7623
    .isOnQuest 2621
step
    .goto Swamp of Sorrows,44.97,57.37
    >>Parle à |cRXP_FRIENDLY_Bengor|r
    .turnin 2622 >>Rends Les ordres disparus
    .accept 2623 >>Accepte Le Parleur des marécages
    .target 7643
    .isOnQuest 2622
step
    .goto Swamp of Sorrows,62.50,84.00
    >>Va au camp murloc au sud-est de Pierrêche. Tue un |cRXP_ENEMY_Parleur des marécages|r et prends les |cRXP_LOOT_Ordres du chef de guerre|r. |cRXP_WARN_Niveau 50 : en duo, un à la fois|r
    .complete 2623,1 --Ordres du chef de guerre
    .mob 950
    .isOnQuest 2623
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Rapporte les ordres au |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .turnin 2623 >>Rends Le Parleur des marécages
    .target 7572
    .isOnQuest 2623
step
    #label FinMaraisChagrins
    +|cRXP_WARN_Niveau conseillé pour la suite : 46. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

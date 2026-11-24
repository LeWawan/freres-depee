if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Terres foudroyées (Blasted Lands), Horde, toutes classes.
-- Pas de base Horde dans la zone : vol jusqu'à Pierrêche (Marais des Chagrins), le Héros déchu
-- de la Horde attend à l'entrée du col (Marais 34.3,66.1). Indépendant des autres régions :
-- 2623 (Marais des Chagrins), 93684 (Marais des Chagrins, après 93679) et 3626
-- (Strangleronce) sont protégées par .isOnQuest / .isQuestComplete, la suite du Héros déchu
-- par .isQuestTurnedIn 2623.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua et xpDB-traces.lua
-- (93572, 93684), taux de drop de classicItemDrops.lua (wowheadData : 34 à 39 % pour les
-- pièces des mages de sang). Duo : kills = 2 x nombre x 100 / taux.
-- Objets partagés : les trois quêtes de Drazial (2581, 2583, 2585) prennent les mêmes poumons
-- et pinces, et le butin s'arrête au plus grand besoin d'une quête (3 de chaque). D'où trois
-- rendus : 2581, puis 2585 après une pince de plus, puis 2583 au second passage.
-- Itinéraire : Héros déchu (2801, 2681) -> Drazial -> pierres de Grol (nord-ouest) -> champ
-- au sud de Drazial (scorpoks, hyènes, vautours) -> Kum'isha (centre) -> sangliers ->
-- pierres de Sevine (ouest) -> basilics -> pierres d'Allistarj (est) -> pierres de Razelikh
-- (sud) -> Drazial -> Héros déchu, Thund et coffret -> scorpoks et sangliers (2583) ->
-- Kirith (est) -> Drazial -> Héros déchu.
-- Coupées :
--   2601/2602 La morsure du basilic / Un esprit infaillible (10 cerveaux + 2 gésiers à ~37 % = ~64 kills, 73 xp/kill),
--   2603/2604 La vigueur du vautour / Domination spirituelle (10 gésiers + 2 joues à ~34 % = ~70 kills, 67 xp/kill),
--   2582, 2584, 2586 (répétables de Drazial, pas d'XP), 2521/2522 et 93685 (Sphère de
--   draenéthyste sans défaut : seulement sur Teremus, élite rare 60), 93686 (pas de donneur),
--   3501/3502 Tout se compte en grandes quantités (fragments à ~3 %, 100 % seulement sur un PNJ de
--   l'Alliance et sur Felcular, niveau 60), 2784, 2621 (début du Héros déchu, niveau 50, guide du Marais des
--   Chagrins avec 2622/2623), 2744 Le chasseur de démons (rendu à Loramus en Azshara, autre
--   continent ; mène à 3141/3508-3511), 3627/3628 (élites 58 à 60, armes d'azsharite venues
--   d'Azshara, Razelikh boss de groupe), 87451 Souvenirs de Rêchepierre (objet sans source
--   dans QuestieDB), 91548 Vek'zol (donnée et rendue à Orgrimmar, prérequis 91547 coupé en
--   Azshara), 81900/81917/81919 (Saison de la Découverte), 91882 La Grande Alliance (rendue à
--   Hyjal, PNJ de l'Alliance), 8423/8424/8425/7581/7582/7583 (quêtes de classe),
--   94317, 94326, 94335, 94353 (commissions d'artisan), 2783, 96797, 96798, 96799, 96811,
--   96812 (Alliance).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 53-55 Blasted Lands
#displayname [FDP] Terres foudroyées (53-55)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 53-55 Western Plaguelands

step
    #sticky
    #completewith FinTerresFoudroyees
    .isQuestAvailable 2623
    .xp 60 >>|cRXP_WARN_Chaîne du Héros déchu pas finie (2784 à 2623, Marais des Chagrins) : sa suite ici (~27 000 xp) sera sautée. Fais-la d'abord avec le guide du Marais des Chagrins|r

-- ===== Héros déchu de la Horde =====
step
    #completewith ArriveeHeros
    .goto Swamp of Sorrows,34.29,66.14,30 >>Vole à Pierrêche, puis va au sud-ouest jusqu'au col des Terres foudroyées
step
    #label ArriveeHeros
    .goto Swamp of Sorrows,34.29,66.14
    >>Parle au |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .turnin 2623 >>Rends Le Parleur des marécages
    .target 7572
    .isQuestComplete 2623
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Parle au |cRXP_FRIENDLY_Héros déchu de la Horde|r. |cRXP_WARN_Ne prends pas la suite, Réunir les morceaux de l'Amulette brisée : élites 58 à 60|r
    .turnin 3626 >>Rends Retour aux Terres foudroyées
    .target 7572
    .isOnQuest 3626
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Parle au |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .accept 2801 >>Accepte Une histoire de chagrin
    .target 7572
    .isQuestTurnedIn 2623
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Écoute l'histoire du |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .complete 2801,1
    .turnin 2801 >>Rends Une histoire de chagrin
    .accept 2681 >>Accepte Les pierres qui nous lient
    .target 7572
    .isQuestTurnedIn 2623

-- ===== Mages de sang et nord de la zone =====
step
    .goto Blasted Lands,50.55,14.20
    >>Descends le col vers le sud. Parle au |cRXP_FRIENDLY_Mage de sang Drazial|r
    .accept 2581 >>Accepte Joues de Raillecroc
    .accept 2583 >>Accepte La vitalité du sanglier
    .accept 2585 >>Accepte Le coup décisif
    .target 7505
step
    .goto Blasted Lands,42.50,12.50
    >>Va à l'ouest. Près des |cRXP_PICK_Pierres de lien|r, tue les |cRXP_ENEMY_Serviteurs de Grol|r. |cRXP_WARN_Reste près de la pierre pendant le combat, sinon ça ne compte pas. Mécanique non vérifiée en jeu|r
    .complete 2681,2 --Serviteur de Grol libéré (3)
    .mob 7669
    .isOnQuest 2681
step
    .goto Blasted Lands,47.50,19.00
    >>Au sud de Drazial, tue les |cRXP_ENEMY_Aiguillonneurs scorpoks|r pour leurs |cRXP_LOOT_Pinces|r, les |cRXP_ENEMY_Raillecrocs affamées|r pour leurs |cRXP_LOOT_Joues|r et les |cRXP_ENEMY_Pourfendeurs noirs|r pour leurs |cRXP_LOOT_Gésiers|r
    >>|cRXP_WARN_Chacun doit looter ses objets. On ne peut porter que 3 pinces pour l'instant : le reste viendra plus tard|r
    .complete 2585,1 --Pince de scorpok (3)
    .complete 2581,1 --Joues de Raillecroc (3)
    .complete 2585,2 --Gésier de vautour (2)
    .mob 5988
    .mob 5984
    .mob 5982

-- ===== Centre : Kum'isha et sangliers =====
step
    .goto Blasted Lands,51.98,35.65
    >>Va au sud jusqu'à |cRXP_FRIENDLY_Kum'isha le collecteur|r
    .turnin 93684 >>Rends Le trouvé
    .target 7363
    .isOnQuest 93684
step
    .goto Blasted Lands,51.98,35.65
    >>Parle à |cRXP_FRIENDLY_Kum'isha le collecteur|r
    .accept 93572 >>Accepte To Serve The Draenei
    .target 7363
step
    .goto Blasted Lands,51.98,35.65
    >>Protège les réfugiés draeneï qui passent par la faille de |cRXP_FRIENDLY_Kum'isha|r. Aucun ne doit mourir. |cRXP_WARN_Événement non vérifié en jeu : s'il échoue, abandonne la quête pour continuer|r
    .complete 93572,1
    .turnin 93572 >>Rends To Serve The Draenei
    .target 7363
    .isOnQuest 93572
step
    .goto Blasted Lands,48.00,35.50
    >>Tue les |cRXP_ENEMY_Sangliers infernaux|r autour de Kum'isha pour leurs |cRXP_LOOT_Poumons|r
    .complete 2583,1 --Poumon de sanglier éclaté (3)
    .mob 5993

-- ===== Pierres de Sevine, basilics, pierres d'Allistarj =====
step
    .goto Blasted Lands,41.00,38.00
    >>Va à l'ouest. Près des |cRXP_PICK_Pierres de lien|r, tue les |cRXP_ENEMY_Serviteurs de Sevine|r
    .complete 2681,4 --Serviteur de Sevine libéré (3)
    .mob 7671
    .isOnQuest 2681
step
    .goto Blasted Lands,56.50,44.80
    >>En allant vers l'est, tue une |cRXP_ENEMY_Peau de cristal Rougepierre|r pour un |cRXP_LOOT_Cerveau de basilic|r
    .complete 2583,3 --Cerveau de basilic
    .mob 5991
step
    .goto Blasted Lands,64.40,40.60
    >>Près des |cRXP_PICK_Pierres de lien|r à l'est, tue les |cRXP_ENEMY_Serviteurs d'Allistarj|r
    .complete 2681,3 --Serviteur d'Allistarj libéré (3)
    .mob 7670
    .isOnQuest 2681
step
    .goto Blasted Lands,57.60,54.90
    >>Va au sud. Près des |cRXP_PICK_Pierres de lien|r, tue les |cRXP_ENEMY_Serviteurs de Razelikh|r. |cRXP_WARN_Niveau 57 : un à la fois. 7 points pour 9 kills : attends les réapparitions|r
    .complete 2681,1 --Serviteur de Razelikh libéré (9)
    .mob 7668
    .isOnQuest 2681

-- ===== Retour au nord : Drazial =====
step
    .goto Blasted Lands,50.55,14.20
    >>Remonte au nord jusqu'au |cRXP_FRIENDLY_Mage de sang Drazial|r. |cRXP_WARN_Rends seulement celle-ci : les deux autres partagent les mêmes objets|r
    .turnin 2581 >>Rends Joues de Raillecroc
    .target 7505
step
    .goto Blasted Lands,47.50,19.00
    >>Tue un |cRXP_ENEMY_Aiguillonneur scorpok|r juste au sud pour la troisième |cRXP_LOOT_Pince|r
    .complete 2585,1 --Pince de scorpok (3)
    .mob 5988
    .isOnQuest 2585
step
    .goto Blasted Lands,50.55,14.20
    >>Retourne voir le |cRXP_FRIENDLY_Mage de sang Drazial|r
    .turnin 2585 >>Rends Le coup décisif
    .target 7505
    .isOnQuest 2585

-- ===== Héros déchu : Thund et le coffret =====
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Remonte le col jusqu'au |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .turnin 2681 >>Rends Les pierres qui nous lient
    .accept 2702 >>Accepte Les héros des Anciens
    .target 7572
    .isOnQuest 2681
step
    .goto Swamp of Sorrows,33.49,65.99
    >>Parle au |cRXP_FRIENDLY_Caporal Thund Splithoof|r, juste à côté
    .turnin 2702 >>Rends Les héros des Anciens
    .accept 2701 >>Accepte Les héros des Anciens
    .target 7750
    .isOnQuest 2702
step
    .goto Swamp of Sorrows,33.26,66.22
    >>Ouvre le |cRXP_PICK_Coffret spectral|r
    .turnin 2701 >>Rends Les héros des Anciens
    .isOnQuest 2701
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Parle au |cRXP_FRIENDLY_Héros déchu de la Horde|r
    .accept 2721 >>Accepte Kirith
    .target 7572
    .isQuestTurnedIn 2701

-- ===== Second passage : 2583 et Kirith =====
step
    .goto Blasted Lands,47.50,19.00
    >>Redescends au sud de Drazial. Tue les |cRXP_ENEMY_Aiguillonneurs scorpoks|r pour deux |cRXP_LOOT_Pinces|r
    .complete 2583,2 --Pince de scorpok (2)
    .mob 5988
    .isOnQuest 2583
step
    .goto Blasted Lands,59.50,30.00
    >>Va à l'est. Tue les |cRXP_ENEMY_Sangliers cendrés|r et |cRXP_ENEMY_Sangliers infernaux|r pour trois |cRXP_LOOT_Poumons|r. Si le |cRXP_LOOT_Cerveau|r manque, tue un |cRXP_ENEMY_Basilic Rougepierre|r ici
    .complete 2583,1 --Poumon de sanglier éclaté (3)
    .complete 2583,3 --Cerveau de basilic
    .mob 5992
    .mob 5993
    .mob 5990
    .isOnQuest 2583
step
    .goto Blasted Lands,68.80,31.07
    >>Va plus à l'est. Tue |cRXP_ENEMY_Kirith le Damné|r, puis parle à l'|cRXP_FRIENDLY_Esprit de Kirith|r. |cRXP_WARN_Élite 55 : en duo|r
    .turnin 2721 >>Rends Kirith
    .accept 2743 >>Accepte Le couvert de l'obscurité
    .target 7729
    .mob 7728
    .isOnQuest 2721
step
    .goto Blasted Lands,50.55,14.20
    >>Remonte au nord jusqu'au |cRXP_FRIENDLY_Mage de sang Drazial|r
    .turnin 2583 >>Rends La vitalité du sanglier
    .target 7505
    .isOnQuest 2583
step
    .goto Swamp of Sorrows,34.29,66.14
    >>Remonte le col jusqu'au |cRXP_FRIENDLY_Héros déchu de la Horde|r. |cRXP_WARN_Ne prends pas la suite, Le chasseur de démons : elle part en Azshara|r
    .turnin 2743 >>Rends Le couvert de l'obscurité
    .target 7572
    .isOnQuest 2743
step
    #label FinTerresFoudroyees
    +|cRXP_WARN_Niveau conseillé pour la suite : 55. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

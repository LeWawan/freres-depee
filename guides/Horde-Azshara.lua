if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Azshara, Horde, toutes classes, joué en duo.
-- Indépendant des autres régions : les envois vers Jediga (91734, 91735, 91737) sont
-- protégés par .isOnQuest. La chaîne Trahison (3504) commence à Orgrimmar : le guide y
-- passe au milieu de la route (livraison à Jes'rimon), donc tout le monde peut la faire.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-traces.lua (prioritaire)
-- et xpDB-classic.lua. Taux de drop absents pour les objets de la zone : 35 % supposés.
-- Les entrées « Removed with cata » de QuestieQuestBlacklist.lua (3517, 3541, 3601, 5535...)
-- dépendent de Expansions.Current >= Cata : elles ne s'appliquent pas à Forever, et
-- xpDB-traces a des rendus Forever pour ces quêtes.
-- Itinéraire : Valormok -> Loh'atu (sud-ouest) -> sabots-de-mousse et guêpes -> ruines
-- d'Eldarath (tablettes, sable) -> Valormok -> aller-retour Orgrimmar -> tour de Xylem ->
-- Ekkal -> Ursolan (Grumegueules) -> camp legashi -> camp thalassien (Rimtori) ->
-- Ursolan -> Ekkal -> Valormok -> Orgrimmar.
-- XP de quêtes gardée : ~125 000, dont ~22 000 pour la chaîne Trahison (3504 sans trace
-- Forever : si Belgrom ne la propose pas, les étapes de la chaîne se sautent).
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   5534 L'équipement « manquant » de Kim'jael (Une rune à 2,7 % wowheadData = ~74 kills
--   pour 6550 xp), 3518/3562 Magatha à Thunder Bluff (trop loin pour ~8900 xp),
--   3542/3564 Andron Gant à Undercity (autre continent), 3141, 3508-3511, 3602, 3621,
--   91877 (chaîne de Loramus : prérequis 2744 aux Terres foudroyées, puis Strangleronce
--   et Hyjal), 3382 Un équipage sous le feu ennemi (niveau 57, deuxième passage à 55+),
--   91685 Tâter le tellurisme (Célégosa élite 54 au lac Mennar, deuxième passage à 55+),
--   91611 Prise mortelle (requin mammouth élite 54, deuxième passage à 55+), 91607 Le gros
--   lot ! (lancée par un drop des géants élites des falaises, taux inconnu), 91610 Pêche
--   hivernale (pêche), 91547 (560 xp, mène à 91548 aux Terres foudroyées), 92346 Sous
--   Nordrassil (envoi à Thunder Bluff, 560 xp), 86798 et 86814 (Bastion des Grumegueules,
--   Gangrebois), 86747 (pas de donneur), 3421 et 3503 (pas d'XP, retirées à Cata, pas de
--   trace Forever), 3506 et 3507 (remplacées par 91497, 91500, 91531 dans Forever),
--   6804, 6805, 6821, 6822, 6823, 6824, 7486 (Hydraxis : 55+, autres zones, Cœur du
--   Magma), 8575, 8729 (raid, niveau 60). Pour les guides de donjon : 96246, 97327, 92065,
--   92066, 92070 (Antre des Noiregueules, 55-60).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 48-52 Azshara
#displayname [FDP] Azshara (48-52)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 51-52 Un'Goro Crater

-- ===== Valormok =====
step
    #completewith ArriveeValormok
    .goto Azshara,21.96,49.62,40 >>Va à Valormok, à l'ouest d'Azshara. |cRXP_WARN_Vol depuis Orgrimmar, ou à pied depuis l'est d'Ashenvale|r
step
    #label ArriveeValormok
    .goto Azshara,21.96,49.62
    >>Parle à |cRXP_FRIENDLY_Kroum|r
    .fp Valormok >>Prends le point de vol de Valormok
    .target 8610
step
    .goto Azshara,22.56,51.42
    >>Parle à |cRXP_FRIENDLY_Jediga|r
    .turnin 91734 >>Rends Contact éloigné
    .target 8587
    .isOnQuest 91734
step
    .goto Azshara,22.56,51.42
    >>Parle à |cRXP_FRIENDLY_Jediga|r
    .turnin 91735 >>Rends Contact éloigné
    .target 8587
    .isOnQuest 91735
step
    .goto Azshara,22.56,51.42
    >>Parle à |cRXP_FRIENDLY_Jediga|r
    .turnin 91737 >>Rends Contact éloigné
    .target 8587
    .isOnQuest 91737
step
    .goto Azshara,22.56,51.42
    >>Parle à |cRXP_FRIENDLY_Jediga|r
    .accept 3517 >>Accepte L'art du vol
    .target 8587
step
    .goto Azshara,21.82,52.10
    >>Parle à |cRXP_FRIENDLY_Kurll|r
    .accept 91488 >>Accepte Foyer en chantier
    .target 3621
step
    .goto Azshara,22.53,51.84
    >>Parle à |cRXP_FRIENDLY_Izvi Buldor|r
    .accept 91568 >>Accepte Longues balades sur la plage
    .accept 91569 >>Accepte L'or bleu
    .target 247473

-- ===== Sud-ouest : Loh'atu =====
step
    #completewith FinPeaux
    >>Tue les |cRXP_ENEMY_Coureurs Sabots-de-mousse|r que tu croises pour leurs |cRXP_LOOT_Peaux|r
    .complete 91488,1 --Peau de sabot-de-mousse (5)
    .mob 8759
step
    .goto Azshara,11.37,78.17
    >>Parle à |cRXP_FRIENDLY_Loh'atu|r, à la frontière d'Ashenvale
    .accept 5535 >>Accepte Agitation spirituelle
    .accept 5536 >>Accepte Un pays plein de haine
    .target 11548
step
    .goto Azshara,16.30,70.50
    >>Tue les |cRXP_ENEMY_Apparitions bien-nées|r et les |cRXP_ENEMY_Jeunes liches bien-nées|r
    .complete 5535,1 --Apparition bien-née (6)
    .complete 5535,2 --Jeune liche bien-née (6)
    .mob 6116
    .mob 6117
step
    .goto Azshara,20.20,61.80
    >>Tue les satyres |cRXP_ENEMY_Haldarr|r
    .complete 5536,1 --Satyre Haldarr (6)
    .complete 5536,2 --Entourloupeur Haldarr (2)
    .complete 5536,3 --Lige de la corruption Haldarr (2)
    .mob 6125
    .mob 6126
    .mob 6127
step
    .goto Azshara,11.37,78.17
    >>Retourne voir |cRXP_FRIENDLY_Loh'atu|r
    .turnin 5535 >>Rends Agitation spirituelle
    .turnin 5536 >>Rends Un pays plein de haine
    .target 11548
step
    #label FinPeaux
    .goto Azshara,20.40,59.10
    >>Finis les |cRXP_ENEMY_Coureurs Sabots-de-mousse|r pour leurs |cRXP_LOOT_Peaux|r. |cRXP_WARN_Chacun doit looter ses peaux (~29 kills en duo)|r
    .complete 91488,1 --Peau de sabot-de-mousse (5)
    .mob 8759
step
    .goto Azshara,21.82,52.10
    >>Retourne voir |cRXP_FRIENDLY_Kurll|r à Valormok
    .turnin 91488 >>Rends Foyer en chantier
    .accept 91608 >>Accepte En faire son miel
    .target 3621
step
    .goto Azshara,19.30,54.70
    >>Tire sur les |cRXP_ENEMY_Guêpes à miel|r avec le |cRXP_LOOT_Fusil à plombs|r et ramasse le |cRXP_LOOT_Miel sauvage|r
    .complete 91608,1 --Miel sauvage (5)
    .use 238501
    .mob 236028
step
    .goto Azshara,21.82,52.10
    >>Retourne voir |cRXP_FRIENDLY_Kurll|r
    .turnin 91608 >>Rends En faire son miel
    .target 3621

-- ===== Ruines d'Eldarath : tablettes et sable =====
step
    #completewith Tablettes
    .goto Azshara,46.80,53.60,0
    >>Fouille le |cRXP_PICK_Sable meuble|r avec la |cRXP_LOOT_Truelle à trésor 3000|r. Les |cRXP_ENEMY_Fouisseurs makrinnis|r en donnent aussi
    .complete 91568,1 --Fragment de trésor de Bien-né (10)
    .use 246683
    .mob 247470
step
    #label Tablettes
    .goto Azshara,37.00,56.00
    >>Ramasse les quatre |cRXP_PICK_Tablettes|r dans les ruines d'Eldarath
    .complete 3517,1 --Tablette de Beth'Amara
    .complete 3517,2 --Tablette de Jin'yael
    .complete 3517,3 --Tablette de Markri
    .complete 3517,4 --Tablette de Sael'hai
step
    .goto Azshara,46.80,53.60
    >>Finis le |cRXP_PICK_Sable meuble|r avec la |cRXP_LOOT_Truelle à trésor 3000|r
    .complete 91568,1 --Fragment de trésor de Bien-né (10)
    .use 246683
    .mob 247470
step
    .goto Azshara,22.53,51.84
    >>Retourne à Valormok et parle à |cRXP_FRIENDLY_Izvi Buldor|r
    .turnin 91568 >>Rends Longues balades sur la plage
    .target 247473
step
    .goto Azshara,22.56,51.42
    >>Parle à |cRXP_FRIENDLY_Jediga|r. |cRXP_WARN_Ne prends que les livraisons pour Jes'rimon et Xylem|r
    .turnin 3517 >>Rends L'art du vol
    .accept 3541 >>Accepte Livraison pour Jes'rimon
    .accept 3561 >>Accepte Livraison à l'archimage Xylem
    .target 8587

-- ===== Aller-retour à Orgrimmar =====
step
    .goto Azshara,21.96,49.62
    >>Parle à |cRXP_FRIENDLY_Kroum|r
    .fly Orgrimmar >>Vole vers Orgrimmar
    .target 8610
step
    .goto Orgrimmar,55.52,34.08
    >>Parle à |cRXP_FRIENDLY_Jes'rimon|r
    .turnin 3541 >>Rends Livraison pour Jes'rimon
    .accept 3563 >>Accepte Le Paiement de Jes'rimon à Jediga
    .target 8659
step
    #completewith next
    .goto Orgrimmar,75.23,34.24
    >>Parle à |cRXP_FRIENDLY_Belgrom Rockmaul|r. |cRXP_WARN_S'il ne propose rien, passe à la suite|r
    .accept 3504 >>Accepte Trahison
    .target 4485
step
    .goto Orgrimmar,45.12,63.89
    >>Parle à |cRXP_FRIENDLY_Doras|r
    .fly Valormok >>Retourne à Valormok
    .target 3310
step
    .goto Azshara,22.56,51.42
    >>Parle à |cRXP_FRIENDLY_Jediga|r
    .turnin 3563 >>Rends Le Paiement de Jes'rimon à Jediga
    .target 8587
step
    .goto Azshara,22.26,51.48
    >>Parle à |cRXP_FRIENDLY_Ag'tor Bloodfist|r
    .turnin 3504 >>Rends Trahison
    .target 8576
    .isOnQuest 3504
step
    .goto Azshara,22.26,51.48
    >>Parle à |cRXP_FRIENDLY_Ag'tor Bloodfist|r
    .accept 3505 >>Accepte Trahison
    .target 8576
    .isQuestTurnedIn 3504

-- ===== Nord-ouest : Xylem, Ekkal, Ursolan =====
step
    .goto Azshara,29.25,40.21
    >>Monte à la tour de l'|cRXP_FRIENDLY_Archimage Xylem|r
    .turnin 3561 >>Rends Livraison à l'archimage Xylem
    .accept 3565 >>Accepte Le Paiement de Xylem à Jediga
    .target 8379
step
    .goto Azshara,42.00,38.88
    >>Parle à |cRXP_FRIENDLY_Ekkal|r
    .accept 86746 >>Accepte La menace legashi
    .accept 86752 >>Accepte Rapport à Hurlerage
    .target 235903
step
    .goto Azshara,42.28,20.13
    >>Parle au |cRXP_FRIENDLY_Portier Hurlerage|r à Ursolan
    .turnin 86752 >>Rends Rapport à Hurlerage
    .accept 86791 >>Accepte Des éclaireurs noiregueules manquent à l'appel
    .target 236573
step
    .goto Azshara,45.29,22.34
    >>Parle à |cRXP_FRIENDLY_Fourze|r
    .accept 86799 >>Accepte Corruption envahissante
    .target 235909
step
    .goto Azshara,41.67,19.54
    >>Parle à l'|cRXP_FRIENDLY_Ancienne Claqueronces|r
    .turnin 86799 >>Rends Corruption envahissante
    .accept 86812 >>Accepte Teinture transmutée
    .accept 86804 >>Accepte Une source improbable
    .target 235906
step
    #completewith FinCampThalassien
    >>Affaiblis des |cRXP_ENEMY_Coursiers Sabots-de-mousse|r ou des |cRXP_ENEMY_Tempêtueux Tête-tonnerre|r puis utilise la |cRXP_LOOT_Teinture|r sur eux
    .complete 86812,1
    .use 235509
    .mob 8761
    .mob 6378

-- ===== Nord-est : camp legashi =====
step
    .goto Azshara,53.45,21.82
    >>Parle à |cRXP_FRIENDLY_Kim'jael|r
    .accept 3601 >>Accepte Kim'jael évidemment !
    .target 8420
step
    .goto Azshara,57.70,21.02
    >>Examine le |cRXP_PICK_Chaudron legashi|r
    .turnin 86804 >>Rends Une source improbable
    .accept 86925 >>Accepte Peine et trouble
    .accept 86926 >>Accepte Gangrefeu, brûle et chaudron, bouillonne
step
    .goto Azshara,63.01,21.43
    >>Parle à |cRXP_FRIENDLY_Korsa|r
    .turnin 86791 >>Rends Des éclaireurs noiregueules manquent à l'appel
    .accept 86777 >>Accepte Le maître Trouilleffroi
    .accept 86792 >>Accepte Décimer leurs troupes
    .target 236770
step
    #completewith Graal
    .goto Azshara,59.40,22.80,0
    >>Ramasse la |cRXP_PICK_Satyrienne|r sur les ronces et le |cRXP_PICK_Gangregranule|r (61.5,25.1)
    .complete 86926,1 --Satyrienne (5)
    .complete 86926,2 --Gangregranule
step
    #completewith Graal
    >>Les satyres donnent la |cRXP_LOOT_Recette d'eau-de-feu|r
    .complete 86925,1 --Recette d'eau-de-feu des Legashi
step
    .goto Azshara,61.00,20.50
    >>Tue les |cRXP_ENEMY_Satyres|r, |cRXP_ENEMY_Voleurs|r et |cRXP_ENEMY_Prêtres noirs Legashi|r
    .complete 86746,1 --Satyre Legashi (5)
    .complete 86746,2 --Voleur Legashi (5)
    .complete 86746,3 --Prêtre noir Legashi (5)
    .mob 6200
    .mob 6201
    .mob 6202
step
    .goto Azshara,61.70,24.80
    >>Tue le |cRXP_ENEMY_Maître Trouilleffroi|r et prends son |cRXP_LOOT_Amulette|r
    .complete 86777,1 --Amulette de Trouilleffroi
    .mob 236496
step
    .goto Azshara,65.50,18.50
    >>Tue les |cRXP_ENEMY_Agitateurs|r, |cRXP_ENEMY_Voleurs d'âmes|r et |cRXP_ENEMY_Canailles legashi|r dans la forteresse
    .complete 86792,1 --Agitateur legashi (6)
    .complete 86792,2 --Voleur d'âmes legashi (4)
    .complete 86792,3 --Canaille legashi (2)
    .mob 236874
    .mob 236867
    .mob 236876
step
    .goto Azshara,66.58,14.56
    >>Parle à |cRXP_FRIENDLY_Graal|r au fond de la forteresse
    .accept 86796 >>Accepte Je me tire, Satyre
    .target 237007
step
    #label Graal
    .goto Azshara,63.01,21.43
    >>Aide |cRXP_FRIENDLY_Graal|r à sortir de la forteresse. Tue ce qui l'attaque. |cRXP_WARN_Point d'arrivée non vérifié : suis-le jusqu'à Korsa|r
    .complete 86796,1
step
    .goto Azshara,59.40,22.80
    >>Finis la |cRXP_PICK_Satyrienne|r, le |cRXP_PICK_Gangregranule|r (61.5,25.1) et la |cRXP_LOOT_Recette|r sur les satyres
    .complete 86926,1 --Satyrienne (5)
    .complete 86926,2 --Gangregranule
    .complete 86925,1 --Recette d'eau-de-feu des Legashi
    .mob 6200
    .mob 6201
    .mob 6202
step
    .goto Azshara,63.01,21.43
    >>Retourne voir |cRXP_FRIENDLY_Korsa|r
    .turnin 86777 >>Rends Le maître Trouilleffroi
    .turnin 86792 >>Rends Décimer leurs troupes
    .turnin 86796 >>Rends Je me tire, Satyre
    .accept 86797 >>Accepte Retour auprès de Hurlerage
    .target 236770
step
    .goto Azshara,57.70,21.02
    >>Retourne au |cRXP_PICK_Chaudron legashi|r
    .turnin 86925 >>Rends Peine et trouble
    .turnin 86926 >>Rends Gangrefeu, brûle et chaudron, bouillonne
    .accept 86927 >>Accepte Course à l'eau-de-feu

-- ===== Camp thalassien : Kim'jael et Rimtori =====
step
    #completewith TomeKaldorei
    .goto Azshara,57.80,27.90,0
    >>Ramasse l'|cRXP_PICK_Équipement de Kim'jael|r dans le camp
    .complete 3601,1 --Boussole de Kim'Jael
    .complete 3601,2 --Lunette de Kim'Jael
    .complete 3601,3 --Poulet farci de Kim'Jael
    .complete 3601,4 --Wizzlegoober de Kim'Jael
step
    .goto Azshara,57.10,28.40
    >>Tue les |cRXP_ENEMY_Vengeurs|r et |cRXP_ENEMY_Géomètres elfes de sang|r
    .complete 3505,1 --Vengeur elfe de sang (10)
    .complete 3505,2 --Géomètre elfe de sang (10)
    .mob 6199
    .mob 6198
    .isOnQuest 3505
step
    #label TomeKaldorei
    .goto Azshara,57.80,27.90
    >>Finis l'|cRXP_PICK_Équipement de Kim'jael|r
    .complete 3601,1 --Boussole de Kim'Jael
    .complete 3601,2 --Lunette de Kim'Jael
    .complete 3601,3 --Poulet farci de Kim'Jael
    .complete 3601,4 --Wizzlegoober de Kim'Jael
step
    .goto Azshara,59.51,31.30
    >>Examine le |cRXP_PICK_Tome d'invocation kaldorei|r au camp de Rimtori
    .turnin 3505 >>Rends Trahison
    .isOnQuest 3505
step
    .goto Azshara,59.53,31.24
    >>Parle au |cRXP_FRIENDLY_Tome d'invocation sin'dorei|r
    .accept 91497 >>Accepte Les sceaux des Sin'dorei
    .target 247449
    .isQuestTurnedIn 3505
step
    .goto Azshara,56.90,27.90
    >>Tue la |cRXP_ENEMY_Magistrice Falcoiffe|r pour le |cRXP_LOOT_Sceau des guerriers|r
    .complete 91497,2 --Sceau des guerriers
    .mob 246991
    .isOnQuest 91497
step
    .goto Azshara,67.10,27.70
    >>Tue le |cRXP_ENEMY_Lieutenant Solcrête|r pour le |cRXP_LOOT_Sceau des gardiens|r
    .complete 91497,1 --Sceau des gardiens
    .mob 247006
    .isOnQuest 91497
step
    .goto Azshara,68.50,28.50
    >>Tue les |cRXP_ENEMY_Arcanistes elfes de sang|r pour une |cRXP_LOOT_Baguette de siphonnage de mana|r
    .complete 91569,1 --Baguette de siphonnage de mana
    .mob 246920
step
    .goto Azshara,70.30,29.90
    >>Tue la |cRXP_ENEMY_Forestière Lydrea|r pour le |cRXP_LOOT_Sceau des Forestiers|r
    .complete 91497,3 --Sceau des Forestiers
    .mob 247013
    .isOnQuest 91497
step
    .goto Azshara,59.53,31.24
    >>Retourne au |cRXP_FRIENDLY_Tome d'invocation sin'dorei|r
    .turnin 91497 >>Rends Les sceaux des Sin'dorei
    .accept 91500 >>Accepte Un stratagème explosif
    .accept 91538 >>Accepte Le tome d'invocation sin'dorei
    .target 247449
    .isOnQuest 91497
step
    .goto Azshara,59.51,31.37
    >>Brise les sceaux, puis tue le |cRXP_ENEMY_Magus Rimtori|r et prends sa |cRXP_LOOT_Tête|r. |cRXP_WARN_Niveau 55 : en duo|r
    .complete 91500,1 --Tête du magus Rimtori
    .mob 8578
    .isOnQuest 91500
step
    #label FinCampThalassien
    .goto Azshara,53.45,21.82
    >>Retourne voir |cRXP_FRIENDLY_Kim'jael|r
    .turnin 3601 >>Rends Kim'jael évidemment !
    .target 8420
step
    .goto Azshara,57.10,19.30
    >>Finis la |cRXP_LOOT_Teinture|r sur des |cRXP_ENEMY_Coursiers Sabots-de-mousse|r ou des |cRXP_ENEMY_Tempêtueux Tête-tonnerre|r affaiblis
    .complete 86812,1
    .use 235509
    .mob 8761
    .mob 6378

-- ===== Retour par Ursolan et Ekkal =====
step
    .goto Azshara,42.28,20.13
    >>Retourne voir le |cRXP_FRIENDLY_Portier Hurlerage|r
    .turnin 86797 >>Rends Retour auprès de Hurlerage
    .target 236573
step
    .goto Azshara,41.67,19.54
    >>Parle à l'|cRXP_FRIENDLY_Ancienne Claqueronces|r
    .turnin 86927 >>Rends Course à l'eau-de-feu
    .turnin 86812 >>Rends Teinture transmutée
    .accept 86813 >>Accepte Potentielle panacée
    .target 235906
step
    .goto Azshara,45.29,22.34
    >>Donne la |cRXP_LOOT_Panacée|r à |cRXP_FRIENDLY_Fourze|r
    .complete 86813,1
    .use 235510
    .target 235909
step
    .goto Azshara,41.67,19.54
    >>Retourne voir l'|cRXP_FRIENDLY_Ancienne Claqueronces|r
    .turnin 86813 >>Rends Potentielle panacée
    .target 235906
step
    .goto Azshara,42.00,38.88
    >>Parle à |cRXP_FRIENDLY_Ekkal|r
    .turnin 86746 >>Rends La menace legashi
    .target 235903

-- ===== Valormok puis Orgrimmar =====
step
    .goto Azshara,22.26,51.48
    >>Parle à |cRXP_FRIENDLY_Ag'tor Bloodfist|r
    .turnin 91500 >>Rends Un stratagème explosif
    .accept 91531 >>Accepte Vengeance accomplie
    .target 8576
    .isOnQuest 91500
step
    .goto Azshara,22.56,51.42
    >>Parle à |cRXP_FRIENDLY_Jediga|r
    .turnin 3565 >>Rends Le Paiement de Xylem à Jediga
    .target 8587
step
    .goto Azshara,22.56,51.42
    >>Parle à |cRXP_FRIENDLY_Jediga|r. |cRXP_WARN_Ne prends pas la suite pour Zevrost (Terres foudroyées)|r
    .turnin 91538 >>Rends Le tome d'invocation sin'dorei
    .target 8587
    .isOnQuest 91538
step
    .goto Azshara,22.53,51.84
    >>Parle à |cRXP_FRIENDLY_Izvi Buldor|r
    .turnin 91569 >>Rends L'or bleu
    .target 247473
step
    .goto Azshara,21.96,49.62
    >>Parle à |cRXP_FRIENDLY_Kroum|r
    .fly Orgrimmar >>Vole vers Orgrimmar
    .target 8610
step
    .goto Orgrimmar,75.23,34.24
    >>Parle à |cRXP_FRIENDLY_Belgrom Rockmaul|r
    .turnin 91531 >>Rends Vengeance accomplie
    .target 4485
    .isOnQuest 91531
step
    #label FinAzshara
    +|cRXP_WARN_Niveau conseillé pour la suite : 51. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Rives Claires (Riverglades, zone Forever, uiMap 2548), Horde,
-- toutes classes. Indépendant des autres régions : les envois depuis Arathi (95143) et
-- Strangleronce (95141) sont protégés par .isOnQuest.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-traces.lua. Taux de drop
-- inconnus dans la zone : 35 % supposés. Beaucoup de quêtes n'ont pas d'objectifs dans
-- QuestieDB : RXP les lit dans le jeu.
-- Accès non vérifié en jeu (sites de fans) : à l'est depuis Kargath (Terres ingrates), au
-- nord depuis Stonard par le col, ou le bateau de Port-Vapeur (Tanaris 68.6,23.0). Rog'mar
-- vole ensuite vers Kargath, Stonard et Trépas-d'Orgrim.
-- Itinéraire : Rog'mar -> plaines Sauvages (Neza, trois allers-retours courts) ->
-- sud-ouest (moulin de Turner, Ruissepré, collines Hirsutes) -> Rog'mar -> rivière et
-- Fort-Lointain -> Clairsoleil et ses grottes -> Bolder'ok (arène) -> port gobelin et côte
-- est -> ouest (Da'grosh) si le niveau suit.
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   93788/93976 Lames réclamées (10 haches à 35 % = ~57 kills), 94535 Bandits des collines
--   Hirsutes (40 minerais = ~228 kills), 94961/94963 Mordre la main (20 os = ~114 kills),
--   95121 Saveurs maritimes (12 yeux = ~69 kills), 95260-95267 Argo (15 entrailles = ~86
--   kills), 95162 Capture de brochepâle (viande sans source dans la zone), 96026 (Caillou
--   lourd, forge), 95982 (ragoût, cuisine), 95433 Mort au bourreau (élite 46, rendu à
--   Bolder'ok depuis l'ouest), 95295-95327 et 95321 (envois vers Baie-du-Butin / Tanaris),
--   95033 (envoi en Féralas), 97884 (commence à Undercity), 93971, 95181, 96027, 96028,
--   98426 (pas de donneur dans QuestieDB).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 37-45 Riverglades
#displayname [FDP] Rives Claires (37-45)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 42-43 Badlands

-- ===== Voyage et Rog'mar =====
step
    #completewith ArriveeRogmar
    .goto 2548,59.59,45.08,40 >>Va à Rog'mar, au centre des Rives Claires. |cRXP_WARN_Routes non vérifiées : à l'est depuis Kargath, au nord depuis Stonard par le col, ou le bateau de Port-Vapeur (Tanaris)|r
step
    #label ArriveeRogmar
    .goto 2548,59.59,45.08
    >>Parle à |cRXP_FRIENDLY_Grakna|r
    .fp Rog'mar >>Prends le point de vol de Rog'mar
    .target 255993
step
    .goto 2548,57.99,45.10
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Toka|r
    .home >>Fixe ta pierre de foyer à Rog'mar
    .target 256675
step
    .goto 2548,58.13,45.32
    >>Parle à |cRXP_FRIENDLY_Tan'jani|r
    .turnin 95143 >>Rends À la recherche de Tan'jani
    .target 263190
    .isOnQuest 95143
step
    .goto 2548,58.13,45.32
    >>Parle à |cRXP_FRIENDLY_Tan'jani|r
    .accept 95951 >>Accepte L'art de la lance
    .target 263190
step
    .goto 2548,59.46,47.03
    >>Lis l'|cRXP_PICK_Avis de recherche|r à côté de Neza
    .accept 95992 >>Accepte AVIS DE RECHERCHE : Gueule-Fantôme
    .xp <38,1
step
    .goto 2548,59.37,45.60
    >>Parle à |cRXP_FRIENDLY_Krom'rosh|r
    .turnin 95141 >>Rends Rapport à Rog'mar
    .target 256418
    .isOnQuest 95141
step
    .goto 2548,59.37,45.60
    >>Parle à |cRXP_FRIENDLY_Krom'rosh|r
    .accept 93786 >>Accepte Message ensanglanté
    .accept 93787 >>Accepte Un festin à portée de main
    .target 256418
step
    .goto 2548,60.46,47.86
    >>Parle à |cRXP_FRIENDLY_Neza Flaire-Sang|r
    .accept 96107 >>Accepte Des plumes pour l'empennage
    .target 258031

-- ===== Plaines Sauvages : chaîne de Neza =====
step
    #completewith FinRiviere
    >>Tue |cRXP_ENEMY_Gueule-Fantôme|r s'il passe le long de la rivière et ramasse son |cRXP_LOOT_Croc|r. |cRXP_WARN_Élite 42 : en duo|r
    .complete 95992,1 --Croc de Gueule-Fantôme
    .mob 263380
    .unitscan 263380
    .isOnQuest 95992
step
    .goto 2548,68.15,48.57
    >>Parle à |cRXP_FRIENDLY_Slibo Bekdanlo|r, à l'est de Rog'mar
    .accept 96063 >>Accepte Du gaz en or
    .target 263367
step
    .goto 2548,61.64,58.82
    >>Fouille la |cRXP_PICK_Carcasse nettoyée|r dans les plaines au sud
    .accept 96103 >>Accepte Un festin pour les busards
    .target 263316
step
    #completewith Plumes
    .goto 2548,62.34,58.87,0
    >>Remplis tes fioles aux |cRXP_PICK_Sources d'émanations du marécage|r
    .complete 96063,1 --Fiole d'émanations du marécage (5)
step
    #label Plumes
    .goto 2548,64.70,56.70
    >>Tue les |cRXP_ENEMY_Busards des basses plaines|r pour leurs |cRXP_LOOT_Plumes|r
    .complete 96107,1 --Plume de busard des plaines (6)
    .mob 263343
step
    .goto 2548,62.34,58.87
    >>Finis les |cRXP_PICK_Sources d'émanations du marécage|r
    .complete 96063,1 --Fiole d'émanations du marécage (5)
step
    .goto 2548,68.15,48.57
    >>Retourne voir |cRXP_FRIENDLY_Slibo Bekdanlo|r et aide-le à tester son invention
    .turnin 96063 >>Rends Du gaz en or
    .accept 96067 >>Accepte On se défoule !
    .turnin 96067 >>Rends On se défoule !
    .target 263367
step
    .goto 2548,60.46,47.86
    >>Retourne voir |cRXP_FRIENDLY_Neza Flaire-Sang|r à Rog'mar
    .turnin 96107 >>Rends Des plumes pour l'empennage
    .accept 96108 >>Accepte Flèches empoisonnées
    .turnin 96103 >>Rends Un festin pour les busards
    .accept 96104 >>Accepte Le chant du trotteur
    .target 258031
step
    .goto 2548,62.70,58.40
    >>Tue les |cRXP_ENEMY_Vipères de la clairière|r pour leur |cRXP_LOOT_Venin|r et les |cRXP_ENEMY_Haut-trotteurs en maraude|r pour un |cRXP_LOOT_Bec intact|r
    .complete 96108,1 --Venin de vipère de la clairière (4)
    .complete 96104,1 --Bec de haut-trotteur intact
    .mob 263307
    .mob 263348
step
    .goto 2548,60.46,47.86
    >>Retourne voir |cRXP_FRIENDLY_Neza Flaire-Sang|r
    .turnin 96108 >>Rends Flèches empoisonnées
    .accept 96109 >>Accepte Le carquois d'une chasseuse
    .turnin 96104 >>Rends Le chant du trotteur
    .accept 96105 >>Accepte Le roi des plaines Sauvages
    .target 258031
step
    .goto 2548,59.70,53.60
    >>Tue les |cRXP_ENEMY_Patriarches|r et |cRXP_ENEMY_Chasseresses des plaines sauvages|r pour leurs |cRXP_LOOT_Peaux de lion|r
    .complete 96109,1 --Peau de lion prisée (6)
    .mob 259054
    .mob 259055
step
    .goto 2548,56.83,56.30
    >>Utilise l'|cRXP_LOOT_Appel du haut-trotteur|r : |cRXP_ENEMY_Ombassa|r arrive. Tue-le et prends sa |cRXP_LOOT_Peau|r. |cRXP_WARN_Élite 41 : en duo|r
    .complete 96105,1 --Peau d'Ombassa
    .use 271779
    .mob 263315
step
    .goto 2548,60.46,47.86
    >>Retourne voir |cRXP_FRIENDLY_Neza Flaire-Sang|r
    .turnin 96109 >>Rends Le carquois d'une chasseuse
    .turnin 96105 >>Rends Le roi des plaines Sauvages
    .accept 94532 >>Accepte Infestation gnolle
    .accept 94533 >>Accepte Le groin de Snargl
    .target 258031

-- ===== Sud-ouest : moulin de Turner, Ruissepré, collines Hirsutes =====
step
    .goto 2548,38.79,62.18
    >>Ramasse les |cRXP_PICK_Fagots de bois|r au moulin de Turner, puis utilise-les pour tailler les |cRXP_LOOT_Lances|r
    .complete 95951,1 --Makeshift Stickin' Spear (20)
step
    #completewith Satchels
    .goto 2548,46.20,81.00,0
    >>Tue les |cRXP_ENEMY_Journaliers de Ruissepré|r
    .complete 93786,1 --Journalier de Ruissepré (12)
    .mob 256383
step
    #label Satchels
    .goto 2548,44.96,80.46
    >>Prends les |cRXP_PICK_Sacoches de nourriture|r à la ferme de Ruissepré
    .complete 93787,1 --Sacoche de nourriture (6)
step
    .goto 2548,46.20,81.00
    >>Finis les |cRXP_ENEMY_Journaliers de Ruissepré|r
    .complete 93786,1 --Journalier de Ruissepré (12)
    .mob 256383
step
    .goto 2548,30.21,69.07
    >>Parle à |cRXP_FRIENDLY_Gélinda Resplencuivre|r, au sud des collines Hirsutes
    .accept 95934 >>Accepte Preuve profitable
    .target 262399
step
    .goto 2548,28.50,64.70
    >>Tue les gnolls |cRXP_ENEMY_Carmines|r des collines Hirsutes
    .complete 94532,1 --Mystique des Carmines (8)
    .complete 94532,2 --Trappeur des Carmines (8)
    .complete 94532,3 --Brute des Carmines (6)
    .mob 255770
    .mob 255772
    .mob 255769
step
    .goto 2548,16.04,69.25
    >>Tue |cRXP_ENEMY_Snargl|r, à l'ouest des collines, et prends son |cRXP_LOOT_Groin|r. |cRXP_WARN_Élite 40 : en duo|r
    .complete 94533,1 --Groin de Snargl
    .mob 255906
step
    .goto 2548,30.10,73.30
    >>Ramasse la |cRXP_PICK_Draconite cubique|r. |cRXP_WARN_Scaldaron, rare élite 43, garde l'endroit : si vous le tuez, sa tête lance Glorieux dracocide|r
    .complete 95934,1 --Draconite cubique
    .unitscan 263141
step
    #completewith next
    >>Si vous avez tué |cRXP_ENEMY_Scaldaron|r, utilise la |cRXP_LOOT_Tête de Scaldaron|r pour lancer la quête
    .collect 271613,1,95936,1
    .accept 95936 >>Accepte Glorieux dracocide
    .use 271613
    .isQuestAvailable 95936
step
    .goto 2548,30.21,69.07
    >>Retourne voir |cRXP_FRIENDLY_Gélinda Resplencuivre|r
    .turnin 95934 >>Rends Preuve profitable
    .target 262399

-- ===== Rog'mar : rendus =====
step
    .goto 2548,60.46,47.86
    >>Retourne à Rog'mar (pierre de foyer si besoin) et parle à |cRXP_FRIENDLY_Neza Flaire-Sang|r
    .turnin 94532 >>Rends Infestation gnolle
    .turnin 94533 >>Rends Le groin de Snargl
    .target 258031
step
    .goto 2548,58.13,45.32
    >>Parle à |cRXP_FRIENDLY_Tan'jani|r
    .turnin 95951 >>Rends L'art de la lance
    .accept 95955 >>Accepte Brochettes de crocilisque
    .target 263190
step
    .goto 2548,59.37,45.60
    >>Parle à |cRXP_FRIENDLY_Krom'rosh|r
    .turnin 93786 >>Rends Message ensanglanté
    .turnin 93787 >>Rends Un festin à portée de main
    .accept 94483 >>Accepte On va leur montrer
    .accept 94480 >>Accepte Un cadeau de nos adversaires
    .target 256418
step
    .goto 2548,59.37,45.60
    >>Rends la tête de Scaldaron à |cRXP_FRIENDLY_Krom'rosh|r
    .turnin 95936 >>Rends Glorieux dracocide
    .target 256418
    .isOnQuest 95936
step
    .goto 2548,58.65,44.57
    >>Parle à |cRXP_FRIENDLY_Gorg|r, le cuisinier
    .turnin 94480 >>Rends Un cadeau de nos adversaires
    .accept 94481 >>Accepte Une bonne part de force
    .target 256655
step
    .goto 2548,59.90,37.30
    >>Utilise le |cRXP_LOOT_Ragoût copieux|r sur les |cRXP_FRIENDLY_Recrues de Rog'mar|r au terrain d'entraînement, au nord
    .complete 94481,1 --Recrue de Rog'mar (8)
    .use 265066
    .target 256749
step
    .goto 2548,58.65,44.57
    >>Retourne voir |cRXP_FRIENDLY_Gorg|r
    .turnin 94481 >>Rends Une bonne part de force
    .target 256655

-- ===== Rivière et Fort-Lointain =====
step
    .goto 2548,52.20,57.30
    >>Utilise les |cRXP_LOOT_Lances|r sur les |cRXP_ENEMY_Crocilisques d'eau douce|r le long de la rivière
    .complete 95955,1 --Crocilisque d'eau douce (10)
    .use 271639
    .mob 259046
step
    #label FinRiviere
    .goto 2548,48.30,67.50
    >>Au sud de la rivière, tue les |cRXP_ENEMY_Prêtres|r et les |cRXP_ENEMY_Eclaireurs de Fort-Lointain|r
    .complete 94483,1 --Prêtre de Fort-Lointain (8)
    .complete 94483,2 --Eclaireur de Fort-Lointain (12)
    .mob 270667
    .mob 257926
step
    .goto 2548,58.13,45.32
    >>Retourne voir |cRXP_FRIENDLY_Tan'jani|r à Rog'mar
    .turnin 95955 >>Rends Brochettes de crocilisque
    .turnin -95992 >>Rends AVIS DE RECHERCHE : Gueule-Fantôme
    .target 263190
step
    .goto 2548,59.37,45.60
    >>Parle à |cRXP_FRIENDLY_Krom'rosh|r
    .turnin 94483 >>Rends On va leur montrer
    .target 256418
step
    .goto 2548,59.51,43.96
    >>Parle à |cRXP_FRIENDLY_Tran'gul|r
    .accept 94672 >>Accepte L'approche du Crépuscule
    .accept 94680 >>Accepte Missives du Crépuscule
    .target 256710

-- ===== Clairsoleil et ses grottes =====
step
    .goto 2548,48.70,48.40
    >>À Clairsoleil, tue les |cRXP_ENEMY_Ecumeuses|r et |cRXP_ENEMY_Néophytes du Crépuscule|r. Les |cRXP_ENEMY_Ténébromanciens|r portent les |cRXP_LOOT_Missives|r
    .complete 94672,1 --Ecumeuse du Crépuscule (8)
    .complete 94672,2
    .complete 94672,3 --Néophyte du Crépuscule (8)
    .complete 94680,1 --Missive du Crépuscule (3)
    .mob 256952
    .mob 256798
    .mob 254560
step
    .goto 2548,59.51,43.96
    >>Retourne voir |cRXP_FRIENDLY_Tran'gul|r à Rog'mar
    .turnin 94672 >>Rends L'approche du Crépuscule
    .turnin 94680 >>Rends Missives du Crépuscule
    .accept 94727 >>Accepte Une mine de réponses
    .target 256710
step
    .goto 2548,49.95,46.99
    >>Parle à |cRXP_FRIENDLY_Frappe-orteils|r, le mineur ogre de Clairsoleil
    .turnin 94727 >>Rends Une mine de réponses
    .accept 95417 >>Accepte Les qui sont violets
    .accept 95602 >>Accepte La lumière qui fait malade
    .target 260931
step
    .goto 2548,49.18,46.74
    >>Entre dans les grottes et parle à la |cRXP_FRIENDLY_Brute du Crépuscule|r
    .turnin 95417 >>Rends Les qui sont violets
    .accept 95601 >>Accepte Les qui sont violets
    .target 261208
step
    .goto 2548,48.80,49.50
    >>Dans les grottes, tue les |cRXP_ENEMY_Brutes surpuissantes|r et les |cRXP_ENEMY_Ritualistes du Crépuscule|r, et détruis les |cRXP_PICK_Cercles rituels du Crépuscule|r
    .complete 95601,1 --Brute surpuissante (5)
    .complete 95601,2 --Ritualiste du Crépuscule (10)
    .complete 95602,1 --Cercle rituel du Crépuscule (5)
    .mob 261711
    .mob 262169
step
    .goto 2548,49.95,46.99
    >>Retourne voir |cRXP_FRIENDLY_Frappe-orteils|r
    .turnin 95601 >>Rends Les qui sont violets
    .turnin 95602 >>Rends La lumière qui fait malade
    .accept 95427 >>Accepte Crépuscule être nul
    .target 260931
step
    .goto 2548,45.03,48.68
    >>Au fond des grottes, tue |cRXP_ENEMY_Chogg'Zac|r et prends ses deux têtes. |cRXP_WARN_Élite 41 : en duo|r
    .complete 95427,1 --Tête de Chogg
    .complete 95427,2 --Tête de Zac
    .mob 256899
step
    .goto 2548,49.95,46.99
    >>Retourne voir |cRXP_FRIENDLY_Frappe-orteils|r
    .turnin 95427 >>Rends Crépuscule être nul
    .accept 95418 >>Accepte Répandre la nouvelle
    .target 260931
step
    .goto 2548,59.51,43.96
    >>Retourne voir |cRXP_FRIENDLY_Tran'gul|r à Rog'mar
    .turnin 95418 >>Rends Répandre la nouvelle
    .accept 95420 >>Accepte La terre des géants
    .target 256710
step
    .goto 2548,59.60,47.01
    >>Lis l'autre |cRXP_PICK_Avis de recherche|r à côté de Neza
    .accept 95882 >>Accepte AVIS DE RECHERCHE : maître-éclaireur Vargas
    .xp <38,1

-- ===== Bolder'ok =====
step
    #completewith Clugfist
    .goto 2548,64.25,15.72,40 >>Va au nord jusqu'à Bolder'ok, la cité ogre
step
    #label Clugfist
    .goto 2548,64.25,15.72
    >>Parle à |cRXP_FRIENDLY_Poing-Serré|r
    .turnin 95420 >>Rends La terre des géants
    .accept 95424 >>Accepte La raison du plus fort…
    .accept 95425 >>Accepte Pas champion de personne
    .target 255829
step
    .goto 2548,67.24,21.75
    >>Parle à |cRXP_FRIENDLY_Hamur|r
    .accept 95183 >>Accepte Première étape : pierre
    .target 263440
    .xp <38,1
step
    .goto 2548,70.73,28.09
    >>Parle à |cRXP_FRIENDLY_Na'zok|r, à sa ferme au sud-est de Bolder'ok
    .accept 95163 >>Accepte Grand rabattage
    .target 256728
    .xp <38,1
step
    #completewith Vargas
    >>Utilise le |cRXP_LOOT_Bâton du porcher|r sur les |cRXP_ENEMY_Jeunes brochepâles|r et ramène-les à la ferme de Na'zok
    .complete 95163,1 --Jeune brochepâle (10)
    .use 268521
    .mob 258331
    .isOnQuest 95163
step
    #completewith Vargas
    >>Ramasse les |cRXP_PICK_Tas de pierres|r
    .complete 95183,1 --Bonne pierre (10)
    .isOnQuest 95183
step
    .goto 2548,75.20,30.40
    >>Tue les |cRXP_ENEMY_Marteleurs|r et les |cRXP_ENEMY_Mandefeux du Crépuscule|r
    .complete 95424,1 --Marteleur du Crépuscule (7)
    .complete 95424,2 --Mandefeu du Crépuscule (7)
    .mob 260968
    .mob 261497
step
    .goto 2548,72.43,26.74
    >>Tue |cRXP_ENEMY_Clank|r et prends l'|cRXP_LOOT_Éclate-crâne|r
    .complete 95425,1 --Éclate-crâne
    .mob 260973
step
    #label Vargas
    .goto 2548,72.81,32.63
    >>Tue le |cRXP_ENEMY_Maître-éclaireur Vargas|r et prends son |cRXP_LOOT_Œil|r. |cRXP_WARN_Élite 42 : en duo|r
    .complete 95882,1 --Œil du maître-éclaireur
    .mob 260211
    .isOnQuest 95882
step
    .goto 2548,68.40,29.10
    >>Finis les |cRXP_PICK_Tas de pierres|r
    .complete 95183,1 --Bonne pierre (10)
    .isOnQuest 95183
step
    .goto 2548,70.73,28.09
    >>Ramène les derniers |cRXP_ENEMY_Jeunes brochepâles|r et parle à |cRXP_FRIENDLY_Na'zok|r
    .complete 95163,1 --Jeune brochepâle (10)
    .turnin 95163 >>Rends Grand rabattage
    .use 268521
    .target 256728
    .isOnQuest 95163
step
    .goto 2548,73.35,24.76
    >>Parle à |cRXP_FRIENDLY_Jom-jom|r pour lancer l'escorte
    .accept 94556 >>Accepte La fuite de Jom-jom
    .target 258048
step
    .goto 2548,64.25,15.72
    >>Escorte |cRXP_FRIENDLY_Jom-jom|r jusqu'à Poing-Serré (tue ce qui l'attaque), puis parle à |cRXP_FRIENDLY_Poing-Serré|r
    .turnin 94556 >>Rends La fuite de Jom-jom
    .turnin 95424 >>Rends La raison du plus fort…
    .turnin 95425 >>Rends Pas champion de personne
    .accept 94668 >>Accepte Arène du maître du sang
    .accept 95428 >>Accepte Le décret de Poing-Serré
    .target 255829
step
    .goto 2548,67.24,21.75
    >>Parle à |cRXP_FRIENDLY_Hamur|r
    .turnin 95183 >>Rends Première étape : pierre
    .target 263440
    .isOnQuest 95183

-- ===== Bolder'ok : arène du maître du sang =====
step
    .goto 2548,65.58,21.45
    >>Parle à |cRXP_FRIENDLY_Jezap Clicabrac|r et paie l'inscription. |cRXP_WARN_Les combats peuvent être en solo : si ton duo ne peut pas entrer, chacun fait les siens|r
    .turnin 94668 >>Rends Arène du maître du sang
    .accept 94669 >>Accepte Frais de participation
    .turnin 94669 >>Rends Frais de participation
    .accept 94670 >>Accepte Arène du maître du sang
    .target 257062
step
    .goto 2548,65.58,21.45
    >>Bats |cRXP_ENEMY_Buzzbeak|r dans l'arène, puis parle à |cRXP_FRIENDLY_Jezap|r
    .turnin 94670 >>Rends Arène du maître du sang
    .accept 94739 >>Accepte Arène du maître du sang
    .target 257062
step
    .goto 2548,65.58,21.45
    >>Bats |cRXP_ENEMY_Kronk|r, puis parle à |cRXP_FRIENDLY_Jezap|r
    .turnin 94739 >>Rends Arène du maître du sang
    .accept 94962 >>Accepte Arène du maître du sang
    .target 257062
step
    .goto 2548,65.58,21.45
    >>Bats |cRXP_ENEMY_Bonegnaw|r, puis parle à |cRXP_FRIENDLY_Jezap|r
    .turnin 94962 >>Rends Arène du maître du sang
    .accept 94964 >>Accepte Arène du maître du sang
    .target 257062
step
    .goto 2548,65.58,21.45
    >>Bats |cRXP_ENEMY_Mog'thar|r, puis parle à |cRXP_FRIENDLY_Jezap|r
    .turnin 94964 >>Rends Arène du maître du sang
    .accept 94733 >>Accepte Notre ami ogre
    .target 257062
step
    .goto 2548,67.00,17.18
    >>Parle à |cRXP_FRIENDLY_Fé'bam|r
    .turnin 94733 >>Rends Notre ami ogre
    .accept 94734 >>Accepte Une friandise pour sanglier
    .target 257058
step
    .goto 2548,78.92,37.08
    >>Cueille les |cRXP_PICK_Baies fraîchement cueillies|r à l'est
    .complete 94734,1 --Doucebaie (8)
step
    .goto 2548,60.40,38.00
    >>Ramasse l'|cRXP_PICK_Algue de rivière|r sur la rivière au nord de Rog'mar
    .complete 94734,2 --Algue de rivière (12)
step
    .goto 2548,67.00,17.18
    >>Retourne voir |cRXP_FRIENDLY_Fé'bam|r
    .turnin 94734 >>Rends Une friandise pour sanglier
    .accept 94737 >>Accepte Une friandise pour un ami
    .target 257058
step
    .goto 2548,65.58,21.45
    >>Parle à |cRXP_FRIENDLY_Jezap Clicabrac|r
    .turnin 94737 >>Rends Une friandise pour un ami
    .accept 94965 >>Accepte Arène du maître du sang
    .target 257062
step
    .goto 2548,65.58,21.45
    >>Bats |cRXP_ENEMY_Snufflesnout|r, puis parle à |cRXP_FRIENDLY_Jezap|r
    .turnin 94965 >>Rends Arène du maître du sang
    .accept 95063 >>Accepte Arène du maître du sang
    .target 257062
step
    .goto 2548,64.25,15.72
    >>Bats |cRXP_ENEMY_Chub'chob|r, maître du sang de Bolder'ok, puis annonce ta victoire à |cRXP_FRIENDLY_Poing-Serré|r
    .turnin 95063 >>Rends Arène du maître du sang
    .target 255829

-- ===== Rog'mar : rendus du nord =====
step
    .goto 2548,60.46,47.86
    >>Pierre de foyer ou vol vers Rog'mar. Parle à |cRXP_FRIENDLY_Neza Flaire-Sang|r
    .turnin 95882 >>Rends AVIS DE RECHERCHE : maître-éclaireur Vargas
    .target 258031
    .isOnQuest 95882
step
    .goto 2548,59.37,45.60
    >>Parle à |cRXP_FRIENDLY_Krom'rosh|r
    .turnin 95428 >>Rends Le décret de Poing-Serré
    .target 256418
step
    .goto 2548,59.37,45.60
    >>Parle à |cRXP_FRIENDLY_Krom'rosh|r
    .accept 94744 >>Accepte Le guerrier téméraire
    .target 256418
    .xp <38,1

-- ===== Port gobelin et côte est =====
step
    .goto 2548,77.10,52.90
    >>Va au port gobelin, à l'est de Rog'mar. Parle à |cRXP_FRIENDLY_Friz Faiblétincelle|r
    .accept 95288 >>Accepte Le paradis de la contrebande
    .target 255897
    .xp <38,1
step
    .goto 2548,77.10,52.90
    >>Parle à |cRXP_FRIENDLY_Friz Faiblétincelle|r
    .accept 95062 >>Accepte La caisse de Faiblétincelle
    .target 255897
step
    .goto 2548,78.49,53.94
    >>Lis l'|cRXP_PICK_AVIS DE RECHERCHE|r du port
    .accept 95120 >>Accepte AVIS DE RECHERCHE : Vieil Appât-Pourri
    .accept 95254 >>Accepte AVIS DE RECHERCHE : Traquepince
step
    .goto 2548,79.45,52.71
    >>Donne le colis de Strangleronce au |cRXP_FRIENDLY_Maître des quais Sifflebruit|r
    .turnin 97332 >>Rends Une confiance deux fois mal placée
    .target 259961
    .isOnQuest 97332
step
    .goto 2548,79.45,52.71
    >>Parle au |cRXP_FRIENDLY_Maître des quais Sifflebruit|r
    .accept 95118 >>Accepte Sauvagerie en haute mer
    .accept 95119 >>Accepte Concurrence déloyale
    .target 259961
    .xp <38,1
step
    .goto 2548,77.78,52.68
    >>Tue |cRXP_ENEMY_Traquepince|r près du port et prends sa |cRXP_LOOT_Pince|r
    .complete 95254,1 --Pince de Traquepince
    .mob 260235
step
    .goto 2548,73.50,69.80
    >>Au sud, tue les |cRXP_ENEMY_Guerriers|r et les |cRXP_ENEMY_Oracles murlocs|r du rivage
    .complete 95118,1 --Guerrier murloc (8)
    .complete 95118,2 --Oracle murloc (8)
    .mob 256801
    .mob 255898
step
    .goto 2548,74.58,71.88
    >>Tue le |cRXP_ENEMY_Vieil Appât-Pourri|r et prends son |cRXP_LOOT_Harpon|r. |cRXP_WARN_Élite 42 : en duo|r
    .complete 95120,1 --Harpon couvert de pourriture
    .mob 257001
step
    .goto 2548,79.45,52.71
    >>Retourne au port. Parle au |cRXP_FRIENDLY_Maître des quais Sifflebruit|r
    .turnin 95118 >>Rends Sauvagerie en haute mer
    .turnin 95120 >>Rends AVIS DE RECHERCHE : Vieil Appât-Pourri
    .target 259961
step
    .goto 2548,79.02,54.20
    >>Parle à |cRXP_FRIENDLY_Fimbo Lubrimitz|r
    .turnin 95254 >>Rends AVIS DE RECHERCHE : Traquepince
    .target 259962
step
    .goto 2548,86.70,37.00
    >>Au nord du port, tue les |cRXP_ENEMY_Boucaniers|r et les |cRXP_ENEMY_Mousquetaires des mers de l'Est|r. Ils portent les |cRXP_LOOT_Marchandises de contrebande|r
    .complete 95119,1 --Boucanier des mers de l'Est (10)
    .complete 95119,2 --Mousquetaire des mers de l'Est (10)
    .complete 95288,1 --Marchandises de contrebande (8)
    .mob 257901
    .mob 257910
    .isOnQuest 95119
step
    .goto 2548,79.45,52.71
    >>Retourne au port. Parle au |cRXP_FRIENDLY_Maître des quais Sifflebruit|r
    .turnin 95119 >>Rends Concurrence déloyale
    .accept 95122 >>Accepte Croissance incontrôlée
    .accept 95123 >>Accepte Et boum, chiens galeux !
    .target 259961
    .isOnQuest 95119
step
    .goto 2548,77.10,52.90
    >>Parle à |cRXP_FRIENDLY_Friz Faiblétincelle|r
    .turnin 95288 >>Rends Le paradis de la contrebande
    .accept 95293 >>Accepte Contrebande surprise
    .target 255897
    .isOnQuest 95288
step
    .goto 2548,78.90,34.80
    >>Au nord, prends les |cRXP_PICK_Barils de poudre|r et tue les |cRXP_ENEMY_Ecumeuses|r et les |cRXP_ENEMY_Bombardières des mers de l'Est|r
    .complete 95123,1 --Baril de poudre des mers de l'Est (5)
    .complete 95122,1 --Ecumeuse des mers de l'Est (8)
    .complete 95122,2 --Bombardière des mers de l'Est (8)
    .mob 257915
    .mob 257916
    .isOnQuest 95122
step
    .goto 2548,91.26,39.72
    >>Va voir le |cRXP_FRIENDLY_Capitaine Courbepièce|r sur la côte, puis le |cRXP_FRIENDLY_Capitaine Haynes|r juste à côté
    .turnin 95293 >>Rends Contrebande surprise
    .accept 95294 >>Accepte Une aubaine de contrebande
    .target 260390
    .target 260391
    .isOnQuest 95293
step
    .goto 2548,79.45,52.71
    >>Retourne au port. Parle au |cRXP_FRIENDLY_Maître des quais Sifflebruit|r
    .turnin 95122 >>Rends Croissance incontrôlée
    .turnin 95123 >>Rends Et boum, chiens galeux !
    .accept 95124 >>Accepte Amiral Lamora
    .accept 95165 >>Accepte À plus, olibrius !
    .target 259961
    .isOnQuest 95123
step
    .goto 2548,77.10,52.90
    >>Parle à |cRXP_FRIENDLY_Friz Faiblétincelle|r
    .turnin 95294 >>Rends Une aubaine de contrebande
    .target 255897
    .isOnQuest 95294
step
    .goto 2548,88.03,29.09
    >>Au nord-est, pose une |cRXP_LOOT_Charge explosive|r sur chacun des trois bateaux des mers de l'Est. Tue l'|cRXP_ENEMY_Amiral Lamora|r et ouvre le |cRXP_PICK_Coffre au trésor de l'amiral|r (90.5,29.3)
    .complete 95165,1 --Charges posées (3)
    .complete 95124,1 --Amiral Lamora
    .complete 95124,2 --Butin de Lamora
    .use 268505
    .mob 257861
    .isOnQuest 95124
step
    .goto 2548,79.45,52.71
    >>Retourne au port. Parle au |cRXP_FRIENDLY_Maître des quais Sifflebruit|r
    .turnin 95124 >>Rends Amiral Lamora
    .turnin 95165 >>Rends À plus, olibrius !
    .target 259961
    .isOnQuest 95124

-- ===== Ouest : Da'grosh (niveau 42+ conseillé) =====
step
    .goto 2548,59.37,45.60
    >>Vole vers Rog'mar et donne la caisse à |cRXP_FRIENDLY_Krom'rosh|r
    .turnin 95062 >>Rends La caisse de Faiblétincelle
    .target 256418
    .isOnQuest 95062
step
    .goto 2548,33.47,37.93
    >>Vole vers Rog'mar, puis va à l'ouest voir |cRXP_FRIENDLY_Da'grosh|r dans les collines
    .turnin 94744 >>Rends Le guerrier téméraire
    .accept 94745 >>Accepte Tracer un chemin
    .accept 94748 >>Accepte Briser leurs chaînes
    .accept 95431 >>Accepte La grogne gagne
    .target 258570
    .isOnQuest 94744
step
    .goto 2548,27.66,36.54
    >>Dans la grotte voisine, parle à |cRXP_FRIENDLY_Crag'rog|r
    .turnin 95431 >>Rends La grogne gagne
    .accept 95432 >>Accepte Soulèvement !
    .target 260993
    .isOnQuest 95431
step
    .goto 2548,26.50,35.54
    >>Parle aux |cRXP_FRIENDLY_Mineurs ogres|r de la grotte pour les recruter
    .complete 95432,1 --Mineur ogre recruté (5)
    .target 260995
    .isOnQuest 95432
step
    .goto 2548,27.66,36.54
    >>Retourne voir |cRXP_FRIENDLY_Crag'rog|r
    .turnin 95432 >>Rends Soulèvement !
    .target 260993
    .isOnQuest 95432
step
    .goto 2548,29.50,42.90
    >>Dans le Voile du Crépuscule, tue les |cRXP_ENEMY_Fanatiques|r, |cRXP_ENEMY_Corruptrices|r et |cRXP_ENEMY_Champions du Crépuscule|r, et libère les |cRXP_FRIENDLY_Eclaireuses de Rog'mar|r
    .complete 94745,1 --Fanatique du Crépuscule (8)
    .complete 94745,2 --Corruptrice du Crépuscule (8)
    .complete 94745,3 --Champion du Crépuscule (8)
    .complete 94748,1 --Eclaireuse de Rog'mar (5)
    .mob 256795
    .mob 256797
    .mob 256799
    .target 257450
    .isOnQuest 94745
step
    .goto 2548,33.47,37.93
    >>Retourne voir |cRXP_FRIENDLY_Da'grosh|r
    .turnin 94745 >>Rends Tracer un chemin
    .turnin 94748 >>Rends Briser leurs chaînes
    .target 258570
    .isOnQuest 94745
step
    .goto 2548,33.47,37.93
    >>Parle à |cRXP_FRIENDLY_Da'grosh|r
    .accept 94768 >>Accepte Ramenez-moi sa tête
    .target 258570
    .isQuestTurnedIn 94745
    .xp <44,1
step
    .goto 2548,24.95,42.41
    >>Tue le |cRXP_ENEMY_Suzerain Kilgar|r et prends sa |cRXP_LOOT_Tête|r. |cRXP_WARN_Élite 46 : en duo, et seulement si vous êtes 44 ou plus|r
    .complete 94768,1 --Tête de Kilgar
    .mob 256881
    .isOnQuest 94768
step
    .goto 2548,33.47,37.93
    >>Retourne voir |cRXP_FRIENDLY_Da'grosh|r
    .turnin 94768 >>Rends Ramenez-moi sa tête
    .accept 95278 >>Accepte L'heure est venue, mon frère
    .target 258570
    .isOnQuest 94768
step
    .goto 2548,59.37,45.60
    >>Rentre à Rog'mar et parle à |cRXP_FRIENDLY_Krom'rosh|r
    .turnin 95278 >>Rends L'heure est venue, mon frère
    .target 256418
    .isOnQuest 95278
step
    #label FinRivesClaires
    +|cRXP_WARN_Fin de la route FDP pour l'instant (niveau 45 environ). En dessous, finis les quêtes coupées ou fais un donjon|r. Coche pour terminer
]])

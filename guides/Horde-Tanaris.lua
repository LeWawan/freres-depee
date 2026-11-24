if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Tanaris, Horde, toutes classes, premier passage (44-50).
-- Indépendant des autres régions : les quêtes venues d'ailleurs (243 d'Undercity, 2872 de
-- Baie-du-Butin) sont protégées par .isOnQuest / .isQuestTurnedIn.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua et xpDB-traces.lua
-- (95753, 97530, 97534). Taux de drop wowheadData : outres 8483 ~50 %, morceaux d'insecte
-- 8587 ~38 %, glande de rosée 8428 ~12 %, chapeaux 20519 ~32 %, tête de Barbe-en-feu 9246
-- ~75 %. Bracelet 278186 sans taux : 35 % supposés. Horaires 9250 et balise 8623 sans
-- source de drop fiable : étapes opportunistes.
-- Itinéraire : Gadgetzan -> mare du guet de Tristesable (992) -> Gadgetzan -> camp
-- Bat-le-désert nord (1690) -> Gadgetzan -> camp sud (1691, Caliph) -> port gobelin -> crique
-- des pirates -> port -> Gadgetzan -> totems et Repaire nuisible -> vallée des Chardonniers
-- -> base des Cognedunes -> pierre de foyer Gadgetzan -> Gouffre béant (Scrimshank, robot)
-- -> Gadgetzan -> port gobelin (fin).
-- Sortante : 32 L'ascension des silithides se rend à Orgrimmar (Zilzibin Drumlore).
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   8365 Ohé, des chapeaux de pirate ! (20 chapeaux à ~32 % = ~125 kills), 2874 Livraison à
--   MacKinley et 648 À la rescousse de OOX-17/TN (rendus à Baie-du-Butin, autre continent),
--   2641, 2661, 2662 (Tragan violet dans les Hinterlands, autre continent), 3161 Gahz'ridian
--   (30 ornements à déterrer chacun, lent), 1560 La quête de Tooga et 97540 L'oasis
--   (escorte lente d'une tortue à travers tout le désert), 3520 Esprits de Hurleurs
--   (objectif en Féralas), 654, 841 et 864 (suite de 243 : kit à minuterie, rendu à
--   Undercity, 841 répétable), 1878 (répétable), 2882 L'or de Cuergo (pas d'XP, carte
--   aléatoire), 95144 Livraison transocéanique (envoi vers les Rives Claires, 285 xp),
--   95296, 95383, 95312, 95321, 95472 (chaîne de Tazzik, coupée aux Rives Claires),
--   97536, 3022, 162 (Alliance), 2954 Le Gardien des pierres (prérequis d'Uldaman),
--   deuxième passage : 3444, 4496, 4504, 4507, 4508, 4509, 5801, 5802, 8182,
--   2741, 2747, 2748, 2749 (niveau 60) et 2750, 8893 (Super-Oeuf-O-Matic, niveau 47 mais
--   après 2741), 9268 (Combat naval, pas
--   d'XP), 8555-8766 et 8921-8928 (niveau 60), donjon Zul'Farrak : 2768, 2770, 2846,
--   2865, 2936, 3042, 3527, 96770, 96775, 2864 Tran'rek (envoi de Krazek à Baie-du-Butin vers
--   Gadgetzan, prérequis de la quête de donjon 2865).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 45-48 Tanaris
#displayname [FDP] Tanaris (45-48)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 47-49 The Hinterlands

-- ===== Voyage et Gadgetzan =====
step
    #completewith ArriveeGadgetzan
    .goto Tanaris,51.60,25.44,40 >>Va à Gadgetzan, au nord de Tanaris. |cRXP_WARN_Par la route au sud du Désert de sel (Mille pointes), ou en bateau depuis le port gobelin des Rives Claires jusqu'au port au nord-est de Tanaris|r
step
    #label ArriveeGadgetzan
    .goto Tanaris,51.60,25.44
    >>Parle à |cRXP_FRIENDLY_Bulkrek Ragefist|r
    .fp Gadgetzan >>Prends le point de vol de Gadgetzan
    .target 7824
step
    .goto Tanaris,52.51,27.91
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Fizzgrimble|r
    .home >>Fixe ta pierre de foyer à Gadgetzan
    .target 7733
step
    .goto Tanaris,50.21,27.48
    >>Parle au |cRXP_FRIENDLY_Grand Géomètre Fizzledowser|r
    .accept 992 >>Accepte Étude des eaux de Gadgetzan
    .target 7724
step
    .goto Tanaris,51.83,27.04
    >>Lis l'|cRXP_PICK_Affiche de recherche|r
    .accept 2781 >>Accepte ON RECHERCHE : Caliph Dard-de-scorpide
    .accept 2875 >>Accepte ON RECHERCHE : André Barbe-en-feu
step
    .goto Tanaris,51.12,27.88
    >>Parle à |cRXP_FRIENDLY_Quinn|r
    .accept 97534 >>Accepte Dans le cambouis
    .target 11756
step
    .goto Tanaris,52.46,28.51
    >>Parle à l'|cRXP_FRIENDLY_Ingénieur en chef Bilgewhizzle|r
    .turnin 243 >>Rends Sur le terrain
    .target 7407
    .isOnQuest 243
step
    .goto Tanaris,52.46,28.51
    >>Parle à l'|cRXP_FRIENDLY_Ingénieur en chef Bilgewhizzle|r
    .accept 379 >>Accepte Etancher cette soif
    .target 7407
    .isQuestTurnedIn 243
step
    .goto Tanaris,52.46,28.51
    >>Parle à l'|cRXP_FRIENDLY_Ingénieur en chef Bilgewhizzle|r
    .accept 1690 >>Accepte Châtier les Bat-le-désert
    .target 7407
step
    .goto Tanaris,52.49,28.45
    >>Parle à l'|cRXP_FRIENDLY_Opérateur du robinet Luglunket|r
    .accept 1707 >>Accepte Prime de la poche à eau
    .target 7408

-- ===== Objets trouvés en route (toute la zone) =====
step
    #completewith RobotOOX
    >>Si un mob lâche la |cRXP_LOOT_Balise de détresse OOX-17/TN|r, utilise-la pour lancer la quête
    .collect 8623,1,351,1
    .accept 351 >>Accepte Trouver OOX-17/TN !
    .use 8623
step
    #completewith RetourGadgetzan
    >>Ramasse les |cRXP_PICK_Déchets gnomes|r éparpillés autour de Gadgetzan pour les |cRXP_LOOT_Débris du désert|r
    .complete 97534,1 --Débris du désert (7)

-- ===== Mare du guet de Tristesable =====
step
    .goto Tanaris,39.00,29.00
    >>Utilise la |cRXP_LOOT_Fiole de sourcier vide|r au bord de la mare du guet de Tristesable. |cRXP_WARN_Trolls Furie-des-sables élites tout près : ne t'attarde pas|r
    .complete 992,1 --Fiole de sourcier pleine
    .use 8584
step
    .goto Tanaris,50.21,27.48
    >>Retourne voir le |cRXP_FRIENDLY_Grand Géomètre Fizzledowser|r
    .turnin 992 >>Rends Étude des eaux de Gadgetzan
    .accept 82 >>Accepte Enquête au Repaire nuisible
    .target 7724

-- ===== Camp Bat-le-désert =====
step
    #completewith FinBatLeDesert
    >>Ramasse les |cRXP_LOOT_Outres de Bat-le-désert|r sur les Bat-le-désert
    .complete 1707,1 --Outre de Bat-le-désert (5)
step
    .goto Tanaris,63.40,29.80
    >>Tue les |cRXP_ENEMY_Bandits|r et |cRXP_ENEMY_Larrons Bat-le-désert|r à l'est de Gadgetzan
    .complete 1690,1 --Bandit Bat-le-désert
    .complete 1690,2 --Larron Bat-le-désert
    .mob 5618
    .mob 5616
step
    .goto Tanaris,52.46,28.51
    >>Retourne voir l'|cRXP_FRIENDLY_Ingénieur en chef Bilgewhizzle|r
    .turnin 1690 >>Rends Châtier les Bat-le-désert
    .accept 1691 >>Accepte Continuer à châtier les Bat-le-désert
    .target 7407
step
    .goto Tanaris,52.49,28.45
    >>Rends déjà les 5 outres à l'|cRXP_FRIENDLY_Opérateur du robinet Luglunket|r : les deux quêtes comptent les mêmes outres, le drop s'arrête à 5
    .turnin 1707 >>Rends Prime de la poche à eau
    .target 7408
    .isQuestComplete 1707
step
    .goto Tanaris,60.80,37.00
    >>Tue les |cRXP_ENEMY_Voleuses|r, |cRXP_ENEMY_Assassins|r et |cRXP_ENEMY_Mages de l'ombre Bat-le-désert|r, au sud du camp
    .complete 1691,1 --Voleuse Bat-le-désert (8)
    .complete 1691,2 --Assassin Bat-le-désert (6)
    .complete 1691,3 --Mage de l'ombre Bat-le-désert (10)
    .mob 5615
    .mob 5623
    .mob 5617
step
    #label FinBatLeDesert
    .goto Tanaris,61.77,38.17
    >>Tue |cRXP_ENEMY_Caliph Dard-de-scorpide|r et prends sa |cRXP_LOOT_Tête|r
    .complete 2781,1 --Tête de Caliph Dard-de-scorpide
    .mob 7847
step
    .goto Tanaris,61.30,36.00
    >>Finis les |cRXP_LOOT_Outres de Bat-le-désert|r si besoin
    .complete 1707,1 --Outre de Bat-le-désert (5)
    .mob 5615
    .mob 5617
    .mob 5623
step
    .goto Tanaris,61.30,36.00
    >>Ramasse 5 |cRXP_LOOT_Outres|r pour Etancher cette soif. |cRXP_WARN_Si Prime de la poche à eau n'est pas encore rendue, rends-la d'abord : les deux quêtes comptent les mêmes outres|r
    .complete 379,1 --Outre de Bat-le-désert (5)
    .mob 5615
    .mob 5617
    .mob 5623
    .isOnQuest 379

-- ===== Port gobelin et crique des pirates =====
step
    .goto Tanaris,67.06,23.89
    >>Va au port gobelin au nord-est et parle au |cRXP_FRIENDLY_Chef de la sécurité Bilgewhizzle|r
    .accept 8366 >>Accepte Le racket des Mers du sud
    .accept 97530 >>Accepte Collecte chez les Cognedunes
    .target 7882
step
    .goto Tanaris,67.11,23.98
    >>Parle à |cRXP_FRIENDLY_Stoley|r
    .turnin 2872 >>Rends Les dettes de Stoley
    .target 7881
    .isOnQuest 2872
step
    .goto Tanaris,67.11,23.98
    >>Parle à |cRXP_FRIENDLY_Stoley|r
    .accept 2873 >>Accepte Chargement de Stoley
    .target 7881
step
    #completewith FinCrique
    >>Si un pirate lâche les |cRXP_LOOT_Horaires du navire|r, utilise-les pour lancer la quête
    .collect 9250,1,2876,1
    .accept 2876 >>Accepte Horaires des bateaux
    .use 9250
step
    #completewith FinCrique
    >>Tue les pirates des |cRXP_ENEMY_Mers du sud|r dans la crique
    .complete 8366,1 --Pirate des Mers du sud (10)
    .complete 8366,2 --Flibustier des Mers du sud (10)
    .complete 8366,3 --Portefaix des Mers du sud (10)
    .complete 8366,4 --Bretteur des Mers du sud (10)
step
    .goto Tanaris,72.15,46.80
    >>Prends la |cRXP_PICK_Cargaison volée|r sur le quai de la crique
    .complete 2873,1 --Chargement de Stoley
step
    .goto Tanaris,73.37,47.14
    >>Tue |cRXP_ENEMY_André Barbe-en-feu|r et prends sa |cRXP_LOOT_Tête|r
    .complete 2875,1 --Tête de Barbe-en-feu
    .mob 7883
step
    #label FinCrique
    .goto Tanaris,73.00,46.00
    >>Finis les pirates des |cRXP_ENEMY_Mers du sud|r
    .complete 8366,1 --Pirate des Mers du sud (10)
    .complete 8366,2 --Flibustier des Mers du sud (10)
    .complete 8366,3 --Portefaix des Mers du sud (10)
    .complete 8366,4 --Bretteur des Mers du sud (10)
    .mob 7855
    .mob 7856
    .mob 7857
    .mob 7858
step
    .goto Tanaris,67.06,23.89
    >>Retourne au port voir le |cRXP_FRIENDLY_Chef de la sécurité Bilgewhizzle|r
    .turnin 8366 >>Rends Le racket des Mers du sud
    .turnin 2875 >>Rends ON RECHERCHE : André Barbe-en-feu
    .target 7882
step
    .goto Tanaris,67.06,23.89
    >>Parle au |cRXP_FRIENDLY_Chef de la sécurité Bilgewhizzle|r
    .turnin 2876 >>Rends Horaires des bateaux
    .target 7882
    .isOnQuest 2876
step
    .goto Tanaris,67.11,23.98
    >>Parle à |cRXP_FRIENDLY_Stoley|r. |cRXP_WARN_N'accepte pas Livraison à MacKinley (Baie-du-Butin)|r
    .turnin 2873 >>Rends Chargement de Stoley
    .target 7881

-- ===== Retour à Gadgetzan =====
step
    #label RetourGadgetzan
    .goto Tanaris,55.00,27.00
    >>Finis les |cRXP_PICK_Déchets gnomes|r en rentrant à Gadgetzan
    .complete 97534,1 --Débris du désert (7)
step
    .goto Tanaris,51.12,27.88
    >>Parle à |cRXP_FRIENDLY_Quinn|r
    .turnin 97534 >>Rends Dans le cambouis
    .target 11756
step
    .goto Tanaris,52.46,28.51
    >>Parle à l'|cRXP_FRIENDLY_Ingénieur en chef Bilgewhizzle|r
    .turnin 1691 >>Rends Continuer à châtier les Bat-le-désert
    .turnin 2781 >>Rends ON RECHERCHE : Caliph Dard-de-scorpide
    .target 7407
step
    .goto Tanaris,52.46,28.51
    >>Parle à l'|cRXP_FRIENDLY_Ingénieur en chef Bilgewhizzle|r. |cRXP_WARN_Ne prends pas la suite (minuterie, rendu à Undercity)|r
    .turnin 379 >>Rends Etancher cette soif
    .target 7407
    .isOnQuest 379
step
    .goto Tanaris,52.49,28.45
    >>Parle à l'|cRXP_FRIENDLY_Opérateur du robinet Luglunket|r
    .turnin 1707 >>Rends Prime de la poche à eau
    .target 7408
    .isOnQuest 1707
step
    .goto Tanaris,52.82,27.40
    >>Parle à |cRXP_FRIENDLY_Andi Lynn|r
    .accept 5863 >>Accepte La base des Cognedunes
    .target 11758
step
    .goto Tanaris,51.57,26.76
    >>Parle à |cRXP_FRIENDLY_Tran'rek|r
    .accept 3362 >>Accepte La vallée des Chardonniers
    .target 7876
step
    .goto Tanaris,51.81,28.66
    >>Parle à |cRXP_FRIENDLY_Marin Noggenfogger|r
    .accept 2605 >>Accepte Le gobelin assoiffé
    .target 7564

-- ===== Totems, Repaire nuisible =====
step
    .goto Tanaris,42.99,41.29
    >>Au sud-ouest de Gadgetzan, parle au |cRXP_FRIENDLY_Totem étrange|r au pied du grand squelette
    .accept 95753 >>Accepte Le défi du loup du désert
    .target 222856
step
    .goto Tanaris,45.75,37.73
    >>Cours le long du squelette jusqu'à l'autre |cRXP_FRIENDLY_Totem étrange|r avant la fin du temps
    .turnin 95753 >>Rends Le défi du loup du désert
    .target 222857
step
    .goto Tanaris,33.40,44.70
    >>Dans le Repaire nuisible, tue les |cRXP_ENEMY_Centipaar|r pour leurs |cRXP_LOOT_Morceaux d'insecte|r. |cRXP_WARN_Chacun doit looter les siens (~26 kills en duo sur ces trois types, 38 %)|r
    .complete 82,1 --Morceaux d'insecte Centipaar (5)
    .mob 5455
    .mob 5456
    .mob 5457

-- ===== Vallée des Chardonniers =====
step
    #completewith Glande
    >>Tue les |cRXP_ENEMY_Chardonniers collecteurs de rosée|r pour une |cRXP_LOOT_Glande de rosée remplie|r chacun
    .complete 2605,1 --Glande de rosée remplie
    .mob 5481
step
    .goto Tanaris,29.30,65.50
    >>Tue les |cRXP_ENEMY_Chardonniers noueux|r et |cRXP_ENEMY_Chardonniers taille-racine|r
    .complete 3362,1 --Chardonnier noueux (8)
    .complete 3362,2 --Chardonnier taille-racine (8)
    .mob 5490
    .mob 5485
step
    #label Glande
    .goto Tanaris,29.20,65.50
    >>Finis la |cRXP_LOOT_Glande de rosée remplie|r sur les |cRXP_ENEMY_Collecteurs de rosée|r (~12 %, chacun la sienne)
    .complete 2605,1 --Glande de rosée remplie
    .mob 5481

-- ===== Base des Cognedunes =====
step
    #completewith Bracelet
    >>Les ogres |cRXP_ENEMY_Cognedunes|r peuvent lâcher le |cRXP_LOOT_Bracelet brillamment poli|r
    .complete 97530,1 --Bracelet brillamment poli
step
    .goto Tanaris,40.50,55.00
    >>Tue les |cRXP_ENEMY_Brutes|r et |cRXP_ENEMY_Massacreurs Cognedunes|r
    .complete 5863,1 --Brute Cognedune (10)
    .complete 5863,2 --Massacreur Cognedune (10)
    .mob 5474
    .mob 5472
step
    .goto Tanaris,41.50,57.81
    >>Tue |cRXP_ENEMY_Gor'marok le Ravageur|r
    .complete 5863,3 --Gor'marok le Ravageur
    .mob 12046
step
    #label Bracelet
    .goto Tanaris,41.00,56.00
    >>Finis le |cRXP_LOOT_Bracelet brillamment poli|r sur les ogres
    .complete 97530,1 --Bracelet brillamment poli
    .mob 5471
    .mob 5472
    .mob 5473
    .mob 5474
    .mob 5475
step
    .hs >>Utilise ta pierre de foyer vers Gadgetzan

-- ===== Gadgetzan =====
step
    .goto Tanaris,50.89,26.96
    >>Parle à l'|cRXP_FRIENDLY_Alchimiste Pestlezugg|r
    .turnin 82 >>Rends Enquête au Repaire nuisible
    .target 5594
step
    .goto Tanaris,50.21,27.48
    >>Parle au |cRXP_FRIENDLY_Grand Géomètre Fizzledowser|r
    .accept 10 >>Accepte La rédemption de Scrimshank
    .target 7724
step
    .goto Tanaris,52.82,27.40
    >>Parle à |cRXP_FRIENDLY_Andi Lynn|r
    .turnin 5863 >>Rends La base des Cognedunes
    .target 11758
step
    .goto Tanaris,51.57,26.76
    >>Parle à |cRXP_FRIENDLY_Tran'rek|r
    .turnin 3362 >>Rends La vallée des Chardonniers
    .target 7876
step
    .goto Tanaris,51.81,28.66
    >>Parle à |cRXP_FRIENDLY_Marin Noggenfogger|r
    .turnin 2605 >>Rends Le gobelin assoiffé
    .accept 2606 >>Accepte De bon goût
    .target 7564
step
    .goto Tanaris,51.06,26.87
    >>Parle à |cRXP_FRIENDLY_Sprinkle|r. |cRXP_WARN_N'accepte pas la suite (ingrédient dans les Hinterlands)|r
    .turnin 2606 >>Rends De bon goût
    .target 7583

-- ===== Gouffre béant : Scrimshank =====
step
    .goto Tanaris,55.96,71.17
    >>Au sud, dans le Gouffre béant des |cRXP_ENEMY_Hazzali|r, ramasse l'|cRXP_PICK_Equipement d'analyse de Scrimshank|r
    .complete 10,1 --Equipement d'analyse de Scrimshank
step
    #label RobotOOX
    .goto Tanaris,60.23,64.72
    >>Donne la balise au |cRXP_FRIENDLY_Robot guidé OOX-17/TN|r. |cRXP_WARN_N'accepte pas l'escorte (rendu à Baie-du-Butin)|r
    .turnin 351 >>Rends Trouver OOX-17/TN !
    .target 7784
    .isOnQuest 351
step
    .goto Tanaris,50.21,27.48
    >>Rentre à Gadgetzan et parle au |cRXP_FRIENDLY_Grand Géomètre Fizzledowser|r
    .turnin 10 >>Rends La rédemption de Scrimshank
    .accept 110 >>Accepte Analyse des morceaux d'insectes
    .target 7724
step
    .goto Tanaris,50.89,26.96
    >>Parle à l'|cRXP_FRIENDLY_Alchimiste Pestlezugg|r
    .turnin 110 >>Rends Analyse des morceaux d'insectes
    .accept 113 >>Accepte Analyse des morceaux d'insectes
    .target 5594
step
    .goto Tanaris,50.21,27.48
    >>Parle au |cRXP_FRIENDLY_Grand Géomètre Fizzledowser|r. |cRXP_WARN_L'ascension des silithides se rend à Orgrimmar (Zilzibin Drumlore) : garde-la pour ton prochain passage en ville|r
    .turnin 113 >>Rends Analyse des morceaux d'insectes
    .accept 32 >>Accepte L'ascension des silithides
    .target 7724

-- ===== Port gobelin =====
step
    .goto Tanaris,67.06,23.89
    >>Va au port gobelin et parle au |cRXP_FRIENDLY_Chef de la sécurité Bilgewhizzle|r
    .turnin 97530 >>Rends Collecte chez les Cognedunes
    .target 7882
step
    #label FinTanaris
    +|cRXP_WARN_Niveau conseillé pour la suite : 48. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

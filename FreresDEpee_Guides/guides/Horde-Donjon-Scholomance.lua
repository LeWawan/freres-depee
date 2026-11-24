if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde de Scholomance (Caer Darrow, Maleterres de l'Ouest), toutes classes.
-- Givers : Grand exécuteur Derrington, Apothicaire Dithers et Alexi Barov (la Barricade,
-- Tirisfal 83,69), Krinkle Goodsteel (Gadgetzan), Eva Sarkhoff et Magistrat Marduke
-- (Caer Darrow), Leonid Barthalomew et Betina Bigglezink (Chapelle de l'Espoir de Lumière).
-- Données : QuestieDB Forever (tools/questiedb.py), zone 2057 (quêtes et PNJ de l'instance).
-- XP de xpDB-classic.lua. Taux de drop wowheadData : fragments de squelette 14619 ~36 %
-- (Bourreaux et Acolytes squelettes d'Andorhal), ~85 kills en duo pour 15 + 15, gardés car la
-- chaîne de la clé (838 -> 5511, ~25 000 xp) dépasse 100 xp par kill et ouvre l'instance.
-- Clé de Scholomance : protégée par .isQuestTurnedIn 5098 (Tout au long des tours de guet, guide
-- des Maleterres de l'Ouest). Détour par Gadgetzan et la Crête de la Fournaise (Un'Goro), deux
-- barres de thorium et Araj l'Invocateur (élite 61 d'Andorhal, à faire avec le groupe).
-- Itinéraire : Barricade -> Andorhal -> Barricade -> Gadgetzan -> Un'Goro -> Barricade ->
-- Andorhal (Araj) -> Barricade -> Espoir de Lumière -> Caer Darrow -> Scholomance (run
-- complète) -> Eva -> Jandice -> Eva -> Kirtonos -> Eva -> Barricade -> Espoir de Lumière (fin).
-- Chaîne d'Eva Sarkhoff (5382 -> 5515 -> 5384) : chaque quête se rend dehors, à côté de l'entrée.
-- La run complète garde Jandice et Kirtonos (proches de l'entrée) pour deux allers-retours courts.
-- Protégées : 5522 (Leonid Barthalomew, chaîne des oeufs des Steppes ardentes), 5531 et 4771
-- Le gambit de l'aube (après 5522) ; 5465 Souvenir lié et 5466 La Liche, Ras Murmegivre (après
-- 5464, chaîne de Stratholme). Rendus protégés par .isOnQuest.
-- Dans l'instance, QuestieDB n'a pas de coordonnées : ordre des salles décrit dans le texte.
-- Coupées :
--   5582 L'écaille de dragon luisante (ne se lance qu'après le rendu de 5529, donc à une run
--   suivante ; pas d'XP dans xpDB-classic.lua),
--   5342 Le dernier Barov (Weldon Barov, élite 60 au camp Alliance du Noroît, gardes et JcJ),
--   5461 L'humain, Ras Murmegivre et 5462 Le moribond, Ras Murmegivre (détour par Stromgarde
--   puis l'Espoir de Lumière, ~11 500 xp seulement, mènent à Stratholme), 5463 et 5464 Le cadeau
--   de Menethil (Stratholme, guide de donjon), 4735 La collecte d'oeufs (Steppes ardentes,
--   Rochenoire), 8969 et 8992 Amulette du seigneur Valthalak (ensemble de donjon 2, Kormok),
--   7629 Livraison de diablotin (démoniste), 7647, 97184, 97185 (paladin, Ravassombre), 7667,
--   7668, 8258 (chaman, Ravassombre), 97169 La menace de Ravassombre (Alliance), 5343, 5344
--   (Barov, Alliance), 5533, 5537, 5538 (clé, Alliance), 8913-8918, 8927, 8939, 8943, 9007-9014,
--   9020-9022 et 84155-84210 (ensemble de donjon, Anthion et Ysida), 9319 et 9386 Une lumière au
--   sein des ombres (fête du Feu du solstice), 5402-5408, 5508-5510 (pierres du Fléau,
--   réputation Aube d'argent), 9124-9127, 9200, 9202 (Naxxramas, Aube d'argent).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 57-60 Scholomance
#displayname [FDP] Scholomance (57-60)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== La Barricade =====
step
    #completewith Derrington
    .goto Tirisfal Glades,83.13,68.94,40 >>Va à la Barricade, à l'est de Tirisfal
step
    #label Derrington
    .goto Tirisfal Glades,83.13,68.94
    >>Parle au |cRXP_FRIENDLY_Grand exécuteur Derrington|r
    >>|cRXP_WARN_Sans la clé squelette, quelqu'un du groupe doit l'avoir pour ouvrir la porte de Scholomance|r
    .accept 838 >>Accepte Scholomance
    .target 10837
    .isQuestTurnedIn 5098
step
    .goto Tirisfal Glades,83.28,69.23
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Dithers|r
    .turnin 838 >>Rends Scholomance
    .accept 964 >>Accepte Fragments de squelette
    .target 11057
    .isOnQuest 838
step
    .goto Tirisfal Glades,83.06,71.60
    >>Parle à |cRXP_FRIENDLY_Alexi Barov|r
    .accept 5341 >>Accepte Fortune de la famille Barov
    .target 11022

-- ===== Clé de Scholomance =====
step
    .goto Western Plaguelands,44.50,69.80
    >>Tue les |cRXP_ENEMY_Bourreaux squelettes|r et les |cRXP_ENEMY_Acolytes squelettes|r à Andorhal pour les |cRXP_LOOT_Fragments de squelette|r
    >>|cRXP_WARN_Farm long en duo (~85 kills) : chacun doit looter ses objets|r
    .complete 964,1 --Fragments de squelette (15)
    .mob 1787
    .mob 1789
    .isOnQuest 964
step
    .goto Tirisfal Glades,83.28,69.23
    >>Retourne voir l'|cRXP_FRIENDLY_Apothicaire Dithers|r à la Barricade
    .turnin 964 >>Rends Fragments de squelette
    .accept 5514 >>Accepte Moisissure rime avec…
    .target 11057
    .isQuestComplete 964
step
    .goto Tanaris,51.46,28.81
    >>Va à Gadgetzan (zeppelin pour Orgrimmar, puis vol) et parle à |cRXP_FRIENDLY_Krinkle Goodsteel|r
    >>|cRXP_WARN_Le rendu coûte 15 pièces d'or|r
    .turnin 5514 >>Rends Moisissure rime avec…
    .accept 5802 >>Accepte Forgée dans la Fournaise
    .target 5411
    .isOnQuest 5514
step
    >>|cRXP_WARN_Achète 2|r |cRXP_LOOT_Barres de thorium|r |cRXP_WARN_à l'hôtel des ventes si tu n'en as pas|r
    .collect 12359,2,5802,1 --Barre de thorium (2)
    .isOnQuest 5802
step
    #completewith ForgeCle
    .goto Un'Goro Crater,49.62,47.56,60 >>Vole au Refuge des Marshal (Un'Goro) et monte au sommet de la Crête de la Fournaise
    .isOnQuest 5802
step
    #label ForgeCle
    .goto Un'Goro Crater,49.28,47.04
    >>Utilise le |cRXP_LOOT_Moule de clé squelette|r au bord du lac de lave pour obtenir la |cRXP_LOOT_Clé squelette inachevée|r
    .complete 5802,1 --Clé squelette inachevée
    .use 14644
    .isOnQuest 5802
step
    .goto Tirisfal Glades,83.28,69.23
    >>Rentre à la Barricade et parle à l'|cRXP_FRIENDLY_Apothicaire Dithers|r
    .turnin 5802 >>Rends Forgée dans la Fournaise
    .accept 5804 >>Accepte Le Scarabée d'Araj
    .target 11057
    .isQuestComplete 5802
step
    .goto Western Plaguelands,45.27,69.21
    >>Tue |cRXP_ENEMY_Araj l'Invocateur|r au centre d'Andorhal et ouvre le |cRXP_PICK_Petit coffret|r au sol pour le |cRXP_LOOT_Scarabée d'Araj|r
    >>|cRXP_WARN_Araj est un élite 61 entouré de squelettes : viens avec ton groupe de donjon|r
    .complete 5804,1 --Scarabée d'Araj
    .mob 1852
    .isOnQuest 5804
step
    .goto Tirisfal Glades,83.28,69.23
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Dithers|r
    .turnin 5804 >>Rends Le Scarabée d'Araj
    .target 11057
    .isQuestComplete 5804
step
    .goto Tirisfal Glades,83.13,68.94
    >>Parle au |cRXP_FRIENDLY_Grand exécuteur Derrington|r, à côté
    .accept 5511 >>Accepte La clé de Scholomance
    .turnin 5511 >>Rends La clé de Scholomance
    .target 10837
    .isQuestTurnedIn 5804

-- ===== Chapelle de l'Espoir de Lumière =====
step
    .goto Eastern Plaguelands,71.89,48.29
    >>Vole à la Chapelle de l'Espoir de Lumière, à l'est des Maleterres de l'Est, et parle à |cRXP_FRIENDLY_Leonid Barthalomew le Révéré|r
    .turnin 5522 >>Rends Leonid Barthalomew
    .accept 5531 >>Accepte Betina Bigglezink
    .target 11036
    .isOnQuest 5522
step
    .goto Eastern Plaguelands,71.89,48.29
    >>Parle à |cRXP_FRIENDLY_Leonid Barthalomew le Révéré|r
    .accept 5465 >>Accepte Souvenir lié
    .target 11036
    .isQuestTurnedIn 5464
step
    .goto Eastern Plaguelands,71.66,49.94
    >>Parle à |cRXP_FRIENDLY_Betina Bigglezink|r
    .accept 5529 >>Accepte Portée contaminée
    .target 11035
step
    .goto Eastern Plaguelands,71.66,49.94
    >>Parle à |cRXP_FRIENDLY_Betina Bigglezink|r
    .turnin 5531 >>Rends Betina Bigglezink
    .accept 4771 >>Accepte Le gambit de l'aube
    .target 11035
    .isOnQuest 5531

-- ===== Caer Darrow =====
step
    #completewith Eva
    .goto Western Plaguelands,70.22,73.71,40 >>Va à Caer Darrow, l'île du lac au sud-est des Maleterres de l'Ouest
step
    #label Eva
    .goto Western Plaguelands,70.22,73.71
    >>Parle à |cRXP_FRIENDLY_Eva Sarkhoff|r
    .accept 5382 >>Accepte Docteur Theolen Krastinov, le boucher
    .target 11216
step
    .goto Western Plaguelands,70.57,74.11
    >>Parle au |cRXP_FRIENDLY_Magistrat Marduke|r
    .turnin 5465 >>Rends Souvenir lié
    .accept 5466 >>Accepte La Liche, Ras Murmegivre
    .target 11286
    .isOnQuest 5465

-- ===== Scholomance : run complète =====
step
    #sticky
    >>Tue les |cRXP_ENEMY_Jeunes pestiférés|r dans la couveuse de la Salle d'observation
    .complete 5529,1 --Jeune pestiféré (20)
    .mob 10678
    .isOnQuest 5529
step
    #sticky
    >>Ramasse les quatre titres de propriété posés dans les salles de l'instance : |cRXP_LOOT_Caer Darrow|r, |cRXP_LOOT_Brill|r, |cRXP_LOOT_Moulin-de-Tarren|r et |cRXP_LOOT_Austrivage|r
    .complete 5341,1 --Titre de propriété de Brill
    .complete 5341,2 --Titre de propriété de Caer Darrow
    .complete 5341,3 --Titre de propriété d'Austrivage
    .complete 5341,4 --Titre de propriété de Moulin-de-Tarren
    .isOnQuest 5341
step
    .goto Western Plaguelands,69.40,72.80,15 >>Entre dans Scholomance, sous le château de Caer Darrow. Laisse le porche de |cRXP_ENEMY_Kirtonos|r et la salle de |cRXP_ENEMY_Jandice Barov|r pour plus tard
step
    +Descends dans le Grand ossuaire et tue |cRXP_ENEMY_Cliquettripes|r : il porte la clé de la Salle d'observation. Coche pour continuer
    .mob 11622
step
    >>Dans la Salle d'observation, pose le |cRXP_LOOT_Gambit de l'aube|r, puis tue |cRXP_ENEMY_Vectus|r et |cRXP_ENEMY_Marduk Noirétang|r
    .complete 4771,1 --Vectus
    .use 12368
    .mob 10432
    .isOnQuest 4771
step
    >>Utilise le |cRXP_LOOT_Souvenir lié|r sur |cRXP_ENEMY_Ras Murmegivre|r pour le rendre mortel, puis tue-le pour sa |cRXP_LOOT_Tête humaine|r
    .complete 5466,1 --Tête humaine de Ras Murmegivre
    .use 13752
    .mob 10508
    .isOnQuest 5466
step
    >>Dans les salles du bas, tue le |cRXP_ENEMY_Docteur Theolen Krastinov|r, puis brûle le |cRXP_PICK_Cadavre d'Eva Sarkhoff|r et le |cRXP_PICK_Cadavre de Lucien Sarkhoff|r
    .complete 5382,1 --Docteur Theolen Krastinov
    .complete 5382,2 --Cadavre d'Eva Sarkhoff brûlé
    .complete 5382,3 --Cadavre de Lucien Sarkhoff brûlé
    .mob 11261
    .isOnQuest 5382
step
    >>Finis les six salles (Malicia, Krastinov, Polkelt, le Voracien, Alexei et Illucia Barov) : |cRXP_ENEMY_Sombre Maître Gandling|r apparaît dans le bureau du directeur. Finis les titres et les jeunes pestiférés avant de sortir
    .complete 5341,1 --Titre de propriété de Brill
    .complete 5341,2 --Titre de propriété de Caer Darrow
    .complete 5341,3 --Titre de propriété d'Austrivage
    .complete 5341,4 --Titre de propriété de Moulin-de-Tarren
    .mob 1853
    .isOnQuest 5341

-- ===== Chaîne d'Eva Sarkhoff : Jandice puis Kirtonos =====
step
    .goto Western Plaguelands,70.22,73.71
    >>Sors et parle à |cRXP_FRIENDLY_Eva Sarkhoff|r
    .turnin 5382 >>Rends Docteur Theolen Krastinov, le boucher
    .accept 5515 >>Accepte Sac des horreurs de Krastinov
    .target 11216
    .isQuestComplete 5382
step
    >>Retourne dans l'instance et tue |cRXP_ENEMY_Jandice Barov|r, à l'étage, pour le |cRXP_LOOT_Sac des horreurs de Krastinov|r. Attaque la vraie Jandice parmi ses images
    .complete 5515,1 --Sac des horreurs de Krastinov
    .mob 10503
    .isOnQuest 5515
step
    .goto Western Plaguelands,70.22,73.71
    >>Parle à |cRXP_FRIENDLY_Eva Sarkhoff|r : elle te donne le |cRXP_LOOT_Sang des innocents|r
    .turnin 5515 >>Rends Sac des horreurs de Krastinov
    .accept 5384 >>Accepte Kirtonos le héraut
    .target 11216
    .isQuestComplete 5515
step
    >>Retourne dans l'instance, monte au porche et pose le |cRXP_LOOT_Sang des innocents|r dans le |cRXP_PICK_Brasero du héraut|r. Tue |cRXP_ENEMY_Kirtonos le Héraut|r
    .complete 5384,1 --Kirtonos le Héraut
    .mob 10506
    .isOnQuest 5384
step
    .goto Western Plaguelands,70.22,73.71
    >>Parle à |cRXP_FRIENDLY_Eva Sarkhoff|r
    .turnin 5384 >>Rends Kirtonos le héraut
    .target 11216
    .isQuestComplete 5384
step
    .goto Western Plaguelands,70.57,74.11
    >>Parle au |cRXP_FRIENDLY_Magistrat Marduke|r
    .turnin 5466 >>Rends La Liche, Ras Murmegivre
    .target 11286
    .isOnQuest 5466

-- ===== Rendus : Barricade et Espoir de Lumière =====
step
    .goto Tirisfal Glades,83.06,71.60
    >>Retourne à la Barricade et parle à |cRXP_FRIENDLY_Alexi Barov|r
    .turnin 5341 >>Rends Fortune de la famille Barov
    .target 11022
    .isQuestComplete 5341
step
    .goto Eastern Plaguelands,71.66,49.94
    >>Vole à l'Espoir de Lumière et parle à |cRXP_FRIENDLY_Betina Bigglezink|r
    .turnin 4771 >>Rends Le gambit de l'aube
    .target 11035
    .isOnQuest 4771
step
    #label FinScholomance
    .goto Eastern Plaguelands,71.66,49.94
    >>Parle à |cRXP_FRIENDLY_Betina Bigglezink|r
    .turnin 5529 >>Rends Portée contaminée
    .target 11035
    .isOnQuest 5529
]])

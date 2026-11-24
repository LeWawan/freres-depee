if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Arathi Highlands (Hautes-terres d'Arathi), Horde, toutes classes.
-- Hub : Trépas-d'Orgrim. Arrivée à pied depuis Moulin-de-Tarren (ogres de Tallow sur la route).
-- Route : Fragments de Myzrael, kobolds, pierre orientale, Witherbark, retour au hub, puis
-- boucle ouest (Rochepoing, pierres extérieure, occidentale et intérieure, Crique de Faldir)
-- fermée par la pierre de foyer.
-- Indépendant des autres régions : les quêtes venues d'ailleurs (638 Trollbane, 6623) sont
-- protégées par .isOnQuest.
-- Coupées : 672-847 L'éveil de l'esprit / La ruse du raptor (yeux et coeurs à 33 %, ~134 kills
-- en duo pour 9225 xp), 97539/92519 Sutures soyeuses (taux inconnu, ~69 kills pour 5600 xp,
-- caisse de toniques sans position), 639-646 chaîne des glyphes (Glyphe de Strom à 2-3 % sur
-- des élites), 652/688 Fozruk (élite 42 qui patrouille), 671/673 Magies immondes (~53 kills,
-- puis Marez Cowl élite 40), 679/680 (élites 38-40 de Stromgarde), 92867 Une position à tenir
-- (élites de Stromgarde), 687 (Badlands), 635 (drop aléatoire), 6622 (Secourisme),
-- 95663 (Wetlands), 667/670 (après Baie-du-Butin).
-- Données : QuestieDB Forever (tools/questiedb.py). Syntaxe : docs/rxp-custom-guides.md.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 35-37 Arathi Highlands
#displayname [FDP] Arathi Highlands (35-37)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 38 Arme tourbillon << Warrior
#next 40 Palefroi corrompu << Warlock
#next 40 Destrier << Paladin

-- ===== Voyage : Fossoyeuse -> Moulin-de-Tarren -> Hautes-terres d'Arathi =====
step
    #completewith ArriveeTrepas
    .goto Undercity,63.3,48.6,15 >>Va au maître des chauves-souris de Fossoyeuse (zeppelin depuis Orgrimmar ou Grom'gol)
    .zoneskip Hillsbrad Foothills/Arathi Highlands
step
    #completewith ArriveeTrepas
    .goto Undercity,63.3,48.6
    .fly Tarren Mill >>Vole vers Moulin-de-Tarren
    .zoneskip Hillsbrad Foothills/Arathi Highlands
step
    .goto Hillsbrad Foothills,61.9,19.6
    >>Parle à |cRXP_FRIENDLY_Tallow|r à Moulin-de-Tarren
    .accept 676 >>Accepte Menace sur le Trépas-d'Orgrim
    .target 2770
    .zoneskip Arathi Highlands
step
    #completewith OgresRochepoing
    .goto Arathi Highlands,21.29,30.24,40 >>Suis la route vers l'est, passe le Mur de Thoradin et entre dans les Hautes-terres d'Arathi
step
    #label OgresRochepoing
    .goto Arathi Highlands,36.0,42.0,30,0
    .goto Arathi Highlands,33.0,45.0,30,0
    .goto Arathi Highlands,36.0,48.0,30,0
    .goto Arathi Highlands,33.0,48.0,30,0
    .goto Arathi Highlands,33.0,45.0
    >>Tue les |cRXP_ENEMY_Ogres|r et |cRXP_ENEMY_Massacreurs Rochepoing|r
    .complete 676,1 --Ogre Rochepoing (8)
    .complete 676,2 --Massacreur Rochepoing (10)
    .mob 2562
    .mob 2564
    .isOnQuest 676
step
    .goto Arathi Highlands,62.5,33.7
    >>Clique sur les |cRXP_PICK_Fragments de Myzrael|r, au bord de la route du Trépas-d'Orgrim
    .accept 642 >>Accepte La Princesse emprisonnée

-- ===== Trépas-d'Orgrim : point de vol et quêtes =====
step
    #label ArriveeTrepas
    .goto Arathi Highlands,73.02,32.70
    >>Parle à |cRXP_FRIENDLY_Urda|r
    .fp Hammerfall >>Prends le point de vol du Trépas-d'Orgrim
    .target 2851
step
    .goto Arathi Highlands,73.84,32.46
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Adegwa|r
    .home >>Fixe ta pierre de foyer au Trépas-d'Orgrim : elle ferme la boucle ouest
    .target 9501
step
    .goto Arathi Highlands,74.24,33.92
    >>Parle à |cRXP_FRIENDLY_Drum Fel|r
    .turnin 676 >>Rends Menace sur le Trépas-d'Orgrim
    .target 2771
    .isOnQuest 676
step
    .goto Arathi Highlands,74.24,33.92
    >>Parle à |cRXP_FRIENDLY_Drum Fel|r
    .accept 677 >>Accepte L'appel du combat
    .target 2771
step
    .goto Arathi Highlands,73.80,33.96
    >>Parle à |cRXP_FRIENDLY_Zengu|r
    .turnin 638 >>Rends Trollbane
    .target 2703
    .isOnQuest 638
step
    .goto Arathi Highlands,73.41,36.89
    >>Parle au |cRXP_FRIENDLY_Docteur Gregory Victor|r
    .turnin 6623 >>Rends Service de traumatologie de la Horde
    .target 12920
    .isOnQuest 6623
step
    .goto Arathi Highlands,72.64,33.93
    >>Parle à |cRXP_FRIENDLY_Gor'mul|r. Il se déplace dans le camp
    .accept 655 >>Accepte Trépas-d'Orgrim
    .target 2792
step
    .goto Arathi Highlands,74.72,36.29
    >>Parle à |cRXP_FRIENDLY_Tor'gan|r
    .turnin 655 >>Rends Trépas-d'Orgrim
    >>|cRXP_WARN_Ne prends pas L'éveil de l'esprit : trop de drops pour l'XP|r
    .target 2706

-- ===== Gorge de Sèche-moustache : poussières de Myzrael =====
step
    .goto Arathi Highlands,78.0,36.0,30,0
    .goto Arathi Highlands,78.0,42.0,30,0
    .goto Arathi Highlands,81.0,39.0,30,0
    .goto Arathi Highlands,84.0,33.0,25,0
    .goto Arathi Highlands,86.0,31.0,25,0
    .goto Arathi Highlands,81.0,36.0
    >>Tue les |cRXP_ENEMY_kobolds Sèche-moustache|r pour les |cRXP_LOOT_Poussières de Myzrael|r
    >>|cRXP_WARN_Farm long en duo (~48 kills) : chacun doit looter ses objets|r
    .complete 642,1 --Poussières de Myzrael (12)
    .mob 2572
    .mob 2573
    .mob 2574
step
    .goto Arathi Highlands,84.3,30.9
    >>Clique sur les |cRXP_PICK_Fragments iridescents|r au fond de la gorge
    .turnin 642 >>Rends La Princesse emprisonnée
    .accept 651 >>Accepte Les pierres de lien
step
    .goto Arathi Highlands,66.7,29.7
    >>Ouvre la |cRXP_PICK_Pierre de Lien orientale|r et prends la |cRXP_LOOT_Clé armoriée|r
    >>|cRXP_WARN_Fozruk, géant élite 42, patrouille dans le coin : évite-le|r
    .complete 651,2 --Clé armoriée
    .unitscan 2611

-- ===== Village Witherbark : L'appel du combat et goliaths =====
step
    #completewith Witherbark
    >>Tue un |cRXP_ENEMY_Goliath fânécorce|r (élite 35) et ramasse les |cRXP_LOOT_Garde-poignets de goliath|r
    >>|cRXP_WARN_Départ de quête non documenté dans Questie : clique sur l'objet s'il ne lance pas la quête tout seul|r
    .collect 253711,1,92707,1 --Garde-poignets de goliath
    .accept 92707 >>Accepte Le Géant de la tanière
    .use 253711
    .mob 218032
step
    #label Witherbark
    .goto Arathi Highlands,72.0,60.0,30,0
    .goto Arathi Highlands,66.0,63.0,30,0
    .goto Arathi Highlands,63.0,70.0,30,0
    .goto Arathi Highlands,66.0,72.0,30,0
    .goto Arathi Highlands,69.0,78.0,30,0
    .goto Arathi Highlands,69.0,81.0,30,0
    .goto Arathi Highlands,72.0,66.0
    >>Tue les |cRXP_ENEMY_Lanceurs de haches|r, |cRXP_ENEMY_Chasseurs de têtes|r et |cRXP_ENEMY_Sorciers-docteurs Witherbark|r
    >>|cRXP_WARN_Les Goliaths fânécorce (élites 35) sont au sud du village (69,81)|r
    .complete 677,1 --Lanceur de haches Witherbark (10)
    .complete 677,2 --Chasseur de têtes Witherbark (10)
    .complete 677,3 --Sorcier-docteur Witherbark (8)
    .mob 2554
    .mob 2556
    .mob 2555
    .mob 218032
step
    #completewith RendusTrepas1
    .goto Arathi Highlands,74.24,33.92,40 >>Retourne au Trépas-d'Orgrim
step
    #label RendusTrepas1
    .goto Arathi Highlands,74.24,33.92
    >>Parle à |cRXP_FRIENDLY_Drum Fel|r
    .turnin 677 >>Rends L'appel du combat
    .turnin -92707 >>Rends Le Géant de la tanière
    .accept 678 >>Accepte L'appel du combat
    .target 2771

-- ===== Boucle ouest : Rochepoing et pierres de lien =====
step
    #completewith BruteRochepoing
    .goto Arathi Highlands,53.0,72.0,40 >>Va au camp des Rochepoing au sud du centre de la région
step
    #label BruteRochepoing
    .goto Arathi Highlands,54.0,75.0,25,0
    .goto Arathi Highlands,51.0,78.0,25,0
    .goto Arathi Highlands,54.0,81.0,25,0
    .goto Arathi Highlands,51.0,72.0,25,0
    .goto Arathi Highlands,54.0,75.0
    >>Tue les |cRXP_ENEMY_Brutes|r et |cRXP_ENEMY_Magus Rochepoing|r
    .complete 678,1 --Brute Rochepoing (10)
    .complete 678,2 --Magus Rochepoing (4)
    .mob 2566
    .mob 2567
step
    .goto Arathi Highlands,52.0,50.7
    >>Ouvre la |cRXP_PICK_Pierre de Lien extérieure|r et prends la |cRXP_LOOT_Clé de tonnerre|r
    .complete 651,3 --Clé de tonnerre
step
    .goto Arathi Highlands,25.5,30.1
    >>Ouvre la |cRXP_PICK_Pierre de Lien occidentale|r et prends la |cRXP_LOOT_Clé ardente|r
    .complete 651,1 --Clé ardente
step
    .goto Arathi Highlands,36.2,57.4
    >>Clique sur la |cRXP_PICK_Pierre de Lien Intérieure|r
    >>|cRXP_WARN_Ne prends pas La Pierre cruciale : Fozruk est un élite 42|r
    .turnin 651 >>Rends Les pierres de lien

-- ===== Crique de Faldir =====
step
    #completewith Lolo
    .goto Arathi Highlands,30.74,66.94,60,0
    .goto Arathi Highlands,22.72,71.98,50,0
    .goto Arathi Highlands,21.50,75.91,40,0
    .goto Arathi Highlands,21.98,79.96,30 >>Va à la Crique de Faldir par le chemin entre les montagnes et le mur sud-est de Stromgarde
step
    #label Lolo
    .goto Arathi Highlands,31.8,82.7
    >>Parle à |cRXP_FRIENDLY_Lolo le Guetteur|r
    .accept 663 >>Accepte Terre !
    .target 2766
    .xp <35,1
step
    .goto Arathi Highlands,32.3,81.4
    >>Parle à |cRXP_FRIENDLY_Shakes O'Breen|r
    .turnin 663 >>Rends Terre !
    .target 2610
    .isOnQuest 663
step
    .goto Arathi Highlands,34.0,80.8
    >>Parle au |cRXP_FRIENDLY_Capitaine Steelgut|r
    .accept 664 >>Accepte Chagrin noyé
    .target 2769
    .isQuestTurnedIn 663
step
    .goto Arathi Highlands,32.8,81.5
    >>Parle au |cRXP_FRIENDLY_Second Nilzlix|r
    .accept 662 >>Accepte Sauvetage en haute mer
    .target 2767
    .isQuestTurnedIn 663
step
    .goto Arathi Highlands,33.9,80.5
    >>Parle au |cRXP_FRIENDLY_Professeur Phizzlethorpe|r pour lancer l'escorte
    .accept 665 >>Accepte Le trésor englouti
    .target 2768
    .isQuestTurnedIn 663
step
    .goto Arathi Highlands,33.87,80.6
    >>Escorte le |cRXP_FRIENDLY_Professeur Phizzlethorpe|r jusqu'à la grotte puis au retour. Tue les nagas qui l'attaquent
    .complete 665,1 --Défendre le Professeur Phizzlethorpe
    .isOnQuest 665
step
    .goto Arathi Highlands,33.9,80.5
    >>Parle au |cRXP_FRIENDLY_Docteur Draxlegauge|r
    .turnin 665 >>Rends Le trésor englouti
    .accept 666 >>Accepte Le trésor englouti
    .target 2774
    .isQuestComplete 665
step
    #completewith FinCrique
    >>Tue les |cRXP_ENEMY_Ecumeurs|r et |cRXP_ENEMY_Sorcières Daguéchine|r
    .complete 664,1 --Ecumeur Daguéchine (10)
    .complete 664,2 --Sorcière Daguéchine (3)
    .mob 2595
    .mob 2596
    .isOnQuest 664
step
    .goto Arathi Highlands,23.1,84.5,10,0
    .goto Arathi Highlands,23.4,85.1
    >>Plonge dans l'épave de la |cRXP_PICK_Folie de la Vierge|r : prends les |cRXP_LOOT_Cartes|r et le |cRXP_LOOT_Journal|r
    >>|cRXP_WARN_Surveille ta jauge de souffle|r
    .complete 662,1 --Cartes de la Folie de la Vierge
    .complete 662,2 --Journal de la Folie de la Vierge
    .isOnQuest 662
step
    .goto Arathi Highlands,20.5,85.6,10,0
    .goto Arathi Highlands,20.6,85.1
    >>Plonge dans l'épave de l'|cRXP_PICK_Esprit des Pins argentés|r : prends les |cRXP_LOOT_Cartes|r et le |cRXP_LOOT_Journal|r
    .complete 662,3 --Cartes de l'Esprit des Pins argentés
    .complete 662,4 --Journal de l'Esprit des Pins argentés
    .isOnQuest 662
step
    .goto Arathi Highlands,21.0,87.0,25,0
    .goto Arathi Highlands,24.0,90.0,25,0
    .goto Arathi Highlands,19.0,90.0,25,0
    .goto Arathi Highlands,22.8,88.2
    >>Ramasse les |cRXP_PICK_Gemmes elfiques calcifiées|r au fond de l'eau
    >>|cRXP_WARN_Vérifie si les Lunettes de chasse aux gemmes doivent être équipées ou utilisées pour les voir|r
    .complete 666,1 --Gemme elfique (10)
    .isOnQuest 666
step
    #label FinCrique
    .goto Arathi Highlands,24.0,87.0,30,0
    .goto Arathi Highlands,21.0,84.0,30,0
    .goto Arathi Highlands,21.0,90.0,30,0
    .goto Arathi Highlands,24.0,84.0
    >>Finis les |cRXP_ENEMY_Ecumeurs|r et |cRXP_ENEMY_Sorcières Daguéchine|r
    .complete 664,1 --Ecumeur Daguéchine (10)
    .complete 664,2 --Sorcière Daguéchine (3)
    .mob 2595
    .mob 2596
    .isOnQuest 664
step
    .goto Arathi Highlands,34.0,80.8
    >>Parle au |cRXP_FRIENDLY_Capitaine Steelgut|r
    .turnin 664 >>Rends Chagrin noyé
    .target 2769
    .isQuestComplete 664
step
    .goto Arathi Highlands,32.8,81.5
    >>Parle au |cRXP_FRIENDLY_Second Nilzlix|r
    .turnin 662 >>Rends Sauvetage en haute mer
    .target 2767
    .isQuestComplete 662
step
    .goto Arathi Highlands,33.9,80.5
    >>Parle au |cRXP_FRIENDLY_Docteur Draxlegauge|r
    .turnin 666 >>Rends Le trésor englouti
    .accept 668 >>Accepte Le trésor englouti
    .target 2774
    .isQuestComplete 666
step
    .goto Arathi Highlands,32.3,81.4
    >>Parle à |cRXP_FRIENDLY_Shakes O'Breen|r
    .turnin 668 >>Rends Le trésor englouti
    .accept 669 >>Accepte Le trésor englouti
    >>|cRXP_WARN_La suite se rend au Maître de flotte Seahorn à Baie-du-Butin, lors de ton prochain passage|r
    .target 2610
    .isOnQuest 668

-- ===== Retour au Trépas-d'Orgrim =====
step
    #completewith RendusTrepas2
    .hs >>Utilise ta pierre de foyer pour revenir au Trépas-d'Orgrim
step
    #label RendusTrepas2
    .goto Arathi Highlands,74.24,33.92
    >>Parle à |cRXP_FRIENDLY_Drum Fel|r
    .turnin 678 >>Rends L'appel du combat
    .turnin -92707 >>Rends Le Géant de la tanière
    >>|cRXP_WARN_Ne prends pas la suite ni La réelle menace : élites 38-40 dans la grotte des Rochepoing|r
    .target 2771
step
    .goto Arathi Highlands,74.72,36.29
    >>Parle à |cRXP_FRIENDLY_Tor'gan|r si tu enchaînes sur les rives Claires (Riverglades)
    .accept 95143 >>Accepte À la recherche de Tan'jani
    .target 2706
    .xp <36,1
step
    #label FinArathi
    +|cRXP_WARN_Niveau conseillé pour la suite : 37. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

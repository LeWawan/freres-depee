if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Felwood (Gangrebois), Horde, toutes classes, en duo.
-- Indépendant des autres régions : Les souvenirs de Linken (3942, Un'Goro) et Une étrange
-- personne (6605, Berceau-de-l'Hiver) sont protégées par .isOnQuest.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua. Taux de drop :
-- wowheadData (Ambre de sang 82 %, Griffe de Ror 36 %), 35 % supposés pour la Clé rouge sang.
-- Itinéraire : arrivée par le sud (Ashenvale) -> Mort-bois du sud et sanctuaire d'Émeraude ->
-- poste de la Vénéneuse -> Jaedenar et puits des Jadefeu -> statue de Malorne, val de la
-- Balafre -> nord (bois d'Arbrefer, village Mort-bois, Nafien) -> sanctuaire et Seigneur Ror
-- -> puits de Jaedenar -> vol vers Cabestan (Islen Waterseer, Tarides) -> deux passages
-- dans Shadow Hold (braseros, clé rouge, Fel'dan, Rakaiah) -> fin au sanctuaire.
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   996, 998, 1514, 2523, 2878, 3363, 4113-4119, 4221, 4222, 4343, 4401, 4403, 4443-4448,
--   4461, 4462, 4464-4467 (plantes corrompues, répétables de l'Eau de source sacrée),
--   4108-4112 et 5887-5891 (baumes de Maybess, répétables et métiers, sans XP),
--   4521, 4741, 4721 Gardiens sauvages (chouettards au Berceau-de-l'Hiver, pas en Gangrebois),
--   86577 Un échantillon de putrescence (18 organes à 35 % supposés = ~103 kills),
--   8465 Parler à Salfa (rendue au Berceau-de-l'Hiver), 8466, 8467, 8469 (plumes et perles,
--   répétables de réputation), 8470 et 8471 (totems lâchés au hasard, réputation Neutre
--   exigée), 6031, 6032, 8481, 8484, 8485, 87346, 86814, 86798 (repaire des Grumegueules,
--   réputation), 4084 Coeur d'argent (11 griffes à 6-21 %, ~15 % en moyenne = ~150 kills, plus un coeur de Bois-de-fer) et 4005 (Tanaris),
--   4120 La force de la corruption (prise et rendue à Féralas, coupée là-bas),
--   5084, 5085, 4882, 4883, 5128 (chaînes du Berceau-de-l'Hiver), 91952, 95568, 95569,
--   90487, 92612, 96796, 96930 (Ketharas, mont Hyjal), 8257 (prêtre, temple englouti),
--   7601-7603, 7623-7625, 8419-8422 (démoniste), 7632-7636 (chasseur), 81790, 81885, 82135,
--   96476 (paladin), 94259, 94271, 94283, 94295, 94307, 94308 (commissions d'artisan).
--   Alliance : 939, 4101, 4103-4107, 5882-5886, 4261, 4421, 4441, 4442, 4906, 5249, 86611.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 51-54 Felwood
#displayname [FDP] Gangrebois (51-54)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 52-53 Burning Steppes

-- ===== Arrivée par le sud et Mort-bois =====
step
    #completewith ArriveeGrifleur
    .goto Felwood,50.93,85.01,40 >>Depuis le poste de Bois-brisé (Ashenvale), prends la route du nord jusqu'au sud de Gangrebois
step
    #label ArriveeGrifleur
    .goto Felwood,50.93,85.01
    >>Parle à |cRXP_FRIENDLY_Grifleur|r, le furbolg au bord de la route
    .accept 8460 >>Accepte Allié des Grumegueules
    .target 11554
step
    .goto Felwood,48.30,90.50
    >>Tue les |cRXP_ENEMY_Guerriers|r, |cRXP_ENEMY_Guides|r et |cRXP_ENEMY_Jardiniers Mort-bois|r au sud-ouest de Grifleur
    .complete 8460,1 --Guerrier Mort-bois (6)
    .complete 8460,2 --Guide Mort-bois (6)
    .complete 8460,3 --Jardinier Mort-bois (6)
    .mob 7153
    .mob 7155
    .mob 7154
step
    .goto Felwood,50.93,85.01
    >>Retourne voir |cRXP_FRIENDLY_Grifleur|r
    .turnin 8460 >>Rends Allié des Grumegueules
    .accept 8462 >>Accepte Parler à Nafien
    .target 11554

-- ===== Sanctuaire d'Émeraude =====
step
    .goto Felwood,51.21,82.11
    >>Dans le sanctuaire d'Émeraude, parle à |cRXP_FRIENDLY_Greta Mosshoof|r
    .accept 5155 >>Accepte Les forces de Jaedenar
    .target 10922
step
    .goto Felwood,50.89,81.62
    >>Parle à |cRXP_FRIENDLY_Taronn Redfeather|r
    .accept 5156 >>Accepte Enquête sur la corruption
    .target 10921
step
    .goto Felwood,51.35,81.51
    >>Parle à |cRXP_FRIENDLY_Eridan Bluewind|r
    .turnin 3942 >>Rends Les souvenirs de Linken
    .target 9116
    .isOnQuest 3942
step
    .goto Felwood,46.75,83.13
    >>Parle à |cRXP_FRIENDLY_Maybess Riverbreeze|r, à l'ouest du sanctuaire
    .accept 4102 >>Accepte Purifie Gangrebois
    .target 9529

-- ===== Poste de la Vénéneuse =====
step
    #completewith ArriveeVeneneuse
    .goto Felwood,34.44,53.96,40 >>Suis la route vers le nord-ouest jusqu'au poste de la Vénéneuse
step
    #label ArriveeVeneneuse
    .goto Felwood,34.44,53.96
    >>Parle à |cRXP_FRIENDLY_Brakkar|r
    .fp Bloodvenom Post >>Prends le point de vol du poste de la Vénéneuse
    .target 11900
step
    .goto Felwood,34.21,52.34
    >>Parle à |cRXP_FRIENDLY_Winna Hazzard|r
    .turnin 6605 >>Rends Une étrange personne
    .target 9996
    .isOnQuest 6605
step
    .goto Felwood,34.21,52.34
    >>Parle à |cRXP_FRIENDLY_Winna Hazzard|r
    .accept 4505 >>Accepte Puits de la corruption
    .target 9996
step
    .goto Felwood,34.80,52.73
    >>Parle à |cRXP_FRIENDLY_Dreka'Sur|r
    .accept 6162 >>Accepte La dernière bataille d'un mari
    .target 9620

-- ===== Jaedenar et puits des Jadefeu =====
step
    .goto Felwood,38.00,61.50
    >>Au sud du poste, tue les |cRXP_ENEMY_Molosses|r, |cRXP_ENEMY_Gardiennes|r, |cRXP_ENEMY_Adeptes|r et |cRXP_ENEMY_Sectateurs de Jaedenar|r. |cRXP_WARN_N'entre pas encore dans la grotte de Shadow Hold|r
    .complete 5155,1 --Molosse de Jaedenar (4)
    .complete 5155,2 --Gardienne de Jaedenar (4)
    .complete 5155,3 --Adepte de Jaedenar (6)
    .complete 5155,4 --Sectateur de Jaedenar (6)
    .mob 7125
    .mob 7113
    .mob 7115
    .mob 7112
step
    .goto Felwood,32.32,66.56
    >>Va au puits de lune corrompu des satyres Jadefeu, au sud-ouest, et utilise le |cRXP_LOOT_Flacon renforcé|r dessus
    .complete 4505,1 --Flacon rempli
    .use 12566
step
    .goto Felwood,34.21,52.34
    >>Retourne voir |cRXP_FRIENDLY_Winna Hazzard|r
    .turnin 4505 >>Rends Puits de la corruption
    .accept 4506 >>Accepte Sabres corrompus
    .target 9996
step
    .goto Felwood,32.32,66.56,10
    >>Retourne au puits de lune corrompu et utilise le |cRXP_LOOT_Panier à chaton de Winna|r pour libérer le chaton
    .use 12565
step
    .goto Felwood,34.21,52.34
    >>Le |cRXP_FRIENDLY_Sabre corrompu|r te suit : ramène-le à |cRXP_FRIENDLY_Winna Hazzard|r. Si ce n'est pas fait, utilise le panier au bord du puits
    .complete 4506,1
    .turnin 4506 >>Rends Sabres corrompus
    .use 12565
    .target 9996

-- ===== Statue de Malorne et val de la Balafre =====
step
    .goto Felwood,42.06,47.31
    >>À l'est du poste, clique sur la |cRXP_PICK_Statue de Malorne|r
    .accept 86612 >>Accepte Le colifichet du seigneur cerf
step
    .goto Felwood,44.20,40.90
    >>Dans le val de la Balafre, tue les |cRXP_ENEMY_Bêtes|r et les |cRXP_ENEMY_Horreurs d'entropie|r
    .complete 5156,1 --Bête d'entropie (2)
    .complete 5156,2 --Horreur d'entropie (2)
    .mob 9878
    .mob 9879
step
    .goto Felwood,41.03,41.96
    >>Explore les cratères du val de la Balafre
    .complete 5156,3 --Explorer les cratères

-- ===== Nord : bois d'Arbrefer et Mort-bois du nord =====
step
    .goto Felwood,57.80,22.20
    >>Au nord, tue les |cRXP_ENEMY_Ecorcheurs|r et |cRXP_ENEMY_Déchireurs Crochebois|r pour leur |cRXP_LOOT_Ambre de sang|r
    >>|cRXP_WARN_Farm en duo (~37 kills) : chacun doit looter son ambre|r
    .complete 4102,1 --Ambre de sang (15)
    .mob 7100
    .mob 7101
step
    #completewith ArriveeNafien
    .goto Felwood,64.77,8.13,30 >>Suis la route vers le nord jusqu'à l'entrée du repaire des Grumegueules
step
    #label ArriveeNafien
    .goto Felwood,64.77,8.13
    >>Parle à |cRXP_FRIENDLY_Nafien|r devant le tunnel
    .turnin 8462 >>Rends Parler à Nafien
    .accept 8461 >>Accepte Les Mort-bois du nord
    .target 15395
step
    .goto Felwood,62.50,7.50
    >>Dans le village Mort-bois à l'ouest, tue les |cRXP_ENEMY_Protecteurs|r, |cRXP_ENEMY_Vengeurs|r et |cRXP_ENEMY_Chamans Mort-bois|r
    .complete 8461,1 --Protecteur Mort-bois (6)
    .complete 8461,2 --Vengeur Mort-bois (6)
    .complete 8461,3 --Chaman Mort-bois (6)
    .mob 7156
    .mob 7157
    .mob 7158
step
    .goto Felwood,64.77,8.13
    >>Retourne voir |cRXP_FRIENDLY_Nafien|r
    .turnin 8461 >>Rends Les Mort-bois du nord
    .target 15395

-- ===== Retour au sanctuaire et Seigneur Ror =====
step
    #completewith RetourGreta
    .goto Felwood,51.21,82.11,40 >>Redescends la route jusqu'au sanctuaire d'Émeraude, tout au sud
step
    #label RetourGreta
    .goto Felwood,51.21,82.11
    >>Parle à |cRXP_FRIENDLY_Greta Mosshoof|r
    .turnin 5155 >>Rends Les forces de Jaedenar
    .accept 5157 >>Accepte Recueillir de l'eau souillée
    .target 10922
step
    .goto Felwood,50.89,81.62
    >>Parle à |cRXP_FRIENDLY_Taronn Redfeather|r
    .turnin 5156 >>Rends Enquête sur la corruption
    .target 10921
step
    .goto Felwood,46.75,83.13
    >>Parle à |cRXP_FRIENDLY_Maybess Riverbreeze|r
    .turnin 4102 >>Rends Purifie Gangrebois
    .target 9529
step
    .goto Felwood,48.23,94.28
    >>Au sud, tue le |cRXP_ENEMY_Seigneur Ror|r et prends sa |cRXP_LOOT_Griffe|r. |cRXP_WARN_Un seul Ror : chacun doit looter sa griffe, attendez sa réapparition si besoin|r
    .complete 6162,1 --Griffe du Seigneur Ror
    .mob 9464
    .unitscan 9464

-- ===== Puits de Jaedenar et voyage dans les Tarides =====
step
    .goto Felwood,35.17,59.79
    >>Au centre de Jaedenar, utilise la |cRXP_LOOT_Gourde vide|r sur le puits de lune corrompu
    .complete 5157,1 --Eau de Puits de lune corrompue
    .use 12922
step
    .goto Felwood,51.21,82.11
    >>Retourne voir |cRXP_FRIENDLY_Greta Mosshoof|r
    .turnin 5157 >>Rends Recueillir de l'eau souillée
    .accept 5158 >>Accepte À la recherche de soutien spirituel
    .target 10922
step
    .goto Felwood,34.80,52.73
    >>Au poste de la Vénéneuse, parle à |cRXP_FRIENDLY_Dreka'Sur|r
    .turnin 6162 >>Rends La dernière bataille d'un mari
    .target 9620
step
    .goto Felwood,34.21,52.34
    >>Parle à |cRXP_FRIENDLY_Winna Hazzard|r
    .turnin 86612 >>Rends Le colifichet du seigneur cerf
    .target 9996
step
    .goto Felwood,34.44,53.96
    >>Parle à |cRXP_FRIENDLY_Brakkar|r
    .fly Ratchet >>Vole vers Cabestan. |cRXP_WARN_Profites-en pour passer chez ton entraîneur à Orgrimmar si besoin|r
    .target 11900
step
    .goto The Barrens,65.83,43.78
    >>Au sud de Cabestan, sur la côte, parle à |cRXP_FRIENDLY_Islen Waterseer|r
    .turnin 5158 >>Rends À la recherche de soutien spirituel
    .accept 5159 >>Accepte L'eau purifiée retourne à Gangrebois
    .target 5901
step
    .goto The Barrens,63.08,37.16
    >>Parle à |cRXP_FRIENDLY_Bragok|r
    .fly Bloodvenom Post >>Vole vers le poste de la Vénéneuse
    .target 16227
step
    .goto Felwood,51.21,82.11
    >>Rejoins le sanctuaire d'Émeraude et parle à |cRXP_FRIENDLY_Greta Mosshoof|r
    .turnin 5159 >>Rends L'eau purifiée retourne à Gangrebois
    .accept 5165 >>Accepte En calmant les flammes de protection
    .target 10922

-- ===== Shadow Hold, premier passage : braseros et clé rouge =====
step
    #completewith FinGangrebois
    >>Les |cRXP_ENEMY_Massacreurs|r, |cRXP_ENEMY_Tisseuses d'ombre|r, |cRXP_ENEMY_Démonistes|r et |cRXP_ENEMY_Légionnaires de Jaedenar|r peuvent lâcher une |cRXP_LOOT_Clé rouge sang|r. Utilise-la pour lancer la quête
    .collect 13140,1,5202,1
    .accept 5202 >>Accepte Une étrange clé rouge
    .use 13140
    .mob 7114
    .mob 7118
    .mob 7120
    .mob 9862
step
    .goto Felwood,36.48,55.19
    >>Entre dans la grotte de Shadow Hold, à Jaedenar, et utilise l'|cRXP_LOOT_Eau de Puits de lune purifiée|r sur les quatre braseros. Tuez les gardes autour : c'est ici que tombe la |cRXP_LOOT_Clé rouge sang|r, une chacun
    .complete 5165,1 --Brasero de la Douleur (36.3,56.3)
    .complete 5165,4 --Brasero de la Haine (36.5,55.2)
    .complete 5165,3 --Brasero de la Souffrance (36.7,53.3)
    .complete 5165,2 --Brasero de la Malice (37.7,52.7)
    .use 12906
step
    .goto Felwood,36.21,55.47
    >>Parle à |cRXP_FRIENDLY_Arko'narin capturée|r, près du Brasero de la Douleur
    .turnin 5202 >>Rends Une étrange clé rouge
    .accept 5203 >>Accepte Sauvetage à Jaedenar
    .target 11016
    .isOnQuest 5202
step
    .goto Felwood,36.21,55.47
    >>Escorte |cRXP_FRIENDLY_Arko'narin|r jusqu'à son équipement puis hors de Shadow Hold. Protège-la, elle est fragile. |cRXP_WARN_Point d'arrivée non vérifié en jeu|r
    .complete 5203,1
    .isOnQuest 5203
step
    .goto Felwood,51.21,82.11
    >>Retourne au sanctuaire et parle à |cRXP_FRIENDLY_Greta Mosshoof|r
    .turnin 5165 >>Rends En calmant les flammes de protection
    .target 10922
step
    .goto Felwood,51.21,82.11
    >>Parle à |cRXP_FRIENDLY_Greta Mosshoof|r
    .accept 5242 >>Accepte Un coup final
    .target 10922
    .xp <53,1
step
    .goto Felwood,51.35,82.01
    >>Parle à |cRXP_FRIENDLY_Jessir Moonbow|r
    .turnin 5203 >>Rends Sauvetage à Jaedenar
    .target 11019
    .isOnQuest 5203
step
    .goto Felwood,51.35,82.01
    >>Parle à |cRXP_FRIENDLY_Jessir Moonbow|r
    .accept 5204 >>Accepte Le châtiment de la Lumière
    .target 11019
    .isQuestTurnedIn 5203
    .xp <53,1

-- ===== Shadow Hold, second passage : Rakaiah et Fel'dan =====
step
    .goto Felwood,38.30,50.50
    >>Retourne dans Shadow Hold et tue la succube |cRXP_ENEMY_Rakaiah|r
    .complete 5204,1 --Rakaiah
    .mob 9518
    .isOnQuest 5204
step
    .goto Felwood,38.50,50.41
    >>Fouille le |cRXP_FRIENDLY_Cadavre de Trey Lightforge|r, juste à côté
    .turnin 5204 >>Rends Le châtiment de la Lumière
    .accept 5385 >>Accepte Les restes de Trey Lightforge
    .target 11020
    .isOnQuest 5204
step
    .goto Felwood,38.80,46.80
    >>Au fond de la grotte, tue |cRXP_ENEMY_Moora|r, |cRXP_ENEMY_Salia|r et le |cRXP_ENEMY_Seigneur des ténèbres Fel'dan|r, et prends sa |cRXP_LOOT_Tête|r. |cRXP_WARN_Niveaux 52 à 57 : tirez-les un par un|r
    .complete 5242,1 --Moora
    .complete 5242,2 --Salia
    .complete 5242,3 --Tête du Seigneur des ténèbres Fel'dan
    .mob 9861
    .mob 9860
    .mob 9517
    .isOnQuest 5242
step
    .goto Felwood,36.21,55.47
    >>Sur le chemin de la sortie, parle à |cRXP_FRIENDLY_Arko'narin capturée|r
    .turnin 5202 >>Rends Une étrange clé rouge
    .accept 5203 >>Accepte Sauvetage à Jaedenar
    .target 11016
    .isOnQuest 5202
step
    .goto Felwood,36.21,55.47
    >>Escorte |cRXP_FRIENDLY_Arko'narin|r jusqu'à son équipement puis hors de Shadow Hold. |cRXP_WARN_Point d'arrivée non vérifié en jeu|r
    .complete 5203,1
    .isOnQuest 5203
step
    .goto Felwood,51.21,82.11
    >>Retourne au sanctuaire et parle à |cRXP_FRIENDLY_Greta Mosshoof|r
    .turnin 5242 >>Rends Un coup final
    .target 10922
    .isOnQuest 5242
step
    .goto Felwood,51.35,82.01
    >>Parle à |cRXP_FRIENDLY_Jessir Moonbow|r
    .turnin 5385 >>Rends Les restes de Trey Lightforge
    .target 11019
    .isOnQuest 5385
step
    .goto Felwood,51.35,82.01
    >>Parle à |cRXP_FRIENDLY_Jessir Moonbow|r
    .turnin 5203 >>Rends Sauvetage à Jaedenar
    .target 11019
    .isOnQuest 5203
step
    #label FinGangrebois
    +|cRXP_WARN_Niveau conseillé pour la suite : 54. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

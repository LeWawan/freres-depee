if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Gorge des Vents brûlants (Searing Gorge), Horde, toutes
-- classes, en duo. Pas de ville Horde : base à la Halte du Thorium (Confrérie du Thorium,
-- neutre, point de vol Horde de Grisha). Aucune quête venue d'une autre région n'arrive ici.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua, taux de drop du
-- bloc wowheadData de classicItemDrops.lua (Coeur des flammes 18-22 %, Huile de golem 10-15 %,
-- Dague plaquée en thorium 24 % sur les Esclaves ouvriers et ~10 % sur les nains, Symbole de
-- Ragnaros 9-16 %, Tuyère 17 %, Longue-vue 15 %). La Clé des toilettes (11818) n'a de taux
-- dans aucun des deux blocs : 35 % supposés, quête prise si elle tombe.
-- Chaîne de Velarok Lamevent (3441 à 3481, 27650 xp) gardée malgré ~150 à 240 kills en duo :
-- plus de 100 xp par kill, et la plupart des kills servent aussi à 7723 et 7729.
-- Itinéraire : Halte du Thorium (prises) -> Velarok (39,39) -> golems et élémentaires du
-- centre -> Velarok -> nains du Chaudron et Fosse aux scories (Maltorius, plans,
-- incendosaures) -> Velarok -> ouest (Crépuscule, araignées de lave) -> Velarok (torche) ->
-- sud (tours, forge-vapeurs, guetteurs) -> toilettes de Crasseboue à l'est -> Velarok ->
-- Halte du Thorium (rendus).
-- Coupées :
--   4450 Grand livre de Tanaris (rendu à Tanaris, Kalimdor), 4022 Un goût de flammes (suite de
--   3481, chez Cyrus Therepentous aux Steppes ardentes puis Profondeurs de Rochenoire ; le guide
--   des Steppes doit la protéger par .isQuestTurnedIn 3481), 7704 Regardez un peu la taille !
--   (lancée par un drop des Profondeurs de Rochenoire, blacklistée), 7736/7737/8241/8242
--   (réputation Confrérie du Thorium, niveau 60, réactifs), 7848 Harmonisation avec le Coeur
--   (Coeur du Magma, raid), 3379/3385/3402 (Couture), 8858 (Ahn'Qiraj, niveau 60), 8651
--   (Fête lunaire), 81900/81955 (Saison de la découverte), 94263/94275/94287/94299/94311
--   (commandes d'artisan niveau 60), quêtes Alliance : 3181, 3367, 3368, 3371, 3372, 3377,
--   3378, 3566, 5144.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 47-49 Searing Gorge
#displayname [FDP] Gorge des Vents brûlants (47-49)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 48-52 Azshara

-- ===== Halte du Thorium =====
step
    #completewith ArriveeThorium
    .goto Searing Gorge,34.84,30.87,40 >>Va à la Halte du Thorium, au nord-ouest de la Gorge des Vents brûlants. |cRXP_WARN_Accès non vérifié en jeu : vol depuis Kargath si tu as déjà le point de vol, sinon par le Mont Rochenoire depuis les Steppes ardentes|r
step
    #label ArriveeThorium
    .goto Searing Gorge,34.84,30.87
    >>Parle à |cRXP_FRIENDLY_Grisha|r
    .fp Thorium Point >>Prends le point de vol de la Halte du Thorium
    .target 3305
step
    .goto Searing Gorge,37.65,26.47
    >>Lis le |cRXP_PICK_panneau On recherche/Disparu/Trouvé & Perdu|r
    .accept 7701 >>Accepte ON RECHERCHE : Surveillant Maltorius
    .accept 7728 >>Accepte OBJETS VOLES : Tuyère et longue-vue
    .accept 7729 >>Accepte OFFRE D'EMPLOI : Réduire la concurrence
step
    .goto Searing Gorge,38.58,27.81
    >>Parle à |cRXP_FRIENDLY_Hansel Heavyhands|r
    .accept 7723 >>Accepte Maudits gros doigts
    .accept 7724 >>Accepte Une menace incandescente
    .accept 7727 >>Accepte Incendosaures ? N'importosaures, plutôt
    .target 14627
step
    .goto Searing Gorge,38.80,28.51
    >>Parle à |cRXP_FRIENDLY_Maître forgeron Burninate|r
    .accept 7722 >>Accepte Le Flux embrasé
    .target 14624

-- ===== En fond : clé des toilettes, nains de la concurrence, golems =====
step
    #completewith Toilettes
    >>Les nains Sombrefer peuvent lâcher la |cRXP_LOOT_Clé des toilettes de Crasseboue|r : utilise-la pour lancer la quête
    .collect 11818,1,4451,1 --Clé des toilettes de Crasseboue
    .accept 4451 >>Accepte La Clé de la liberté
    .use 11818
step
    #completewith Concurrence
    >>Tue les |cRXP_ENEMY_Esclavagistes Sombrefer|r et |cRXP_ENEMY_Sous-chefs Sombrefer|r que tu croises
    .complete 7729,1 --Sous-chef Sombrefer (15)
    .complete 7729,2 --Esclavagiste Sombrefer (15)
    .mob 5846
    .mob 5844
step
    #completewith GolemsSud
    >>Tue les |cRXP_ENEMY_Golems de guerre lourds|r que tu croises
    .complete 7723,1 --Golem de guerre lourd (20)
    .mob 5854

-- ===== Velarok Lamevent : la flamme parfaite =====
step
    .goto Searing Gorge,39.06,38.99
    >>Parle à |cRXP_FRIENDLY_Velarok Lamevent|r, au sud de la Halte
    .accept 3441 >>Accepte Châtiment divin
    .target 8479
step
    .goto Searing Gorge,39.06,38.99
    >>Écoute l'histoire de |cRXP_FRIENDLY_Velarok Lamevent|r
    .complete 3441,1
    .target 8479
step
    .goto Searing Gorge,39.06,38.99
    >>Parle à |cRXP_FRIENDLY_Velarok Lamevent|r
    .turnin 3441 >>Rends Châtiment divin
    .accept 3442 >>Accepte La flamme parfaite
    .target 8479
step
    #label FlammeParfaite
    .goto Searing Gorge,38.67,41.39,40,0
    .goto Searing Gorge,41.66,41.39,40,0
    .goto Searing Gorge,45.80,41.61,40,0
    .goto Searing Gorge,48.03,49.44,40,0
    .goto Searing Gorge,52.24,50.37,40,0
    .goto Searing Gorge,55.58,46.90,40,0
    .goto Searing Gorge,51.83,45.69
    >>Tue les |cRXP_ENEMY_Golems de guerre lourds|r pour l'|cRXP_LOOT_Huile de golem|r et les |cRXP_ENEMY_Élémentaires|r pour les |cRXP_LOOT_Coeurs des flammes|r
    >>|cRXP_WARN_Farm long en duo (~40 élémentaires et ~50 golems) : chacun doit looter ses objets. Les élémentaires de magma lâchent les deux|r
    .complete 3442,1 --Coeur des flammes (4)
    .complete 3442,2 --Huile de golem (4)
    .mob 5854
    .mob 5855
    .mob 5850
step
    .goto Searing Gorge,39.06,38.99
    >>Retourne voir |cRXP_FRIENDLY_Velarok Lamevent|r
    .turnin 3442 >>Rends La flamme parfaite
    .accept 3443 >>Accepte Forger le manche
    .target 8479

-- ===== Le Chaudron et la Fosse aux scories =====
step
    #completewith Dagues
    >>Tue les |cRXP_ENEMY_Esclaves ouvriers|r et les nains Sombrefer pour les |cRXP_LOOT_Dagues plaquées en thorium|r
    >>|cRXP_WARN_Farm long en duo : ~70 esclaves ouvriers (24 %) ou ~150 nains (10 %), chacun doit looter ses dagues. QuestieDB marque les esclaves amicaux : s'ils ne sont pas attaquables, tue les Esclavagistes et Sous-chefs|r
    .complete 3443,1 --Dague plaquée en thorium (8)
    .mob 5843
    .mob 5844
    .mob 5846
step
    .goto Searing Gorge,40.77,35.89
    >>Entre dans la |cRXP_PICK_Fosse aux scories|r, sous le Chaudron, et tue le |cRXP_ENEMY_Surveillant Maltorius|r pour sa |cRXP_LOOT_Tête|r
    >>|cRXP_WARN_Élite 50 gardé par deux Sentinelles Sombrefer élites : tirez-les une par une. Entrée de la fosse non vérifiée en jeu|r
    .complete 7701,1 --Tête du surveillant Maltorius
    .mob 14621
    .mob 8504
step
    .goto Searing Gorge,40.45,35.74
    >>Prends les |cRXP_PICK_Plans secrets : Flux embrasé|r à côté de Maltorius
    .complete 7722,1 --Plans secrets : Flux embrasé
step
    .goto Searing Gorge,49.88,39.01,30,0
    .goto Searing Gorge,51.24,33.71,30,0
    .goto Searing Gorge,51.15,29.25,30,0
    .goto Searing Gorge,48.46,26.48,30,0
    .goto Searing Gorge,45.15,21.49
    >>Tue les |cRXP_ENEMY_Incendosaures|r dans les bassins de lave de la fosse
    .complete 7727,1 --Incendosaure (20)
    .mob 9318
step
    #label Dagues
    .goto Searing Gorge,43.04,28.29,40,0
    .goto Searing Gorge,42.60,31.57,40,0
    .goto Searing Gorge,44.57,35.47,40,0
    .goto Searing Gorge,40.64,39.17,40,0
    .goto Searing Gorge,36.72,31.62
    >>Finis les |cRXP_LOOT_Dagues plaquées en thorium|r sur les |cRXP_ENEMY_Esclaves ouvriers|r et les nains autour du Chaudron
    .complete 3443,1 --Dague plaquée en thorium (8)
    .mob 5843
    .mob 5844
    .mob 5846
step
    .goto Searing Gorge,39.06,38.99
    >>Retourne voir |cRXP_FRIENDLY_Velarok Lamevent|r
    .turnin 3443 >>Rends Forger le manche
    .accept 3452 >>Accepte L'enveloppe de la flamme
    .target 8479

-- ===== Ouest : Crépuscule et araignées de lave =====
step
    #completewith Araignees
    >>Tue les |cRXP_ENEMY_Araignées de lave incendiaires|r que tu croises
    .complete 7724,1 --Araignée de lave incendiaire (20)
    .mob 5858
step
    .goto Searing Gorge,23.54,39.39,30,0
    .goto Searing Gorge,19.65,38.60,30,0
    .goto Searing Gorge,21.63,36.30,30,0
    .goto Searing Gorge,24.06,34.16
    >>Tue les membres du |cRXP_ENEMY_Crépuscule|r du camp de l'ouest pour un |cRXP_LOOT_Symbole de Ragnaros|r
    >>|cRXP_WARN_Élites 47 à 50 en groupes, en duo : tirez-les un par un (~15 kills, chacun doit looter le sien)|r
    .complete 3452,1 --Symbole de Ragnaros
    .mob 5860
    .mob 5861
    .mob 5862
step
    #label Araignees
    .goto Searing Gorge,27.12,37.34,40,0
    .goto Searing Gorge,29.49,43.82,40,0
    .goto Searing Gorge,27.17,48.55,40,0
    .goto Searing Gorge,26.25,51.03,40,0
    .goto Searing Gorge,29.56,56.52,40,0
    .goto Searing Gorge,31.10,61.43
    >>Finis les |cRXP_ENEMY_Araignées de lave incendiaires|r sur les plateaux de l'ouest
    .complete 7724,1 --Araignée de lave incendiaire (20)
    .mob 5858

-- ===== Velarok : la Torche de vindicte =====
step
    .goto Searing Gorge,39.06,38.99
    >>Retourne voir |cRXP_FRIENDLY_Velarok Lamevent|r
    .turnin 3452 >>Rends L'enveloppe de la flamme
    .accept 3453 >>Accepte La Torche de vindicte
    .target 8479
step
    .goto Searing Gorge,39.06,38.99
    >>Attends que |cRXP_FRIENDLY_Velarok Lamevent|r finisse la torche
    .complete 3453,1
    .target 8479
step
    .goto Searing Gorge,39.06,38.99
    >>Parle à |cRXP_FRIENDLY_Velarok Lamevent|r
    .turnin 3453 >>Rends La Torche de vindicte
    .accept 3454 >>Accepte La Torche de vindicte
    .target 8479
step
    .goto Searing Gorge,39.06,39.07
    >>Prends la |cRXP_PICK_Torche de vindicte|r posée à côté de lui
    .turnin 3454 >>Rends La Torche de vindicte
step
    .goto Searing Gorge,39.06,38.99
    >>Parle à |cRXP_FRIENDLY_Velarok Lamevent|r
    .accept 3462 >>Accepte L'écuyer Maltrake
    .target 8479
step
    .goto Searing Gorge,39.17,39.00
    >>Parle à l'|cRXP_FRIENDLY_Ecuyer Maltrake|r
    .turnin 3462 >>Rends L'écuyer Maltrake
    .accept 3463 >>Accepte Allumer le feu !
    .target 8509

-- ===== Sud : tours de guet, forge-vapeurs, guetteurs =====
step
    #completewith Tours
    >>Tue les |cRXP_ENEMY_Forge-vapeurs Sombrefer|r pour la |cRXP_LOOT_Tuyère de forge|r et les |cRXP_ENEMY_Guetteurs Sombrefer|r pour la |cRXP_LOOT_Longue-vue|r
    .complete 7728,1 --Tuyère de forge
    .complete 7728,2 --Longue-vue de guetteur
    .mob 5840
    .mob 8566
step
    .goto Searing Gorge,38.15,51.36,30,0
    .goto Searing Gorge,40.01,48.33,30,0
    .goto Searing Gorge,42.98,51.68
    >>Tue les |cRXP_ENEMY_Forge-vapeurs Sombrefer|r pour la |cRXP_LOOT_Tuyère de forge|r
    >>|cRXP_WARN_~12 kills en duo, chacun doit looter la sienne|r
    .complete 7728,1 --Tuyère de forge
    .mob 5840
step
    #label Concurrence
    .goto Searing Gorge,40.52,51.14,30,0
    .goto Searing Gorge,41.22,53.04,30,0
    .goto Searing Gorge,39.88,54.47
    >>Finis les |cRXP_ENEMY_Esclavagistes|r et |cRXP_ENEMY_Sous-chefs Sombrefer|r du sud
    .complete 7729,1 --Sous-chef Sombrefer (15)
    .complete 7729,2 --Esclavagiste Sombrefer (15)
    .mob 5846
    .mob 5844
step
    .goto Searing Gorge,33.30,54.48
    >>Entre dans la tour de guet et utilise la |cRXP_LOOT_Torche de vindicte|r sur le |cRXP_PICK_Brasero de sentinelle|r
    >>|cRXP_WARN_Des Sentinelles Sombrefer élites gardent les tours|r
    .complete 3463,4 --Tour nord en feu
    .use 10515
step
    .goto Searing Gorge,35.67,60.68
    >>Brûle le |cRXP_PICK_Brasero de sentinelle|r de la tour suivante
    .complete 3463,1 --Tour ouest en feu
    .use 10515
step
    #label GolemsSud
    .goto Searing Gorge,37.17,62.03,30,0
    .goto Searing Gorge,41.64,63.42,30,0
    .goto Searing Gorge,44.85,63.76
    >>Finis les |cRXP_ENEMY_Golems de guerre lourds|r autour des tours du sud
    .complete 7723,1 --Golem de guerre lourd (20)
    .mob 5854
step
    .goto Searing Gorge,44.03,60.91
    >>Brûle le |cRXP_PICK_Brasero de sentinelle|r de la tour sud
    .complete 3463,2 --Tour sud en feu
    .use 10515
step
    .goto Searing Gorge,50.07,54.74
    >>Brûle le |cRXP_PICK_Brasero de sentinelle|r de la tour est
    .complete 3463,3 --Tour est en feu
    .use 10515
step
    #label Tours
    .goto Searing Gorge,49.78,55.97,30,0
    .goto Searing Gorge,52.91,58.79,30,0
    .goto Searing Gorge,42.72,62.57
    >>Finis la |cRXP_LOOT_Longue-vue de guetteur|r sur les |cRXP_ENEMY_Guetteurs Sombrefer|r
    >>|cRXP_WARN_~14 kills en duo, chacun doit looter la sienne|r
    .complete 7728,2 --Longue-vue de guetteur
    .mob 8566

-- ===== Est : toilettes de Crasseboue =====
step
    #label Toilettes
    .goto Searing Gorge,65.59,62.17
    >>Clique sur les |cRXP_PICK_Toilettes en bois|r du site de fouilles de Crasseboue
    >>|cRXP_WARN_Il faut 15 Étoffes de soie chacun (aucun vendeur). Sans elles, saute cette quête|r
    .accept 4449 >>Accepte Piégé !
    .turnin -4451 >>Rends La Clé de la liberté
step
    .goto Searing Gorge,62.76,62.27,20,0
    .goto Searing Gorge,63.90,60.39,20,0
    .goto Searing Gorge,63.06,59.56
    >>Tue les |cRXP_ENEMY_Géologues Sombrefer|r autour du site de fouilles
    .complete 4449,1 --Géologue Sombrefer (8)
    .complete 4449,2 --Etoffe de soie (15)
    .mob 5839
    .isOnQuest 4449
step
    .goto Searing Gorge,65.59,62.17
    >>Retourne aux |cRXP_PICK_Toilettes en bois|r
    .turnin 4449 >>Rends Piégé !
    .isOnQuest 4449

-- ===== Rendus : Velarok puis la Halte du Thorium =====
step
    .goto Searing Gorge,39.17,39.00
    >>Retourne voir l'|cRXP_FRIENDLY_Ecuyer Maltrake|r, à côté de Velarok
    .turnin 3463 >>Rends Allumer le feu !
    .target 8509
step
    .goto Searing Gorge,38.85,38.99
    >>Ouvre le |cRXP_PICK_Trésor du Vol noir|r
    .accept 3481 >>Accepte Bibelots...
    .turnin 3481 >>Rends Bibelots...
step
    .goto Searing Gorge,37.74,26.56
    >>Parle au |cRXP_FRIENDLY_Capitaine de guet Lolo Longstriker|r
    .turnin 7701 >>Rends ON RECHERCHE : Surveillant Maltorius
    .target 14634
step
    .goto Searing Gorge,38.58,27.81
    >>Parle à |cRXP_FRIENDLY_Hansel Heavyhands|r
    .turnin 7723 >>Rends Maudits gros doigts
    .turnin 7724 >>Rends Une menace incandescente
    .turnin 7727 >>Rends Incendosaures ? N'importosaures, plutôt
    .target 14627
step
    .goto Searing Gorge,38.80,28.51
    >>Parle au |cRXP_FRIENDLY_Maître forgeron Burninate|r
    .turnin 7722 >>Rends Le Flux embrasé
    .target 14624
step
    .goto Searing Gorge,38.97,27.51
    >>Parle au |cRXP_FRIENDLY_Sous-chef Scrange|r
    .turnin 7728 >>Rends OBJETS VOLES : Tuyère et longue-vue
    .turnin 7729 >>Rends OFFRE D'EMPLOI : Réduire la concurrence
    .target 14626
step
    #label FinGorge
    +|cRXP_WARN_Niveau conseillé pour la suite : 49. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde du Kraal de Tranchebauge (sud des Tarides), toutes classes.
-- Givers : Maître apothicaire Faranell (Undercity), Stonespire le Vieil (Thunder Bluff),
-- Mebok Mizzyrix (Cabestan), Willix (dans l'instance). Charlga Trancheflanc lâche le
-- Petit parchemin (6522, rendu à Varimathras, suite 6521 aux Souilles de Tranchebauge).
-- Corvée de guano (1109) ouvre Des cœurs zélés (1113, Monastère écarlate).
-- Chaman : suite Forever de L'appel de l'air, 79360 -> 79364 -> 79361 -> 79366 -> 79442.
-- Seule 79360 se fait dans l'instance ; 79361 demande des totems tordus sur quatre zones
-- (Désolace, Marécage d'Âprefange, Marais des Chagrins, Terres ingrates), niveau 43.
-- Données : QuestieDB Forever (tools/questiedb.py). Dans l'instance, QuestieDB n'a pas de
-- coordonnées : ordre des boss décrit dans le texte.

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 25-31 Razorfen Kraul
#displayname [FDP] Kraal de Tranchebauge (25-31)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Undercity : Faranell =====
step
    #completewith Faranell
    .goto Undercity,48.82,69.28,40 >>Va à Undercity, à l'Apothicarium
    .xp <30,1
step
    #label Faranell
    .goto Undercity,48.82,69.28
    >>Parle au |cRXP_FRIENDLY_Maître apothicaire Faranell|r
    .accept 1109 >>Accepte Corvée de guano
    .target 2055
    .xp <30,1

-- ===== Thunder Bluff : Stonespire le Vieil =====
step
    #completewith Stonespire
    .goto Thunder Bluff,35.97,59.92,40 >>Va à Thunder Bluff (zeppelin vers Orgrimmar puis vol)
    .xp <29,1
step
    #label Stonespire
    .goto Thunder Bluff,35.97,59.92
    >>Parle à |cRXP_FRIENDLY_Stonespire le Vieil|r
    .accept 1102 >>Accepte Un destin funeste
    .target 4451
    .xp <29,1

-- ===== Cabestan : Mebok =====
step
    #completewith Mebok
    .goto The Barrens,62.37,37.62,40 >>Va à Cabestan
step
    #label Mebok
    .goto The Barrens,62.37,37.62
    >>Parle à |cRXP_FRIENDLY_Mebok Mizzyrix|r
    .accept 1221 >>Accepte Racines de Feuillebleue
    .target 3446
step
    .goto The Barrens,62.33,37.61
    >>Prends la |cRXP_PICK_Caisse trouée|r, le |cRXP_PICK_Bâton de commandement de Sniffetarin|r et le |cRXP_PICK_Manuel d'utilisateur de Sniffetarin|r à côté de Mebok. Lis le manuel
    .complete 1221,2 --Caisse percée
    .complete 1221,3 --Manuel d'utilisateur de Sniffetarin
    .complete 1221,4 --Bâton de commandement de Sniffetarin

-- ===== Chaman : Librevent =====
step << Shaman
    .goto Thousand Needles,46.14,51.71
    >>Va au poste de Librevent (Mille pointes) et parle à |cRXP_FRIENDLY_Rau Cliffrunner|r
    .accept 79360 >>Accepte Soutien élémentaire
    .target 4722
    .isQuestTurnedIn 1531,1532,96136

-- ===== Instance =====
step
    #label EntreeRFK
    .goto The Barrens,42.90,90.20,15 >>Entre dans le Kraal de Tranchebauge, tout au sud des Tarides
step
    #completewith SortieRFK
    >>Utilise la |cRXP_LOOT_Caisse percée|r pour appeler un |cRXP_FRIENDLY_Sniffetarin|r, puis le |cRXP_LOOT_Bâton de commandement|r sur lui : il déterre les |cRXP_LOOT_Racines de Feuillebleue|r
    >>|cRXP_WARN_Chacun doit déterrer ses propres racines|r
    .complete 1221,1 --Racines de Feuillebleue (6)
    .use 5880
    .use 6684
step
    #completewith SortieRFK
    >>Tue les |cRXP_ENEMY_Chauves-souris du kraal|r et les |cRXP_ENEMY_Chasseurs aveugles|r pour le |cRXP_LOOT_Guano du kraal|r
    .complete 1109,1 --Guano du kraal
    .mob 4538
    .mob 4539
    .mob 4425
    .isOnQuest 1109
step
    >>Trouve |cRXP_FRIENDLY_Willix l'Importateur|r, prisonnier dans l'instance, et parle-lui pour lancer l'escorte
    .accept 1144 >>Accepte Willix l'Importateur
    .target 4508
step
    >>Escorte |cRXP_FRIENDLY_Willix l'Importateur|r jusqu'à l'entrée de l'instance. Tue ce qui l'attaque
    .complete 1144,1 --Aider Willix à s'échapper
step
    >>Parle à |cRXP_FRIENDLY_Willix l'Importateur|r à l'entrée de l'instance
    .turnin 1144 >>Rends Willix l'Importateur
    .target 4508
step
    >>Tue |cRXP_ENEMY_Charlga Trancheflanc|r, dernier boss au fond de l'instance, et ramasse son |cRXP_LOOT_Cœur|r
    .complete 1102,1 --Coeur de Trancheflanc
    .mob 4421
    .isOnQuest 1102
step
    >>Ramasse le |cRXP_LOOT_Petit parchemin|r sur |cRXP_ENEMY_Charlga Trancheflanc|r et utilise-le pour lancer la quête
    .collect 17008,1,6522,1 --Petit parchemin
    .accept 6522 >>Accepte Une alliance impie
    .use 17008
    .mob 4421
    .xp <28,1
step << Shaman
    >>Ramasse aussi la |cRXP_LOOT_Note en lambeaux|r sur |cRXP_ENEMY_Charlga Trancheflanc|r
    .complete 79360,1 --Note en lambeaux
    .mob 4421
    .isOnQuest 79360
step
    >>Finis les |cRXP_LOOT_Racines de Feuillebleue|r et le |cRXP_LOOT_Guano du kraal|r avant de sortir
    .complete 1221,1 --Racines de Feuillebleue (6)
    .complete 1109,1 --Guano du kraal
    .isOnQuest 1109
step
    #label SortieRFK
    >>Finis les |cRXP_LOOT_Racines de Feuillebleue|r avant de sortir
    .complete 1221,1 --Racines de Feuillebleue (6)

-- ===== Rendus =====
step << Shaman
    .goto Thousand Needles,46.14,51.71
    >>Va au poste de Librevent et parle à |cRXP_FRIENDLY_Rau Cliffrunner|r
    .turnin 79360 >>Rends Soutien élémentaire
    .accept 79364 >>Accepte Surveiller les cieux
    .target 4722
    .isQuestComplete 79360
step
    .goto The Barrens,62.37,37.62
    >>Retourne à Cabestan et parle à |cRXP_FRIENDLY_Mebok Mizzyrix|r
    .turnin 1221 >>Rends Racines de Feuillebleue
    .target 3446
step
    .goto Thunder Bluff,35.97,59.92
    >>Parle à |cRXP_FRIENDLY_Stonespire le Vieil|r à Thunder Bluff
    .turnin 1102 >>Rends Un destin funeste
    .target 4451
    .isOnQuest 1102
step
    #completewith Varimathras
    .goto Undercity,56.25,92.20,40 >>Va à Undercity (vol vers Orgrimmar puis zeppelin)
    .isOnQuest 6522
step
    .goto Undercity,48.82,69.28
    >>Parle au |cRXP_FRIENDLY_Maître apothicaire Faranell|r
    .turnin 1109 >>Rends Corvée de guano
    .target 2055
    .isOnQuest 1109
step
    .goto Undercity,48.82,69.28
    >>Parle au |cRXP_FRIENDLY_Maître apothicaire Faranell|r. La suite se fait au Monastère écarlate
    .accept 1113 >>Accepte Des cœurs zélés
    .target 2055
    .isQuestTurnedIn 1109
step
    #label Varimathras
    .goto Undercity,56.25,92.20
    >>Parle à |cRXP_FRIENDLY_Varimathras|r dans le Quartier royal
    .turnin 6522 >>Rends Une alliance impie
    .target 2425
    .isOnQuest 6522
step
    .goto Undercity,56.25,92.20
    >>Parle à |cRXP_FRIENDLY_Varimathras|r. La suite se fait aux Souilles de Tranchebauge
    .accept 6521 >>Accepte Une alliance impie
    .target 2425
    .isQuestTurnedIn 6522

-- ===== Chaman : suite de Soutien élémentaire (hors donjon) =====
step << Shaman
    .goto Thousand Needles,53.54,42.65
    >>Va voir |cRXP_FRIENDLY_Prate Cloudseer|r, sur le plateau à l'est de Librevent (Mille pointes)
    .turnin 79364 >>Rends Surveiller les cieux
    .accept 79361 >>Accepte Tempête, terre et feu
    .target 5905
    .isOnQuest 79364
step << Shaman
    #completewith Prate2
    >>|cRXP_WARN_Tempête, terre et feu (niveau 43) : 5 totems de chaque sorte, sur quatre zones. Fais-les au fil de ta route|r
    .complete 79361,1 --Totem d'eau tordu (5)
    .complete 79361,2 --Totem de terre tordu (5)
    .complete 79361,3 --Totem de feu tordu (5)
    .complete 79361,4 --Totem d'air tordu (5)
    .isOnQuest 79361
step << Shaman
    .goto Desolace,35.81,61.25,40
    >>Tue les |cRXP_ENEMY_Centaures Maraudine|r autour de Maraudon (Désolace) pour les |cRXP_LOOT_Totems d'air tordus|r
    .complete 79361,4 --Totem d'air tordu (5)
    .mob 4654
    .mob 4655
    .mob 4657
    .isOnQuest 79361
step << Shaman
    .goto Dustwallow Marsh,57.00,15.00,40
    >>Tue les |cRXP_ENEMY_Murlocs Aileron boueux|r au nord du Marécage d'Âprefange pour les |cRXP_LOOT_Totems d'eau tordus|r
    .complete 79361,1 --Totem d'eau tordu (5)
    .mob 4358
    .mob 4359
    .isOnQuest 79361
step << Shaman
    .goto Swamp of Sorrows,50.16,34.18,40
    >>Tue les |cRXP_ENEMY_Perdus|r du Marais des Chagrins pour les |cRXP_LOOT_Totems de terre tordus|r
    .complete 79361,2 --Totem de terre tordu (5)
    .mob 755
    .mob 757
    .isOnQuest 79361
step << Shaman
    .goto Badlands,62.52,68.44,40
    >>Tue les |cRXP_ENEMY_Ogres Crache-poussières|r des Terres ingrates pour les |cRXP_LOOT_Totems de feu tordus|r
    .complete 79361,3 --Totem de feu tordu (5)
    .mob 2701
    .mob 2715
    .isOnQuest 79361
step << Shaman
    #label Prate2
    .goto Thousand Needles,53.54,42.65
    >>Retourne voir |cRXP_FRIENDLY_Prate Cloudseer|r à Mille pointes
    .turnin 79361 >>Rends Tempête, terre et feu
    .accept 79366 >>Accepte Entendez mon appel
    .target 5905
    .isQuestComplete 79361
step << Shaman
    .goto Thousand Needles,36.70,39.12,40
    >>Utilise les totems tordus sur le rituel des huragriffes et tue les |cRXP_ENEMY_Tempêtes ravageuses|r pour l'|cRXP_LOOT_Œil de la tempête|r
    .complete 79366,1 --Œil de la tempête
    .mob 216474
    .isOnQuest 79366
step << Shaman
    .goto Thousand Needles,46.14,51.71
    >>Parle à |cRXP_FRIENDLY_Rau Cliffrunner|r à Librevent
    .turnin 79366 >>Rends Entendez mon appel
    .target 4722
    .isQuestComplete 79366
step << Orc Shaman/Tauren Shaman/Troll Shaman
    .goto Thousand Needles,46.14,51.71
    >>Parle à |cRXP_FRIENDLY_Rau Cliffrunner|r
    .accept 79442 >>Accepte Les armes de la tempête
    .target 4722
    .isQuestTurnedIn 79366
step << Shaman
    #label FinTranchebauge
    .goto Alterac Mountains,80.50,66.92
    >>Apporte l'|cRXP_LOOT_Œil de la tempête|r à |cRXP_FRIENDLY_Bath'rah la Vigie des vents|r, au sud-est des Montagnes d'Alterac
    .turnin 79442 >>Rends Les armes de la tempête
    .target 6176
    .isOnQuest 79442
]])

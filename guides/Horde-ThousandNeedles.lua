if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Thousand Needles (Mille pointes), Horde, toutes classes.
-- Indépendant des autres régions : les quêtes venues d'ailleurs sont protégées par
-- .isOnQuest / .isQuestTurnedIn, et les quêtes à forte XP dont le prérequis manque
-- sont signalées par les étapes d'alerte en tête de guide.
-- Données : QuestieDB Forever (tools/questiedb.py). Syntaxe : docs/rxp-custom-guides.md.

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 27-33 Thousand Needles
#displayname [FDP] Thousand Needles (27-33)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 30 Posture berserker << Warrior

-- ===== Alertes : quêtes à forte XP dont le prérequis se fait hors de la région =====
-- Visibles tant que la quête rapporte l'XP pleine (niveau de quête + 5).
step
    #sticky
    #completewith FinMillePointes
    .isQuestAvailable 1197
    .isQuestAvailable 1196
    .isNotOnQuest 1196
    .maxlevel 34
    .xp 35 >>|cRXP_WARN_Quête manquée : La flamme sacrée (~2350 xp). Prérequis à Thunder Bluff chez Zangen Stonehoof (55,51)|r
step
    #sticky
    #completewith FinMillePointes
    .isQuestAvailable 1153
    .isNotOnQuest 1153
    .maxlevel 34
    .xp 35 >>|cRXP_WARN_Quête manquée : Un nouveau minerai (~2350 xp). Chez Tatternack Steelforge au Camp Taurajo (Barrens 45,58), après « Des armes de choix »|r
step
    #sticky
    #completewith FinMillePointes
    .isQuestAvailable 1131
    .isNotOnQuest 1131
    .maxlevel 35
    .xp 36 >>|cRXP_WARN_Quête manquée : Broie-l'acier (~2450 xp). À prendre chez Melor Stonehoof à Thunder Bluff (61,81), le mob est ici (18,20)|r
step
    #sticky
    #completewith FinMillePointes
    .isQuestAvailable 1146
    .isNotOnQuest 1145
    .isNotOnQuest 1146
    .maxlevel 38
    .xp 39 >>|cRXP_WARN_Chaîne manquée : L'essaim s'agrandit (~4700 xp). Commence chez Korran à la Croisée (Barrens 51,30)|r

-- ===== Arrivée et poste de Librevent =====
step
    .goto Thousand Needles,31.86,21.66
    >>Parle à |cRXP_FRIENDLY_Grish Longrunner|r au Grand élévateur
    .turnin 5881 >>Rends Puiser dans les réserves
    .target 12576
    .isOnQuest 5881
step
    #completewith FreewindHaut
    .goto Thousand Needles,46.73,48.27,30 >>Va aux élévateurs du poste de Librevent
step
    #label FreewindHaut
    .goto Thousand Needles,45.91,49.91,25 >>Prends l'élévateur jusqu'au poste de Librevent
step
    .goto Thousand Needles,45.14,49.11
    >>Parle à |cRXP_FRIENDLY_Nyse|r
    .fp Freewind Post >>Prends le point de vol du poste de Librevent
    .target 4317
step
    .goto Thousand Needles,46.14,51.71
    >>Parle à |cRXP_FRIENDLY_Rau Cliffrunner|r
    .turnin 1196 >>Rends La flamme sacrée
    .target 4722
    .isOnQuest 1196
step
    .goto Thousand Needles,46.14,51.71
    >>Parle à |cRXP_FRIENDLY_Rau Cliffrunner|r
    .accept 1197 >>Accepte La flamme sacrée
    .target 4722
    .isQuestTurnedIn 1196
step
    .goto Thousand Needles,45.67,50.74
    >>Parle à |cRXP_FRIENDLY_Garde-falaise Longhorn|r
    .accept 4841 >>Accepte Pacifier les centaures
    .target 10537
step
    .goto Thousand Needles,46.00,50.86
    >>Clique sur l'|cRXP_PICK_Avis de recherche - Arnak Grimtotem|r
    .accept 5147 >>Accepte ON RECHERCHE : Arnak Totem-sinistre
step
    .goto Thousand Needles,46.21,51.51
    >>Parle à |cRXP_FRIENDLY_Jandia|r
    .accept 98069 >>Accepte Les fournitures de Librevent volées
    .accept 98070 >>Accepte Interruption des hurlements
    .target 4877
    .xp <27,1
step
    .goto Thousand Needles,44.64,50.29
    >>Parle à |cRXP_FRIENDLY_Hagar Lightninghoof|r
    .accept 4821 >>Accepte L'oeuf étrange
    .target 10539
step
    .goto Thousand Needles,44.93,48.92
    >>Parle à |cRXP_FRIENDLY_Elu|r
    .accept 4767 >>Accepte Le cavalier céleste
    .target 10377
step
    #completewith FinMillePointes
    >>Ramasse les |cRXP_LOOT_Fournitures de Librevent volées|r dès que tu en vois
    >>|cRXP_WARN_Emplacement non documenté dans Questie : note où tu les trouves|r
    .complete 98069,1 --Fournitures de Librevent volées (8)
    .isOnQuest 98069

-- ===== Traqueur des plaines Dorn : L'épreuve de la Foi =====
step
    #completewith Dorn1
    .goto Thousand Needles,54.57,44.36,12,0
    .goto Thousand Needles,53.71,42.59,10,0
    .goto Thousand Needles,53.95,41.49,10 >>Monte jusqu'au |cRXP_FRIENDLY_Traqueur des plaines Dorn|r
step
    #label Dorn1
    .goto Thousand Needles,53.95,41.49
    >>Parle au |cRXP_FRIENDLY_Traqueur des plaines Dorn|r
    .accept 1149 >>Accepte L'épreuve de la Foi
    .timer 7,RP de L'épreuve de la Foi
    .target 2986
step
    .goto Thousand Needles,53.95,41.49
    >>|cRXP_WARN_Attends la fin du RP, puis saute du bout de la planche : tu es téléporté au lieu de mourir|r
    .complete 1149,1 --L'épreuve de la Foi
step
    .goto Thousand Needles,53.95,41.49
    >>Parle au |cRXP_FRIENDLY_Traqueur des plaines Dorn|r
    .turnin 1149 >>Rends L'épreuve de la Foi
    .accept 1150 >>Accepte L'épreuve de l'Endurance
    .target 2986

-- ===== Est du poste : l'oeuf étrange =====
step
    #completewith OeufEtrange
    >>Tue les |cRXP_ENEMY_Géomètres Mufle-de-gravier|r pour un |cRXP_LOOT_Echantillon de minerai brut|r
    .complete 1153,1 --Echantillon de minerai brut
    .mob 4116
    .mob 4113
    .isOnQuest 1153
step
    #label OeufEtrange
    .goto Thousand Needles,56.36,50.39,20,0
    .goto Thousand Needles,52.34,55.25,20,0
    .goto Thousand Needles,56.36,50.39
    >>Ramasse l'|cRXP_LOOT_Oeuf étrange|r au sol. Il apparaît à l'un des deux endroits
    .complete 4821,1 --Oeuf étrange

-- ===== Rocher des Fendsabots : centaures et brasero =====
step
    #completewith NoteAssassin
    .goto Thousand Needles,39.40,33.10,0
    >>Tue le |cRXP_ENEMY_Messager galak|r s'il est là et ramasse l'|cRXP_LOOT_Engagement d'assassin|r
    >>|cRXP_WARN_Utilise l'objet pour lancer la quête|r
    .collect 12564,1,4881,1 --Engagement d'assassin
    .accept 4881 >>Accepte Complot d'assassinat
    .use 12564
    .unitscan 10617
step
    #completewith Brasero
    >>Tue les |cRXP_ENEMY_Eclaireurs|r, |cRXP_ENEMY_Querelleurs|r et |cRXP_ENEMY_Chasse-vent galaks|r
    .complete 4841,1 --Eclaireur galak (12)
    .complete 4841,2 --Querelleur galak (10)
    .complete 4841,3 --Chasse-vent galak (6)
    .mob 4094
    .mob 4093
    .mob 4096
step
    #completewith Brasero
    .goto Thousand Needles,44.12,37.22,20 >>Entre dans la grotte
    .isOnQuest 1197
step
    #label Brasero
    .goto Thousand Needles,44.44,36.32,12,0
    .goto Thousand Needles,43.14,35.19,12,0
    .goto Thousand Needles,42.11,34.54,12,0
    .goto Thousand Needles,42.01,31.47
    >>Ouvre le |cRXP_PICK_Brasero antique|r au fond de la grotte et prends le |cRXP_LOOT_Sabot fendu|r
    .complete 1197,1 --Sabot fendu
    .isOnQuest 1197
step
    .goto Thousand Needles,43.12,36.86,40,0
    .goto Thousand Needles,40.42,34.45,40,0
    .goto Thousand Needles,39.76,35.82,40,0
    .goto Thousand Needles,41.12,41.34,40,0
    .goto Thousand Needles,44.15,40.72,40,0
    .goto Thousand Needles,47.23,41.98,40,0
    .goto Thousand Needles,48.14,40.43,40,0
    .goto Thousand Needles,43.12,36.86
    >>Tue les |cRXP_ENEMY_Eclaireurs|r, |cRXP_ENEMY_Querelleurs|r et |cRXP_ENEMY_Chasse-vent galaks|r
    .complete 4841,1 --Eclaireur galak (12)
    .complete 4841,2 --Querelleur galak (10)
    .complete 4841,3 --Chasse-vent galak (6)
    .mob 4094
    .mob 4093
    .mob 4096

-- ===== Sud-ouest : harpies et Grenka =====
step
    #completewith Grenka
    >>Tue les |cRXP_ENEMY_Harpies|r, |cRXP_ENEMY_Volplumes|r et |cRXP_ENEMY_Imploratrices célestes hurlantes|r
    .complete 98070,1 --Harpie hurlante (5)
    .complete 98070,2 --Volplume hurlante (5)
    .complete 98070,3 --Imploratrice céleste hurlante (5)
    .mob 4100
    .mob 4101
    .mob 4104
    .isOnQuest 98070
step
    #completewith Grenka
    .goto Thousand Needles,27.59,49.86,12,0
    .goto Thousand Needles,28.65,51.30,12,0
    .goto Thousand Needles,27.29,51.30,12 >>Va vers la grotte de |cRXP_ENEMY_Grenka|r
    >>|cRXP_WARN_Les Imploratrices célestes étourdissent 4 s autour d'elles, les Harpies hurlantes réduisent au silence 8 s|r
step
    #completewith Grenka
    .goto Thousand Needles,26.89,52.07,12,0
    .goto Thousand Needles,26.66,53.55,12,0
    .goto Thousand Needles,25.84,54.78,10 >>Ouvre les |cRXP_PICK_Vivres de harpie|r au sol pour invoquer |cRXP_ENEMY_Grenka|r
    .isOnQuest 1150
step
    #label Grenka
    .goto Thousand Needles,25.90,55.23
    >>Tue |cRXP_ENEMY_Grenka Hurlesang|r et prends ses |cRXP_LOOT_Griffes de Grenka|r
    .complete 1150,1 --Griffes de Grenka
    .mob 4490
step
    .goto Thousand Needles,27.60,52.30,30,0
    .goto Thousand Needles,26.50,54.30,30,0
    .goto Thousand Needles,27.20,51.00
    >>Finis les harpies
    .complete 98070,1 --Harpie hurlante (5)
    .complete 98070,2 --Volplume hurlante (5)
    .complete 98070,3 --Imploratrice céleste hurlante (5)
    .mob 4100
    .mob 4101
    .mob 4104
    .isOnQuest 98070

-- ===== Retour Dorn puis poste de Librevent =====
step
    .goto Thousand Needles,53.95,41.49
    >>Parle au |cRXP_FRIENDLY_Traqueur des plaines Dorn|r
    .turnin 1150 >>Rends L'épreuve de l'Endurance
    .accept 1151 >>Accepte L'épreuve de la Force
    .target 2986
step
    #completewith FreewindRetour1
    .goto Thousand Needles,46.73,48.27,30 >>Remonte au poste de Librevent
step
    #label FreewindRetour1
    .goto Thousand Needles,45.67,50.74
    >>Parle au |cRXP_FRIENDLY_Garde-falaise Longhorn|r
    .turnin 4841 >>Rends Pacifier les centaures
    .accept 5064 >>Accepte Espionner le Totem sinistre
    .target 10537
step
    .goto Thousand Needles,44.64,50.29
    >>Parle à |cRXP_FRIENDLY_Hagar Lightninghoof|r
    .turnin 4821 >>Rends L'oeuf étrange
    .accept 4865 >>Accepte Serpent sauvage
    .target 10539
step
    .goto Thousand Needles,46.14,51.71
    >>Parle à |cRXP_FRIENDLY_Rau Cliffrunner|r
    .turnin 1197 >>Rends La flamme sacrée
    .target 4722
    .isQuestComplete 1197
step
    .goto Thousand Needles,46.21,51.51
    >>Parle à |cRXP_FRIENDLY_Jandia|r
    .turnin 98070 >>Rends Interruption des hurlements
    .target 4877
    .isOnQuest 98070

-- ===== Pic de la Sombrenuée : Arnak, Lakota, notes secrètes =====
step
    .goto Thousand Needles,38.11,26.87
    >>Tue |cRXP_ENEMY_Arnak Grimtotem|r et prends son |cRXP_LOOT_Sabot d'Arnak|r
    .complete 5147,1 --Sabot d'Arnak
    .mob 10896
step
    .goto Thousand Needles,37.95,26.45
    >>Parle à |cRXP_FRIENDLY_Lakota Windsong|r pour lancer l'escorte
    .accept 4904 >>Accepte Libre, enfin !
    .target 10646
step
    .goto Thousand Needles,30.93,37.12
    >>Escorte |cRXP_FRIENDLY_Lakota Windsong|r hors du pic. Tue ce qui l'attaque
    .complete 4904,1 --Libre, enfin !
step
    .goto Thousand Needles,31.79,32.58
    >>Ouvre le |cRXP_PICK_Coffre de documents|r
    .complete 5064,1 --Note secrète n°1
step
    .goto Thousand Needles,33.76,39.99
    >>Ouvre le |cRXP_PICK_Coffre de documents|r
    .complete 5064,2 --Note secrète n°2
step
    .goto Thousand Needles,39.34,41.53
    >>Ouvre le |cRXP_PICK_Coffre de documents|r
    .complete 5064,3 --Note secrète n°3

-- ===== Poste de Portblanc : Kanati, Motega, Wizlo =====
step
    #label NoteAssassin
    .goto Thousand Needles,21.25,32.06
    >>Parle à |cRXP_FRIENDLY_Kanati Greycloud|r
    >>|cRXP_WARN_Rendre la quête fait apparaître trois |cRXP_ENEMY_Assassins galaks|r : reste prêt|r
    .turnin 4881 >>Rends Complot d'assassinat
    .target 10638
    .isOnQuest 4881
step
    .goto Thousand Needles,21.25,32.06
    >>Parle à |cRXP_FRIENDLY_Kanati Greycloud|r
    .accept 4966 >>Accepte Protéger Kanati Greycloud
    .target 10638
    .isQuestTurnedIn 4881
step
    .goto Thousand Needles,21.06,31.70
    >>Tue les |cRXP_ENEMY_Assassins galaks|r avant qu'ils ne tuent |cRXP_FRIENDLY_Kanati|r
    .complete 4966,1 --Protéger Kanati Greycloud
    .mob 10720
    .isOnQuest 4966
step
    .goto Thousand Needles,21.25,32.06
    >>Parle à |cRXP_FRIENDLY_Kanati Greycloud|r
    .turnin 4966 >>Rends Protéger Kanati Greycloud
    .target 10638
    .isQuestComplete 4966
step
    .goto Thousand Needles,21.54,32.35
    >>Parle à |cRXP_FRIENDLY_Motega Firemane|r
    .turnin 4865 >>Rends Serpent sauvage
    .accept 5062 >>Accepte Feu sacré
    .target 10428
step
    .goto Thousand Needles,21.43,32.55
    >>Parle à |cRXP_FRIENDLY_Wizlo Bearingshiner|r
    .accept 5151 >>Accepte Hypercapaciteur bidulotron
    .target 10941
step
    .goto Thousand Needles,22.76,24.62
    >>Tue la |cRXP_ENEMY_Panthère enragée|r et prends l'|cRXP_LOOT_Hypercapaciteur bidulotron|r
    .complete 5151,1 --Hypercapaciteur bidulotron
    .mob 10992

-- ===== Haut-perchoir : Pao'ka, oeufs de wyverne, Rok'Alim =====
step
    #completewith Paoka
    .goto Thousand Needles,16.46,41.09,25,0
    .goto Thousand Needles,17.89,40.57,20 >>Monte le chemin jusqu'à |cRXP_FRIENDLY_Pao'ka Swiftmountain|r
step
    #label Paoka
    .goto Thousand Needles,17.89,40.57
    >>Parle à |cRXP_FRIENDLY_Pao'ka Swiftmountain|r pour lancer l'escorte
    .accept 4770 >>Accepte Vers le pays natal
    .target 10427
step
    #completewith next
    >>Ramasse les |cRXP_LOOT_Oeufs de wyverne de Haut-perchoir|r pendant l'escorte
    .complete 4767,1 --Oeuf de wyverne de Haut-perchoir (10)
step
    .goto Thousand Needles,11.06,34.95,40,0
    .goto Thousand Needles,15.17,32.66
    >>Escorte |cRXP_FRIENDLY_Pao'ka|r
    >>|cRXP_WARN_Trois wyvernes apparaissent au milieu de Haut-perchoir : n'engage que celle de l'est, les autres disparaissent|r
    .complete 4770,1 --Vers le pays natal
step
    .goto Thousand Needles,11.31,33.07,50,0
    .goto Thousand Needles,9.57,34.90,50,0
    .goto Thousand Needles,10.68,40.95,50,0
    .goto Thousand Needles,11.98,36.72,50,0
    .goto Thousand Needles,13.91,39.11,50,0
    .goto Thousand Needles,17.57,42.25
    >>Ramasse les |cRXP_LOOT_Oeufs de wyverne de Haut-perchoir|r au sol
    .complete 4767,1 --Oeuf de wyverne de Haut-perchoir (10)
step
    .goto Thousand Needles,17.10,38.10
    >>Tue |cRXP_ENEMY_Rok'Alim le Marteleur|r et prends ses |cRXP_LOOT_Fragments de Rok'Alim|r
    .complete 1151,1 --Fragments de Rok'Alim
    .mob 4499
step
    .goto Thousand Needles,17.79,19.79
    >>Tue |cRXP_ENEMY_Broie-l'acier|r et prends sa |cRXP_LOOT_Côte de Broie-l'acier|r. Il patrouille sur la crête
    .complete 1131,1 --Côte de Broie-l'acier
    .unitscan 4548
    .isOnQuest 1131
step
    .goto Thousand Needles,21.54,32.35
    >>Parle à |cRXP_FRIENDLY_Motega Firemane|r
    .turnin 4770 >>Rends Vers le pays natal
    .target 10428
step
    .goto Thousand Needles,21.43,32.55
    >>Parle à |cRXP_FRIENDLY_Wizlo Bearingshiner|r
    .turnin 5151 >>Rends Hypercapaciteur bidulotron
    .target 10941

step
    .goto Thousand Needles,33.0,33.5,30,0
    .goto Thousand Needles,35.5,34.0,30,0
    .goto Thousand Needles,36.5,36.5,30,0
    .goto Thousand Needles,37.5,39.0
    >>Ramasse l'|cRXP_LOOT_Agave d'incendia|r au pied du pic, sur la route du poste. Tu rendras la quête à Thunder Bluff
    .complete 5062,1 --Agave d'incendia (10)
    .isOnQuest 5062

-- ===== Poste de Librevent : rendus =====
step
    #completewith FreewindRetour2
    .goto Thousand Needles,46.73,48.27,30 >>Retourne au poste de Librevent
step
    #label FreewindRetour2
    .goto Thousand Needles,44.93,48.92
    >>Parle à |cRXP_FRIENDLY_Elu|r
    .turnin 4767 >>Rends Le cavalier céleste
    .target 10377
step
    .goto Thousand Needles,45.97,51.61
    >>Parle à |cRXP_FRIENDLY_Thalia Amberhide|r
    .turnin 4904 >>Rends Libre, enfin !
    .target 10645
step
    .goto Thousand Needles,45.67,50.74
    >>Parle au |cRXP_FRIENDLY_Garde-falaise Longhorn|r
    .turnin 5147 >>Rends ON RECHERCHE : Arnak Totem-sinistre
    .turnin 5064 >>Rends Espionner le Totem sinistre
    .target 10537
step
    .goto Thousand Needles,46.21,51.51
    >>Parle à |cRXP_FRIENDLY_Jandia|r
    .turnin 98069 >>Rends Les fournitures de Librevent volées
    .target 4877
    .isQuestComplete 98069
step
    .goto Thousand Needles,53.95,41.49
    >>Parle au |cRXP_FRIENDLY_Traqueur des plaines Dorn|r
    .turnin 1151 >>Rends L'épreuve de la Force
    .target 2986

-- ===== Salines de Miroitement : camp des courses =====
step
    .xp 29 >>Monte au niveau 29, requis pour les quêtes des Salines
step
    #completewith Kravel
    .goto Thousand Needles,77.79,77.27,40 >>Va au camp des courses des Salines de Miroitement
step
    #label Kravel
    .goto Thousand Needles,77.79,77.27
    >>Parle à |cRXP_FRIENDLY_Kravel Koalbeard|r
    .accept 1110 >>Accepte Pièces de chariot explosif
    .accept 5762 >>Accepte Hemet Nesingwary
    .target 4452
step
    .goto Thousand Needles,78.06,77.13
    >>Parle à |cRXP_FRIENDLY_Fizzle Brassbolts|r et |cRXP_FRIENDLY_Wizzle Brassbolts|r
    .accept 1104 >>Accepte Le venin acide des salines
    .accept 1105 >>Accepte Les carapaces durcies
    .target 4454
    .target 4453
step
    .goto Thousand Needles,80.18,75.88
    >>Parle à |cRXP_FRIENDLY_Pozzik|r
    .accept 1176 >>Accepte Allégement de la structure
    .target 4630
step
    .goto Thousand Needles,81.63,77.95
    >>Parle au |cRXP_FRIENDLY_Maître pisteur Zherin|r
    .accept 1175 >>Accepte Les cahots de la piste
    .target 4629
step
    #completewith FinSalines
    >>Ramasse les |cRXP_LOOT_Décombres de chariot explosif|r partout dans les Salines
    .complete 1110,1 --Pièces de chariot explosif (30)
step
    #completewith FinSalines
    >>Tue |cRXP_ENEMY_Scorpides|r, |cRXP_ENEMY_Tortues|r, |cRXP_ENEMY_Basilics|r et |cRXP_ENEMY_Vautours|r au passage
    .complete 1104,1 --Venin de scorpide acide (6)
    .complete 1105,1 --Carapace de tortue durcie (9)
    .complete 1176,1 --Os creux de vautour (10)
    .mob 4140
    .mob 4139
    .mob 4142
    .mob 4143
    .mob 4154
    .mob 4158
step
    .goto Thousand Needles,75.50,59.60,50,0
    .goto Thousand Needles,75.40,56.30,50,0
    .goto Thousand Needles,76.10,61.30
    >>Nord des Salines : |cRXP_ENEMY_Basilics du sel gemme|r, |cRXP_ENEMY_Tortues nacrétoiles|r, |cRXP_ENEMY_Scorpides ravageurs|r
    .complete 1175,1 --Basilic du sel gemme (10)
    .complete 1105,1 --Carapace de tortue durcie (9)
    .mob 4147
    .mob 4142
    .mob 4140
step
    .goto Thousand Needles,82.90,66.30,50,0
    .goto Thousand Needles,87.40,65.30,50,0
    .goto Thousand Needles,79.30,76.20
    >>Est des Salines : |cRXP_ENEMY_Peaux de cristal|r, |cRXP_ENEMY_Charognards|r, |cRXP_ENEMY_Mordeuses|r
    .complete 1175,2 --Peau de cristal du sel gemme (10)
    .complete 1104,1 --Venin de scorpide acide (6)
    .complete 1176,1 --Os creux de vautour (10)
    .mob 4151
    .mob 4154
    .mob 4143
    .mob 4139
step
    .goto Thousand Needles,67.58,63.94
    >>Parle à |cRXP_FRIENDLY_Moktar Krin|r
    .turnin 1146 >>Rends L'essaim s'agrandit
    .accept 1147 >>Accepte L'essaim s'agrandit
    .target 4483
    .isOnQuest 1146
step
    .goto Thousand Needles,69.00,86.00,40,0
    .goto Thousand Needles,65.10,86.20,40,0
    .goto Thousand Needles,69.90,83.30
    >>Tue les |cRXP_ENEMY_silithides|r au sud-ouest des Salines
    .complete 1147,1 --Chercheur silithide (5)
    .complete 1147,2 --Bourdon silithide (5)
    .complete 1147,3 --Envahisseur silithide (5)
    .mob 4130
    .mob 4133
    .mob 4131
    .isOnQuest 1147
step
    .goto Thousand Needles,67.58,63.94
    >>Parle à |cRXP_FRIENDLY_Moktar Krin|r
    .turnin 1147 >>Rends L'essaim s'agrandit
    .target 4483
    .isQuestComplete 1147
step
    #label FinSalines
    .goto Thousand Needles,77.80,88.60,50,0
    .goto Thousand Needles,79.30,79.20,50,0
    .goto Thousand Needles,77.80,88.60
    >>Sud des Salines : |cRXP_ENEMY_Contemplateurs du sel gemme|r, finis les pièces de chariot
    .complete 1175,3 --Contemplateur du sel gemme (6)
    .complete 1110,1 --Pièces de chariot explosif (30)
    .mob 4150
step
    .goto Thousand Needles,78.06,77.13
    >>Parle à |cRXP_FRIENDLY_Fizzle Brassbolts|r et |cRXP_FRIENDLY_Wizzle Brassbolts|r
    .turnin 1104 >>Rends Le venin acide des salines
    .turnin 1105 >>Rends Les carapaces durcies
    .target 4454
    .target 4453
step
    .goto Thousand Needles,78.06,77.13
    >>Parle à |cRXP_FRIENDLY_Fizzle Brassbolts|r
    .accept 1106 >>Accepte Martek l'Exilé
    .target 4454
step
    .goto Thousand Needles,77.79,77.27
    >>Parle à |cRXP_FRIENDLY_Kravel Koalbeard|r
    .turnin 1110 >>Rends Pièces de chariot explosif
    .target 4452
step
    .goto Thousand Needles,80.18,75.88
    >>Parle à |cRXP_FRIENDLY_Pozzik|r
    .turnin 1176 >>Rends Allégement de la structure
    .accept 1178 >>Accepte Mécénat gobelin
    .target 4630
step
    .goto Thousand Needles,81.63,77.95
    >>Parle au |cRXP_FRIENDLY_Maître pisteur Zherin|r
    .turnin 1175 >>Rends Les cahots de la piste
    .target 4629
step
    #label FinMillePointes
    +|cRXP_WARN_Niveau conseillé pour la suite : 30. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

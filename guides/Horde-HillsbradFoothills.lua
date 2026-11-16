if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Hillsbrad Foothills (Contreforts d'Hillsbrad), Horde, toutes classes.
-- Hub : Moulin-de-Tarren. Indépendant des autres régions : les quêtes venues d'ailleurs sont
-- protégées par .isOnQuest / .isQuestTurnedIn, et la chaîne de Thunder Bluff manquée est
-- signalée par l'étape d'alerte en tête de guide.
-- Route de vitesse en duo : quêtes de collecte lentes et élites de Dun Garok coupées.
-- Données : QuestieDB Forever (tools/questiedb.py). Syntaxe : docs/rxp-custom-guides.md.

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 23-24 Hillsbrad Foothills
#displayname [FDP] Hillsbrad Foothills (23-24)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 22-26 Ashenvale

-- ===== Alertes : quêtes à forte XP dont le prérequis se fait hors de la région =====
-- Visibles tant que la quête rapporte l'XP pleine (niveau de quête + 5).
step
    #sticky
    #completewith FinHillsbrad
    .isQuestAvailable 1066
    .isQuestAvailable 1065
    .isNotOnQuest 1065
    .maxlevel 28
    .xp 29 >>|cRXP_WARN_Chaîne manquée : Le sang des innocents (~4600 xp avec le retour). Suite de la chaîne des Réprouvés de Magatha Grimtotem à Thunder Bluff (70,31), qui mène à l'Apothicaire Zamah (22,21)|r

-- ===== Voyage : Orgrimmar -> Tirisfal -> Silverpine -> Moulin-de-Tarren =====
-- Chaque étape se termine à l'arrivée à Moulin-de-Tarren : qui arrive en vol depuis Fossoyeuse saute le trajet.
step
    #completewith ArriveeMoulin
    .goto Durotar,50.80,13.80,15 >>Prends le zeppelin de Durotar pour Tirisfal
    >>|cRXP_WARN_Si tu as déjà le point de vol de Moulin-de-Tarren, vole directement depuis Fossoyeuse|r
    .zoneskip Tirisfal Glades/Undercity/Silverpine Forest/Hillsbrad Foothills
step
    #completewith ArriveeMoulin
    .goto Silverpine Forest,42.80,40.87
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Renferrel|r au Sépulcre
    .accept 493 >>Accepte Voyage jusqu'aux contreforts d'Hillsbrad
    .target 1937
    .maxlevel 25
step
    #completewith ArriveeMoulin
    .goto Silverpine Forest,46.33,44.30,30,0
    .goto Silverpine Forest,61.47,67.47,40,0
    .goto Silverpine Forest,67.14,79.06,40,0
    .goto Hillsbrad Foothills,20.79,47.40,40 >>Suis la route vers le sud jusqu'à Hillsbrad
    >>|cRXP_WARN_Les Sorciers de Dalaran sur la route ralentissent avec leurs Eclairs de givre|r
step
    #completewith ArriveeMoulin
    .goto Hillsbrad Foothills,20.79,47.40
    >>Parle au |cRXP_FRIENDLY_Traqueur noir Lesh|r
    .accept 494 >>Accepte Prêts à frapper
    .target 2214
step
    #label ArriveeMoulin
    .goto Hillsbrad Foothills,60.14,18.62
    >>Rejoins Moulin-de-Tarren et parle à |cRXP_FRIENDLY_Zarise|r
    .fp Tarren Mill >>Prends le point de vol de Moulin-de-Tarren
    .target 2389

-- ===== Moulin-de-Tarren : prise des quêtes =====
step
    .goto Hillsbrad Foothills,61.44,19.06
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Lydon|r
    .turnin 493 >>Rends Voyage jusqu'aux contreforts d'Hillsbrad
    .target 2216
    .isOnQuest 493
step
    .goto Hillsbrad Foothills,61.44,19.06
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Lydon|r
    .turnin 1065 >>Rends Un voyage vers Moulin-de-Tarren
    .target 2216
    .isOnQuest 1065
step
    .goto Hillsbrad Foothills,61.44,19.06
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Lydon|r
    .accept 1066 >>Accepte Le sang des innocents
    .target 2216
    .isQuestTurnedIn 1065
step
    .goto Hillsbrad Foothills,62.78,19.03
    >>Parle à |cRXP_FRIENDLY_Shay l'aubergiste|r
    .home >>Fixe ta pierre de foyer à Moulin-de-Tarren : la chaîne de la bataille y revient cinq fois
    .target 2388
step
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .turnin 494 >>Rends Prêts à frapper
    .target 2215
    .isOnQuest 494
step
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .accept 527 >>Accepte La bataille d'Hillsbrad
    .target 2215
step
    .goto Hillsbrad Foothills,62.60,19.70
    >>Clique sur l'affiche |cRXP_PICK_Dangereux !|r
    .accept 567 >>Accepte Dangereux !
step
    .goto Hillsbrad Foothills,62.60,20.80
    >>Clique sur l'affiche |cRXP_PICK_ON RECHERCHE|r
    .accept 549 >>Accepte ON RECHERCHE : Personnel du Syndicat
step
    .goto Hillsbrad Foothills,63.24,20.66
    >>Parle à |cRXP_FRIENDLY_Krusk|r
    .accept 498 >>Accepte Sauvetage
    .target 2229

-- ===== Camp du Syndicat et donjon de Fort-de-Durn =====
step
    #completewith Durnholde
    >>Tue les |cRXP_ENEMY_Voleurs|r et |cRXP_ENEMY_Sentinelles du Syndicat|r
    .complete 549,1 --Voleur du Syndicat (10)
    .complete 549,2 --Sentinelle du Syndicat (10)
    .mob 2260
    .mob 2261
step
    #completewith Durnholde
    >>Tue les |cRXP_ENEMY_Mages de l'ombre du Syndicat|r pour les |cRXP_LOOT_Fioles de sang d'innocent|r
    .complete 1066,1 --Fiole de sang d'innocent (5)
    .mob 2244
    .isOnQuest 1066
step
    .goto Hillsbrad Foothills,65.40,46.60,30,0
    .goto Hillsbrad Foothills,67.10,47.70,30,0
    .goto Hillsbrad Foothills,66.70,50.00,30,0
    .goto Hillsbrad Foothills,76.72,46.22,40 >>Nettoie le camp du Syndicat au sud de Moulin-de-Tarren, puis entre dans Fort-de-Durn
step
    .goto Hillsbrad Foothills,79.60,41.83
    >>Tue le |cRXP_ENEMY_Geôlier Eston|r pour la |cRXP_LOOT_Clé en fer terne|r
    >>|cRXP_WARN_Chacun a besoin de sa clé : attends sa réapparition si l'autre n'a rien eu|r
    .collect 3467,1,498,1 --Clé en fer terne
    .mob 2427
step
    .goto Hillsbrad Foothills,79.49,40.57
    >>Tue le |cRXP_ENEMY_Geôlier Marlgen|r pour la |cRXP_LOOT_Clé en or bruni|r
    >>|cRXP_WARN_Chacun a besoin de sa clé : attends sa réapparition si l'autre n'a rien eu|r
    .collect 3499,1,498,1 --Clé en or bruni
    .mob 2428
step
    .goto Hillsbrad Foothills,79.80,39.60
    >>Ouvre le |cRXP_PICK_Boulet et chaîne verrouillés|r de Tog'thar
    .complete 498,2 --Libérer Tog'thar
step
    .goto Hillsbrad Foothills,75.30,41.50
    >>Ouvre le |cRXP_PICK_Boulet et chaîne verrouillés|r de Drull
    .complete 498,1 --Libérer Drull
step
    #label Durnholde
    .goto Hillsbrad Foothills,75.29,40.17,30,0
    .goto Hillsbrad Foothills,78.25,41.30,30,0
    .goto Hillsbrad Foothills,79.70,43.22,30,0
    .goto Hillsbrad Foothills,81.82,45.15,30,0
    .goto Hillsbrad Foothills,82.24,42.50,30,0
    .goto Hillsbrad Foothills,79.58,46.88,30,0
    .goto Hillsbrad Foothills,76.47,46.62
    >>Finis les |cRXP_ENEMY_Voleurs|r et |cRXP_ENEMY_Sentinelles du Syndicat|r
    .complete 549,1 --Voleur du Syndicat (10)
    .complete 549,2 --Sentinelle du Syndicat (10)
    .mob 2260
    .mob 2261
    .mob 2244
step
    .goto Hillsbrad Foothills,79.77,43.42,30,0
    .goto Hillsbrad Foothills,78.73,43.51,30,0
    .goto Hillsbrad Foothills,76.01,42.03
    >>Finis les |cRXP_ENEMY_Mages de l'ombre du Syndicat|r pour les |cRXP_LOOT_Fioles de sang d'innocent|r
    .complete 1066,1 --Fiole de sang d'innocent (5)
    .mob 2244
    .isOnQuest 1066

-- ===== Champs d'Hillsbrad : fermes (bataille 1) =====
step
    #completewith Bataille2
    >>Tue le |cRXP_ENEMY_Citoyen Wilkes|r (il patrouille sur les routes du village) et |cRXP_ENEMY_Kalaba la fermière|r (36,47) quand tu les croises
    .complete 567,2 --Citoyen Wilkes
    .complete 567,4 --Kalaba la fermière
    .unitscan 2449
    .mob 2451
step
    #completewith Getz
    .goto Hillsbrad Foothills,36.02,39.19,60 >>Traverse les collines vers l'ouest jusqu'aux champs d'Hillsbrad
step
    #completewith Getz
    >>Tue les |cRXP_ENEMY_Fermiers|r et |cRXP_ENEMY_Ouvriers agricoles d'Hillsbrad|r
    .complete 527,1 --Fermier d'Hillsbrad (6)
    .complete 527,2 --Ouvrier agricole d'Hillsbrad (6)
    .mob 2266
    .mob 2360
step
    .goto Hillsbrad Foothills,33.21,34.78
    >>Tue |cRXP_ENEMY_Ray le fermier|r. Il est dans la vigne ou dans la maison (rez-de-chaussée ou étage)
    .complete 527,3 --Ray le fermier
    .unitscan 232
step
    #label Getz
    .goto Hillsbrad Foothills,35.39,37.70
    >>Tue |cRXP_ENEMY_Getz le fermier|r. Il est dans la maison, le champ ou la grange
    .complete 527,4 --Getz le fermier
    .unitscan 2403
step
    .goto Hillsbrad Foothills,35.90,40.63,30,0
    .goto Hillsbrad Foothills,33.88,41.80,30,0
    .goto Hillsbrad Foothills,35.20,47.40,30,0
    .goto Hillsbrad Foothills,36.80,41.30
    >>Finis les |cRXP_ENEMY_Fermiers|r et |cRXP_ENEMY_Ouvriers agricoles d'Hillsbrad|r
    .complete 527,1 --Fermier d'Hillsbrad (6)
    .complete 527,2 --Ouvrier agricole d'Hillsbrad (6)
    .mob 2266
    .mob 2360

-- ===== Retour à Moulin-de-Tarren =====
step
    #completewith Rendus1
    .goto Hillsbrad Foothills,62.33,20.45,40 >>Retourne à Moulin-de-Tarren
step
    .goto Hillsbrad Foothills,63.24,20.66
    >>Parle à |cRXP_FRIENDLY_Krusk|r
    .turnin 498 >>Rends Sauvetage
    .target 2229
step
    .goto Hillsbrad Foothills,61.44,19.06
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Lydon|r
    .turnin 1066 >>Rends Le sang des innocents
    .accept 1067 >>Accepte Le retour à Thunder Bluff
    >>|cRXP_WARN_Le retour à Thunder Bluff se rend à l'Apothicaire Zamah, lors de ton prochain passage à Thunder Bluff|r
    .target 2216
    .isQuestComplete 1066
step
    #label Rendus1
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .turnin 549 >>Rends ON RECHERCHE : Personnel du Syndicat
    .turnin 527 >>Rends La bataille d'Hillsbrad
    .accept 528 >>Accepte La bataille d'Hillsbrad
    .target 2215

-- ===== Bataille 2 : paysans =====
step
    #completewith Bataille2
    .goto Hillsbrad Foothills,34.10,45.70,60 >>Retourne aux champs d'Hillsbrad
step
    #label Bataille2
    .goto Hillsbrad Foothills,36.64,45.21,30,0
    .goto Hillsbrad Foothills,33.82,45.75,30,0
    .goto Hillsbrad Foothills,33.25,48.54,30,0
    .goto Hillsbrad Foothills,30.30,40.30,30,0
    .goto Hillsbrad Foothills,35.29,47.28
    >>Tue les |cRXP_ENEMY_Paysans d'Hillsbrad|r
    .complete 528,1 --Paysan d'Hillsbrad (15)
    .mob 2267
step
    .goto Hillsbrad Foothills,35.90,46.60
    >>Tue |cRXP_ENEMY_Kalaba la fermière|r si ce n'est pas fait
    .complete 567,4 --Kalaba la fermière
    .mob 2451
step
    #completewith Rendus2
    .goto Hillsbrad Foothills,62.33,20.45,40 >>Retourne à Moulin-de-Tarren
step
    #label Rendus2
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .turnin 528 >>Rends La bataille d'Hillsbrad
    .accept 529 >>Accepte La bataille d'Hillsbrad
    .accept 98094 >>Accepte Soutien aux éclaireurs
    .target 2215

-- ===== Bataille 3 : la forge =====
step
    #completewith Forge
    .goto Hillsbrad Foothills,32.10,44.40,60 >>Va à la forge d'Hillsbrad
step
    #completewith Forge
    >>Tue les |cRXP_ENEMY_Apprentis forgerons d'Hillsbrad|r
    .complete 529,2 --Apprenti forgeron d'Hillsbrad (4)
    .mob 2265
step
    .goto Hillsbrad Foothills,32.01,45.45
    >>Ramasse le |cRXP_PICK_Chargement de fer|r au sol, dans la forge
    .complete 529,3 --Chargement de fer
step
    #label Forge
    .goto Hillsbrad Foothills,32.10,44.40
    >>Tue le |cRXP_ENEMY_Forgeron Verringtan|r et finis les |cRXP_ENEMY_Apprentis forgerons|r
    .complete 529,1 --Forgeron Verringtan
    .complete 529,2 --Apprenti forgeron d'Hillsbrad (4)
    .mob 2404
    .mob 2265
step
    .goto Hillsbrad Foothills,32.56,40.03,30,0
    .goto Hillsbrad Foothills,32.66,36.08,30,0
    .goto Hillsbrad Foothills,36.54,39.44
    >>Tue le |cRXP_ENEMY_Citoyen Wilkes|r si ce n'est pas fait. Il patrouille sur les routes du village
    .complete 567,2 --Citoyen Wilkes
    .unitscan 2449
step
    #completewith Rendus3
    .goto Hillsbrad Foothills,62.33,20.45,40 >>Retourne à Moulin-de-Tarren
step
    #label Rendus3
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .turnin 529 >>Rends La bataille d'Hillsbrad
    .accept 532 >>Accepte La bataille d'Hillsbrad
    .target 2215

-- ===== Bataille 4 : l'hôtel de ville =====
step
    #completewith HotelDeVille
    .goto Hillsbrad Foothills,30.10,42.00,60 >>Va à l'hôtel de ville d'Hillsbrad
step
    #completewith HotelDeVille
    >>Tue les |cRXP_ENEMY_Conseillers d'Hillsbrad|r
    .complete 532,2 --Conseiller d'Hillsbrad (5)
    .mob 2387
step
    .goto Hillsbrad Foothills,29.50,42.40
    >>Tue le |cRXP_ENEMY_Commis Horrace Whitesteed|r dans l'hôtel de ville
    .complete 567,1 --Commis Horrace Whitesteed
    .mob 2448
step
    .goto Hillsbrad Foothills,29.70,41.60
    >>Tue le |cRXP_ENEMY_Magistrat Burnside|r (niveau 30) dans l'hôtel de ville
    >>|cRXP_WARN_Niveau 30 : engage-le à deux, après avoir nettoyé les conseillers autour|r
    .complete 532,1 --Magistrat Burnside
    .mob 2335
step
    .goto Hillsbrad Foothills,29.70,41.80
    >>Détruis la |cRXP_PICK_Proclamation d'Hillsbrad|r
    .complete 532,3 --Proclamation d'Hillsbrad détruite
step
    .goto Hillsbrad Foothills,29.50,41.50
    >>Prends le |cRXP_PICK_Registre municipal d'Hillsbrad|r
    .complete 532,4 --Registre municipal d'Hillsbrad
step
    #label HotelDeVille
    .goto Hillsbrad Foothills,29.60,39.70,25,0
    .goto Hillsbrad Foothills,30.20,43.50,25,0
    .goto Hillsbrad Foothills,32.40,46.40,25,0
    .goto Hillsbrad Foothills,30.10,41.10
    >>Finis les |cRXP_ENEMY_Conseillers d'Hillsbrad|r
    .complete 532,2 --Conseiller d'Hillsbrad (5)
    .mob 2387
step
    #completewith Rendus4
    .goto Hillsbrad Foothills,62.33,20.45,40 >>Retourne à Moulin-de-Tarren
step
    #label Rendus4
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .turnin 532 >>Rends La bataille d'Hillsbrad
    .accept 539 >>Accepte La bataille d'Hillsbrad
    .target 2215

-- ===== Bataille 5 : la mine =====
step
    #completewith Bonds
    .goto Hillsbrad Foothills,31.80,52.70,60 >>Va à la mine au sud des champs d'Hillsbrad
step
    #completewith Bonds
    >>Tue les |cRXP_ENEMY_Mineurs d'Hillsbrad|r
    .complete 539,2 --Mineur d'Hillsbrad (10)
    .mob 2269
step
    .goto Hillsbrad Foothills,31.80,52.70
    >>Tue le |cRXP_ENEMY_Mineur Hackett|r (niveau 29)
    .complete 567,3 --Mineur Hackett
    .mob 2450
step
    #label Bonds
    .goto Hillsbrad Foothills,31.20,56.00
    >>Tue le |cRXP_ENEMY_Contremaître Bonds|r (niveau 30) au fond de la mine
    >>|cRXP_WARN_Niveau 30 : vide la salle avant de l'engager à deux|r
    .complete 539,1 --Contremaître Bonds
    .mob 2305
step
    .goto Hillsbrad Foothills,32.40,52.00,25,0
    .goto Hillsbrad Foothills,28.90,57.50,25,0
    .goto Hillsbrad Foothills,31.50,52.40
    >>Finis les |cRXP_ENEMY_Mineurs d'Hillsbrad|r
    .complete 539,2 --Mineur d'Hillsbrad (10)
    .mob 2269
step
    #completewith Rendus5
    .goto Hillsbrad Foothills,62.33,20.45,40 >>Retourne à Moulin-de-Tarren. Utilise ta pierre de foyer si elle est disponible
step
    #label Rendus5
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .turnin 539 >>Rends La bataille d'Hillsbrad
    .turnin 567 >>Rends Dangereux !
    .target 2215

-- ===== Sud de Moulin-de-Tarren : éclaireur et fleurs de fangemufle =====
step
    .xp 24 >>Monte au niveau 24, requis pour L'élixir d'agonie
step
    .goto Hillsbrad Foothills,61.44,19.06
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Lydon|r
    .accept 509 >>Accepte L'élixir d'agonie
    .target 2216
step
    .goto Hillsbrad Foothills,63.58,53.11
    >>Parle au |cRXP_FRIENDLY_Nécrotraqueur Masoj|r, au sud du camp du Syndicat
    .turnin 98094 >>Rends Soutien aux éclaireurs
    .accept 98095 >>Accepte Positions stratégiques
    .target 270438
step
    .goto Hillsbrad Foothills,63.50,62.50,25,0
    .goto Hillsbrad Foothills,65.20,60.20,25,0
    .goto Hillsbrad Foothills,64.60,61.20,25,0
    .goto Hillsbrad Foothills,65.10,62.50
    >>Ramasse les |cRXP_LOOT_Fleurs de fangemufle|r au sol
    .complete 509,1 --Fleurs de fangemufle (6)
step
    >>Pose les trois |cRXP_LOOT_Fioles d'apothicaire|r sur des sommets autour d'Hillsbrad
    >>|cRXP_WARN_Emplacement non documenté dans Questie : note où tu les poses|r
    +Fioles posées sur les trois sommets
    .isOnQuest 98095
step
    .goto Hillsbrad Foothills,63.58,53.11
    >>Parle au |cRXP_FRIENDLY_Nécrotraqueur Masoj|r
    .turnin 98095 >>Rends Positions stratégiques
    .target 270438
    .isQuestComplete 98095

-- ===== Moulin-de-Tarren : derniers rendus =====
step
    #completewith Agonie
    .goto Hillsbrad Foothills,61.44,19.06,40 >>Retourne à Moulin-de-Tarren
step
    #label Agonie
    .goto Hillsbrad Foothills,61.44,19.06
    >>Parle à l'|cRXP_FRIENDLY_Apothicaire Lydon|r
    .turnin 509 >>Rends L'élixir d'agonie
    .accept 513 >>Accepte L'élixir d'agonie
    >>|cRXP_WARN_La suite se rend au Maître apothicaire Faranell à Fossoyeuse, lors de ton prochain passage|r
    .target 2216
step
    #label FinHillsbrad
    +|cRXP_WARN_Niveau conseillé pour la suite : 24. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

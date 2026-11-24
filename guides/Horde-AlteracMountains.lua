if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Alterac Mountains (Montagnes d'Alterac), Horde, toutes classes.
-- Hub : Moulin-de-Tarren. Reprend aussi les quêtes de niveau 29+ de Moulin-de-Tarren que le
-- guide Hillsbrad (23-24) laisse de côté, sans refaire celles qu'il fait déjà.
-- Indépendant des autres régions : les quêtes venues d'ailleurs sont protégées par
-- .isOnQuest / .isQuestTurnedIn. Les quêtes au-dessus du niveau sont sautées par .xp <N,1.
-- Route : Dun Garok, camp du Syndicat, grotte des yétis, flammes, Dalaran, tombeau
-- d'Helcular, puis Strahnbrande en dernier (mobs 34-37) et, à partir du niveau 35, le nord.
-- Coupées : 556/557 Runes gravées et Bracelets de liaison (~42 puis ~62 kills en duo),
-- 93680/545 Clé de la ville et Patrouilles de Dalaran (objet de la clé sans position dans
-- Questie, second aller-retour à Dalaran), 7321 Bisque de tortue (~69 kills pour 2500 xp),
-- 515/517/524 Elixir d'agonie (potion d'alchimie requise), 518-521 Couronne de Volonté
-- (élites 36-43), 1136 Gueule-glacée (niveau 37,
-- rendue à Thunder Bluff), quêtes de la Cité de Dalaran (donjon Forever).
-- Données : QuestieDB Forever (tools/questiedb.py). Syntaxe : docs/rxp-custom-guides.md.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 30-31 Alterac Mountains
#displayname [FDP] Montagnes d'Alterac (30-31)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 30-32 Desolace

-- ===== Alerte : prérequis de la chaîne de Krusk fait dans le guide Hillsbrad =====
step
    #sticky
    #completewith FinAlterac
    .isQuestAvailable 498
    .maxlevel 38
    .xp 39 >>|cRXP_WARN_Sauvetage n'est pas rendue : Infiltration et sa suite chez Krusk (~7600 xp) restent fermées. Fais Sauvetage avec le guide Hillsbrad (23-24)|r

-- ===== Voyage jusqu'à Moulin-de-Tarren =====
step
    #completewith ArriveeMoulin
    .goto Durotar,50.80,13.80,15 >>Prends le zeppelin de Durotar pour Tirisfal
    >>|cRXP_WARN_Si tu as déjà le point de vol de Moulin-de-Tarren, vole directement depuis Fossoyeuse|r
    .zoneskip Tirisfal Glades/Undercity/Silverpine Forest/Hillsbrad Foothills/Alterac Mountains
step
    #completewith ArriveeMoulin
    .goto Silverpine Forest,46.33,44.30,30,0
    .goto Silverpine Forest,61.47,67.47,40,0
    .goto Silverpine Forest,67.14,79.06,40,0
    .goto Hillsbrad Foothills,20.79,47.40,40 >>Suis la route vers le sud jusqu'à Hillsbrad
    .zoneskip Hillsbrad Foothills/Alterac Mountains
step
    #label ArriveeMoulin
    .goto Hillsbrad Foothills,60.14,18.62
    >>Rejoins Moulin-de-Tarren et parle à |cRXP_FRIENDLY_Zarise|r
    .fp Tarren Mill >>Prends le point de vol de Moulin-de-Tarren
    .target 2389

-- ===== Moulin-de-Tarren : prise des quêtes =====
step
    .goto Hillsbrad Foothills,62.78,19.03
    >>Parle à |cRXP_FRIENDLY_Shay l'aubergiste|r
    .home >>Fixe ta pierre de foyer à Moulin-de-Tarren
    .target 2388
step
    .goto Hillsbrad Foothills,63.88,19.66
    >>Parle au |cRXP_FRIENDLY_Novice Thaivand|r
    .accept 552 >>Accepte La vengeance d'Helcular
    .target 2429
step
    .goto Hillsbrad Foothills,63.24,20.66
    >>Parle à |cRXP_FRIENDLY_Krusk|r
    .accept 533 >>Accepte Infiltration
    .target 2229
    .isQuestTurnedIn 498
step
    .goto Hillsbrad Foothills,62.76,20.21
    >>Parle au |cRXP_FRIENDLY_Garde noir Humbert|r
    .accept 547 >>Accepte Epée d'Humbert
    .target 2419
step
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .accept 541 >>Accepte La bataille d'Hillsbrad
    .target 2215
    .isQuestTurnedIn 539
step
    .goto Hillsbrad Foothills,61.60,20.85
    >>Parle au |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
    .accept 544 >>Accepte L'invasion de la prison
    .target 2410

-- ===== Dun Garok =====
step
    #completewith DunGarok
    .goto Hillsbrad Foothills,63.58,53.11,40,0
    .goto Hillsbrad Foothills,70.00,74.00,40 >>Descends au sud jusqu'à Dun Garok
step
    #completewith DunGarok
    >>Tue les |cRXP_ENEMY_Montagnards|r, |cRXP_ENEMY_Fusiliers|r et |cRXP_ENEMY_Prêtresses de Dun Garok|r
    >>|cRXP_WARN_Ce sont des élites 28-30 : tire-les un par un, tuez d'abord les Prêtresses|r
    .complete 541,1 --Montagnard de Dun Garok (8)
    .complete 541,2 --Fusilier de Dun Garok (4)
    .complete 541,3 --Prêtresse de Dun Garok (2)
    .mob 2344
    .mob 2345
    .mob 2346
    .isOnQuest 541
step
    #completewith DunGarok
    >>Ramasse l'|cRXP_LOOT_Epée d'Humbert|r sur les nains de Dun Garok. Chacun doit looter la sienne (~30 kills en duo)
    .complete 547,1 --Epée d'Humbert
    .mob 2344
    .mob 2345
    .mob 2346
step
    .goto Hillsbrad Foothills,72.58,80.03
    >>Tue le |cRXP_ENEMY_Capitaine Ironhill|r (élite 32), au fond de Dun Garok
    .complete 541,4 --Capitaine Ironhill
    .mob 2304
    .isOnQuest 541
step
    .goto Hillsbrad Foothills,70.00,77.00,30,0
    .goto Hillsbrad Foothills,72.00,80.00,30,0
    .goto Hillsbrad Foothills,73.00,82.00,30,0
    .goto Hillsbrad Foothills,71.00,75.00,30,0
    .goto Hillsbrad Foothills,71.00,79.00
    >>Finis les élites de Dun Garok
    .complete 541,1 --Montagnard de Dun Garok (8)
    .complete 541,2 --Fusilier de Dun Garok (4)
    .complete 541,3 --Prêtresse de Dun Garok (2)
    .mob 2344
    .mob 2345
    .mob 2346
    .isOnQuest 541
step
    #label DunGarok
    .goto Hillsbrad Foothills,70.00,77.00,30,0
    .goto Hillsbrad Foothills,72.00,80.00,30,0
    .goto Hillsbrad Foothills,73.00,82.00,30,0
    .goto Hillsbrad Foothills,71.00,75.00,30,0
    .goto Hillsbrad Foothills,71.00,79.00
    >>Tue les nains jusqu'à l'|cRXP_LOOT_Epée d'Humbert|r
    .complete 547,1 --Epée d'Humbert
    .mob 2344
    .mob 2345
    .mob 2346

-- ===== Retour à Moulin-de-Tarren =====
step
    #completewith Rendus1
    .goto Hillsbrad Foothills,62.33,20.45,40 >>Retourne à Moulin-de-Tarren
step
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .turnin 541 >>Rends La bataille d'Hillsbrad
    .accept 550 >>Accepte La bataille d'Hillsbrad
    >>|cRXP_WARN_La suite se rend à Varimathras à Fossoyeuse, lors de ton prochain passage|r
    .target 2215
    .isOnQuest 541
step
    #label Rendus1
    .goto Hillsbrad Foothills,62.76,20.21
    >>Parle au |cRXP_FRIENDLY_Garde noir Humbert|r
    .turnin 547 >>Rends Epée d'Humbert
    .target 2419

-- ===== Camp du Syndicat =====
step
    #completewith Valik
    .goto Alterac Mountains,57.17,69.51,30 >>Monte au nord dans les montagnes d'Alterac jusqu'au camp du Syndicat
step
    #completewith Missives
    >>Tue les |cRXP_ENEMY_Détrousseurs|r et |cRXP_ENEMY_Larrons du Syndicat|r pour la |cRXP_LOOT_Missive du Syndicat|r
    >>|cRXP_WARN_Farm long en duo (~60 kills) : chacun doit looter ses objets|r
    .complete 533,1 --Missive du Syndicat
    .mob 2240
    .mob 2241
    .isOnQuest 533
step
    #label Valik
    .goto Alterac Mountains,57.17,69.51
    >>Parle à |cRXP_FRIENDLY_Valik le malfrat|r
    .accept 535 >>Accepte Valik
    .target 2333
step
    .goto Alterac Mountains,59.30,69.76,20,0
    .goto Alterac Mountains,58.66,67.21
    >>Tue les |cRXP_ENEMY_Détrousseurs ivres|r pour la |cRXP_LOOT_Bière d'Austrivage|r
    .complete 535,1 --Bière d'Austrivage
    .mob 2440
step
    .goto Alterac Mountains,57.17,69.51
    >>Parle à |cRXP_FRIENDLY_Valik le malfrat|r
    .turnin 535 >>Rends Valik
    .target 2333
step
    #label Missives
    .goto Alterac Mountains,58.50,68.00,30,0
    .goto Alterac Mountains,56.50,66.00,30,0
    .goto Alterac Mountains,48.00,80.00,30,0
    .goto Alterac Mountains,48.50,82.50,30,0
    .goto Alterac Mountains,58.50,68.00
    >>Tourne entre le camp et le groupe du sud-ouest jusqu'à la |cRXP_LOOT_Missive du Syndicat|r
    .complete 533,1 --Missive du Syndicat
    .mob 2240
    .mob 2241
    .isOnQuest 533
step
    #completewith next
    .goto Hillsbrad Foothills,63.24,20.66,40 >>Retourne à Moulin-de-Tarren
    .isOnQuest 533
step
    .goto Hillsbrad Foothills,63.24,20.66
    >>Parle à |cRXP_FRIENDLY_Krusk|r
    .turnin 533 >>Rends Infiltration
    .accept 503 >>Accepte Gol'dir
    .target 2229
    .isOnQuest 533

-- ===== Grotte des yétis : bâtonnet d'Helcular =====
step
    #completewith Baton
    .goto Hillsbrad Foothills,46.50,31.50,30 >>Va à la grotte des yétis, à l'ouest de Moulin-de-Tarren
step
    #label Baton
    .goto Hillsbrad Foothills,46.50,31.50,25,0
    .goto Hillsbrad Foothills,45.00,29.50,25,0
    .goto Hillsbrad Foothills,44.00,27.00,25,0
    .goto Hillsbrad Foothills,43.00,32.50,25,0
    .goto Hillsbrad Foothills,45.00,30.50
    >>Tue les |cRXP_ENEMY_Yétis des grottes|r et |cRXP_ENEMY_Yétis féroces|r pour le |cRXP_LOOT_Bâtonnet d'Helcular|r
    >>|cRXP_WARN_Farm long en duo (~50 kills) : chacun doit looter ses objets|r
    .complete 552,1 --Bâtonnet d'Helcular
    .mob 2248
    .mob 2249
step
    #completewith next
    .goto Hillsbrad Foothills,63.88,19.66,40 >>Retourne à Moulin-de-Tarren
step
    .goto Hillsbrad Foothills,63.88,19.66
    >>Parle au |cRXP_FRIENDLY_Novice Thaivand|r
    .turnin 552 >>Rends La vengeance d'Helcular
    .accept 553 >>Accepte La vengeance d'Helcular
    .target 2429

-- ===== Les trois flammes =====
step
    .goto Hillsbrad Foothills,46.50,31.50,25,0
    .goto Hillsbrad Foothills,43.89,28.06
    >>Retourne dans la grotte. Utilise le |cRXP_LOOT_Bâtonnet d'Helcular|r près de la |cRXP_PICK_Flamme d'Azel|r (ou clique la flamme)
    .complete 553,1 --Flamme d'Azel chargée
    .use 3710
step
    .goto Hillsbrad Foothills,44.05,26.55
    >>Utilise le |cRXP_LOOT_Bâtonnet d'Helcular|r près de la |cRXP_PICK_Flamme de Veraz|r (ou clique la flamme)
    .complete 553,2 --Flamme de Veraz chargée
    .use 3710
step
    #completewith next
    .goto Alterac Mountains,37.55,66.24,30 >>Va au nord jusqu'à la grotte des Yétis des montagnes, dans Alterac
step
    .goto Alterac Mountains,37.55,66.24
    >>Utilise le |cRXP_LOOT_Bâtonnet d'Helcular|r près de la |cRXP_PICK_Flamme d'Uzel|r (ou clique la flamme)
    >>|cRXP_WARN_Si quelqu'un a invoqué Gueule-glacée (niveau 37) près de la flamme, attends qu'il parte|r
    .complete 553,3 --Flamme d'Uzel chargée
    .use 3710
    .mob 2250

-- ===== Dalaran : les traîtres =====
step
    #completewith Prison
    .goto Alterac Mountains,20.00,82.00,40 >>Va à l'ouest jusqu'au camp de Dalaran, au bord du lac Lordamere
step
    #label Prison
    .goto Alterac Mountains,20.16,84.28,15,0
    .goto Alterac Mountains,19.91,85.97,15,0
    .goto Alterac Mountains,20.34,86.40,15,0
    .goto Alterac Mountains,17.80,83.20
    >>Tue |cRXP_ENEMY_Ricter|r, |cRXP_ENEMY_Dermot|r, |cRXP_ENEMY_Alina|r et |cRXP_ENEMY_Kegan Darkmar|r pour leurs pierres de sang
    .complete 544,1 --Coeur de pierre de sang (Dermot)
    .complete 544,2 --Pierre de sang marbrée (Ricter)
    .complete 544,3 --Eclat de pierre de sang (Alina)
    .complete 544,4 --Pierre de sang ovale (Kegan Darkmar)
    .mob 2411
    .mob 2413
    .mob 2412
    .mob 2414

-- ===== Austrivage : tombeau d'Helcular =====
step
    #completewith Tombeau
    .goto Hillsbrad Foothills,52.75,53.37,30 >>Descends le long du lac jusqu'au cimetière au nord d'Austrivage
    >>|cRXP_WARN_Austrivage est une ville de l'Alliance : approche par le nord et évite les gardes|r
step
    #label Tombeau
    .goto Hillsbrad Foothills,52.75,53.37
    >>Plante le bâtonnet chargé dans le |cRXP_PICK_Tombeau d'Helcular|r
    .turnin 553 >>Rends La vengeance d'Helcular
    .isOnQuest 553

-- ===== Moulin-de-Tarren =====
step
    #completewith next
    .goto Hillsbrad Foothills,61.60,20.85,40 >>Retourne à Moulin-de-Tarren
step
    .goto Hillsbrad Foothills,61.60,20.85
    >>Parle au |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
    .turnin 544 >>Rends L'invasion de la prison
    .target 2410

-- ===== Strahnbrande : Gol'dir =====
step
    #completewith Goldir
    .goto Alterac Mountains,60.50,44.00,40 >>Monte au nord jusqu'à Strahnbrande
    >>|cRXP_WARN_Mobs 34-37 : tire-les un par un. Le Baron Vardus (niveau 40) peut apparaître près de Gol'dir|r
    .isOnQuest 503
step
    #completewith Goldir
    >>Si une |cRXP_ENEMY_Sorcière du Syndicat|r ou un |cRXP_ENEMY_Mage de l'ombre d'Argus|r lâche la |cRXP_LOOT_Note roussie|r, utilise-la pour lancer la quête
    .collect 213421,1,95534,1 --Note roussie
    .accept 95534 >>Accepte Le mystère de Strahnbrande
    .use 213421
    .mob 2319
    .mob 2318
step
    .goto Alterac Mountains,60.80,43.60,20,0
    .goto Alterac Mountains,62.40,40.20,20,0
    .goto Alterac Mountains,63.00,43.40
    >>Tue les |cRXP_ENEMY_Geôliers Borhuin|r (niveau 37) pour la |cRXP_LOOT_Clé rouillée en fer|r. Chacun a besoin de la sienne
    .collect 3704,1,503,1 --Clé rouillée en fer
    .mob 2431
    .isOnQuest 503
step
    #label Goldir
    .goto Alterac Mountains,59.96,43.74
    >>Libère |cRXP_FRIENDLY_Gol'dir|r avec la clé
    .complete 503,1 --Libérer Gol'dir
    .complete 503,2 --Clé rouillée en fer
    .isOnQuest 503
step
    .goto Alterac Mountains,59.96,43.74
    >>Parle à |cRXP_FRIENDLY_Gol'dir|r
    .turnin 503 >>Rends Gol'dir
    .accept 506 >>Accepte L'héritage de Blackmoore
    .target 2316
    .isOnQuest 503
step
    >>|cRXP_WARN_Le mystère de Strahnbrande : objectif non documenté dans Questie, suis le texte de la quête et note ce qu'il faut faire|r
    +Mystère de Strahnbrande résolu
    .isOnQuest 95534

-- ===== Moulin-de-Tarren : rendus =====
step
    #completewith next
    .goto Hillsbrad Foothills,63.24,20.66,40 >>Retourne à Moulin-de-Tarren
step
    .goto Hillsbrad Foothills,63.24,20.66
    >>Parle à |cRXP_FRIENDLY_Krusk|r
    .turnin 506 >>Rends L'héritage de Blackmoore
    .target 2229
    .isOnQuest 506
step
    .goto Hillsbrad Foothills,63.24,20.66
    >>Parle à |cRXP_FRIENDLY_Krusk|r
    .accept 507 >>Accepte Seigneur Aliden Perenolde
    .target 2229
    .isQuestTurnedIn 506
    .xp <35,1
step
    .goto Hillsbrad Foothills,63.66,21.16
    >>Parle à |cRXP_FRIENDLY_Shara Blazen|r
    .turnin 95534 >>Rends Le mystère de Strahnbrande
    .target 2402
    .isQuestComplete 95534
step
    .goto Hillsbrad Foothills,62.60,20.80
    >>Clique sur l'affiche |cRXP_PICK_ON RECHERCHE|r
    .accept 566 >>Accepte ON RECHERCHE : baron Vardus
    .isQuestTurnedIn 549
    .xp <35,1
step
    .goto Hillsbrad Foothills,61.87,19.57
    >>Parle à |cRXP_FRIENDLY_Tallow|r
    .accept 676 >>Accepte Menace sur le Trépas-d'Orgrim
    >>|cRXP_WARN_Objectifs et rendu dans les hautes-terres d'Arathi, à faire avec le guide Arathi|r
    .target 2770

-- ===== Nord d'Alterac (niveau 35+) : Vardus et Perenolde =====
step
    #completewith Perenolde
    >>Tue le |cRXP_ENEMY_Baron Vardus|r (niveau 40) s'il est là et prends sa |cRXP_LOOT_Tête|r
    .complete 566,1 --Tête du baron Vardus
    .unitscan 2306
    .isOnQuest 566
step
    #completewith Perenolde
    .goto Alterac Mountains,56.28,26.70,40,0
    .goto Alterac Mountains,53.67,20.40,40,0
    .goto Alterac Mountains,39.32,14.58,30 >>Monte au nord jusqu'au domaine de Perenolde
    .isOnQuest 507
step
    #label Perenolde
    .goto Alterac Mountains,39.32,14.58
    >>Tue le |cRXP_ENEMY_Seigneur Aliden Perenolde|r (niveau 41)
    .complete 507,1 --Seigneur Aliden Perenolde
    .mob 2423
    .isOnQuest 507
step
    .goto Alterac Mountains,39.30,14.31
    >>Parle à |cRXP_FRIENDLY_Elysa|r
    .turnin 507 >>Rends Seigneur Aliden Perenolde
    .accept 508 >>Accepte Le cadeau de Taretha
    .target 2317
    .isOnQuest 507
step
    .goto Alterac Mountains,47.83,17.11,30,0
    .goto Alterac Mountains,53.67,20.40,30,0
    .goto Alterac Mountains,56.28,26.70,30,0
    .goto Alterac Mountains,57.80,29.80
    >>Cherche le |cRXP_ENEMY_Baron Vardus|r sur ses points d'apparition
    .complete 566,1 --Tête du baron Vardus
    .unitscan 2306
    .isOnQuest 566
step
    #completewith next
    .goto Hillsbrad Foothills,63.24,20.66,40 >>Retourne à Moulin-de-Tarren
    .isOnQuest 508
step
    .goto Hillsbrad Foothills,63.24,20.66
    >>Parle à |cRXP_FRIENDLY_Krusk|r
    .turnin 508 >>Rends Le cadeau de Taretha
    .target 2229
    .isOnQuest 508
step
    .goto Hillsbrad Foothills,62.33,20.45
    >>Parle à la |cRXP_FRIENDLY_Grande exécutrice Darthalia|r
    .turnin 566 >>Rends ON RECHERCHE : baron Vardus
    .target 2215
    .isQuestComplete 566
step
    #label FinAlterac
    +|cRXP_WARN_Niveau conseillé pour la suite : 31. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

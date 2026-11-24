if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde du temple d'Atal'Hakkar (Temple englouti, bassin des Larmes au
-- Marais des Chagrins), toutes classes.
-- Givers : Sorcier-docteur Uzer'i (camp Mojache, Féralas), Marvon Rivetseeker (Tanaris, au sud
-- de Gadgetzan), Liv Rizzlefix (Ratchet), Larion (refuge de Marshal, Un'Goro), Exilé atal'ai
-- (ouest des Hinterlands), Fel'zerul (Pierrêche), Itharius (ouest du Marais des Chagrins).
-- Données : QuestieDB Forever (tools/questiedb.py), quêtes de la zone 1417, mobs de
-- l'instance en zone 1477 (sans coordonnées : ordre des salles décrit dans le texte). XP de
-- xpDB-classic.lua. Taux de drop wowheadData : Fétiche d'Hakkar 6181 ~12-20 % sur les trolls
-- (20 fétiches, ~270 kills en duo : gardée comme l'agent durcissant de Zul'Farrak, les trolls
-- meurent pendant la run), Brume atal'ai 11318 20-40 % (5 brumes, ~40 kills en duo), Tête de
-- Jammal'an 6212 ~52 %.
-- Itinéraire : Orgrimmar -> camp Mojache (Uzer'i) -> refuge de Marshal (Larion, si 4145 est
-- rendue) -> Tanaris (Marvon) -> Ratchet (cercle de pierres, Liv) -> Tanaris (Marvon) ->
-- Undercity -> Moulin-de-Tarren -> Exilé atal'ai -> Pierrêche -> Temple englouti -> pierre
-- de foyer Pierrêche -> Itharius -> Exilé atal'ai -> refuge de Marshal (Larion, si 4146).
-- Chaîne de Marvon (3380 -> 3444 -> 3446 / 3447, ~19 500 xp) : 3446 et 3447 se rendent à des
-- objets de l'instance, donc les deux passages à Tanaris se font avant la run.
-- Protégées (prises ailleurs) : 1429 L'Exilé atal'ai (Marais des Chagrins) puis 1444 et 1445
-- qui en découlent ; 4147 Atelier de Marvon (après 4145 Larion et Muigin, guide d'Un'Goro)
-- puis 4146 Carburant de baguette.
-- Sortante : 3512 Par les mots d'Eranikus se rend à Umbranse, à l'est de Berceau-de-l'Hiver
-- (Kalimdor) : prise chez Itharius, à garder pour le guide de Berceau-de-l'Hiver.
-- Coupées :
--   3528 Le dieu Hakkar (prérequis 3520, 3527 et 4787, chaîne coupée par les guides de
--   Tanaris, Zul'Farrak et des Hinterlands ; l'Avatar d'Hakkar devient donc optionnel),
--   4148 La baguette Pétale-de-sang (suite de 4146 en Un'Goro, quête de région hors donjon,
--   quantité inconnue dans QuestieDB),
--   8733 Eranikus, le tyran du Rêve (niveau 60, Cénarion),
--   8257 Le sang de Morphaz (prêtre), 8232, 8236, 8253, 8413, 8418, 8422, 8425, 9053
--   (quêtes de classe), 5145 (travail du cuir, écailles de dragon), 6610 (cuisine),
--   8785 (niveau 60, Légion d'Orgrimmar),
--   1475 Dans le temple d'Atal'Hakkar, 3445 Le Temple englouti, 4143 Brouillard maléfique, 5141,
--   92109 (Alliance).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 48-55 Sunken Temple
#displayname [FDP] Temple d'Atal'Hakkar (48-55)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Féralas : Uzer'i =====
step
    #completewith Uzeri
    .goto Feralas,74.42,43.36,40 >>Va au camp Mojache, à l'est de Féralas (vol depuis Orgrimmar ou Thunder Bluff)
step
    #label Uzeri
    .goto Feralas,74.42,43.36
    >>Parle au |cRXP_FRIENDLY_Sorcier-docteur Uzer'i|r
    .accept 3380 >>Accepte Le Temple englouti
    .target 8115

-- ===== Un'Goro : Larion (si Larion et Muigin est rendue) =====
step
    #completewith Larion
    .goto Un'Goro Crater,45.54,8.72,40 >>Vole au refuge de Marshal, au nord du cratère d'Un'Goro
    .isQuestTurnedIn 4145
step
    #label Larion
    .goto Un'Goro Crater,45.54,8.72
    >>Parle à |cRXP_FRIENDLY_Larion|r
    .accept 4147 >>Accepte Atelier de Marvon
    .target 9118
    .isQuestTurnedIn 4145

-- ===== Tanaris et Ratchet : chaîne de Marvon =====
step
    #completewith Marvon1
    .goto Tanaris,52.71,45.92,40 >>Vole à Gadgetzan puis descends au sud jusqu'à |cRXP_FRIENDLY_Marvon Rivetseeker|r, au Pilier brisé
step
    #label Marvon1
    .goto Tanaris,52.71,45.92
    >>Parle à |cRXP_FRIENDLY_Marvon Rivetseeker|r
    .turnin 3380 >>Rends Le Temple englouti
    .accept 3444 >>Accepte Le Cercle de pierres
    .target 7771
step
    #completewith Coffre
    .goto The Barrens,62.50,38.54,40 >>Vole à Ratchet, dans les Tarides
step
    #label Coffre
    .goto The Barrens,62.50,38.54
    >>Ouvre le |cRXP_PICK_Coffre de Marvon|r dans son atelier pour prendre le |cRXP_LOOT_Cercle de pierres|r
    .complete 3444,1 --Cercle de pierres
step
    .goto The Barrens,62.45,38.73
    >>Parle à |cRXP_FRIENDLY_Liv Rizzlefix|r, devant l'atelier
    .turnin 4147 >>Rends Atelier de Marvon
    .target 8496
    .isOnQuest 4147
step
    .goto The Barrens,62.45,38.73
    >>Parle à |cRXP_FRIENDLY_Liv Rizzlefix|r
    .accept 4146 >>Accepte Carburant de baguette
    .target 8496
    .isQuestTurnedIn 4147
step
    #completewith Marvon2
    .goto Tanaris,52.71,45.92,40 >>Retourne voir |cRXP_FRIENDLY_Marvon Rivetseeker|r (vol vers Gadgetzan)
step
    #label Marvon2
    .goto Tanaris,52.71,45.92
    >>Parle à |cRXP_FRIENDLY_Marvon Rivetseeker|r
    .turnin 3444 >>Rends Le Cercle de pierres
    .accept 3446 >>Accepte Dans les profondeurs
    .accept 3447 >>Accepte Le secret du cercle
    .target 7771

-- ===== Hinterlands : Exilé atal'ai =====
step
    #completewith Exile
    .goto The Hinterlands,33.75,75.21,40 >>Va à Undercity (zeppelin depuis Orgrimmar), vole à Moulin-de-Tarren puis entre à cheval dans les Hinterlands par l'ouest. |cRXP_WARN_Route non vérifiée : contourne le Nid-de-l'Aigle (Alliance)|r
step
    .goto The Hinterlands,33.75,75.21
    >>Parle à l'|cRXP_FRIENDLY_Exilé atal'ai|r
    .turnin 1429 >>Rends L'Exilé atal'ai
    .target 5598
    .isOnQuest 1429
step
    .goto The Hinterlands,33.75,75.21
    >>Parle à l'|cRXP_FRIENDLY_Exilé atal'ai|r
    .accept 1444 >>Accepte De retour vers Fel’Zerul
    .target 5598
    .isQuestTurnedIn 1429
step
    #label Exile
    .goto The Hinterlands,33.75,75.21
    >>Parle à l'|cRXP_FRIENDLY_Exilé atal'ai|r
    .accept 1446 >>Accepte Jammal'an le Prophète
    .target 5598

-- ===== Marais des Chagrins : Pierrêche =====
step
    #completewith Karakul
    .goto Swamp of Sorrows,45.16,56.66,40 >>Vole à Pierrêche (depuis Moulin-de-Tarren)
step
    #label Karakul
    .goto Swamp of Sorrows,45.16,56.66
    >>Parle à |cRXP_FRIENDLY_Karakul l'aubergiste|r : tu reviendras ici par la pierre de foyer après l'instance
    .home >>Fixe ta pierre de foyer à Pierrêche
    .target 6930
step
    .goto Swamp of Sorrows,47.93,54.78
    >>Parle à |cRXP_FRIENDLY_Fel'zerul|r
    .turnin 1444 >>Rends De retour vers Fel’Zerul
    .target 1443
    .isOnQuest 1444
step
    .goto Swamp of Sorrows,47.93,54.78
    >>Parle à |cRXP_FRIENDLY_Fel'zerul|r
    .accept 1445 >>Accepte Le temple d'Atal'Hakkar
    .target 1443
    .isQuestTurnedIn 1444

-- ===== Temple englouti =====
step
    #sticky
    >>Tue les trolls |cRXP_ENEMY_Atal'ai|r pendant toute l'instance pour les |cRXP_LOOT_Fétiches d'Hakkar|r
    >>|cRXP_WARN_Farm long en duo (~270 kills) : chacun doit looter ses objets. Rends-la seulement si elle est finie|r
    .complete 1445,1 --Fétiche d'Hakkar (20)
    .isOnQuest 1445
step
    #sticky
    >>Dans l'eau du niveau inférieur, tue les |cRXP_ENEMY_Vers des boues|r, |cRXP_ENEMY_Limons saturés|r et |cRXP_ENEMY_Rôdeurs des Abysses|r pour la |cRXP_LOOT_Brume atal'ai|r
    .complete 4146,1 --Brume atal'ai (5)
    .mob 5226
    .mob 5228
    .mob 8384
    .isOnQuest 4146
step
    #label EntreeTemple
    .goto Swamp of Sorrows,69.80,53.80,20 >>Va au bassin des Larmes, à l'est du Marais des Chagrins, plonge vers le temple englouti et entre dans l'instance
step
    >>Descends au niveau inférieur, au cercle des statues. Active les |cRXP_PICK_Statues atal'ai|r dans l'ordre sud, nord, sud-ouest, sud-est, nord-ouest, nord-est, tue |cRXP_ENEMY_Atal'alarion|r puis clique sur l'|cRXP_PICK_Idole d'Hakkar|r
    >>|cRXP_WARN_Ordre des statues non vérifié en jeu|r
    .turnin 3447 >>Rends Le secret du cercle
    .mob 8580
    .isOnQuest 3447
step
    >>Trouve l'|cRXP_PICK_Autel d'Hakkar|r au niveau inférieur, au centre du temple, et clique dessus. |cRXP_WARN_Emplacement non vérifié en jeu|r
    .turnin 3446 >>Rends Dans les profondeurs
    .isOnQuest 3446
step
    >>Remonte au niveau supérieur et tue les six trolls des balcons : leur mort ouvre l'accès à |cRXP_ENEMY_Jammal'an le prophète|r et |cRXP_ENEMY_Ogom le Misérable|r. Tue Jammal'an pour sa |cRXP_LOOT_Tête|r
    .complete 1446,1 --Tête de Jammal'an
    .mob 5710
    .mob 5711
    .isOnQuest 1446
step
    >>Passe les dragons verts et tue l'|cRXP_ENEMY_Ombre d'Eranikus|r au fond de son antre. Ramasse l'|cRXP_LOOT_Essence d'Eranikus|r et utilise-la pour lancer la quête
    >>|cRXP_WARN_L'Avatar d'Hakkar est optionnel : aucune quête gardée ne le demande|r
    .collect 10454,1,3373,1
    .accept 3373 >>Accepte L'Essence d'Eranikus
    .use 10454
    .mob 5709
step
    >>Place l'essence dans le |cRXP_PICK_Réceptacle d'essence|r de l'antre. Si un objet te propose une quête, accepte-la
    .turnin 3373 >>Rends L'Essence d'Eranikus
    .isOnQuest 3373
step
    >>Finis les fétiches et la brume avant de sortir si tu le peux
    .complete 1445,1 --Fétiche d'Hakkar (20)
    .complete 4146,1 --Brume atal'ai (5)
    .isOnQuest 1445
step
    .hs >>Utilise ta pierre de foyer pour Pierrêche

-- ===== Rendus : Marais des Chagrins =====
step
    .goto Swamp of Sorrows,47.93,54.78
    >>Parle à |cRXP_FRIENDLY_Fel'zerul|r. |cRXP_WARN_Fétiches pas finis : refais une run du temple sur les trolls, puis reviens|r
    .turnin 1445 >>Rends Le temple d'Atal'Hakkar
    .target 1443
    .isOnQuest 1445
step
    #completewith Itharius
    .goto Swamp of Sorrows,13.67,71.72,40 >>Va voir |cRXP_FRIENDLY_Itharius|r, à l'extrême ouest du Marais des Chagrins
    .isQuestTurnedIn 3373
step
    #label Itharius
    .goto Swamp of Sorrows,13.67,71.72
    >>Parle à |cRXP_FRIENDLY_Itharius|r. |cRXP_WARN_QuestieDB fait venir de lui l'objet qui lance cette quête : prends-la ici si tu ne l'as pas déjà|r
    .accept 3374 >>Accepte L'Essence d'Eranikus
    .turnin 3374 >>Rends L'Essence d'Eranikus
    .target 5353
    .isQuestTurnedIn 3373
step
    .goto Swamp of Sorrows,13.67,71.72
    >>Parle à |cRXP_FRIENDLY_Itharius|r
    .accept 3512 >>Accepte Par les mots d'Eranikus. |cRXP_WARN_Garde-la : elle se rend à Berceau-de-l'Hiver, en Kalimdor|r
    .target 5353
    .isQuestTurnedIn 3374

-- ===== Rendus : Hinterlands et Un'Goro =====
step
    #completewith RenduExile
    .goto The Hinterlands,33.75,75.21,40 >>Retourne voir l'|cRXP_FRIENDLY_Exilé atal'ai|r (vol de Pierrêche à Moulin-de-Tarren, puis à cheval vers l'est)
    .isQuestComplete 1446
step
    #label RenduExile
    .goto The Hinterlands,33.75,75.21
    >>Parle à l'|cRXP_FRIENDLY_Exilé atal'ai|r
    .turnin 1446 >>Rends Jammal'an le Prophète
    .target 5598
    .isQuestComplete 1446
step
    #completewith FinTempleEnglouti
    .goto Un'Goro Crater,45.54,8.72,40 >>Retourne voir |cRXP_FRIENDLY_Larion|r au refuge de Marshal (zeppelin pour Orgrimmar, puis vol)
    .isQuestComplete 4146
step
    #label FinTempleEnglouti
    .goto Un'Goro Crater,45.54,8.72
    >>Parle à |cRXP_FRIENDLY_Larion|r
    .turnin 4146 >>Rends Carburant de baguette
    .target 9118
    .isQuestComplete 4146
]])

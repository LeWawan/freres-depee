if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Les Hinterlands (The Hinterlands), Horde, toutes classes, base
-- village des Revantusk (côte est). Indépendant des autres régions : les quêtes venues
-- d'ailleurs (1429 Marais des Chagrins, 650 chaîne d'Orgrimmar) sont protégées par
-- .isOnQuest / .isQuestTurnedIn.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua et xpDB-traces.lua
-- (98203), taux de drop de classicItemDrops.lua (wowheadData : plume de Seigneur du ciel 40 %,
-- Longue plume élégante 35,8 % sur les Seigneurs du ciel ; tête de Ti'ik inconnue, 35 %
-- supposés). Duo : kills = 2 x nombre x 100 / taux.
-- Accès non vérifié en jeu : à cheval depuis Moulin-de-Tarren par l'entrée ouest (attention
-- au Nid-de-l'Aigle, Alliance) ou depuis le Trépas-d'Orgrim.
-- Itinéraire : Revantusk -> centre (Shaol'watha, Roche-Rôdeuse : outils, chouettards,
-- traqueurs, plume) -> ouest (hurleurs, pavillon de Quel'Danil et escorte de Rin'ji, Ti'ik,
-- Exilé atal'ai) -> pierre de foyer -> côte nord (tortues, Gammerita, secret de Rin'ji,
-- île de Lard) -> centre (plumes élégantes) -> Revantusk -> puits du Nid-de-l'Aigle ->
-- Revantusk.
-- Chaîne Wildhammer gardée : 7841 (60 elfes) + 7842 (10 plumes = ~56 kills) = ~116 kills pour
-- 15750 xp avec 7843, soit ~136 xp/kill (85 xp/kill sans 7843, qui demande d'entrer au
-- Nid-de-l'Aigle, sentinelles Alliance niveau 55 non élites).
-- Coupées :
--   7844 Les cousins cannibales (45 kills pour 4400 xp = ~98 xp/kill, sous la limite de 100),
--   7845, 7846, 7847, 7849, 7850, 7861, 7862 (Jintha'Alor : toute la zone est élite 47-51,
--   contenu de groupe), 485/836 OOX-09/HL (balise lâchée au hasard sans taux connu, rendu à
--   Baie-du-Butin), 2932 Sinistre message (pris et rendu en Strangleronce, aucun guide ne le
--   donne), 2933, 2934, 2935, 2937, 2938 (chaîne du venin rendue à Moulin-de-Tarren puis
--   Sen'jin, Kalimdor), 4787 L'oeuf antique (pris et rendu à Tanaris, Kalimdor, en
--   Jintha'Alor), 1444 De retour vers Fel'Zerul (envoi vers Pierrêche, suite 1445 donjon),
--   1445 et 1446 (temple d'Atal'Hakkar, donjon), 2782 Secret de Rin'ji et 8273 (rendues à
--   Undercity), 81 La livraison de Houle (rendue à Orgrimmar), 81786-81852 Missions des
--   Hinterlands (Saison de la Découverte, retirées), 1450, 1451, 1452, 1469, 2877, 2880, 2881,
--   2988, 2989, 2990, 2992, 2993, 2994, 86616 (Alliance).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 47-49 The Hinterlands
#displayname [FDP] Les Hinterlands (47-49)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 47-49 Searing Gorge

-- ===== Arrivée au village des Revantusk =====
step
    #completewith ArriveeRevantusk
    .goto The Hinterlands,81.70,81.76,40 >>Va au village des Revantusk, sur la côte est des Hinterlands. |cRXP_WARN_Route non vérifiée : à cheval depuis Moulin-de-Tarren par l'entrée ouest (contourne le Nid-de-l'Aigle, Alliance) ou depuis le Trépas-d'Orgrim|r
step
    #label ArriveeRevantusk
    .goto The Hinterlands,81.70,81.76
    >>Parle à |cRXP_FRIENDLY_Gorkas|r
    .fp Revantusk Village >>Prends le point de vol du village des Revantusk
    .target 4314
step
    .goto The Hinterlands,78.14,81.38
    >>Parle à |cRXP_FRIENDLY_Lard|r, l'aubergiste
    .home >>Fixe ta pierre de foyer au village des Revantusk
    .accept 7840 >>Accepte Lard a perdu son déjeuner !
    .target 14731
step
    .goto The Hinterlands,80.33,81.54
    >>Parle à |cRXP_FRIENDLY_Katoom le pêcheur|r, sur le ponton
    .accept 7815 >>Accepte Les Gueules d'acier, l'ami !
    .accept 7816 >>Accepte Gammerita, l'ami !
    .target 14740
step
    .goto The Hinterlands,79.20,79.40
    >>Parle à |cRXP_FRIENDLY_Veneur Markhor|r et à |cRXP_FRIENDLY_Otho Moji'ko|r juste à côté
    .accept 7828 >>Accepte Traquer les traqueurs
    .accept 7829 >>Accepte Chasser les sauvages
    .accept 7830 >>Accepte Venger les victimes
    .accept 7841 >>Accepte Un message pour les Wildhammer
    .target 14741
    .target 14738
step
    .goto The Hinterlands,77.23,80.13
    >>Parle au |cRXP_FRIENDLY_Forgeron Slagtree|r
    .accept 7839 >>Accepte Les voyous Vilebranch
    .target 14737
step
    .goto The Hinterlands,77.95,77.83
    >>Parle à |cRXP_FRIENDLY_Qujo|r
    .accept 98203 >>Accepte Féticheur Ti'ik
    .target 270780

-- ===== Centre : Shaol'watha, chouettards, traqueurs, Roche-Rôdeuse =====
step
    #completewith OutilsSlagtree
    >>Tue les |cRXP_ENEMY_Traqueurs Crins-d'argent|r, les |cRXP_ENEMY_Chouettards sauvages|r et un |cRXP_ENEMY_Seigneur du ciel Bec-rasoir|r pour sa |cRXP_LOOT_Plume|r en chemin
    .complete 7828,1 --Traqueur Crins-d'argent (10)
    .complete 7829,1 --Chouettard sauvage (20)
    .complete 7830,1 --Plume de Seigneur du ciel
    .mob 2926
    .mob 2929
    .mob 2659
step
    .goto The Hinterlands,66.40,44.80
    >>Cherche les |cRXP_PICK_Outils perdus de Slagtree|r au temple de Shaol'watha. |cRXP_WARN_Un seul emplacement est actif : sinon regarde en 71.0,48.6, 72.6,52.9, puis à Roche-Rôdeuse (57.4,42.6) et Agol'watha (53.3,38.8)|r
    .complete 7839,1 --Outils perdus de Slagtree
step
    #label OutilsSlagtree
    .goto The Hinterlands,57.40,42.60,30
    >>Si les outils n'étaient pas à Shaol'watha, cherche-les à Roche-Rôdeuse puis à Agol'watha (53.3,38.8)
    .complete 7839,1 --Outils perdus de Slagtree
step
    .goto The Hinterlands,58.00,50.00
    >>Finis les |cRXP_ENEMY_Chouettards sauvages|r, les |cRXP_ENEMY_Traqueurs Crins-d'argent|r et la |cRXP_LOOT_Plume de Seigneur du ciel|r
    .complete 7828,1 --Traqueur Crins-d'argent (10)
    .complete 7829,1 --Chouettard sauvage (20)
    .complete 7830,1 --Plume de Seigneur du ciel
    .mob 2926
    .mob 2929
    .mob 2659

-- ===== Ouest : hurleurs, Quel'Danil, Ti'ik, Exilé atal'ai =====
step
    .goto The Hinterlands,48.50,60.00
    >>Tue les |cRXP_ENEMY_Hurleurs Crins-d'argent|r, dispersés entre ici et l'ouest (41-52,46-67)
    .complete 7828,2 --Hurleur Crins-d'argent (10)
    .mob 2925
step
    .goto The Hinterlands,32.00,45.50
    >>Tue les elfes du |cRXP_ENEMY_Haut-val|r autour du pavillon de Quel'Danil. |cRXP_WARN_Farm long en duo (~60 kills) : les forestiers sont rares, attends qu'ils réapparaissent|r
    .complete 7841,1 --Eclaireur du Haut-val (15)
    .complete 7841,2 --Estafette du Haut-val (15)
    .complete 7841,3 --Forestier du Haut-val (15)
    .complete 7841,4 --Tireur d'élite du Haut-val (15)
    .mob 2692
    .mob 2691
    .mob 2694
    .mob 2693
step
    .goto The Hinterlands,30.73,46.90
    >>Parle à |cRXP_FRIENDLY_Rin'ji|r, prisonnier dans le pavillon, pour lancer l'escorte
    .accept 2742 >>Accepte Rin'ji est pris au piège !
    .target 7780
step
    .goto The Hinterlands,34.58,56.33
    >>Escorte |cRXP_FRIENDLY_Rin'ji|r hors du pavillon. Tue les elfes qui l'attaquent
    .complete 2742,1
step
    .goto The Hinterlands,26.71,48.59
    >>Parle à |cRXP_FRIENDLY_Gilveradin Sunchaser|r
    .turnin 650 >>Rends La récupération de Houle
    .target 7801
    .isOnQuest 650
step
    .goto The Hinterlands,26.71,48.59
    >>Parle à |cRXP_FRIENDLY_Gilveradin Sunchaser|r
    .accept 77 >>Accepte Une situation délicate
    .target 7801
    .isQuestTurnedIn 650
step
    .goto The Hinterlands,26.00,65.50
    >>Entre dans la grotte à l'ouest de Hiri'watha. Tue le |cRXP_ENEMY_Féticheur Ti'ik|r et prends sa |cRXP_LOOT_Tête|r
    .complete 98203,1 --Tête de Ti'ik
    .mob 270772
step
    .goto The Hinterlands,33.75,75.21
    >>Parle à l'|cRXP_FRIENDLY_Exilé atal'ai|r
    .turnin 1429 >>Rends L'Exilé atal'ai
    .target 5598
    .isOnQuest 1429

-- ===== Retour à Revantusk =====
step
    .hs >>Utilise ta pierre de foyer vers le village des Revantusk (sinon rentre à cheval)
step
    .goto The Hinterlands,79.20,79.40
    >>Parle au |cRXP_FRIENDLY_Veneur Markhor|r et à |cRXP_FRIENDLY_Otho Moji'ko|r
    .turnin 7828 >>Rends Traquer les traqueurs
    .turnin 7829 >>Rends Chasser les sauvages
    .turnin 7830 >>Rends Venger les victimes
    .turnin 7841 >>Rends Un message pour les Wildhammer
    .accept 7842 >>Accepte Encore un message pour les Wildhammer
    .target 14741
    .target 14738
step
    .goto The Hinterlands,77.23,80.13
    >>Parle au |cRXP_FRIENDLY_Forgeron Slagtree|r
    .turnin 7839 >>Rends Les voyous Vilebranch
    .target 14737
step
    .goto The Hinterlands,77.95,77.83
    >>Parle à |cRXP_FRIENDLY_Qujo|r
    .turnin 98203 >>Rends Féticheur Ti'ik
    .target 270780

-- ===== Côte nord : tortues, Gammerita, secret de Rin'ji, île de Lard =====
step
    #completewith IleLard
    >>Tue les |cRXP_ENEMY_Gueules d'acier des mers|r le long de la côte
    .complete 7815,1 --Gueule d'acier des mers (15)
    .mob 2505
step
    .goto The Hinterlands,80.40,58.23
    >>Tue |cRXP_ENEMY_Gammerita|r au milieu des tortues et prends le |cRXP_LOOT_Meilleur appât de Katoom|r. |cRXP_WARN_Élite 48 : en duo|r
    .complete 7816,1 --Le meilleur appât de Katoom
    .mob 7977
    .unitscan 7977
step
    .goto The Hinterlands,86.30,59.01
    >>Clique sur le |cRXP_PICK_Secret de Rin'ji|r, sur la falaise au bord de la mer
    .turnin 2742 >>Rends Rin'ji est pris au piège !
step
    #label IleLard
    .goto The Hinterlands,84.47,41.22
    >>Va sur l'île au nord et ouvre le |cRXP_PICK_Panier de pique-nique de Lard|r. |cRXP_WARN_Un Kidnappeur Vilebranch rôde à côté|r
    .complete 7840,1 --Repas de Lard
    .mob 14748
step
    .goto The Hinterlands,83.00,48.00
    >>Finis les |cRXP_ENEMY_Gueules d'acier des mers|r
    .complete 7815,1 --Gueule d'acier des mers (15)
    .mob 2505

-- ===== Centre : plumes élégantes =====
step
    #completewith Plumes
    .goto The Hinterlands,58.50,41.00,0
    >>Si tu as la quête, ramasse le |cRXP_LOOT_Houle au miel|r dans les |cRXP_PICK_Caisses de ravitaillement de la Horde|r à Roche-Rôdeuse (et 46,39). |cRXP_WARN_10 caisses seulement : attends qu'elles réapparaissent|r
    .complete 77,1 --Houle au miel des Hinterlands (10)
    .isOnQuest 77
step
    #label Plumes
    .goto The Hinterlands,60.00,50.00
    >>Tue les |cRXP_ENEMY_Seigneurs du ciel Bec-rasoir|r pour leurs |cRXP_LOOT_Longues plumes élégantes|r. |cRXP_WARN_Farm long en duo (~56 kills) : chacun doit looter ses objets|r
    .complete 7842,1 --Longue plume élégante (10)
    .mob 2659
step
    .goto The Hinterlands,58.50,41.00
    >>Finis les |cRXP_PICK_Caisses de ravitaillement de la Horde|r
    .complete 77,1 --Houle au miel des Hinterlands (10)
    .isOnQuest 77

-- ===== Revantusk puis le Nid-de-l'Aigle =====
step
    .goto The Hinterlands,80.33,81.54
    >>Retourne voir |cRXP_FRIENDLY_Katoom le pêcheur|r
    .turnin 7815 >>Rends Les Gueules d'acier, l'ami !
    .turnin 7816 >>Rends Gammerita, l'ami !
    .target 14740
step
    .goto The Hinterlands,78.14,81.38
    >>Parle à |cRXP_FRIENDLY_Lard|r
    .turnin 7840 >>Rends Lard a perdu son déjeuner !
    .target 14731
step
    .goto The Hinterlands,79.38,79.08
    >>Parle à |cRXP_FRIENDLY_Otho Moji'ko|r
    .turnin 7842 >>Rends Encore un message pour les Wildhammer
    .accept 7843 >>Accepte Le message final pour les Wildhammer
    .target 14738
step
    .goto The Hinterlands,26.71,48.59
    >>En route vers l'ouest, parle à |cRXP_FRIENDLY_Gilveradin Sunchaser|r
    .turnin 77 >>Rends Une situation délicate
    .target 7801
    .isOnQuest 77
step
    .goto The Hinterlands,14.34,48.07
    >>Entre au Nid-de-l'Aigle et pose le |cRXP_LOOT_Message final|r près du puits au centre du village, puis ressors vite. |cRXP_WARN_Sentinelles Wildhammer niveau 55 (Alliance) : restez groupés, une mort est possible|r
    .complete 7843,1
    .use 19036
step
    .hs >>Utilise ta pierre de foyer vers le village des Revantusk si elle est prête, sinon rentre à cheval
step
    .goto The Hinterlands,79.38,79.08
    >>Parle à |cRXP_FRIENDLY_Otho Moji'ko|r
    .turnin 7843 >>Rends Le message final pour les Wildhammer
    .target 14738
step
    #label FinHinterlands
    +|cRXP_WARN_Niveau conseillé pour la suite : 49. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

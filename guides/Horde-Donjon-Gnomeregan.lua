if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde de Gnomeregan (Dun Morogh), toutes classes.
-- Givers : Sovik et Nogg (Orgrimmar), Scooty (Baie-du-Butin, Strangleronce), Kernobee et le
-- Décapeur 5200 (instance). Le transpondeur gobelin de Scooty (2843) téléporte de
-- Baie-du-Butin à l'entrée de Gnomeregan : c'est la route Horde vers l'instance.
-- Anneau sali (2945) : lancé par un objet que lâchent les Agents Sombrefer, nettoyé dans
-- le Décapeur 5200, puis rendu à Nogg (2949) qui l'améliore (2950, Barre d'argent + Agate
-- mousse + 30 pa, à acheter avant).
-- Coupées : 2951-2953 et 4601-4606 Décapeur 5200 (objets salis, pas d'XP dans QuestieDB),
--   80325 Le roi fou (Forever, niveau 40, aucun donneur dans QuestieDB).
-- Données : QuestieDB Forever (tools/questiedb.py). Dans l'instance, QuestieDB n'a pas de
-- coordonnées : ordre des salles décrit dans le texte.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 28-35 Gnomeregan
#displayname [FDP] Gnomeregan (28-35)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Orgrimmar : Sovik et Nogg =====
step
    .goto Orgrimmar,75.99,25.41
    >>Parle à |cRXP_FRIENDLY_Nogg|r dans la Vallée de l'Honneur. |cRXP_WARN_Avant Sovik : Nogg ne propose plus sa quête quand celle de Sovik est dans le journal|r
    .accept 2841 >>Accepte Guerre des plates-formes
    .target 3412
step
    .goto Orgrimmar,75.49,25.36
    >>Parle à |cRXP_FRIENDLY_Sovik|r, juste à côté. |cRXP_WARN_Suis tout son dialogue pour obtenir la quête|r
    .accept 2842 >>Accepte L'ingénieur en chef Scooty
    .target 3413

-- ===== Voyage : zeppelin -> Grom'gol -> Baie-du-Butin =====
step
    #completewith next
    .goto Durotar,50.69,12.89,15 >>Monte à la tour des zeppelins devant Orgrimmar et prends le zeppelin pour Grom'gol
    .target 12136
    .zoneskip Stranglethorn Vale
step
    .goto Stranglethorn Vale,32.54,29.35
    >>Descends du zeppelin et parle à |cRXP_FRIENDLY_Thysta|r
    .fp Grom'gol >>Prends le point de vol de Grom'gol
    .target 1387
step
    #completewith Gringer
    .goto Stranglethorn Vale,27.00,72.00,50 >>Va à Baie-du-Butin (vol depuis Grom'gol si tu l'as, sinon la route vers le sud)
step
    #label Gringer
    .goto Stranglethorn Vale,26.87,77.10
    >>Parle à |cRXP_FRIENDLY_Gringer|r
    .fp Booty Bay >>Prends le point de vol de Baie-du-Butin : il sert au retour
    .target 2858
step
    #label Scooty
    .goto Stranglethorn Vale,27.60,77.48
    >>Parle à |cRXP_FRIENDLY_Scooty|r, en haut de Baie-du-Butin. Attends qu'il calibre le transpondeur
    .turnin 2842 >>Rends L'ingénieur en chef Scooty
    .accept 2843 >>Accepte Gnomer-paaarti !
    .timer 9,Calibrage du transpondeur
    .target 7853
step
    .goto Stranglethorn Vale,27.60,77.48
    >>Parle à |cRXP_FRIENDLY_Scooty|r
    .turnin 2843 >>Rends Gnomer-paaarti !
    .target 7853
step
    .goto Stranglethorn Vale,27.04,77.31
    >>Parle à |cRXP_FRIENDLY_Skindle l'aubergiste|r : tu reviendras ici par la pierre de foyer après l'instance
    .home >>Fixe ta pierre de foyer à Baie-du-Butin
    .target 6807
step
    .goto Stranglethorn Vale,27.63,77.55
    .goto Eastern Kingdoms,42.75,59.93,30 >>Monte sur le |cRXP_PICK_Transpondeur gobelin|r à côté de Scooty : il te téléporte devant Gnomeregan

-- ===== Gnomeregan =====
step
    #completewith Thermaplugg
    >>Tue les |cRXP_ENEMY_Agents Sombrefer|r. S'ils lâchent l'|cRXP_LOOT_Anneau sali|r, utilise-le pour lancer la quête
    .collect 9326,1,2945,1
    .accept 2945 >>Accepte Anneau sali
    .use 9326
    .mob 6212
    .isQuestAvailable 2945
step
    #label EntreeGnomer
    .goto Eastern Kingdoms,42.34,60.18,20 >>Descends l'ascenseur et entre dans l'instance
step
    >>Parle à |cRXP_FRIENDLY_Kernobee|r. Il apparaît au hasard dans le Dortoir, juste après la Zone propre
    .accept 2904 >>Accepte Une jolie pagaille
    .target 7850
    .unitscan 7850
step
    >>Escorte |cRXP_FRIENDLY_Kernobee|r jusqu'au début de l'instance. Tue ce qui l'attaque
    .complete 2904,1
    .isOnQuest 2904
step
    #label Thermaplugg
    >>Dernier boss : tue |cRXP_ENEMY_Mekgénieur Thermaplugg|r pour la |cRXP_LOOT_Combinaison du coffre|r, puis ouvre le |cRXP_PICK_Coffre de Thermaplugg|r dans sa salle pour le |cRXP_LOOT_Plan de plateforme|r
    .complete 2841,2 --Combinaison du coffre de Thermaplugg
    .complete 2841,1 --Plan de plateforme
    .mob 7800
    .isOnQuest 2841
step
    >>Avant de sortir, retourne à la Zone propre près de l'entrée. Mets l'|cRXP_LOOT_Anneau sali|r dans le |cRXP_PICK_Décapeur 5200|r, puis clique une seconde fois la machine pour l'anneau propre
    .turnin 2945 >>Rends Anneau sali
    .accept 2949 >>Accepte Le retour de l'anneau
    .isOnQuest 2945
step
    .hs >>Utilise ta pierre de foyer pour Baie-du-Butin

-- ===== Rendus : Baie-du-Butin =====
step
    .goto Stranglethorn Vale,27.60,77.48
    >>Retourne voir |cRXP_FRIENDLY_Scooty|r à Baie-du-Butin
    .turnin 2904 >>Rends Une jolie pagaille
    .target 7853
    .isOnQuest 2904

-- ===== Rendus : Orgrimmar =====
step
    #completewith RenduNogg
    .goto Durotar,50.69,12.89,30 >>Rentre à Orgrimmar : vol vers Grom'gol puis zeppelin pour Orgrimmar
    .zoneskip Orgrimmar
step
    #label RenduNogg
    .goto Orgrimmar,75.99,25.41
    >>Parle à |cRXP_FRIENDLY_Nogg|r à Orgrimmar
    .turnin 2841 >>Rends Guerre des plates-formes
    .target 3412
    .isOnQuest 2841
step
    .goto Orgrimmar,75.99,25.41
    >>Parle à |cRXP_FRIENDLY_Nogg|r
    .turnin 2949 >>Rends Le retour de l'anneau
    .accept 2950 >>Accepte Nogg améliore l'anneau
    .target 3412
    .isOnQuest 2949
step
    #label FinGnomeregan
    .goto Orgrimmar,75.99,25.41
    >>Donne à |cRXP_FRIENDLY_Nogg|r l'|cRXP_LOOT_Anneau d'or brillant|r, une |cRXP_LOOT_Barre d'argent|r, une |cRXP_LOOT_Agate mousse|r et 30 pa. |cRXP_WARN_Barre et agate à l'hôtel des ventes si tu ne les as pas|r
    .turnin 2950 >>Rends Nogg améliore l'anneau
    .target 3412
    .isOnQuest 2950
]])

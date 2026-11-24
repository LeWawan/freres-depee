if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Shaman Horde, L'appel de l'eau (Totem d'eau).
-- Le Speedrun RestedXP 1-22 s'arrête après l'acceptation de 1536 (puits de Tarren Mill) :
-- ce guide reprend là. Les débuts de chaîne sont protégés, ils se valident seuls si déjà faits.
-- Données : QuestieDB Forever (tools/questiedb.py). Syntaxe : docs/rxp-custom-guides.md.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Shaman
#name 22 Totem d'eau
#displayname [FDP] Chaman 22 : Totem d'eau
#version 1
#group Guide FDP (Horde)
#subgroup Classe
#next 23-24 Hillsbrad Foothills

-- ===== Début de chaîne, si le Speedrun RestedXP ne l'a pas fait =====
step
    .goto Orgrimmar,37.96,37.73
    >>Parle à |cRXP_FRIENDLY_Searn Firewarder|r
    .accept 1528 >>Accepte L'appel de l'eau
    .target 5892
    .isQuestAvailable 1530
    .isNotOnQuest 1530
    .isNotOnQuest 1529
    .isNotOnQuest 2985
    .isNotOnQuest 2986
step
    .goto The Barrens,65.83,43.78
    >>Parle à |cRXP_FRIENDLY_Islen Waterseer|r
    .turnin 1528 >>Rends L'appel de l'eau
    .target 5901
    .isOnQuest 1528
step
    .goto The Barrens,65.83,43.78
    >>Parle à |cRXP_FRIENDLY_Islen Waterseer|r
    .turnin 1529 >>Rends L'appel de l'eau
    .target 5901
    .isOnQuest 1529
step
    .goto The Barrens,65.83,43.78
    >>Parle à |cRXP_FRIENDLY_Islen Waterseer|r
    .turnin 2985 >>Rends L'appel de l'eau
    .target 5901
    .isOnQuest 2985
step
    .goto The Barrens,65.83,43.78
    >>Parle à |cRXP_FRIENDLY_Islen Waterseer|r
    .turnin 2986 >>Rends L'appel de l'eau
    .target 5901
    .isOnQuest 2986
step
    .goto The Barrens,65.83,43.78
    >>Parle à |cRXP_FRIENDLY_Islen Waterseer|r
    .accept 1530 >>Accepte L'appel de l'eau
    .target 5901
step
    .goto The Barrens,43.42,77.41
    >>Parle à |cRXP_FRIENDLY_Brine|r
    .turnin 1530 >>Rends L'appel de l'eau
    .accept 1535 >>Accepte L'appel de l'eau
    .target 5899
step
    .goto The Barrens,44.28,76.75
    >>Remplis l'|cRXP_LOOT_Outre marron vide|r au |cRXP_PICK_Point d'eau des hurans|r sous la hutte
    .complete 1535,1 --Outre marron remplie (1)
    .use 7766
step
    .goto The Barrens,43.42,77.41
    >>Parle à |cRXP_FRIENDLY_Brine|r
    .turnin 1535 >>Rends L'appel de l'eau
    .accept 1536 >>Accepte L'appel de l'eau
    .target 5899

-- ===== Les trois outres =====
step
    #completewith PuitsTarren
    .goto Hillsbrad Foothills,62.18,20.79,60 >>Va à Tarren Mill (zeppelin pour Undercity, puis la route vers le sud)
step
    #label PuitsTarren
    .goto Hillsbrad Foothills,62.18,20.79
    >>Remplis l'|cRXP_LOOT_Outre rouge vide|r au |cRXP_PICK_Puits de printemps|r de Tarren Mill
    .complete 1536,1 --Outre rouge remplie (1)
    .use 7768
step
    #completewith Brine2
    .goto The Barrens,43.42,77.41,60 >>Retourne voir |cRXP_FRIENDLY_Brine|r dans les Barrens
step
    #label Brine2
    .goto The Barrens,43.42,77.41
    >>Parle à |cRXP_FRIENDLY_Brine|r
    .turnin 1536 >>Rends L'appel de l'eau
    .accept 1534 >>Accepte L'appel de l'eau
    .target 5899
step
    .goto Ashenvale,33.55,67.47
    >>Remplis l'|cRXP_LOOT_Outre bleue vide|r à la |cRXP_PICK_Fontaine des ruines de Chimétoile|r
    >>|cRXP_WARN_Zone alliance, près d'Astranaar : attention aux gardes et aux joueurs|r
    .complete 1534,1 --Outre bleue remplie (1)
    .use 7767
step
    .goto The Barrens,43.42,77.41
    >>Parle à |cRXP_FRIENDLY_Brine|r
    .turnin 1534 >>Rends L'appel de l'eau
    .accept 220 >>Accepte L'appel de l'eau
    .target 5899
step
    .goto The Barrens,65.83,43.78
    >>Parle à |cRXP_FRIENDLY_Islen Waterseer|r. Elle te donne le |cRXP_LOOT_Sapta d'eau|r
    .turnin 220 >>Rends L'appel de l'eau
    .accept 63 >>Accepte L'appel de l'eau
    .target 5901

-- ===== Silverpine : la manifestation corrompue =====
step
    #completewith Brasero
    .goto Silverpine Forest,38.26,44.56,60 >>Va au |cRXP_PICK_Brasero d'Everfount|r, au sud-ouest du Sépulcre (Silverpine)
step
    .goto Silverpine Forest,38.78,44.26
    >>Bois le |cRXP_LOOT_Sapta d'eau|r pour voir les esprits, puis tue la |cRXP_ENEMY_Manifestation d'eau corrompue mineure|r et ramasse ses |cRXP_LOOT_Bracelets|r
    .complete 63,1 --Bracelets de manifestation corrompue (1)
    .use 6637
    .mob 5894
step
    #label Brasero
    .goto Silverpine Forest,38.26,44.56
    >>Clique sur le |cRXP_PICK_Brasero d'Everfount|r
    .turnin 63 >>Rends L'appel de l'eau
    .accept 100 >>Accepte L'appel de l'eau
step
    .goto Silverpine Forest,38.65,44.58
    >>Parle à la |cRXP_FRIENDLY_Manifestation d'eau mineure|r (visible grâce au Sapta)
    >>|cRXP_WARN_Si elle a disparu : Tiev Mordune (37.3,44.2) a une quête de secours avec un Sapta d'eau|r
    .turnin 100 >>Rends L'appel de l'eau
    .accept 96 >>Accepte L'appel de l'eau
    .target 5895
step
    #completewith FinTotemEau
    .goto The Barrens,65.83,43.78,60 >>Retourne voir |cRXP_FRIENDLY_Islen Waterseer|r dans les Barrens
step
    #label FinTotemEau
    .goto The Barrens,65.83,43.78
    >>Parle à |cRXP_FRIENDLY_Islen Waterseer|r pour recevoir le |cRXP_LOOT_Totem d'eau|r
    .turnin 96 >>Rends L'appel de l'eau
    .target 5901
]])

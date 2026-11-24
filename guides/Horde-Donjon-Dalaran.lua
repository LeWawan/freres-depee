if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde de la Cité de Dalaran (donjon Forever, Montagnes d'Alterac),
-- toutes classes. Entrée par les égouts, à l'ouest du dôme (Alterac 8.5,59.2).
-- Givers : Docteur Martin Felben (Undercity), Magus Wordeen Voidglare et Melisara
-- (Moulin-de-Tarren), Image de l'archimage Modera (bord du lac Lordamere).
-- Protégée : 92434 Du sang dans les rues (après 545 Les patrouilles de Dalaran, coupée par
-- le guide Alterac), puis 96984 et 97287 qui en découlent.
-- Coupée : 96987 Éducation opportuniste (ni donneur ni receveur dans QuestieDB).
-- Données : QuestieDB Forever (tools/questiedb.py), XP inconnue pour ces quêtes Forever.
-- Les mobs de l'instance n'ont pas de nom français dans QuestieDB : noms anglais.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 30-35 City of Dalaran
#displayname [FDP] Cité de Dalaran (30-35)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Undercity : Felben =====
step
    #completewith Felben
    .goto Undercity,46.61,74.09,40 >>Va à Undercity, à l'Apothicarium
step
    #label Felben
    .goto Undercity,46.61,74.09
    >>Parle au |cRXP_FRIENDLY_Docteur Martin Felben|r
    .accept 96988 >>Accepte Source de pouvoir
    .target 11044

-- ===== Moulin-de-Tarren =====
step
    #completewith Voidglare
    .goto Hillsbrad Foothills,61.60,20.85,40 >>Va à Moulin-de-Tarren (vol depuis Undercity)
step
    #label Voidglare
    .goto Hillsbrad Foothills,61.60,20.85
    >>Parle au |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
    .accept 92434 >>Accepte Du sang dans les rues
    .target 2410
    .isQuestTurnedIn 545
step
    .goto Hillsbrad Foothills,62.63,20.65
    >>Parle à |cRXP_FRIENDLY_Melisara|r
    .accept 96986 >>Accepte Le Chevalier de la tombe
    .target 2278

-- ===== Lac Lordamere : l'Image de Modera =====
step
    .goto Silverpine Forest,68.55,45.89,15
    >>Longe le lac Lordamere jusqu'au passage vers Dalaran, à l'est de la Forêt des Pins-Argentés
    .complete 92434,1 --Trouver un passage vers Dalaran
    .isOnQuest 92434
step
    .goto Silverpine Forest,68.62,45.13
    >>Parle à l'|cRXP_FRIENDLY_Image de l'archimage Modera|r
    .turnin 92434 >>Rends Du sang dans les rues
    .accept 96984 >>Accepte Cœur de la perturbation
    .target 269127
    .isOnQuest 92434
step
    .goto Silverpine Forest,68.62,45.13
    >>Parle à l'|cRXP_FRIENDLY_Image de l'archimage Modera|r
    .accept 96984 >>Accepte Cœur de la perturbation
    .target 269127
    .isQuestTurnedIn 92434

-- ===== Instance =====
step
    #label EntreeCOD
    .goto Alterac Mountains,8.46,59.21,15 >>Va à l'entrée des égouts de Dalaran, à l'ouest du dôme, et entre dans l'instance
step
    #completewith SortieCOD
    >>Tue les |cRXP_ENEMY_Fragmented Sentries|r et les |cRXP_ENEMY_Unstable Sentinels|r (ou fouille les sentinelles brisées) pour les |cRXP_LOOT_Noyaux de sentinelle fissurés|r
    .complete 96988,1 --Noyau de sentinelle fissuré (6)
    .mob 246664
    .mob 246017
step
    >>Tue la |cRXP_ENEMY_Shade of the Archmage|r et ramasse le |cRXP_LOOT_Granule arcanique|r
    .complete 96984,1 --Granule arcanique
    .mob 246020
    .isOnQuest 96984
step
    >>Tue |cRXP_ENEMY_Atrexis the Grave Knight|r
    .complete 96986,1 --Atrexis
    .mob 247126
step
    #label SortieCOD
    >>Finis les |cRXP_LOOT_Noyaux de sentinelle fissurés|r avant de sortir
    .complete 96988,1 --Noyau de sentinelle fissuré (6)

-- ===== Rendus =====
step
    .goto Hillsbrad Foothills,61.60,20.85
    >>Retourne à Moulin-de-Tarren et parle au |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
    .turnin 96984 >>Rends Cœur de la perturbation
    .accept 97287 >>Accepte Négociations avisées
    .target 2410
    .isOnQuest 96984
step
    .goto Hillsbrad Foothills,62.63,20.65
    >>Parle à |cRXP_FRIENDLY_Melisara|r
    .turnin 96986 >>Rends Le Chevalier de la tombe
    .target 2278
step
    .goto Alterac Mountains,14.30,59.57
    >>Retourne à Dalaran et parle à l'|cRXP_FRIENDLY_Image de l'archimage Modera|r, devant le dôme
    .turnin 97287 >>Rends Négociations avisées
    .target 269127
    .isOnQuest 97287
step
    #label FinDalaran
    .goto Undercity,46.61,74.09
    >>Retourne à Undercity et parle au |cRXP_FRIENDLY_Docteur Martin Felben|r
    .turnin 96988 >>Rends Source de pouvoir
    .target 11044
]])

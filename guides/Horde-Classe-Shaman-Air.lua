if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Shaman Horde, L'appel de l'air (Totem d'air, niveau 30).
-- La suite Forever (Soutien élémentaire, 79360) demande Charlga dans Kraal de Tranchebauge :
-- quête de donjon, hors de ce guide.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Shaman
#name 30 Totem d'air
#displayname [FDP] Chaman 30 : Totem d'air
#version 1
#group Guide FDP (Horde)
#subgroup Classe
#next 30-31 Alterac Mountains

step
    .xp 30 >>Monte au niveau 30, requis pour la quête
step << Orc/Troll
    .goto Orgrimmar,37.96,37.73
    >>Parle à |cRXP_FRIENDLY_Searn Firewarder|r
    .accept 1531 >>Accepte L'appel de l'air
    .target 5892
    .isNotOnQuest 1532
step << Tauren
    .goto Thunder Bluff,25.16,20.51
    >>Parle à |cRXP_FRIENDLY_Xanis Flameweaver|r
    .accept 1532 >>Accepte L'appel de l'air
    .target 5906
    .isNotOnQuest 1531
step
    #completewith Prate
    .goto Thousand Needles,54.57,44.36,12,0
    .goto Thousand Needles,53.71,42.59,10 >>Monte sur le plateau à l'est du poste de Librevent (Thousand Needles)
step
    #label Prate
    .goto Thousand Needles,53.54,42.65
    >>Parle à |cRXP_FRIENDLY_Prate Cloudseer|r pour recevoir le |cRXP_LOOT_Totem d'air|r
    .turnin 1531 >>Rends L'appel de l'air
    .target 5905
    .isOnQuest 1531
step
    #label FinTotemAir
    .goto Thousand Needles,53.54,42.65
    >>Parle à |cRXP_FRIENDLY_Prate Cloudseer|r pour recevoir le |cRXP_LOOT_Totem d'air|r
    .turnin 1532 >>Rends L'appel de l'air
    .target 5905
    .isOnQuest 1532
]])

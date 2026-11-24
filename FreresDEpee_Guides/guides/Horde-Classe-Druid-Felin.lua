if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Druid Horde, L'esprit du Grand félin (forme de félin, niveau 20).
-- Chaîne Forever. Tauren : Esprit du Grand félin. Skyborne : Avatar de Saeyleenan.
-- Les trois reliques sont dans le Stormrage Barrow Den, au sud-est de Reflet-de-Lune.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Druid
#name 20 Forme de félin
#displayname [FDP] Druide 20 : Forme de félin
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 20 >>Monte au niveau 20, requis pour la quête
step
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r sur la cime des Anciens
    .accept 98340 >>Accepte L'esprit du Grand félin
    .target 3033
step << Tauren
    .goto Moonglade,56.21,30.64
    >>Lance |cRXP_WARN_Téléportation : Reflet-de-Lune|r et parle à |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 98340 >>Rends L'esprit du Grand félin
    .accept 98405 >>Accepte L'esprit du Grand félin
    .target 11802
step << Skyborne
    .goto Moonglade,56.21,30.64
    >>Lance |cRXP_WARN_Téléportation : Reflet-de-Lune|r et parle à |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 98340 >>Rends L'esprit du Grand félin
    .accept 98341 >>Accepte L'esprit du Grand félin du vent
    .target 11802

-- ===== Tauren =====
step << Tauren
    .goto Moonglade,58.39,73.52
    >>Parle à l'|cRXP_FRIENDLY_Esprit du Grand félin|r au sud de Reflet-de-Lune
    .turnin 98405 >>Rends L'esprit du Grand félin
    .accept 98342 >>Accepte L'esprit du Grand félin
    .target 11957
step << Tauren
    .goto Moonglade,74.40,65.40
    >>Entre dans le Stormrage Barrow Den et ramasse les trois reliques
    .complete 98342,1 --Relique du Croc (1)
    .complete 98342,2 --Relique de la Griffe (1)
    .complete 98342,3 --Relique de l'ombre furtive (1)
step << Tauren
    .goto Moonglade,58.39,73.52
    >>Parle à l'|cRXP_FRIENDLY_Esprit du Grand félin|r
    .turnin 98342 >>Rends L'esprit du Grand félin
    .accept 98739 >>Accepte Bénédiction de l'esprit du Grand félin
    .target 11957
step << Tauren
    .goto Moonglade,56.21,30.64
    >>Parle à |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 98739 >>Rends Bénédiction de l'esprit du Grand félin
    .accept 98362 >>Accepte Vers les Pitons-du-Tonnerre
    .target 11802

-- ===== Skyborne =====
step << Skyborne
    .goto Moonglade,43.92,73.44
    >>Parle à l'|cRXP_FRIENDLY_Avatar de Saeyleenan|r au sud de Reflet-de-Lune
    .turnin 98341 >>Rends L'esprit du Grand félin du vent
    .accept 98404 >>Accepte L'esprit du Grand félin du vent
    .target 272054
step << Skyborne
    .goto Moonglade,74.40,65.40
    >>Entre dans le Stormrage Barrow Den et ramasse les trois reliques
    .complete 98404,1 --Relique du Croc (1)
    .complete 98404,2 --Relique de la Griffe (1)
    .complete 98404,3 --Relique de l'ombre furtive (1)
step << Skyborne
    .goto Moonglade,43.92,73.44
    >>Parle à l'|cRXP_FRIENDLY_Avatar de Saeyleenan|r
    .turnin 98404 >>Rends L'esprit du Grand félin du vent
    .accept 98738 >>Accepte Bénédiction de l'esprit du Grand félin du vent
    .target 272054
step << Skyborne
    .goto Moonglade,56.21,30.64
    >>Parle à |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 98738 >>Rends Bénédiction de l'esprit du Grand félin du vent
    .accept 98362 >>Accepte Vers les Pitons-du-Tonnerre
    .target 11802

step
    #label FinFelin
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r pour apprendre la forme de félin
    .turnin 98362 >>Rends Vers les Pitons-du-Tonnerre
    .target 3033
]])

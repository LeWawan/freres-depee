if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Druid Horde, Forme d'ours (niveau 10).
-- Tauren : Turak (Thunder Bluff), Reflet-de-Lune, Lunegriffe à la Moonkin Stone (Barrens).
-- Skyborne : l'esprit ursera sur l'île de Zephras, puis Turak et Reflet-de-Lune.

RXPGuides.RegisterGuide([[
#classic
<< Horde Druid
#name 10 Forme d'ours
#displayname [FDP] Druide 10 : Forme d'ours
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 10 >>Monte au niveau 10, requis pour la quête

-- ===== Tauren =====
step << Tauren
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r sur la cime des Anciens
    .accept 5922 >>Accepte Reflet-de-Lune
    .target 3033
step << Tauren
    .goto Moonglade,56.21,30.64
    >>Lance |cRXP_WARN_Téléportation : Reflet-de-Lune|r et parle à |cRXP_FRIENDLY_Dendrite Starblaze|r au village de Reflet-de-Lune
    .turnin 5922 >>Rends Reflet-de-Lune
    .accept 5930 >>Accepte Esprit du Grand ours
    .target 11802
step << Tauren
    .goto Moonglade,39.11,27.50
    >>Parle à l'|cRXP_FRIENDLY_Esprit du Grand ours|r au nord-ouest de Reflet-de-Lune
    .complete 5930,1 --Écouter l'Esprit du Grand ours
    .target 11956
    .skipgossip
step << Tauren
    .goto Moonglade,56.21,30.64
    >>Parle à |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 5930 >>Rends Esprit du Grand ours
    .accept 5932 >>Accepte Retour vers Thunder Bluff
    .target 11802
step << Tauren
    #completewith next
    .goto Moonglade,44.28,45.87,10 >>Parle à |cRXP_FRIENDLY_Bunthen Plainswind|r pour rentrer à Thunder Bluff en vol
    .target 11798
step << Tauren
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r. Il te donne la |cRXP_LOOT_Poussière lunaire cénarienne|r
    .turnin 5932 >>Rends Retour vers Thunder Bluff
    .accept 6002 >>Accepte Corps et cœur
    .target 3033
step << Tauren
    .goto The Barrens,42.00,60.87
    >>Utilise la |cRXP_LOOT_Poussière lunaire cénarienne|r à la |cRXP_PICK_Moonkin Stone|r, entre Mulgore et les Barrens. Bats |cRXP_ENEMY_Lunegriffe|r puis parle à l'|cRXP_FRIENDLY_Esprit de Lunegriffe|r
    .complete 6002,1 --Affronter Lunegriffe
    .use 15710
    .mob 12138
    .target 12144
    .skipgossip
step << Tauren
    #label FinOursTauren
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r pour apprendre la forme d'ours
    .turnin 6002 >>Rends Corps et cœur
    .target 3033

-- ===== Skyborne =====
step << Skyborne
    .goto 2521,63.99,75.08
    >>Parle à |cRXP_FRIENDLY_Lotheluum Brise-Stellaire|r à Valanaar (île de Zephras)
    .accept 94006 >>Accepte Le grand esprit ursera
    .target 252359
step << Skyborne
    .goto 2521,69.81,61.71
    >>Parle à |cRXP_FRIENDLY_Urs'endris|r près des chutes au nord-est de Valanaar
    .turnin 94006 >>Rends Le grand esprit ursera
    .accept 94638 >>Accepte Force et clémence
    .target 255853
step << Skyborne
    .goto 2521,52.78,65.42
    >>Trouve et tue |cRXP_ENEMY_Ur'endra|r dans les hautes-terres de Shen'dar
    .complete 94638,1 --Ur'endra
    .mob 258443
step << Skyborne
    .goto 2521,69.81,61.71
    >>Parle à |cRXP_FRIENDLY_Urs'endris|r
    .turnin 94638 >>Rends Force et clémence
    .target 255853
step << Skyborne
    .goto Mulgore,33.41,22.59
    >>Prends l'aéronef pour Mulgore et parle à |cRXP_FRIENDLY_Muln Rageterre|r (Skywatcher Plateau, nord-ouest de Mulgore)
    .accept 94911 >>Accepte Enfant de la nature
    .target 259118
step << Skyborne
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r sur la cime des Anciens
    .turnin 94911 >>Rends Enfant de la nature
    .accept 94913 >>Accepte Reflet-de-Lune
    .target 3033
step << Skyborne
    #label FinOursSkyborne
    .goto Moonglade,56.21,30.64
    >>Lance |cRXP_WARN_Téléportation : Reflet-de-Lune|r et parle à |cRXP_FRIENDLY_Dendrite Starblaze|r au village de Reflet-de-Lune
    .turnin 94913 >>Rends Reflet-de-Lune
    .target 11802
]])

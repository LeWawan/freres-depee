if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Shaman Horde, L'appel de la terre (Totem de terre, niveau 4).
-- Orc/Troll : vallée des Épreuves (Durotar). Tauren : camp Narache (Mulgore).
-- Skyborne : Thendal Grove (île de Zephras).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Shaman
#name 4 Totem de terre
#displayname [FDP] Chaman 4 : Totem de terre
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 4 >>Monte au niveau 4, requis pour la quête

-- ===== Orc, Troll : vallée des Épreuves =====
step << Orc/Troll
    .goto Durotar,42.40,69.17
    >>Parle à |cRXP_FRIENDLY_Canaga Earthcaller|r dans la vallée des Épreuves
    .accept 1516 >>Accepte L'appel de la terre
    .target 5887
step << Orc/Troll
    .goto Durotar,43.83,54.86
    >>Tue les |cRXP_ENEMY_Traqueurs corrompus|r pour leurs |cRXP_LOOT_Sabots|r
    >>|cRXP_WARN_~5 % par kill d'après QuestieDB : environ 40 kills (le double si vous êtes deux chamans)|r
    .complete 1516,1 --Sabot de traqueur corrompu (2)
    .mob 3102
step << Orc/Troll
    .goto Durotar,42.40,69.17
    >>Parle à |cRXP_FRIENDLY_Canaga Earthcaller|r. Elle te donne le |cRXP_LOOT_Sapta de terre|r
    .turnin 1516 >>Rends L'appel de la terre
    .accept 1517 >>Accepte L'appel de la terre
    .target 5887
step << Orc/Troll
    .goto Durotar,44.03,76.20
    >>Va à Spirit Rock, au sud de la vallée, et bois le |cRXP_LOOT_Sapta de terre|r pour voir la |cRXP_FRIENDLY_Manifestation de terre mineure|r
    .turnin 1517 >>Rends L'appel de la terre
    .accept 1518 >>Accepte L'appel de la terre
    .use 6635
    .target 5891
step << Orc/Troll
    #label FinTerreDurotar
    .goto Durotar,42.40,69.17
    >>Parle à |cRXP_FRIENDLY_Canaga Earthcaller|r pour recevoir le |cRXP_LOOT_Totem de terre|r
    .turnin 1518 >>Rends L'appel de la terre
    .target 5887

-- ===== Tauren : camp Narache =====
step << Tauren
    .goto Mulgore,44.35,76.77
    >>Parle à la |cRXP_FRIENDLY_Prophétesse Ravenfeather|r au camp Narache
    .accept 1519 >>Accepte L'appel de la terre
    .target 5888
step << Tauren
    .goto Mulgore,62.17,78.12
    >>Tue les |cRXP_ENEMY_Chamans Dos-hirsute|r pour le |cRXP_LOOT_Baume rituel|r (~13 %, environ 15 kills)
    .complete 1519,1 --Baume rituel (2)
    .mob 2953
step << Tauren
    .goto Mulgore,44.35,76.77
    >>Parle à la |cRXP_FRIENDLY_Prophétesse Ravenfeather|r. Elle te donne le |cRXP_LOOT_Sapta de terre|r
    .turnin 1519 >>Rends L'appel de la terre
    .accept 1520 >>Accepte L'appel de la terre
    .target 5888
step << Tauren
    .goto Mulgore,51.99,80.40
    >>Va à Kodo Rock, à l'est du camp, et bois le |cRXP_LOOT_Sapta de terre|r pour voir la |cRXP_FRIENDLY_Manifestation de terre mineure|r
    .turnin 1520 >>Rends L'appel de la terre
    .accept 1521 >>Accepte L'appel de la terre
    .use 6635
    .target 5891
step << Tauren
    #label FinTerreMulgore
    .goto Mulgore,44.35,76.77
    >>Parle à la |cRXP_FRIENDLY_Prophétesse Ravenfeather|r pour recevoir le |cRXP_LOOT_Totem de terre|r
    .turnin 1521 >>Rends L'appel de la terre
    .target 5888

-- ===== Skyborne : Thendal Grove =====
step << Skyborne
    .goto 2521,42.79,23.58
    >>Parle à |cRXP_FRIENDLY_Sculpte-vent Boro|r au Thendal Grove (île de Zephras)
    .accept 92466 >>Accepte L'appel de la terre
    .target 251374
step << Skyborne
    .goto 2521,43.77,24.09
    >>Tue les fidèles |cRXP_ENEMY_al'aketh|r jusqu'à la |cRXP_LOOT_Chevalière d'Akir|r
    .complete 92466,1 --Chevalière d'Akir (1)
    .mob 251160
    .mob 251145
    .mob 251448
step << Skyborne
    .goto 2521,42.79,23.58
    >>Parle à |cRXP_FRIENDLY_Sculpte-vent Boro|r. Il te donne le |cRXP_LOOT_Sapta de terre|r
    .turnin 92466 >>Rends L'appel de la terre
    .accept 92467 >>Accepte L'appel de la terre
    .target 251374
step << Skyborne
    .goto 2521,49.67,23.80
    >>Va à la Rise of Spirits et bois le |cRXP_LOOT_Sapta de terre|r pour voir la |cRXP_FRIENDLY_Manifestation de terre mineure|r
    .turnin 92467 >>Rends L'appel de la terre
    .accept 92468 >>Accepte L'appel de la terre
    .use 6635
    .target 251166
step << Skyborne
    #label FinTerreZephras
    .goto 2521,42.79,23.58
    >>Parle à |cRXP_FRIENDLY_Sculpte-vent Boro|r pour recevoir le |cRXP_LOOT_Totem de terre|r
    .turnin 92468 >>Rends L'appel de la terre
    .target 251374
]])

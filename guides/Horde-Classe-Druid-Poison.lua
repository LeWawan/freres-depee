if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Druid Horde, Pouvoir contre le poison (Guérison du poison, niveau 14).
-- QuestieDB réserve cette chaîne aux Tauren : un Skyborne voit seulement un avertissement.

RXPGuides.RegisterGuide([[
#classic
<< Horde Druid
#name 14 Guérison du poison
#displayname [FDP] Druide 14 : Guérison du poison
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 14 >>Monte au niveau 14, requis pour la quête
step << Skyborne
    #label FinPoisonSkyborne
    +|cRXP_WARN_D'après QuestieDB, cette chaîne est réservée aux druides tauren|r. Coche pour finir
step << Tauren
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r sur la cime des Anciens
    .accept 6126 >>Accepte Nouvelles leçons
    .target 3033
step << Tauren
    .goto Moonglade,56.21,30.64
    >>Lance |cRXP_WARN_Téléportation : Reflet-de-Lune|r et parle à |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 6126 >>Rends Nouvelles leçons
    .accept 6127 >>Accepte Le principe originel
    .target 11802
step << Tauren
    .goto The Barrens,48.40,18.89
    >>Monte au sommet du pic de Brume-funeste et utilise la |cRXP_LOOT_Fiole d'échantillon vide|r au bassin
    .complete 6127,1 --Fiole d'échantillon du Pic de Brume-funeste remplie (1)
    .use 15842
step << Tauren
    .goto The Barrens,52.26,31.93
    >>Parle à |cRXP_FRIENDLY_Tonga Runetotem|r à la Croisée
    .turnin 6127 >>Rends Le principe originel
    .accept 6128 >>Accepte Rassembler les ingrédients du remède
    .target 3448
step << Tauren
    #completewith Remede
    >>Cueille la |cRXP_LOOT_Terrestrine|r que tu croises (ou achète-la à l'hôtel des ventes)
    .complete 6128,1 --Terrestrine (5)
step << Tauren
    #label Remede
    .goto The Barrens,42.39,37.69
    >>Tue les |cRXP_ENEMY_Kodos égarés des Tarides|r pour leurs |cRXP_LOOT_Cornes de kodo|r (~29 %, environ 17 kills)
    .complete 6128,2 --Corne de kodo (5)
    .mob 3234
step << Tauren
    .goto The Barrens,52.26,31.93
    >>Parle à |cRXP_FRIENDLY_Tonga Runetotem|r
    .turnin 6128 >>Rends Rassembler les ingrédients du remède
    .accept 6129 >>Accepte Soigner la maladie
    .target 3448
step << Tauren
    .goto The Barrens,48.80,23.80
    >>Utilise le |cRXP_LOOT_Baume curatif pour animaux|r sur 10 |cRXP_FRIENDLY_Gazelles malades|r, au nord de la route de la Croisée
    .complete 6129,1 --Gazelle malade soignée (10)
    .use 15826
    .target 12296
step << Tauren
    .goto Moonglade,56.21,30.64
    >>Retourne à Reflet-de-Lune et parle à |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 6129 >>Rends Soigner la maladie
    .accept 6130 >>Accepte Pouvoir contre le poison
    .target 11802
step << Tauren
    #label FinPoison
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r pour apprendre Guérison du poison
    .turnin 6130 >>Rends Pouvoir contre le poison
    .target 3033
]])

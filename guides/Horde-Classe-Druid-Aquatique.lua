if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Druid Horde, Forme aquatique (niveau 16).
-- QuestieDB réserve cette chaîne aux Tauren : un Skyborne voit seulement un avertissement.
-- Les deux demi-pendentifs côté Horde : Silverpine (endurance) et le nord des Barrens (agilité).

RXPGuides.RegisterGuide([[
#classic
<< Horde Druid
#name 16 Forme aquatique
#displayname [FDP] Druide 16 : Forme aquatique
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 16 >>Monte au niveau 16, requis pour la quête
step << Skyborne
    #label FinAquatiqueSkyborne
    +|cRXP_WARN_D'après QuestieDB, cette chaîne est réservée aux druides tauren|r. Coche pour finir
step << Tauren
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r sur la cime des Anciens
    .accept 27 >>Accepte Une leçon à apprendre
    .target 3033
step << Tauren
    .goto Moonglade,56.21,30.64
    >>Lance |cRXP_WARN_Téléportation : Reflet-de-Lune|r et parle à |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 27 >>Rends Une leçon à apprendre
    .accept 28 >>Accepte L'épreuve du lac
    .target 11802
step << Tauren
    .goto Moonglade,50.10,50.60
    >>Plonge dans le lac Elune'ara et ouvre un |cRXP_PICK_Conteneur de babioles|r pour le |cRXP_LOOT_Colifichet du sanctuaire|r
    .collect 15877,1,28,1
step << Tauren
    .goto Moonglade,36.00,41.42
    >>Utilise le |cRXP_LOOT_Colifichet du sanctuaire|r au |cRXP_PICK_Sanctuaire de Remulos|r
    .complete 28,1 --Utiliser le colifichet au sanctuaire
    .use 15877
step << Tauren
    .goto Moonglade,36.52,40.10
    >>Parle à |cRXP_FRIENDLY_Tajarri|r au sanctuaire
    .turnin 28 >>Rends L'épreuve du lac
    .accept 30 >>Accepte L'épreuve du lion de mer
    .target 11799
step << Tauren
    .goto Silverpine Forest,29.56,29.20
    >>Plonge au large de la côte de Silverpine et ouvre l'|cRXP_PICK_Etrange coffret|r pour le |cRXP_LOOT_Demi-pendentif d'endurance aquatique|r
    .collect 15882,1,30,1
step << Tauren
    .goto The Barrens,56.67,8.32
    >>Plonge au large de la côte nord des Barrens et ouvre l'|cRXP_PICK_Etrange coffret|r pour le |cRXP_LOOT_Demi-pendentif d'agilité aquatique|r
    .collect 15883,1,30,1
step << Tauren
    .goto Moonglade,36.00,41.42
    >>Retourne au |cRXP_PICK_Sanctuaire de Remulos|r et assemble les deux moitiés en |cRXP_LOOT_Pendentif du lion de mer|r
    .complete 30,1 --Pendentif du lion de mer (1)
    .use 15882
step << Tauren
    .goto Moonglade,56.21,30.64
    >>Parle à |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 30 >>Rends L'épreuve du lion de mer
    .accept 31 >>Accepte Forme aquatique
    .target 11802
step << Tauren
    #label FinAquatique
    .goto Thunder Bluff,76.48,27.22
    >>Parle à |cRXP_FRIENDLY_Turak Runetotem|r pour apprendre la forme aquatique
    .turnin 31 >>Rends Forme aquatique
    .target 3033
]])

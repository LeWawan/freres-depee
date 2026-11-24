if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warlock Horde, Invoquer un Palefroi corrompu (niveau 40).
-- Que de la discussion : prévois l'or de l'entraînement de la monture.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Warlock
#name 40 Palefroi corrompu
#displayname [FDP] Démoniste 40 : Palefroi corrompu
#version 1
#group Guide FDP (Horde)
#subgroup Classe
#next 37-45 Riverglades

step
    .xp 40 >>Monte au niveau 40, requis pour la quête
step << Orc/Troll
    .goto Orgrimmar,48.47,45.43
    >>Parle à |cRXP_FRIENDLY_Zevrost|r dans la Faille de l'ombre
    .accept 3631 >>Accepte Invoquer un Palefroi corrompu
    .target 3326
    .isNotOnQuest 4489
step << Undead
    .goto Undercity,86.21,15.93
    >>Parle à |cRXP_FRIENDLY_Kaal Soulreaper|r au quartier des Mages
    .accept 4489 >>Accepte Invoquer un Palefroi corrompu
    .target 4563
    .isNotOnQuest 3631
step
    #completewith Strahad
    .goto The Barrens,62.63,35.50,30 >>Va à Ratchet, dans la tour au-dessus du port
step
    #label Strahad
    .goto The Barrens,62.63,35.50
    >>Parle à |cRXP_FRIENDLY_Strahad Farsan|r
    .turnin 3631 >>Rends Invoquer un Palefroi corrompu
    .target 6251
    .isOnQuest 3631
step
    .goto The Barrens,62.63,35.50
    >>Parle à |cRXP_FRIENDLY_Strahad Farsan|r
    .turnin 4489 >>Rends Invoquer un Palefroi corrompu
    .target 6251
    .isOnQuest 4489
step
    #label FinPalefroi
    .goto The Barrens,62.63,35.50
    >>Parle à |cRXP_FRIENDLY_Strahad Farsan|r pour apprendre l'invocation du Palefroi corrompu
    .accept 4490 >>Accepte Invoquer un Palefroi corrompu
    .turnin 4490 >>Rends Invoquer un Palefroi corrompu
    .target 6251
    .isQuestTurnedIn 3631,4489
]])

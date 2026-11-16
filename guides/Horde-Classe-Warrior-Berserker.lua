if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warrior Horde, quête de la Posture berserker (niveau 30).
-- Chargé par le #next du guide Thousand Needles, ou à la main depuis le menu RXP.
-- Si la chaîne est déjà faite, toutes les étapes se valident d'elles-mêmes.

RXPGuides.RegisterGuide([[
#classic
<< Horde Warrior
#name 30 Posture berserker
#displayname [FDP] Guerrier 30 : Posture berserker
#version 1
#group Guide FDP (Horde)
#subgroup Classe
#next 30-31 Alterac Mountains

step
    .xp 30 >>Monte au niveau 30, requis pour la quête
step << Orc/Troll
    .goto Orgrimmar,80.39,32.38
    >>Parle à |cRXP_FRIENDLY_Sorek|r au Hall des guerriers
    .accept 1718 >>Accepte L'île mortelle
    .target 3354
step << Tauren
    .goto Thunder Bluff,57.24,87.37
    >>Parle à |cRXP_FRIENDLY_Torm Ragetotem|r au bassin des Chasseurs
    .accept 1718 >>Accepte L'île mortelle
    .target 3041
step << Undead
    .goto Undercity,47.40,17.29
    >>Parle à |cRXP_FRIENDLY_Baltus Fowler|r au quartier des guerriers
    .accept 1718 >>Accepte L'île mortelle
    .target 4595
step
    #completewith Klannoc
    .goto The Barrens,68.62,49.16,40 >>Va sur l'île de la Dispute, au large de la côte est des Barrens (nage depuis la plage)
step
    #label Klannoc
    .goto The Barrens,68.62,49.16
    >>Parle à |cRXP_FRIENDLY_Klannoc Macleod|r
    .turnin 1718 >>Rends L'île mortelle
    .accept 1719 >>Accepte La Dispute
    .target 6236
step
    .goto The Barrens,68.55,48.82
    >>Parle à |cRXP_FRIENDLY_Twiggy Flathead|r pour lancer les combats, bats les challengers puis |cRXP_ENEMY_Grand Will|r
    .complete 1719,1 --Grand Will
    .target 6248
    .mob 6238
step
    .goto The Barrens,68.62,49.16
    >>Parle à |cRXP_FRIENDLY_Klannoc Macleod|r, puis vérifie ton grimoire : la Posture berserker doit y être
    .turnin 1719 >>Rends La Dispute
    .accept 1791 >>Accepte La Vigie des vents (à rendre à Bath'rah, montagnes d'Alterac 80,67)
    .target 6236
]])

if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Rogue Horde, Piller les Pilleurs (Thé de chardon, niveau 16-18).
-- Shenthul, Zando'zan (Orgrimmar), puis Wrenix à Ratchet et le trésor de Polly.

RXPGuides.RegisterGuide([[
#classic
<< Horde Rogue
#name 16 Piller les Pilleurs
#displayname [FDP] Voleur 16 : Piller les Pilleurs
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 16 >>Monte au niveau 16, requis pour la quête
step << Undead
    .goto Undercity,83.51,69.11
    >>Parle à |cRXP_FRIENDLY_Mennet Carkad|r au quartier des Voleurs
    .accept 2378 >>Accepte Trouver la Main brisée
    .target 6467
step << !Undead
    .goto Durotar,51.98,43.69
    >>Parle à |cRXP_FRIENDLY_Kaplak|r à Razor Hill
    .accept 2380 >>Accepte Cap sur Orgrimmar !
    .target 3170
step
    #completewith Shenthul
    .goto Orgrimmar,43.05,53.74,20 >>Va voir |cRXP_FRIENDLY_Shenthul|r dans la Faille de l'ombre (Orgrimmar)
step
    .goto Orgrimmar,43.05,53.74
    >>Parle à |cRXP_FRIENDLY_Shenthul|r
    .turnin 2378 >>Rends Trouver la Main brisée
    .target 3401
    .isOnQuest 2378
step
    .goto Orgrimmar,43.05,53.74
    >>Parle à |cRXP_FRIENDLY_Shenthul|r
    .turnin 2380 >>Rends Cap sur Orgrimmar !
    .target 3401
    .isOnQuest 2380
step
    #label Shenthul
    .goto Orgrimmar,43.05,53.74
    >>Parle à |cRXP_FRIENDLY_Shenthul|r
    .accept 2379 >>Accepte Zando'zan
    .target 3401
step
    .goto Orgrimmar,42.73,52.95
    >>Parle à |cRXP_FRIENDLY_Zando'zan|r, juste à côté
    .turnin 2379 >>Rends Zando'zan
    .accept 2382 >>Accepte Wrenix de Ratchet
    .target 3402
step
    .goto The Barrens,63.07,36.32
    >>Parle à |cRXP_FRIENDLY_Wrenix le Misérable|r à Ratchet. Prends l'|cRXP_LOOT_E.C.A.C.|r et des |cRXP_LOOT_Outils de voleur|r à son appareil gizmotronique
    .turnin 2382 >>Rends Wrenix de Ratchet
    .accept 2381 >>Accepte Piller les Pilleurs
    .target 7161
step
    .goto The Barrens,64.95,45.44
    >>Va au camp des Mers du sud, au sud de Ratchet. Utilise l'|cRXP_LOOT_E.C.A.C.|r sur |cRXP_ENEMY_Polly|r si elle attaque, et crochète le |cRXP_PICK_Joyau des Mers du sud|r pour le |cRXP_LOOT_Trésor|r
    .complete 2381,1 --Trésor des Mers du sud (1)
    .mob 7167
    .mob 7168
step
    #label FinPilleurs
    .goto The Barrens,63.07,36.32
    >>Parle à |cRXP_FRIENDLY_Wrenix le Misérable|r et prends le |cRXP_LOOT_Thé de chardon|r
    .turnin 2381 >>Rends Piller les Pilleurs
    .target 7161
]])

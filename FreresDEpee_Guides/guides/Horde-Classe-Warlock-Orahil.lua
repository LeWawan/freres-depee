if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warlock Horde, l'Orbe d'Orahil (bâton ou orbe de Dar'Orahil, niveau 35-40).
-- Voie choisie : le gangrechien (4962, Dar'Orahil). La voie de l'infernal (4963, Noh'Orahil)
-- n'est pas guidée. Le Démon de l'Orbe est élite niveau 40.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Warlock
#name 35 Orbe d'Orahil
#displayname [FDP] Démoniste 35 : Orbe d'Orahil
#version 1
#group Guide FDP (Horde)
#subgroup Classe
#next 35-37 Arathi Highlands

step
    .xp 35 >>Monte au niveau 35, requis pour la quête
step << Orc/Troll
    .goto Orgrimmar,48.47,45.43
    >>Parle à |cRXP_FRIENDLY_Zevrost|r dans la Faille de l'ombre
    .accept 4967 >>Accepte Connaissance de l'Orbe d'Orahil
    .target 3326
    .isNotOnQuest 4969
step << Undead
    .goto Undercity,86.21,15.93
    >>Parle à |cRXP_FRIENDLY_Kaal Soulreaper|r au quartier des Mages
    .accept 4969 >>Accepte Connaissance de l'Orbe d'Orahil
    .target 4563
    .isNotOnQuest 4967
step
    #completewith Menara1
    .goto The Barrens,62.51,35.45,30 >>Va à Ratchet, dans la tour au-dessus du port
step
    #label Menara1
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .turnin 4967 >>Rends Connaissance de l'Orbe d'Orahil
    .target 6266
    .isOnQuest 4967
step
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .turnin 4969 >>Rends Connaissance de l'Orbe d'Orahil
    .target 6266
    .isOnQuest 4969
step
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .accept 1799 >>Accepte Fragments de l'Orbe d'Orahil
    .target 6266
    .isQuestTurnedIn 4967,4969
step
    .goto The Barrens,62.64,35.30
    >>Parle à l'|cRXP_FRIENDLY_Acolyte Wytula|r (voie du gangrechien)
    .accept 4962 >>Accepte Un éclat de gangrechien
    .target 6254

-- ===== Desolace =====
step
    .goto Desolace,51.40,67.98
    >>Utilise le |cRXP_LOOT_Rubis de Felhas|r sur un |cRXP_ENEMY_Mange-mana|r (gangrechien) et tue-le
    .complete 4962,1 --Esprit de gangrechien emprisonné (1)
    .use 12647
    .mob 4678
step
    .goto Desolace,80.30,76.98
    >>Tue les |cRXP_ENEMY_Invocateurs de la Lame ardente|r jusqu'à l'|cRXP_LOOT_Orbe infernal|r (environ 3 kills)
    .complete 1799,1 --Orbe infernal (1)
    .mob 4668
step
    #completewith Menara2
    .goto The Barrens,62.51,35.45,30 >>Retourne à Ratchet
step
    #label Menara2
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .turnin 4962 >>Rends Un éclat de gangrechien
    .target 6266

-- ===== Marécage d'Âprefange =====
step
    .goto Dustwallow Marsh,46.06,57.09
    >>Parle à |cRXP_FRIENDLY_Tabetha|r
    .turnin 1799 >>Rends Fragments de l'Orbe d'Orahil
    .accept 4961 >>Accepte Purifie l'Orbe d'Orahil
    .target 6546
step
    .goto Dustwallow Marsh,45.79,56.97
    >>Tue le |cRXP_ENEMY_Démon de l'Orbe|r
    >>|cRXP_WARN_Élite niveau 40 : à faire en duo|r
    .complete 4961,1 --Démon de l'Orbe
    .mob 6549
step
    .goto Dustwallow Marsh,46.06,57.09
    >>Parle à |cRXP_FRIENDLY_Tabetha|r
    .turnin 4961 >>Rends Purifie l'Orbe d'Orahil
    .accept 4976 >>Accepte Rapporter l'Orbe purifié
    .target 6546
step
    #completewith Menara3
    .goto The Barrens,62.51,35.45,30 >>Retourne à Ratchet
step
    #label Menara3
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .turnin 4976 >>Rends Rapporter l'Orbe purifié
    .accept 4964 >>Accepte L'Orbe complet de Dar'Orahil
    .target 6266
    .isQuestTurnedIn 4962
step
    .goto The Barrens,62.51,35.45
    >>Attends que |cRXP_FRIENDLY_Menara Voidrender|r termine l'orbe
    .complete 4964,1
step
    #label FinOrahil
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r et choisis le |cRXP_LOOT_Bâton|r ou l'|cRXP_LOOT_Orbe de Dar'Orahil|r
    .turnin 4964 >>Rends L'Orbe complet de Dar'Orahil
    .target 6266
]])

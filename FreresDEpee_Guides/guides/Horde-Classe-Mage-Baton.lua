if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Mage Horde, premier bâton ou orbe de mage (niveau 10).
-- Deux voies exclusives : la ferme des Balnir (Tirisfal) pour les Morts-vivants,
-- les Tas de Ju-Ju (Durotar) pour les Orcs et les Trolls.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Mage
#name 10 Bâton de mage
#displayname [FDP] Mage 10 : Bâton de mage
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 10 >>Monte au niveau 10, requis pour la quête

-- ===== Morts-vivants : la ferme des Balnir =====
step << Undead
    .goto Undercity,85.14,10.03
    >>Parle à |cRXP_FRIENDLY_Anastasia Hartwell|r au quartier des Mages
    .turnin 1881 >>Rends Parler à Anastasia
    .target 4568
    .isOnQuest 1881
step << Undead
    .goto Undercity,85.14,10.03
    >>Parle à |cRXP_FRIENDLY_Anastasia Hartwell|r au quartier des Mages
    .accept 1882 >>Accepte La ferme des Balnir
    .target 4568
step << Undead
    .goto Tirisfal Glades,77.58,61.76
    >>Cueille les |cRXP_PICK_Gueules-de-loup de Balnir|r à la ferme des Balnir, à l'est de Tirisfal
    .complete 1882,1 --Gueules-de-loup de Balnir
step << Undead
    #label FinBalnir
    .goto Undercity,85.14,10.03
    >>Parle à |cRXP_FRIENDLY_Anastasia Hartwell|r et choisis le bâton ou l'orbe
    .turnin 1882 >>Rends La ferme des Balnir
    .target 4568

-- ===== Orcs et Trolls : les Tas de Ju-Ju =====
step << Orc/Troll
    .goto Orgrimmar,39.16,86.27
    >>Parle à |cRXP_FRIENDLY_Uthel'nay|r dans la vallée des Esprits
    .accept 1883 >>Accepte Parler à Un'thuwa
    .target 7311
step << Orc/Troll
    .goto Durotar,56.31,75.11
    >>Parle à |cRXP_FRIENDLY_Un'Thuwa|r au village de Sen'jin
    .turnin 1883 >>Rends Parler à Un'thuwa
    .accept 1884 >>Accepte Les Tas de Ju-Ju
    .target 5880
step << Orc/Troll
    .goto Durotar,67.03,87.80
    >>Détruis 4 |cRXP_PICK_Monceaux Ju-Ju|r sur les îles de l'Écho
    .complete 1884,1 --Monceaux Ju-Ju détruits (4)
step << Orc/Troll
    #label FinJuju
    .goto Durotar,56.31,75.11
    >>Parle à |cRXP_FRIENDLY_Un'Thuwa|r et choisis le bâton ou l'orbe
    .turnin 1884 >>Rends Les Tas de Ju-Ju
    .target 5880
]])

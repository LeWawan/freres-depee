if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Mage Horde, L'Habit du néant (Robe du Néant, niveau 26).
-- QuestieDB réserve cette chaîne aux Trolls et aux Morts-vivants.
-- Les Sœurs rieuses sont en Ashenvale, près d'Astranaar : zone alliance.

RXPGuides.RegisterGuide([[
#classic
<< Horde Mage
#name 26 Robe du Néant
#displayname [FDP] Mage 26 : Robe du Néant
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 26 >>Monte au niveau 26, requis pour la quête
step << Orc
    #label FinNeantOrc
    +|cRXP_WARN_D'après QuestieDB, cette chaîne n'est pas proposée aux Mages orcs : vérifie auprès d'Anastasia Hartwell ou de Deino|r. Coche pour finir
step << Troll/Undead
    .goto Undercity,85.14,10.03
    >>Parle à |cRXP_FRIENDLY_Anastasia Hartwell|r au quartier des Mages d'Undercity
    .accept 1943 >>Accepte Parler à Deino
    .target 4568
step << Troll/Undead
    .goto Orgrimmar,38.45,86.13
    >>Parle à |cRXP_FRIENDLY_Deino|r dans la vallée des Esprits
    .turnin 1943 >>Rends Parler à Deino
    .accept 1944 >>Accepte Les Eaux de Xavian
    .target 5885
step << Troll/Undead
    .goto Ashenvale,76.29,41.49
    >>Utilise la |cRXP_LOOT_fiole|r à la |cRXP_PICK_cascade de Xavian|r, au milieu des satyres
    .complete 1944,1 --Echantillon d'eau de Xavian (1)
    .use 7269
step << Troll/Undead
    .goto Orgrimmar,38.45,86.13
    >>Parle à |cRXP_FRIENDLY_Deino|r
    .turnin 1944 >>Rends Les Eaux de Xavian
    .accept 1945 >>Accepte Les sœurs rieuses
    .target 5885
step << Troll/Undead
    .goto Ashenvale,58.05,58.43
    >>Tue les |cRXP_ENEMY_Sœurs rieuses|r pour leurs |cRXP_LOOT_Cheveux|r (~26 %, environ 46 kills ; le double si vous êtes deux mages)
    >>|cRXP_WARN_Près d'Astranaar : attention aux gardes et aux joueurs|r
    .complete 1945,1 --Cheveu de Soeur rieuse (12)
    .mob 4054
step << Troll/Undead
    #label FinNeant
    .goto The Barrens,52.20,31.70
    >>Parle à |cRXP_FRIENDLY_Kil'hala|r à la Croisée et choisis la robe ou la tunique
    .turnin 1945 >>Rends Les sœurs rieuses
    .accept 1946 >>Accepte L'Habit du néant
    .turnin 1946 >>Rends L'Habit du néant
    .target 3484
]])

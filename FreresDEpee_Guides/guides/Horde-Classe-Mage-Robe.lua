if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Mage Horde, Robe du feu-sorcier (niveau 15).
-- QuestieDB réserve le début (1959) et la robe (1962) aux Trolls et aux Morts-vivants :
-- un Mage orc doit vérifier en jeu qu'il peut finir la chaîne.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Mage
#name 15 Robe du feu-sorcier
#displayname [FDP] Mage 15 : Robe du feu-sorcier
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 15 >>Monte au niveau 15, requis pour la quête
step << Orc
    +|cRXP_WARN_D'après QuestieDB, la robe n'est pas proposée aux Mages orcs : vérifie auprès d'Anastasia Hartwell avant de faire la chaîne|r. Coche pour continuer
step
    #completewith Anastasia1
    .goto Undercity,85.14,10.03,20 >>Va voir |cRXP_FRIENDLY_Anastasia Hartwell|r au quartier des Mages d'Undercity
step
    .goto Undercity,85.14,10.03
    >>Parle à |cRXP_FRIENDLY_Anastasia Hartwell|r
    .turnin 1959 >>Rends Rendre compte à Anastasia
    .target 4568
    .isOnQuest 1959
step
    #label Anastasia1
    .goto Undercity,85.14,10.03
    >>Parle à |cRXP_FRIENDLY_Anastasia Hartwell|r
    .accept 1960 >>Accepte Enquêter dans le magasin de l'Alchimiste
    .target 4568
step
    .goto Undercity,85.67,9.91
    >>Prends la |cRXP_PICK_Caisse de coffres de stockage|r et les |cRXP_PICK_Chants de manifestation|r derrière Anastasia
    .complete 1960,2 --Caisse de coffres de stockage (1)
    .complete 1960,3 --Chants de manifestation (1)
step
    .goto Undercity,53.29,74.56
    >>Lis les |cRXP_LOOT_Chants de manifestation|r près du magasin de l'alchimiste pour faire apparaître un |cRXP_ENEMY_Rejeton de la faille|r. Bats-le jusqu'à l'étourdir, puis utilise la |cRXP_LOOT_Caisse de coffres de stockage|r dessus. Trois fois
    .complete 1960,1 --Coffre de stockage rempli (3)
    .use 7308
    .use 7247
    .mob 6492
step
    .goto Undercity,85.14,10.03
    >>Parle à |cRXP_FRIENDLY_Anastasia Hartwell|r
    .turnin 1960 >>Rends Enquêter dans le magasin de l'Alchimiste
    .accept 1961 >>Accepte Rassembler les matériaux
    .target 4568
step
    #completewith Gemmes
    >>Garde 10 |cRXP_LOOT_Etoffes de lin|r (sur les humanoïdes ou à l'hôtel des ventes)
    .complete 1961,1 --Etoffe de lin (10)
step
    #label Gemmes
    .goto Silverpine Forest,51.77,65.83
    >>Tue les |cRXP_ENEMY_Apprenties de Dalaran|r à la ferme d'Ambermill pour les |cRXP_LOOT_Gemmes de mana de Dalaran|r
    >>|cRXP_WARN_~11 % par kill : environ 55 kills (le double si vous êtes deux mages)|r
    .complete 1961,2 --Gemme de mana de Dalaran (6)
    .mob 1867
    .mob 1912
    .mob 1914
step
    .goto Undercity,70.76,30.69
    >>Parle à |cRXP_FRIENDLY_Josef Gregorian|r au quartier des Artisans
    .turnin 1961 >>Rends Rassembler les matériaux
    .target 4576
step << Troll/Undead
    #label FinRobeFeu
    .goto Undercity,70.76,30.69
    >>Parle à |cRXP_FRIENDLY_Josef Gregorian|r pour recevoir la |cRXP_LOOT_Robe du feu-sorcier mineur|r
    .accept 1962 >>Accepte Robe du feu-sorcier
    .turnin 1962 >>Rends Robe du feu-sorcier
    .target 4576
]])

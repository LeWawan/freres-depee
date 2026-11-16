if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Paladin Horde (Forever), Une leçon de divinité (Rédemption, niveau 12).
-- QuestieDB réserve ces quêtes aux Morts-vivants : Danitha Morr (donjon de Bandarion),
-- Tanis Aulnebois (Undercity), puis le Symbole de vie sur le nécrogarde Falgan.

RXPGuides.RegisterGuide([[
#classic
<< Horde Paladin
#name 12 Leçon de divinité
#displayname [FDP] Paladin 12 : Leçon de divinité
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 12 >>Monte au niveau 12, requis pour la quête
step
    .goto Tirisfal Glades,22.09,44.66
    >>Parle à |cRXP_FRIENDLY_Danitha Morr|r au donjon de Bandarion
    .accept 94427 >>Accepte Une leçon de divinité
    .target 246378
step
    .goto Undercity,65.48,37.49
    >>Parle à |cRXP_FRIENDLY_Tanis Aulnebois|r à Undercity
    .turnin 94427 >>Rends Une leçon de divinité
    .accept 94434 >>Accepte Une leçon de divinité
    .target 257648
step
    .goto Undercity,65.48,37.49
    >>Donne 10 |cRXP_LOOT_Etoffes de lin|r à |cRXP_FRIENDLY_Tanis Aulnebois|r
    .collect 2589,10,94434,1
    .turnin 94434 >>Rends Une leçon de divinité
    .accept 94435 >>Accepte Une leçon de divinité
    .target 257648
step
    .goto Tirisfal Glades,22.09,44.66
    >>Retourne voir |cRXP_FRIENDLY_Danitha Morr|r. Elle te donne le |cRXP_LOOT_Symbole de vie|r
    .turnin 94435 >>Rends Une leçon de divinité
    .accept 94436 >>Accepte Une leçon de divinité
    .target 246378
step
    .goto Tirisfal Glades,21.92,44.50
    >>Parle au |cRXP_FRIENDLY_Nécrogarde Billmuth|r, juste à côté
    .turnin 94436 >>Rends Une leçon de divinité
    .accept 94438 >>Accepte Une leçon de divinité
    .target 257655
step
    .goto Tirisfal Glades,86.73,47.72
    >>Va à Venomweb Vale, à l'est de Tirisfal, et utilise le |cRXP_LOOT_Symbole de vie|r pour ressusciter le |cRXP_FRIENDLY_Nécrogarde Falgan|r
    .turnin 94438 >>Rends Une leçon de divinité
    .accept 94440 >>Accepte Une leçon de divinité
    .use 6866
    .target 257663
step
    .goto Tirisfal Glades,87.44,42.91
    >>Tue les |cRXP_ENEMY_Zélotes|r et les |cRXP_ENEMY_Sœurs écarlates|r jusqu'aux |cRXP_LOOT_Plans d'attaque de la Croisade écarlate|r
    .complete 94440,1 --Plans d'attaque de la Croisade écarlate (1)
    .mob 1537
    .mob 1538
step
    .goto Tirisfal Glades,21.92,44.50
    >>Retourne voir le |cRXP_FRIENDLY_Nécrogarde Billmuth|r au donjon de Bandarion
    .turnin 94440 >>Rends Une leçon de divinité
    .accept 94441 >>Accepte Une leçon de divinité
    .target 257655
step
    #label FinDivinite
    .goto Tirisfal Glades,22.09,44.66
    >>Parle à |cRXP_FRIENDLY_Danitha Morr|r dans le donjon
    .turnin 94441 >>Rends Une leçon de divinité
    .target 246378
]])

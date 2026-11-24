if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Paladin Horde (Forever), le donjon de Bandarion (niveau 8-12).
-- QuestieDB réserve ces quêtes aux Morts-vivants. Shari Morpuits (Brill) envoie au donjon
-- de Bandarion, à l'ouest de Tirisfal : Breton Samuels, Jorin Croge, Danitha Morr.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Paladin
#name 8 Donjon de Bandarion
#displayname [FDP] Paladin 8 : Donjon de Bandarion
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 8 >>Monte au niveau 8, requis pour la quête
step
    .goto Tirisfal Glades,60.22,52.66
    >>Parle à |cRXP_FRIENDLY_Shari Morpuits|r à Brill
    .accept 91282 >>Accepte Un second foyer
    .target 246152
step
    .goto Tirisfal Glades,21.85,45.23
    >>Va au donjon de Bandarion, à l'ouest de Tirisfal, et parle à |cRXP_FRIENDLY_Breton Samuels|r
    .turnin 91282 >>Rends Un second foyer
    .accept 91285 >>Accepte Des Murlocs à nos portes
    .target 246349
step
    .goto Tirisfal Glades,12.17,58.03
    >>Tue les |cRXP_ENEMY_Attaquants|r et les |cRXP_ENEMY_Oracles aileron noir|r sur la côte ouest
    .complete 91285,1 --Attaquant aileron noir (8)
    .complete 91285,2 --Oracle aileron noir (8)
    .mob 250283
    .mob 250282
step
    .goto Tirisfal Glades,21.85,45.23
    >>Parle à |cRXP_FRIENDLY_Breton Samuels|r
    .turnin 91285 >>Rends Des Murlocs à nos portes
    .accept 91294 >>Accepte En patrouille
    .target 246349
step
    .goto Tirisfal Glades,21.96,47.25
    >>Parle aux habitants du donjon : |cRXP_FRIENDLY_Hilda la Briseuse|r, |cRXP_FRIENDLY_Jorin Croge|r, |cRXP_FRIENDLY_Ander Solliden|r (25,50) et |cRXP_FRIENDLY_Danitha Morr|r
    .complete 91294,1 --Hilda la Briseuse
    .complete 91294,2 --Jorin Croge
    .complete 91294,3 --Ander Solliden
    .complete 91294,4 --Danitha Morr
    .target 246389
    .target 246393
    .target 246394
    .target 246378
step
    .xp 9 >>Monte au niveau 9, requis pour la suite
step
    .goto Tirisfal Glades,22.09,44.66
    >>Parle à |cRXP_FRIENDLY_Danitha Morr|r
    .turnin 91294 >>Rends En patrouille
    .accept 91317 >>Accepte Les ternis
    .target 246378
step
    .goto Tirisfal Glades,22.69,44.70
    >>Parle à |cRXP_FRIENDLY_Jorin Croge|r
    .accept 91316 >>Accepte Procéder aux réparations
    .target 246393
step
    .goto Tirisfal Glades,8.80,66.00
    >>Ramasse 12 |cRXP_LOOT_Bois solides|r sur les |cRXP_PICK_Tas de bois|r de Shadowvale
    .complete 91316,1 --Bois solide (12)
step
    .goto Tirisfal Glades,9.99,58.57
    >>Tue les |cRXP_ENEMY_Manoeuvres|r et les |cRXP_ENEMY_Zélotes ternis|r du sud-ouest de Tirisfal et |cRXP_ENEMY_Rudolph Gelhardt|r (11,64) pour sa |cRXP_LOOT_Tête|r
    .complete 91317,1 --Manoeuvre terni (8)
    .complete 91317,2 --Zélote terni (6)
    .complete 91317,3 --Tête de Rudolph Gelhardt (1)
    .mob 259434
    .mob 259433
    .mob 259431
step
    .goto Tirisfal Glades,22.69,44.70
    >>Parle à |cRXP_FRIENDLY_Jorin Croge|r
    .turnin 91316 >>Rends Procéder aux réparations
    .target 246393
step
    .goto Tirisfal Glades,22.09,44.66
    >>Parle à |cRXP_FRIENDLY_Danitha Morr|r
    .turnin 91317 >>Rends Les ternis
    .accept 95803 >>Accepte Un gage de bonne volonté
    .target 246378
step
    #label FinBandarion
    .goto Undercity,58.05,91.79
    >>Apporte la tête à |cRXP_FRIENDLY_Dame Sylvanas Windrunner|r dans la Chambre royale d'Undercity
    .turnin 95803 >>Rends Un gage de bonne volonté
    .target 10181
]])

if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Paladin Horde (Forever), Les palefrois des paladins (niveau 40).
-- QuestieDB réserve ces quêtes aux Morts-vivants. Rendre compte à Danitha n'est qu'un
-- message d'Undercity ou de Thunder Bluff : on va directement voir Danitha Morr.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Paladin
#name 40 Destrier
#displayname [FDP] Paladin 40 : Destrier
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 40 >>Monte au niveau 40, requis pour la quête
step
    #completewith Danitha
    .goto Tirisfal Glades,22.09,44.66,30 >>Va au donjon de Bandarion, à l'ouest des clairières de Tirisfal
step
    .goto Tirisfal Glades,22.09,44.66
    >>Parle à |cRXP_FRIENDLY_Danitha Morr|r
    .turnin 97022 >>Rends Rendre compte à Danitha
    .target 246378
    .isOnQuest 97022
step
    #label Danitha
    .goto Tirisfal Glades,22.09,44.66
    >>Parle à |cRXP_FRIENDLY_Danitha Morr|r pour apprendre l'invocation de ton destrier
    .accept 94971 >>Accepte Les palefrois des paladins
    .turnin 94971 >>Rends Les palefrois des paladins
    .target 246378
]])

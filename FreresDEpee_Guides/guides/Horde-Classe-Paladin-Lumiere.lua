if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Paladin Horde (Forever), premiers pas du paladin mort-vivant (niveau 2-4).
-- QuestieDB réserve ces quêtes aux Morts-vivants : Aramis Mainmartel à Deathknell, puis Brill.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Paladin
#name 2 Lumière retrouvée
#displayname [FDP] Paladin 2 : Lumière retrouvée
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 2 >>Monte au niveau 2, requis pour la quête
step
    .goto Tirisfal Glades,31.01,66.24
    >>Parle à |cRXP_FRIENDLY_Aramis Mainmartel|r dans l'église de Deathknell
    .turnin 98601 >>Rends Un chemin tortueux
    .target 244808
    .isOnQuest 98601
step
    .goto Tirisfal Glades,31.01,66.24
    >>Parle à |cRXP_FRIENDLY_Aramis Mainmartel|r dans l'église de Deathknell (après Les Déchus)
    .accept 90902 >>Accepte Redécouverte de la Lumière
    .target 244808
    .isQuestTurnedIn 364
step
    .goto Tirisfal Glades,29.69,66.13
    >>Soigne 5 |cRXP_FRIENDLY_Nécrogardes blessés|r avec Lumière sacrée
    .complete 90902,1 --Nécrogarde blessé soigné (5)
    .target 259377
step
    .goto Tirisfal Glades,31.01,66.24
    >>Parle à |cRXP_FRIENDLY_Aramis Mainmartel|r
    .turnin 90902 >>Rends Redécouverte de la Lumière
    .target 244808
step
    .xp 4 >>Monte au niveau 4 pour la suite
step
    .goto Tirisfal Glades,31.01,66.24
    >>Parle à |cRXP_FRIENDLY_Aramis Mainmartel|r
    .accept 91208 >>Accepte L'acceptation
    .accept 91209 >>Accepte Poursuivre votre entraînement
    .target 244808
step
    .goto Tirisfal Glades,27.69,63.82
    >>Trouve la |cRXP_FRIENDLY_Paladine effrayée|r à l'ouest de Deathknell
    .complete 91208,1 --Paladine effrayée
    .target 246143
step
    .goto Tirisfal Glades,31.01,66.24
    >>Parle à |cRXP_FRIENDLY_Aramis Mainmartel|r
    .turnin 91208 >>Rends L'acceptation
    .target 244808
step
    #label FinLumiere
    .goto Tirisfal Glades,60.22,52.66
    >>Suis la route vers l'est jusqu'à Brill et parle à |cRXP_FRIENDLY_Shari Morpuits|r
    .complete 91209,1 --Parler à Shari Morpuits
    .turnin 91209 >>Rends Poursuivre votre entraînement
    .target 246152
]])

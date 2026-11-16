if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Rogue Horde, Les outils du métier (niveau 16-20).
-- QuestieDB réserve cette chaîne aux Morts-vivants. Il faut des Outils de voleur et
-- un peu de Crochetage pour le coffre d'Ambermill.

RXPGuides.RegisterGuide([[
#classic
<< Horde Rogue
#name 16 Outils du métier
#displayname [FDP] Voleur 16 : Outils du métier
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 16 >>Monte au niveau 16, requis pour la quête
step << !Undead
    #label FinOutilsAutres
    +|cRXP_WARN_D'après QuestieDB, cette chaîne est réservée aux Morts-vivants|r. Coche pour finir
step << Undead
    .goto Undercity,83.51,69.11
    >>Parle à |cRXP_FRIENDLY_Mennet Carkad|r au quartier des Voleurs
    .accept 1998 >>Accepte Fenwick Thatros
    .target 6467
step << Undead
    .goto Silverpine Forest,59.58,33.94
    >>Tue |cRXP_ENEMY_Fenwick Thatros|r et ramasse sa |cRXP_LOOT_Tête|r (~39 %, il peut falloir l'attendre)
    .complete 1998,1 --Tête de Fenwick (1)
    .mob 6570
step << Undead
    .goto Undercity,83.51,69.11
    >>Parle à |cRXP_FRIENDLY_Mennet Carkad|r
    .turnin 1998 >>Rends Fenwick Thatros
    .accept 1999 >>Accepte Les outils du métier
    .target 6467
step << Undead
    .goto Undercity,78.22,76.26,5
    >>Parle à |cRXP_FRIENDLY_Estelle Gendry|r au quartier des Voleurs avant de partir
    .target 6566
    .skipgossip
step << Undead
    .goto Silverpine Forest,63.71,65.24
    >>Crochète le |cRXP_PICK_Coffre-fort d'Ambermill|r et prends le |cRXP_LOOT_Rapport de situation de Dalaran|r
    >>|cRXP_WARN_Il faut des Outils de voleur dans le sac|r
    .complete 1999,1 --Rapport de situation de Dalaran (1)
step << Undead
    #label FinOutils
    .goto Undercity,83.51,69.11
    >>Parle à |cRXP_FRIENDLY_Mennet Carkad|r
    .turnin 1999 >>Rends Les outils du métier
    .target 6467
]])

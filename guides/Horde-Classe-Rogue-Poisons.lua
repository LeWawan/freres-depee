if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Rogue Horde, Le Salut brisé et L'aide d'Hinott (poisons, niveau 20).
-- Tour de la KapitalRisk au nord des Barrens : Gallywix est élite niveau 23.

RXPGuides.RegisterGuide([[
#classic
<< Horde Rogue
#name 20 Poisons
#displayname [FDP] Voleur 20 : Poisons
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 20 >>Monte au niveau 20, requis pour la quête
step
    .goto Orgrimmar,43.05,53.74
    >>Parle à |cRXP_FRIENDLY_Shenthul|r dans la Faille de l'ombre, puis fais-lui l'emote |cRXP_WARN_salut|r
    .accept 2460 >>Accepte Le Salut brisé
    .complete 2460,1 --Salut brisé
    .emote SALUTE,3401
    .target 3401
step
    .goto Orgrimmar,43.05,53.74
    >>Parle à |cRXP_FRIENDLY_Shenthul|r. Il te donne le |cRXP_LOOT_Pistolet éclairant|r
    .turnin 2460 >>Rends Le Salut brisé
    .accept 2458 >>Accepte Sous le couvert de la nuit
    .target 3401
step
    .goto The Barrens,55.44,5.56
    >>Va à la tour de la KapitalRisk, au nord du marais de la Boue. Tire deux fusées avec le |cRXP_LOOT_Pistolet éclairant|r, puis fais l'emote |cRXP_WARN_salut|r au |cRXP_FRIENDLY_Sous-chef Fizzule|r
    >>|cRXP_WARN_Dans cet ordre, sinon il attaque|r
    .turnin 2458 >>Rends Sous le couvert de la nuit
    .accept 2478 >>Accepte Mission : possible mais non probable
    .use 8051
    .emote SALUTE,7233
    .target 7233
step
    .goto The Barrens,54.80,5.97
    >>Fais les poches du |cRXP_ENEMY_Contremaître Silixiz|r pour la |cRXP_LOOT_Clé de la tour|r, puis tue 2 |cRXP_ENEMY_Pantins mutés|r, 2 |cRXP_ENEMY_Patrouilleurs|r et 2 |cRXP_ENEMY_Sentinelles|r dans la tour
    .complete 2478,5 --Clé de la tour de Silixiz (1)
    .complete 2478,1 --Pantin muté de la KapitalRisk (2)
    .complete 2478,2 --Sentinelle de la KapitalRisk (2)
    .complete 2478,3 --Patrouilleur de la KapitalRisk (2)
    .mob 7287
    .mob 7310
    .mob 7307
    .mob 7308
step
    .goto The Barrens,54.75,5.59
    >>En haut de la tour, tue le |cRXP_ENEMY_Grand contremaître Puzik Gallywix|r, puis crochète le |cRXP_PICK_Coffret de Gallywix|r
    >>|cRXP_WARN_Gallywix est élite niveau 23 : à faire en duo|r
    .complete 2478,4 --Tête de Gallywix (1)
    .complete 2478,6 --Cache de mixture altérée de Zanzil (1)
    .mob 7288
step
    .goto Orgrimmar,43.05,53.74
    >>Retourne voir |cRXP_FRIENDLY_Shenthul|r
    .turnin 2478 >>Rends Mission : possible mais non probable
    .accept 2479 >>Accepte L'aide d'Hinott
    .target 3401
step
    .goto Hillsbrad Foothills,61.63,19.19
    >>Parle à |cRXP_FRIENDLY_Serge Hinott|r à Tarren Mill
    .turnin 2479 >>Rends L'aide d'Hinott
    .accept 2480 >>Accepte L'aide d'Hinott
    .target 2391
step
    .goto Hillsbrad Foothills,61.63,19.19
    >>Attends que |cRXP_FRIENDLY_Serge Hinott|r termine le remède
    .complete 2480,1 --Remède terminé
step
    #label FinPoisons
    .goto Hillsbrad Foothills,61.63,19.19
    >>Parle à |cRXP_FRIENDLY_Serge Hinott|r et prends l'|cRXP_LOOT_Huile d'Hinott|r
    .turnin 2480 >>Rends L'aide d'Hinott
    .target 2391
]])

if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warrior Horde, L'épreuve du Champ des géants (Bouclier de Ruga, niveau 20).
-- La suite (Armure de brutalité, 1838) demande la Fiole de Phlogiston de Roogug dans
-- Kraal de Tranchebauge : quête de donjon, hors de ce guide.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Warrior
#name 20 Bouclier de Ruga
#displayname [FDP] Guerrier 20 : Bouclier de Ruga
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 20 >>Monte au niveau 20, requis pour la quête
step << Orc/Troll
    .goto Orgrimmar,80.39,32.38
    >>Parle à |cRXP_FRIENDLY_Sorek|r au Hall des guerriers
    .accept 1823 >>Accepte Parler à Ruga
    .target 3354
step << Tauren/Skyborne
    .goto Thunder Bluff,57.24,87.37
    >>Parle à |cRXP_FRIENDLY_Torm Ragetotem|r au bassin des Chasseurs
    .accept 1823 >>Accepte Parler à Ruga
    .target 3041
step << Undead
    .goto Undercity,47.40,17.29
    >>Parle à |cRXP_FRIENDLY_Baltus Fowler|r au quartier des guerriers
    .accept 1823 >>Accepte Parler à Ruga
    .target 4595
step
    #completewith Ruga1
    .goto The Barrens,44.67,59.42,40 >>Va au camp Taurajo, dans le sud des Barrens
step
    #label Ruga1
    .goto The Barrens,44.67,59.42
    >>Parle à |cRXP_FRIENDLY_Ruga Ragetotem|r
    .turnin 1823 >>Rends Parler à Ruga
    .accept 1824 >>Accepte L'épreuve du Champ des géants
    .target 6394
step
    .goto The Barrens,44.90,72.55
    >>Tue les silithides du Champ des géants pour les |cRXP_LOOT_Antennes mobiles|r. Les |cRXP_ENEMY_Rampants silithides|r donnent le plus souvent
    >>|cRXP_WARN_~12 % sur les rampants, ~6 % sur les autres : environ 45 kills (le double si vous êtes deux guerriers)|r
    .complete 1824,1 --Antenne mobile (5)
    .mob 3250
    .mob 3251
    .mob 3252
step
    .goto The Barrens,44.67,59.42
    >>Parle à |cRXP_FRIENDLY_Ruga Ragetotem|r et prends le |cRXP_LOOT_Bouclier de Ruga|r
    .turnin 1824 >>Rends L'épreuve du Champ des géants
    .accept 1825 >>Accepte Parler à Thun'grim
    .target 6394
step
    #label FinRuga
    .goto The Barrens,57.23,30.34
    >>Parle à |cRXP_FRIENDLY_Thun'grim Firegaze|r, au nord-est de la Croisée
    >>|cRXP_WARN_Sa suite, Armure de brutalité, demande une fiole de Kraal de Tranchebauge (donjon) : elle n'est pas dans ce guide|r
    .turnin 1825 >>Rends Parler à Thun'grim
    .target 5878
]])

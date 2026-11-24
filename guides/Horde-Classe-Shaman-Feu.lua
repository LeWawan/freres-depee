if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Shaman Horde, L'appel du feu (Totem de feu, niveau 10-13).
-- Orc/Troll/Tauren : Kranal Fiss (Barrens), Telf Joolam et le sanctuaire de la Flamme éternelle
-- (Durotar). Skyborne : Olariaan Vivebrûle sur l'île de Zephras.
-- Le Goudron de feu tombe à ~1 % (objet de quête, pas d'hôtel des ventes) : prévois un long farm.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Shaman
#name 10 Totem de feu
#displayname [FDP] Chaman 10 : Totem de feu
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 10 >>Monte au niveau 10, requis pour la quête

-- ===== Orc, Troll, Tauren =====
step << Orc/Troll
    .goto Orgrimmar,37.96,37.73
    >>Parle à |cRXP_FRIENDLY_Searn Firewarder|r dans la vallée de la Sagesse
    .accept 1522 >>Accepte L'appel du feu
    .target 5892
step << Tauren
    .goto Thunder Bluff,25.16,20.51
    >>Parle à |cRXP_FRIENDLY_Xanis Flameweaver|r sur la cime des Esprits
    .accept 1523 >>Accepte L'appel du feu
    .target 5906
step << !Skyborne
    #completewith Kranal1
    .goto The Barrens,56.03,19.89,30 >>Va voir |cRXP_FRIENDLY_Kranal Fiss|r dans le nord des Barrens
step << !Skyborne
    .goto The Barrens,56.03,19.89
    >>Parle à |cRXP_FRIENDLY_Kranal Fiss|r
    .turnin 1522 >>Rends L'appel du feu
    .target 5907
    .isOnQuest 1522
step << !Skyborne
    .goto The Barrens,56.03,19.89
    >>Parle à |cRXP_FRIENDLY_Kranal Fiss|r
    .turnin 1523 >>Rends L'appel du feu
    .target 5907
    .isOnQuest 1523
step << !Skyborne
    .goto The Barrens,56.03,19.89
    >>Parle à |cRXP_FRIENDLY_Kranal Fiss|r
    .turnin 2983 >>Rends L'appel du feu
    .target 5907
    .isOnQuest 2983
step << !Skyborne
    .goto The Barrens,56.03,19.89
    >>Parle à |cRXP_FRIENDLY_Kranal Fiss|r
    .turnin 2984 >>Rends L'appel du feu
    .target 5907
    .isOnQuest 2984
step << !Skyborne
    #label Kranal1
    .goto The Barrens,56.03,19.89
    >>Parle à |cRXP_FRIENDLY_Kranal Fiss|r. Il te donne la |cRXP_LOOT_Torche de la Flamme dormante|r
    .accept 1524 >>Accepte L'appel du feu
    .target 5907
step << !Skyborne
    .goto Durotar,38.55,58.96
    >>Parle à |cRXP_FRIENDLY_Telf Joolam|r au pied du sanctuaire, à l'ouest de Durotar
    .turnin 1524 >>Rends L'appel du feu
    .accept 1525 >>Accepte L'appel du feu
    .target 5900
step << !Skyborne
    #completewith GoudronFeu
    .goto Durotar,52.67,25.36,0
    >>Tue les |cRXP_ENEMY_Sectateurs de la Lame ardente|r (grottes de Durotar) pour la |cRXP_LOOT_Bourse de réactifs|r (~32 %)
    .complete 1525,2 --Bourse de réactifs (1)
    .mob 3199
step << !Skyborne
    #label GoudronFeu
    .goto The Barrens,54.37,25.01
    >>Tue les quilboars |cRXP_ENEMY_Tranchecrin|r pour le |cRXP_LOOT_Goudron de feu|r
    >>|cRXP_WARN_Farm long : ~1 % par kill, environ 100 kills (le double si vous êtes deux chamans)|r
    .complete 1525,1 --Goudron de feu (1)
    .mob 3267
    .mob 3268
    .mob 3269
step << !Skyborne
    .goto Durotar,52.67,25.36
    >>Termine la |cRXP_LOOT_Bourse de réactifs|r si tu ne l'as pas encore
    .complete 1525,2 --Bourse de réactifs (1)
    .mob 3199
step << !Skyborne
    .goto Durotar,38.55,58.96
    >>Parle à |cRXP_FRIENDLY_Telf Joolam|r. Il te donne le |cRXP_LOOT_Sapta de feu|r
    .turnin 1525 >>Rends L'appel du feu
    .accept 1526 >>Accepte L'appel du feu
    .target 5900
step << !Skyborne
    .goto Durotar,38.72,58.29
    >>Monte au sommet du sanctuaire, bois le |cRXP_LOOT_Sapta de feu|r et tue la |cRXP_ENEMY_Manifestation de feu mineure|r pour la |cRXP_LOOT_Braise rougeoyante|r
    .complete 1526,1 --Braise rougeoyante (1)
    .use 6636
    .mob 5893
step << !Skyborne
    .goto Durotar,38.96,58.22
    >>Place la braise dans le |cRXP_PICK_Brasero de la Flamme dormante|r
    .turnin 1526 >>Rends L'appel du feu
    .accept 1527 >>Accepte L'appel du feu
step << !Skyborne
    #label FinFeu
    .goto The Barrens,56.03,19.89
    >>Rapporte la |cRXP_LOOT_Torche de la flamme éternelle|r à |cRXP_FRIENDLY_Kranal Fiss|r pour recevoir le |cRXP_LOOT_Totem de feu|r
    .turnin 1527 >>Rends L'appel du feu
    .target 5907

-- ===== Skyborne : île de Zephras =====
step << Skyborne
    .goto 2521,58.31,78.51
    >>Parle à |cRXP_FRIENDLY_Sessaria Marcheciel|r à Valanaar (île de Zephras)
    .turnin 98517 >>Rends L'appel du feu
    .target 252382
    .isOnQuest 98517
step << Skyborne
    .goto 2521,58.31,78.51
    >>Parle à |cRXP_FRIENDLY_Sessaria Marcheciel|r. Elle te donne la |cRXP_LOOT_Torche de la Flamme dormante|r
    .accept 97243 >>Accepte L'appel du feu
    .target 252382
step << Skyborne
    .goto 2521,51.24,86.19
    >>Parle à |cRXP_FRIENDLY_Olariaan Vivebrûle|r au sanctuaire des Flammes
    .turnin 97243 >>Rends L'appel du feu
    .accept 97244 >>Accepte L'appel du feu
    .target 268592
step << Skyborne
    .goto 2521,64.43,63.71
    >>Tue le |cRXP_ENEMY_Prêtre céleste Faladiel|r et prends son |cRXP_LOOT_Cœur|r
    .complete 97244,1 --Cœur de Faladiel (1)
    .mob 268602
step << Skyborne
    .goto 2521,51.24,86.19
    >>Parle à |cRXP_FRIENDLY_Olariaan Vivebrûle|r
    .turnin 97244 >>Rends L'appel du feu
    .accept 97245 >>Accepte L'appel du feu
    .target 268592
step << Skyborne
    .goto 2521,42.44,68.75
    >>Frappe à la souche de |cRXP_ENEMY_Kuramaa|r dans les hautes-terres de Shen'dar, bats l'esprit et prends son |cRXP_LOOT_Masque|r
    .complete 97245,1 --Masque de Kuramaa (1)
    .mob 268605
step << Skyborne
    .goto 2521,51.24,86.19
    >>Parle à |cRXP_FRIENDLY_Olariaan Vivebrûle|r
    .turnin 97245 >>Rends L'appel du feu
    .accept 97257 >>Accepte L'appel du feu
    .target 268592
step << Skyborne
    .goto 2521,51.20,85.90
    >>Attends le rituel au |cRXP_PICK_Brasero d'offrande|r et suis les instructions d'Olariaan
    .complete 97257,1 --Rituel au brasero d'offrande
step << Skyborne
    .goto 2521,58.35,78.84
    >>|cRXP_WARN_Minuté|r : porte la flamme éternelle jusqu'au |cRXP_PICK_Brasero de la flamme éternelle|r de Valanaar
    .complete 97257,2 --Brasero de la flamme éternelle
step << Skyborne
    #label FinFeuZephras
    .goto 2521,58.31,78.51
    >>Parle à |cRXP_FRIENDLY_Sessaria Marcheciel|r pour recevoir le |cRXP_LOOT_Totem de feu|r
    .turnin 97257 >>Rends L'appel du feu
    .target 252382
]])

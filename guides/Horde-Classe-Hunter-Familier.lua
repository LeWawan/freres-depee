if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Hunter Horde, Dompter la bête (familier, niveau 10).
-- Trois chaînes selon la race : Thotar (Durotar) pour Orc/Troll, Yaw Sharpmane (Mulgore)
-- pour les Tauren, Quel'ana Vent-Vif (île de Zephras) pour les Skyborne.
-- Chaque Baguette de dressage se garde jusqu'au rendu : clique-la sur la bête ciblée.

RXPGuides.RegisterGuide([[
#classic
<< Horde Hunter
#name 10 Dompter la bête
#displayname [FDP] Chasseur 10 : Dompter la bête
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 10 >>Monte au niveau 10, requis pour la quête

-- ===== Orc, Troll : Thotar à Razor Hill =====
step << Orc/Troll
    .goto Durotar,51.85,43.49
    >>Parle à |cRXP_FRIENDLY_Thotar|r à Razor Hill
    .accept 6062 >>Accepte Dompter la bête
    .target 3171
step << Orc/Troll
    .goto Durotar,52.03,49.96
    >>Utilise la |cRXP_LOOT_Baguette de dressage|r sur un |cRXP_ENEMY_Sanglier tacheté redoutable|r
    .complete 6062,1 --Dompter un sanglier tacheté redoutable
    .use 15917
    .mob 3099
step << Orc/Troll
    .goto Durotar,51.85,43.49
    >>Parle à |cRXP_FRIENDLY_Thotar|r
    .turnin 6062 >>Rends Dompter la bête
    .accept 6083 >>Accepte Dompter la bête
    .target 3171
step << Orc/Troll
    .goto Durotar,58.85,28.34
    >>Utilise la |cRXP_LOOT_Baguette de dressage|r sur un |cRXP_ENEMY_Clampant de l'écume|r, sur la côte
    .complete 6083,1 --Dompter un clampant de l'écume
    .use 15919
    .mob 3107
step << Orc/Troll
    .goto Durotar,51.85,43.49
    >>Parle à |cRXP_FRIENDLY_Thotar|r
    .turnin 6083 >>Rends Dompter la bête
    .accept 6082 >>Accepte Dompter la bête
    .target 3171
step << Orc/Troll
    .goto Durotar,55.72,31.68
    >>Utilise la |cRXP_LOOT_Baguette de dressage|r sur un |cRXP_ENEMY_Scorpide blindé|r
    .complete 6082,1 --Dompter un scorpide blindé
    .use 15920
    .mob 3126
step << Orc/Troll
    .goto Durotar,51.85,43.49
    >>Parle à |cRXP_FRIENDLY_Thotar|r
    .turnin 6082 >>Rends Dompter la bête
    .accept 6081 >>Accepte Entraîner la bête
    .target 3171
step << Orc/Troll
    #label FinThotar
    .goto Orgrimmar,66.05,18.53
    >>Parle à |cRXP_FRIENDLY_Ormak Grimshot|r dans la vallée de l'Honneur pour apprendre à dompter les bêtes
    .turnin 6081 >>Rends Entraîner la bête
    .target 3352

-- ===== Tauren : Yaw Sharpmane à Bloodhoof =====
step << Tauren
    .goto Mulgore,46.93,59.65
    >>Parle à |cRXP_FRIENDLY_Yaw Sharpmane|r au village de Bloodhoof
    .accept 6061 >>Accepte Dompter la bête
    .target 3065
step << Tauren
    .goto Mulgore,54.92,43.99
    >>Utilise la |cRXP_LOOT_Baguette de dressage|r sur un |cRXP_ENEMY_Trotteur des plaines adulte|r
    .complete 6061,1 --Dompter un trotteur des plaines adulte
    .use 15914
    .mob 2956
step << Tauren
    .goto Mulgore,46.93,59.65
    >>Parle à |cRXP_FRIENDLY_Yaw Sharpmane|r
    .turnin 6061 >>Rends Dompter la bête
    .accept 6087 >>Accepte Dompter la bête
    .target 3065
step << Tauren
    .goto Mulgore,59.59,57.61
    >>Utilise la |cRXP_LOOT_Baguette de dressage|r sur un |cRXP_ENEMY_Traqueur des prairies|r
    .complete 6087,1 --Dompter un traqueur des prairies
    .use 15915
    .mob 2959
step << Tauren
    .goto Mulgore,46.93,59.65
    >>Parle à |cRXP_FRIENDLY_Yaw Sharpmane|r
    .turnin 6087 >>Rends Dompter la bête
    .accept 6088 >>Accepte Dompter la bête
    .target 3065
step << Tauren
    .goto Mulgore,52.75,44.37
    >>Utilise la |cRXP_LOOT_Baguette de dressage|r sur un |cRXP_ENEMY_Rapace|r
    .complete 6088,1 --Dompter un rapace
    .use 15916
    .mob 2970
step << Tauren
    .goto Mulgore,46.93,59.65
    >>Parle à |cRXP_FRIENDLY_Yaw Sharpmane|r
    .turnin 6088 >>Rends Dompter la bête
    .accept 6089 >>Accepte Entraîner la bête
    .target 3065
step << Tauren
    #label FinYaw
    .goto Thunder Bluff,57.30,89.79
    >>Parle à |cRXP_FRIENDLY_Holt Thunderhorn|r au bassin des Chasseurs pour apprendre à dompter les bêtes
    .turnin 6089 >>Rends Entraîner la bête
    .target 3039

-- ===== Skyborne : Quel'ana Vent-Vif à Valanaar =====
step << Skyborne
    .goto 2521,59.56,72.63
    >>Parle à |cRXP_FRIENDLY_Quel'ana Vent-Vif|r à Valanaar (île de Zephras)
    .accept 94978 >>Accepte Dompter la bête
    .target 252389
step << Skyborne
    .goto 2521,42.64,66.73
    >>Utilise la |cRXP_LOOT_Baguette de dressage|r sur un |cRXP_ENEMY_Clampant chantevent|r, près de l'eau
    .complete 94978,1 --Dompter un clampant chantevent
    .use 267272
    .mob 254588
step << Skyborne
    .goto 2521,59.56,72.63
    >>Parle à |cRXP_FRIENDLY_Quel'ana Vent-Vif|r
    .turnin 94978 >>Rends Dompter la bête
    .accept 94979 >>Accepte Dompter la bête
    .target 252389
step << Skyborne
    .goto 2521,45.82,81.08
    >>Utilise la |cRXP_LOOT_Baguette de dressage|r sur un |cRXP_ENEMY_Trotteur des trombes hargneux|r (Gustberry Lowlands)
    .complete 94979,1 --Dompter un trotteur des trombes hargneux
    .use 267298
    .mob 251707
step << Skyborne
    .goto 2521,59.56,72.63
    >>Parle à |cRXP_FRIENDLY_Quel'ana Vent-Vif|r
    .turnin 94979 >>Rends Dompter la bête
    .accept 94013 >>Accepte Dompter la bête
    .target 252389
step << Skyborne
    .goto 2521,44.91,69.17
    >>Utilise la |cRXP_LOOT_Baguette de dressage|r sur un |cRXP_ENEMY_Alpha vuldrène|r
    .complete 94013,1 --Dompter un alpha vuldrène
    .use 264163
    .mob 250874
step << Skyborne
    .goto 2521,59.56,72.63
    >>Parle à |cRXP_FRIENDLY_Quel'ana Vent-Vif|r
    .turnin 94013 >>Rends Dompter la bête
    .accept 94050 >>Accepte Entraîner la bête
    .target 252389
step << Skyborne
    #label FinQuelana
    .goto 2521,59.74,72.76
    >>Parle à |cRXP_FRIENDLY_Quel'dora Vent-Vif|r, juste à côté, pour apprendre à dompter les bêtes
    .turnin 94050 >>Rends Entraîner la bête
    .target 254411
]])

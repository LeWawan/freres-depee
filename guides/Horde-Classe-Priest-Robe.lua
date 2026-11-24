if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Priest Horde, première robe de prêtre (niveau 5).
-- Trolls : Ken'jai puis Tai'jin (Durotar). Morts-vivants : Duesten puis Beryl (Tirisfal).
-- Il faut Soins inférieurs (rang 2) et Mot de pouvoir : Robustesse.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Priest
#name 5 Robe de prêtre
#displayname [FDP] Prêtre 5 : Robe de prêtre
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 5 >>Monte au niveau 5, requis pour la quête

-- ===== Trolls =====
step << Troll
    .goto Durotar,42.36,68.81
    >>Parle à |cRXP_FRIENDLY_Ken'jai|r dans la vallée des Épreuves
    .accept 5649 >>Accepte Au service de la spiritualité
    .target 3707
step << Troll
    .goto Durotar,54.26,42.93
    >>Parle à |cRXP_FRIENDLY_Tai'jin|r à Razor Hill
    .turnin 5649 >>Rends Au service de la spiritualité
    .accept 5648 >>Accepte Vêtements de la spiritualité
    .target 3706
step << Troll
    .goto Durotar,53.10,46.46
    >>Lance Soins inférieurs (rang 2) puis Mot de pouvoir : Robustesse sur la |cRXP_FRIENDLY_Grunt Kor'ja|r blessée
    .complete 5648,1 --Soigner et protéger la grunt Kor'ja
    .target 12430
step << Troll
    #label FinRobeTroll
    .goto Durotar,54.26,42.93
    >>Parle à |cRXP_FRIENDLY_Tai'jin|r et prends ta robe
    .turnin 5648 >>Rends Vêtements de la spiritualité
    .target 3706

-- ===== Morts-vivants =====
step << Undead
    .goto Tirisfal Glades,31.11,66.03
    >>Parle au |cRXP_FRIENDLY_Sombre clerc Duesten|r à Deathknell
    .accept 5651 >>Accepte Au service des ténèbres
    .target 2123
step << Undead
    .goto Tirisfal Glades,61.57,52.19
    >>Parle au |cRXP_FRIENDLY_Sombre clerc Beryl|r à Brill
    .turnin 5651 >>Rends Au service des ténèbres
    .accept 5650 >>Accepte Vêtements des ténèbres
    .target 2129
step << Undead
    .goto Tirisfal Glades,59.18,46.50
    >>Lance Soins inférieurs (rang 2) puis Mot de pouvoir : Robustesse sur le |cRXP_FRIENDLY_Garde noir Kel|r blessé
    .complete 5650,1 --Soigner et protéger le garde noir Kel
    .target 12428
step << Undead
    #label FinRobeMortVivant
    .goto Tirisfal Glades,61.57,52.19
    >>Parle au |cRXP_FRIENDLY_Sombre clerc Beryl|r et prends ta robe
    .turnin 5650 >>Rends Vêtements des ténèbres
    .target 2129
]])

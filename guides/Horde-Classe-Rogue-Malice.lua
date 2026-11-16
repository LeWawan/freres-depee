if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Rogue Horde, Lame de malice (niveau 10).
-- Orcs et Trolls : la Main brisée (Therzok, Orgrimmar). Morts-vivants : les Traqueurs noirs
-- (Mennet Carkad, Undercity). Les deux donnent la Lame de malice.

RXPGuides.RegisterGuide([[
#classic
<< Horde Rogue
#name 10 Lame de malice
#displayname [FDP] Voleur 10 : Lame de malice
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 10 >>Monte au niveau 10, requis pour la quête

-- ===== Orcs et Trolls : la Main brisée =====
step << Orc/Troll
    .goto Orgrimmar,42.73,53.55
    >>Parle à |cRXP_FRIENDLY_Therzok|r dans la Faille de l'ombre
    .turnin 1859 >>Rends Therzok
    .target 6446
    .isOnQuest 1859
step << Orc/Troll
    .goto Orgrimmar,42.73,53.55
    >>Parle à |cRXP_FRIENDLY_Therzok|r dans la Faille de l'ombre
    .accept 1963 >>Accepte La Main brisée
    .target 6446
step << Orc/Troll
    .goto The Barrens,63.11,44.29
    >>Tue |cRXP_ENEMY_Tazan|r et ramasse sa |cRXP_LOOT_Sacoche|r
    .complete 1963,1 --Sacoche de Tazan (1)
    .mob 6494
step << Orc/Troll
    .goto Orgrimmar,42.73,53.55
    >>Parle à |cRXP_FRIENDLY_Therzok|r
    .turnin 1963 >>Rends La Main brisée
    .accept 1858 >>Accepte La Main brisée
    .target 6446
step << Orc/Troll
    .goto Orgrimmar,54.00,68.03
    >>Fais les poches de |cRXP_ENEMY_Gamon|r pour la |cRXP_LOOT_Clé de Tazan|r, puis ouvre la sacoche
    >>|cRXP_WARN_Porteur de la clé d'après QuestieDB, à vérifier en jeu|r
    .complete 1858,1 --Journal des messages de Tazan (1)
    .use 7209
    .target 6466
step << Orc/Troll
    #label FinMainBrisee
    .goto Orgrimmar,42.73,53.55
    >>Parle à |cRXP_FRIENDLY_Therzok|r et prends la |cRXP_LOOT_Lame de malice|r
    .turnin 1858 >>Rends La Main brisée
    .target 6446

-- ===== Morts-vivants : les Traqueurs noirs =====
step << Undead
    .goto Undercity,83.51,69.11
    >>Parle à |cRXP_FRIENDLY_Mennet Carkad|r au quartier des Voleurs
    .turnin 1885 >>Rends Mennet Carkad
    .target 6467
    .isOnQuest 1885
step << Undead
    .goto Undercity,83.51,69.11
    >>Parle à |cRXP_FRIENDLY_Mennet Carkad|r au quartier des Voleurs
    .accept 1886 >>Accepte Les Traqueurs noirs
    .target 6467
step << Undead
    .goto Silverpine Forest,49.71,32.22
    >>Tue |cRXP_ENEMY_Astor Hadren|r sur la route de Silverpine et ramasse sa |cRXP_LOOT_Lettre d'introduction|r
    .complete 1886,1 --Lettre d'introduction d'Astor (1)
    .mob 6497
step << Undead
    .goto Undercity,83.51,69.11
    >>Parle à |cRXP_FRIENDLY_Mennet Carkad|r
    .turnin 1886 >>Rends Les Traqueurs noirs
    .accept 1898 >>Accepte Les Traqueurs noirs
    .target 6467
step << Undead
    .goto Undercity,54.81,76.33
    >>Parle à |cRXP_FRIENDLY_Andron Gant|r
    .turnin 1898 >>Rends Les Traqueurs noirs
    .accept 1899 >>Accepte Les Traqueurs noirs
    .target 6522
step << Undead
    .goto Undercity,55.40,76.96
    >>Prends le |cRXP_LOOT_Grand Livre d'Andron|r sur les |cRXP_PICK_Livres d'Andron|r, juste derrière lui
    .complete 1899,1 --Grand Livre d'Andron (1)
step << Undead
    .goto Undercity,83.51,69.11
    >>Parle à |cRXP_FRIENDLY_Mennet Carkad|r
    .turnin 1899 >>Rends Les Traqueurs noirs
    .accept 1978 >>Accepte Les Traqueurs noirs
    .target 6467
step << Undead
    #label FinTraqueurs
    .goto Undercity,56.25,92.20
    >>Parle à |cRXP_FRIENDLY_Varimathras|r dans le Hall de la Dame noire et prends la |cRXP_LOOT_Lame de malice|r
    .turnin 1978 >>Rends Les Traqueurs noirs
    .target 2425
]])

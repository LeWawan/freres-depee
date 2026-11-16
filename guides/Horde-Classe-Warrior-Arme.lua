if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warrior Horde, première arme de guerrier (niveau 10).
-- Trois voies exclusives : Thun'grim (Barrens) pour Orc/Troll/Tauren, l'héritage des Agamand
-- (Tirisfal) pour les Morts-vivants, le Rempart de Briseciel (île de Zephras) pour les Skyborne.

RXPGuides.RegisterGuide([[
#classic
<< Horde Warrior
#name 10 Arme de guerrier
#displayname [FDP] Guerrier 10 : Arme de guerrier
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 10 >>Monte au niveau 10, requis pour la quête

-- ===== Orc, Troll, Tauren : Uzzek et Thun'grim =====
step << !Undead !Skyborne
    .goto The Barrens,61.38,21.12
    >>Parle à |cRXP_FRIENDLY_Uzzek|r au poste de la Vigie lointaine
    .turnin 1505 >>Rends Le vétéran Uzzek
    .target 5810
    .isOnQuest 1505
step << !Undead !Skyborne
    .goto The Barrens,61.38,21.12
    >>Parle à |cRXP_FRIENDLY_Uzzek|r au poste de la Vigie lointaine, à la frontière de Durotar
    .accept 1498 >>Accepte La voie de la défense
    .target 5810
step << !Undead !Skyborne
    .goto Durotar,40.46,29.75
    >>Tue les |cRXP_ENEMY_Lézards-tonnerre|r et les |cRXP_ENEMY_Foudroyants|r de la crête du Tonnerre pour les |cRXP_LOOT_Ecailles roussies|r
    >>|cRXP_WARN_~16 % par kill : environ 32 kills (le double si vous êtes deux guerriers)|r
    .complete 1498,1 --Ecaille roussie (5)
    .mob 3130
    .mob 3131
step << !Undead !Skyborne
    .goto The Barrens,61.38,21.12
    >>Parle à |cRXP_FRIENDLY_Uzzek|r
    .turnin 1498 >>Rends La voie de la défense
    .accept 1502 >>Accepte Thun'grim Firegaze
    .target 5810
step << !Undead !Skyborne
    .goto The Barrens,57.23,30.34
    >>Parle à |cRXP_FRIENDLY_Thun'grim Firegaze|r, au nord-est de la Croisée
    .turnin 1502 >>Rends Thun'grim Firegaze
    .accept 1503 >>Accepte Acier forgé
    .target 5878
step << !Undead !Skyborne
    .goto The Barrens,55.05,26.65
    >>Ouvre le |cRXP_PICK_Coffre en fer dérobé|r dans le camp tranchecrin et prends les |cRXP_LOOT_Barres d'acier forgé|r
    .complete 1503,1 --Barres d'acier forgé (1)
step << !Undead !Skyborne
    #label FinThungrim
    .goto The Barrens,57.23,30.34
    >>Parle à |cRXP_FRIENDLY_Thun'grim Firegaze|r et choisis ton arme
    .turnin 1503 >>Rends Acier forgé
    .target 5878

-- ===== Morts-vivants : Ulag et l'héritage des Agamand =====
step << Undead
    .goto Tirisfal Glades,58.20,51.45
    >>Parle au |cRXP_FRIENDLY_Garde noir Dillinger|r à Brill
    .turnin 1818 >>Rends Parler à Dillinger
    .target 1496
    .isOnQuest 1818
step << Undead
    .goto Tirisfal Glades,58.20,51.45
    >>Parle au |cRXP_FRIENDLY_Garde noir Dillinger|r à Brill
    .accept 1819 >>Accepte Ulag le Fendeur
    .target 1496
step << Undead
    .goto Tirisfal Glades,59.47,48.28
    >>Ouvre la crypte au nord de Brill et tue |cRXP_ENEMY_Ulag le Fendeur|r
    .complete 1819,1 --Ulag le Fendeur
    .mob 6390
step << Undead
    .goto Tirisfal Glades,58.20,51.45
    >>Parle au |cRXP_FRIENDLY_Garde noir Dillinger|r
    .turnin 1819 >>Rends Ulag le Fendeur
    .accept 1820 >>Accepte Parler à Coleman
    .target 1496
step << Undead
    .goto Tirisfal Glades,61.72,52.29
    >>Parle à |cRXP_FRIENDLY_Coleman Farthing|r dans l'auberge de Brill
    .turnin 1820 >>Rends Parler à Coleman
    .accept 1821 >>Accepte L'héritage des Agamand
    .target 1500
step << Undead
    .goto Tirisfal Glades,51.68,25.69
    >>Ouvre les quatre |cRXP_PICK_Râteliers d'armes Agamand|r dans les moulins Agamand
    .complete 1821,1 --Hache de la famille Agamand
    .complete 1821,2 --Dague de la famille Agamand
    .complete 1821,3 --Masse de la famille Agamand
    .complete 1821,4 --Epée de la famille Agamand
step << Undead
    #label FinAgamand
    .goto Tirisfal Glades,61.72,52.29
    >>Parle à |cRXP_FRIENDLY_Coleman Farthing|r et choisis ton arme
    .turnin 1821 >>Rends L'héritage des Agamand
    .accept 1822 >>Accepte Une arme en héritage
    .turnin 1822 >>Rends Une arme en héritage
    .target 1500

-- ===== Skyborne : le Rempart de Briseciel =====
step << Skyborne
    .goto 2521,59.89,72.87
    >>Parle à |cRXP_FRIENDLY_Seena Briseciel|r à Valanaar (île de Zephras)
    .accept 94003 >>Accepte Le Rempart de Briseciel
    .target 252377
step << Skyborne
    .goto 2521,56.63,50.37
    >>Tue |cRXP_ENEMY_Zaal Pare-tempête|r au sanctuaire d'Akir et ramasse le |cRXP_LOOT_Rempart de Briseciel|r
    .complete 94003,1 --Rempart de Briseciel (1)
    .mob 257196
step << Skyborne
    #label FinBriseciel
    .goto 2521,59.89,72.87
    >>Parle à |cRXP_FRIENDLY_Seena Briseciel|r
    .turnin 94003 >>Rends Le Rempart de Briseciel
    .target 252377
]])

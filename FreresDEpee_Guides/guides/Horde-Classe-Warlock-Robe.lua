if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warlock Horde, Robe sanglante dorée enchantée (niveau 31-38).
-- Menara Voidrender (Ratchet), Xizk Goodstitch (Strangleronce), les Fielfurie et les
-- Infernaux mineurs (Desolace), les Exilés ardents (Arathi).
-- Prévois la Robe d'Arcana (couture ou hôtel des ventes), une Barre d'or et un Fragment d'âme.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Warlock
#name 31 Robe sanglante dorée
#displayname [FDP] Démoniste 31 : Robe sanglante dorée
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 31 >>Monte au niveau 31, requis pour la quête
step << Orc/Troll
    .goto Orgrimmar,48.47,45.43
    >>Parle à |cRXP_FRIENDLY_Zevrost|r dans la Faille de l'ombre
    .accept 4737 >>Accepte À la recherche de Menara Voidrender
    .target 3326
    .isNotOnQuest 4739
step << Undead
    .goto Undercity,86.21,15.93
    >>Parle à |cRXP_FRIENDLY_Kaal Soulreaper|r au quartier des Mages
    .accept 4739 >>Accepte À la recherche de Menara Voidrender
    .target 4563
    .isNotOnQuest 4737
step
    #completewith Menara1
    .goto The Barrens,62.51,35.45,30 >>Va à Ratchet, dans la tour au-dessus du port
step
    #label Menara1
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .turnin 4737 >>Rends À la recherche de Menara Voidrender
    .target 6266
    .isOnQuest 4737
step
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .turnin 4739 >>Rends À la recherche de Menara Voidrender
    .target 6266
    .isOnQuest 4739
step
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .accept 1796 >>Accepte Les composants de la robe sanglante dorée enchantée
    .target 6266
step
    .goto The Barrens,62.51,35.45
    >>Donne une |cRXP_LOOT_Robe d'Arcana|r à |cRXP_FRIENDLY_Menara Voidrender|r (fabriquée en couture ou achetée à l'hôtel des ventes)
    .collect 5770,1,1796,1
    .turnin 1796 >>Rends Les composants de la robe sanglante dorée enchantée
    .accept 4781 >>Accepte Les composants de la robe sanglante dorée enchantée
    .target 6266
step
    .goto Stranglethorn Vale,28.71,76.89
    >>Apporte une |cRXP_LOOT_Barre d'or|r (minage ou hôtel des ventes) à |cRXP_FRIENDLY_Xizk Goodstitch|r à Baie-du-Butin
    .collect 3577,1,4781,1
    .turnin 4781 >>Rends Les composants de la robe sanglante dorée enchantée
    .accept 4782 >>Accepte Les composants de la robe sanglante dorée enchantée
    .target 2670
step
    .goto The Barrens,62.51,35.45
    >>Retourne voir |cRXP_FRIENDLY_Menara Voidrender|r à Ratchet
    .turnin 4782 >>Rends Les composants de la robe sanglante dorée enchantée
    .accept 4783 >>Accepte Les composants de la robe sanglante dorée enchantée
    .target 6266
step
    .goto Desolace,74.49,13.40
    >>Tue les satyres |cRXP_ENEMY_Fielfurie|r au nord-est de Desolace pour les |cRXP_LOOT_Fioles de sang|r
    >>|cRXP_WARN_Farm long : ~5 % par kill, environ 190 kills (le double si vous êtes deux démonistes)|r
    .complete 4783,1 --Fiole de sang de Fielfurie (10)
    .mob 4670
    .mob 4671
    .mob 4672
    .mob 4673
    .mob 4674
    .mob 4675
step
    .goto Desolace,54.22,80.89
    >>Tue les |cRXP_ENEMY_Infernaux mineurs|r au sud de Desolace pour la |cRXP_LOOT_Pierre d'Infernal inférieure|r (~6 %, environ 17 kills)
    .complete 4783,2 --Pierre d'Infernal inférieure (1)
    .mob 4676
step
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .turnin 4783 >>Rends Les composants de la robe sanglante dorée enchantée
    .accept 4784 >>Accepte Les composants de la robe sanglante dorée enchantée
    .target 6266
step
    .goto Stranglethorn Vale,28.71,76.89
    >>Parle à |cRXP_FRIENDLY_Xizk Goodstitch|r à Baie-du-Butin pour le |cRXP_LOOT_Fil d'or fin|r
    .accept 4785 >>Accepte Fil d'or fin
    .turnin 4785 >>Rends Fil d'or fin
    .target 2670
step
    .goto Arathi Highlands,25.64,28.53
    >>Tue les |cRXP_ENEMY_Exilés ardents|r pour 2 |cRXP_LOOT_Charbons ardents|r. Garde aussi un |cRXP_LOOT_Fragment d'âme|r
    >>|cRXP_WARN_Taux QuestieDB ~1 % (objet de quête, sans doute plus haut en jeu) : farm possiblement long|r
    .complete 4784,2 --Charbon ardent (2)
    .complete 4784,3 --Fragment d'âme (1)
    .mob 2760
step
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r
    .turnin 4784 >>Rends Les composants de la robe sanglante dorée enchantée
    .accept 4786 >>Accepte La Robe terminée
    .target 6266
step
    .goto The Barrens,62.51,35.45
    >>Attends que |cRXP_FRIENDLY_Menara Voidrender|r termine ta robe
    .complete 4786,1
step
    #label FinRobeSanglante
    .goto The Barrens,62.51,35.45
    >>Parle à |cRXP_FRIENDLY_Menara Voidrender|r et prends la |cRXP_LOOT_Robe sanglante dorée enchantée|r
    .turnin 4786 >>Rends La Robe terminée
    .target 6266
]])

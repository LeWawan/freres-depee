if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warlock Horde, Tome de la Cabale (Chasseur corrompu, niveau 30).
-- Chaîne à voyages : Ratchet, Undercity, Hillsbrad, Thousand Needles, Undercity, Wetlands, Ratchet.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Warlock
#name 30 Chasseur corrompu
#displayname [FDP] Démoniste 30 : Chasseur corrompu
#version 1
#group Guide FDP (Horde)
#subgroup Classe
#next 30-31 Alterac Mountains

step
    .xp 30 >>Monte au niveau 30, requis pour la quête
step << Orc/Troll
    .goto Orgrimmar,48.25,45.28
    >>Parle à |cRXP_FRIENDLY_Gan'rul Bloodeye|r dans la Faille de l'ombre
    .accept 2996 >>Accepte À la recherche de Strahad
    .target 5875
step << Undead
    .goto Undercity,85.06,25.99
    >>Parle à |cRXP_FRIENDLY_Carendin Halgar|r au quartier des Mages
    .accept 3001 >>Accepte À la recherche de Strahad
    .target 5675
step
    #completewith Strahad1
    .goto The Barrens,62.63,35.50,30 >>Va à Ratchet, dans la tour au-dessus du port
step
    #label Strahad1
    .goto The Barrens,62.63,35.50
    >>Parle à |cRXP_FRIENDLY_Strahad Farsan|r
    .turnin 2996 >>Rends À la recherche de Strahad
    .target 6251
    .isOnQuest 2996
step
    .goto The Barrens,62.63,35.50
    >>Parle à |cRXP_FRIENDLY_Strahad Farsan|r
    .turnin 3001 >>Rends À la recherche de Strahad
    .target 6251
    .isOnQuest 3001
step
    .goto The Barrens,62.63,35.50
    >>Parle à |cRXP_FRIENDLY_Strahad Farsan|r
    .accept 1801 >>Accepte Tome de la Cabale
    .target 6251
step
    .goto Undercity,75.92,37.89
    >>Parle à |cRXP_FRIENDLY_Jorah Annison|r dans l'anneau extérieur d'Undercity
    .turnin 1801 >>Rends Tome de la Cabale
    .accept 1803 >>Accepte Tome de la Cabale
    .target 6293
step
    .goto Hillsbrad Foothills,27.78,72.79
    >>Ramasse le |cRXP_LOOT_Tome moisi|r sur le |cRXP_PICK_Tome de la Cabale|r
    .complete 1803,1 --Tome moisi (1)
step
    .goto Thousand Needles,43.44,32.69
    >>Ouvre le |cRXP_PICK_Coffre endommagé|r et prends le |cRXP_LOOT_Manuscrit en lambeaux|r
    >>|cRXP_WARN_Pic de Sombrenuée, plein de Grimtotem : avance prudemment|r
    .complete 1803,2 --Manuscrit en lambeaux (1)
step
    .goto Undercity,75.92,37.89
    >>Parle à |cRXP_FRIENDLY_Jorah Annison|r
    .turnin 1803 >>Rends Tome de la Cabale
    .accept 1805 >>Accepte Tome de la Cabale
    .target 6293
step
    #completewith Batonnets
    .goto Wetlands,45.48,45.39,80 >>Va au camp Dragonmaw au centre des Wetlands (par Arathi Highlands et le passage de Thandol)
step
    #label Batonnets
    .goto Wetlands,45.48,45.39
    >>Tue les |cRXP_ENEMY_Gardiens Dragonmaw|r (meilleur taux) et les |cRXP_ENEMY_Veilleurs des ombres Dragonmaw|r pour les |cRXP_LOOT_Bâtonnets de canalisation|r
    >>|cRXP_WARN_Environ 15 kills (le double si vous êtes deux démonistes : chacun doit looter ses objets)|r
    .complete 1805,1 --Bâtonnet de canalisation (3)
    .mob 1057
    .mob 1038
step
    #completewith Strahad2
    .goto The Barrens,62.63,35.50,30 >>Retourne voir |cRXP_FRIENDLY_Strahad Farsan|r à Ratchet
step
    #label Strahad2
    .goto The Barrens,62.63,35.50
    >>Parle à |cRXP_FRIENDLY_Strahad Farsan|r
    .turnin 1805 >>Rends Tome de la Cabale
    .accept 1795 >>Accepte Le lien
    .target 6251
step
    .goto The Barrens,62.60,35.31
    >>Utilise le |cRXP_LOOT_Tome de la Cabale|r dans la tour pour invoquer le |cRXP_ENEMY_Chasseur corrompu invoqué|r, puis tue-le
    .complete 1795,1 --Chasseur corrompu invoqué
    .use 6999
    .mob 6268
step
    #label FinChasseur
    .goto The Barrens,62.63,35.50
    >>Parle à |cRXP_FRIENDLY_Strahad Farsan|r pour apprendre l'invocation du chasseur corrompu
    .turnin 1795 >>Rends Le lien
    .target 6251
]])

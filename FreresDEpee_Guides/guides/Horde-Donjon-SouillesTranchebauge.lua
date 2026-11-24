if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde des Souilles de Tranchebauge (sud des Tarides), toutes classes.
-- Givers : Andrew Brownell et Varimathras (Undercity), Sutara Marche-plaines (plateau des
-- Guetteurs du ciel, Mulgore), Myriam Moonsinger (devant l'entrée), Belnistrasz (instance).
-- Protégée : 6521 Une alliance impie (après 6522, Petit parchemin de Charlga au Kraal de
-- Tranchebauge). L'Ambassadeur Malcin est dehors, devant l'entrée (élite 36).
-- Données : QuestieDB Forever (tools/questiedb.py). L'Œil du Porte-froid (97196) est un
-- objet Forever sans position dans QuestieDB. Dans l'instance, QuestieDB n'a pas de
-- coordonnées : ordre des boss décrit dans le texte.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 33-40 Razorfen Downs
#displayname [FDP] Souilles de Tranchebauge (33-40)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Undercity =====
step
    #completewith Brownell
    .goto Undercity,74.05,33.31,40 >>Va à Undercity, au Quartier des mages
    .xp <37,1
step
    #label Brownell
    .goto Undercity,74.05,33.31
    >>Parle à |cRXP_FRIENDLY_Andrew Brownell|r
    .accept 3341 >>Accepte L'anéantissement
    .target 2308
    .xp <37,1
step
    .goto Undercity,56.25,92.20
    >>Parle à |cRXP_FRIENDLY_Varimathras|r dans le Quartier royal
    .turnin 6522 >>Rends Une alliance impie
    .accept 6521 >>Accepte Une alliance impie
    .target 2425
    .isOnQuest 6522
step
    .goto Undercity,56.25,92.20
    >>Parle à |cRXP_FRIENDLY_Varimathras|r dans le Quartier royal
    .accept 6521 >>Accepte Une alliance impie
    .target 2425
    .isQuestTurnedIn 6522

-- ===== Mulgore : Sutara =====
step
    #completewith Sutara
    .goto Mulgore,34.56,23.00,40 >>Va au plateau des Guetteurs du ciel, au nord-ouest de Mulgore
    .xp <34,1
step
    #label Sutara
    .goto Mulgore,34.56,23.00
    >>Parle à |cRXP_FRIENDLY_Sutara Marche-plaines|r
    .accept 97196 >>Accepte L'Œil du Porte-froid
    .target 264078
    .xp <34,1

-- ===== Devant l'entrée =====
step
    #completewith Myriam
    .goto The Barrens,49.01,94.94,40 >>Va aux Souilles de Tranchebauge, tout au sud des Tarides (vol vers le Camp Taurajo)
step
    #label Myriam
    .goto The Barrens,49.01,94.94
    >>Parle à |cRXP_FRIENDLY_Myriam Moonsinger|r
    .accept 6626 >>Accepte L'hôte du mal
    .target 12866
step
    .goto The Barrens,46.20,90.20
    >>Tue l'|cRXP_ENEMY_Ambassadeur Malcin|r (élite) à l'ouest de l'entrée et ramasse sa |cRXP_LOOT_Tête|r
    .complete 6521,1 --Tête de l'Ambassadeur Malcin
    .mob 12865
    .isOnQuest 6521
step
    .goto The Barrens,47.06,88.31,30,0
    .goto The Barrens,48.65,89.71,30,0
    .goto The Barrens,48.06,90.28
    >>Tue les |cRXP_ENEMY_Gardes de guerre|r, les |cRXP_ENEMY_Tisseurs d'épines|r et les |cRXP_ENEMY_Sectateurs de la Tête de Mort|r (élites) autour de l'entrée
    .complete 6626,1 --Garde de guerre de Tranchebauge (8)
    .complete 6626,2 --Tisseur d'épines de Tranchebauge (8)
    .complete 6626,3 --Sectateur de la Tête de Mort (8)
    .mob 7873
    .mob 7874
    .mob 7872
step
    .goto The Barrens,49.01,94.94
    >>Parle à |cRXP_FRIENDLY_Myriam Moonsinger|r
    .turnin 6626 >>Rends L'hôte du mal
    .target 12866

-- ===== Instance =====
step
    #label EntreeRFD
    .goto The Barrens,49.00,93.90,15 >>Entre dans les Souilles de Tranchebauge
step
    >>Parle à |cRXP_FRIENDLY_Belnistrasz|r, prisonnier au début de l'instance. Accepte, puis rends-lui la |cRXP_LOOT_Pierre de voeu|r
    .accept 3523 >>Accepte Le Fléau des Souilles
    .turnin 3523 >>Rends Le Fléau des Souilles
    .accept 3525 >>Accepte L'extinction de l'idole
    .target 8516
step
    >>Escorte |cRXP_FRIENDLY_Belnistrasz|r jusqu'à l'idole et protège-le pendant le rituel. Des vagues de mobs arrivent, puis un boss
    >>Clique ensuite sur le |cRXP_PICK_Brasero de Belnistrasz|r
    .turnin 3525 >>Rends L'extinction de l'idole
step
    >>Ramasse |cRXP_PICK_L'Œil du Porte-froid|r dans l'instance
    >>|cRXP_WARN_Objet Forever sans position connue : note où tu le trouves|r
    .complete 97196,1 --L'Œil du Porte-froid
    .isOnQuest 97196
step
    >>Tue |cRXP_ENEMY_Amnennar le Porte-froid|r, dernier boss au fond de l'instance, et ramasse son |cRXP_LOOT_Crâne|r
    .complete 3341,1 --Crâne du Porte-froid
    .mob 7358
    .isOnQuest 3341

-- ===== Rendus =====
step
    .goto Mulgore,34.56,23.00
    >>Retourne voir |cRXP_FRIENDLY_Sutara Marche-plaines|r à Mulgore
    .turnin 97196 >>Rends L'Œil du Porte-froid
    .target 264078
    .isOnQuest 97196
step
    .goto Undercity,74.05,33.31
    >>Parle à |cRXP_FRIENDLY_Andrew Brownell|r à Undercity
    .turnin 3341 >>Rends L'anéantissement
    .target 2308
    .isOnQuest 3341
step
    #label FinSouilles
    .goto Undercity,56.25,92.20
    >>Parle à |cRXP_FRIENDLY_Varimathras|r
    .turnin 6521 >>Rends Une alliance impie
    .target 2425
    .isOnQuest 6521
]])

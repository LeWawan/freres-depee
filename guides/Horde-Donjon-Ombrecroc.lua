if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde du Donjon d'Ombrecroc (Forêt des Pins-Argentés), toutes classes.
-- Givers : Gardien Bel'dugur (Undercity), Grand exécuteur Hadrec et Dalar Dawnweaver (Le Sépulcre).
-- Démoniste : grand fragment de L'Orbe de Soran'ruk (1740, prise à Brassenoire chez Doan
-- Karhan), protégé par .isOnQuest. Taux 0,9 % sur les Ténébreux d'Ombrecroc.
-- Données : QuestieDB Forever (tools/questiedb.py). Dans l'instance, QuestieDB n'a pas de
-- coordonnées : ordre des boss décrit dans le texte.

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 20-26 Shadowfang Keep
#displayname [FDP] Donjon d'Ombrecroc (20-26)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Undercity : Bel'dugur =====
step
    #completewith Beldugur
    .goto Undercity,53.74,54.46,40 >>Va à Undercity, à l'Apothicarium
step
    #label Beldugur
    .goto Undercity,53.74,54.46
    >>Parle au |cRXP_FRIENDLY_Gardien Bel'dugur|r
    .accept 1013 >>Accepte Le Livre d'Ur
    .target 2934

-- ===== Le Sépulcre =====
step
    #completewith Hadrec
    .goto Silverpine Forest,43.42,40.86,40 >>Va au Sépulcre, dans la Forêt des Pins-Argentés (vol depuis Undercity)
step
    #label Hadrec
    .goto Silverpine Forest,43.42,40.86
    >>Parle au |cRXP_FRIENDLY_Grand exécuteur Hadrec|r
    .accept 1098 >>Accepte Des Traqueurs noirs à Ombrecroc
    .target 1952
step
    .goto Silverpine Forest,44.20,39.81
    >>Parle à |cRXP_FRIENDLY_Dalar Dawnweaver|r
    .accept 1014 >>Accepte Arugal doit mourir
    .target 1938

-- ===== Instance =====
step
    #label EntreeSFK
    .goto Silverpine Forest,44.80,67.80,15 >>Entre dans le Donjon d'Ombrecroc, au sud du Sépulcre
step << Warlock
    #completewith Arugal
    >>Tue les |cRXP_ENEMY_Ténébreux d'Ombrecroc|r pour le |cRXP_LOOT_Grand fragment de Soran'ruk|r
    >>|cRXP_WARN_Taux très faible (~1 %) : prends-le s'il tombe, sinon ne farme pas|r
    .complete 1740,2 --Grand fragment de Soran'ruk
    .mob 3855
    .isOnQuest 1740
step
    >>Avance après |cRXP_ENEMY_Rethilgore|r jusqu'à la cour. Parle au |cRXP_FRIENDLY_Traqueur noir Vincent|r, à terre près de l'entrée de la cour
    .turnin 1098 >>Rends Des Traqueurs noirs à Ombrecroc
    .target 4444
step
    >>Ramasse |cRXP_PICK_Le Livre d'Ur|r, posé dans la bibliothèque au sommet du donjon, avant la dernière salle
    .complete 1013,1 --Le Livre d'Ur
step
    #label Arugal
    >>Tue l'|cRXP_ENEMY_Archimage Arugal|r, dernier boss au sommet du donjon, et ramasse sa |cRXP_LOOT_Tête|r
    .complete 1014,1 --Tête d'Arugal
    .mob 4275

-- ===== Rendus =====
step
    .goto Silverpine Forest,44.20,39.81
    >>Retourne au Sépulcre et parle à |cRXP_FRIENDLY_Dalar Dawnweaver|r
    .turnin 1014 >>Rends Arugal doit mourir
    .target 1938
step
    .goto Undercity,53.74,54.46
    >>Parle au |cRXP_FRIENDLY_Gardien Bel'dugur|r à Undercity
    .turnin 1013 >>Rends Le Livre d'Ur
    .target 2934
step << Warlock
    #label FinOmbrecroc
    .goto The Barrens,49.31,57.21
    >>Va voir |cRXP_FRIENDLY_Doan Karhan|r dans les Tarides
    .turnin 1740 >>Rends L'Orbe de Soran'ruk
    .target 6247
    .isQuestComplete 1740
]])

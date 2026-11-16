if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde du Monastère écarlate (Clairières de Tirisfal), toutes classes.
-- Ailes dans l'ordre : Cimetière, Bibliothèque, Armurerie, Cathédrale.
-- Givers : Varimathras, Faranell et Parqual Fintallas (Undercity), Sage Truthseeker
-- (Thunder Bluff, orc, tauren et troll seulement), Vorrel Sengutz (dans le Cimetière).
-- Protégées : 1113 Des cœurs zélés (après 1109, Kraal de Tranchebauge) et 1160 L'épreuve de
-- la Connaissance (chaîne commencée aux Serres-Rocheuses).
-- La vengeance de Vorrel (1051) : l'anneau tombe de Nancy Vishas dans les Montagnes
-- d'Alterac, rendu à Moulin-de-Tarren.
-- Mage : baguette de Tabetha (1947-1952). Seul le livre Rituels du Pouvoir (1951) est dans
-- la Bibliothèque ; le reste se fait au Marécage d'Âprefange, à Mille pointes et dans les
-- Hautes-terres d'Arathi, et demande une Jade (minage ou hôtel des ventes).
-- Données : QuestieDB Forever (tools/questiedb.py). Dans l'instance, QuestieDB n'a pas de
-- coordonnées : ordre des boss décrit dans le texte.

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 30-40 Scarlet Monastery
#displayname [FDP] Monastère écarlate (30-40)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Mage : Tabetha et Magus Tirth, avant le monastère =====
step << Mage
    .goto Undercity,85.14,10.03
    >>Parle à |cRXP_FRIENDLY_Anastasia Hartwell|r, maître des mages d'Undercity (ou Deino à Orgrimmar, Ursyn Ghull à Thunder Bluff)
    .accept 1947 >>Accepte Voyager vers le Marais
    .target 4568
    .xp <30,1
step << Mage
    .goto Dustwallow Marsh,46.06,57.09
    >>Va voir |cRXP_FRIENDLY_Tabetha|r dans sa maison, au centre du Marécage d'Âprefange
    .turnin 1947 >>Rends Voyager vers le Marais
    .accept 1948 >>Accepte Les Objets de Puissance
    .accept 1949 >>Accepte Des secrets cachés
    .target 6546
    .isOnQuest 1947
step << Mage
    .goto Thousand Needles,78.29,75.70
    >>Va voir |cRXP_FRIENDLY_Magus Tirth|r aux Salines (Mille pointes)
    .turnin 1949 >>Rends Des secrets cachés
    .accept 1950 >>Accepte Trouver le Scoop
    .target 6548
    .isOnQuest 1949
step << Mage
    .goto Thousand Needles,79.61,75.63
    >>Parle à |cRXP_FRIENDLY_Johnson "le Brave"|r juste à côté pour obtenir la phrase du coffre
    .complete 1950,1 --La phrase du coffre
    .target 6626
    .isOnQuest 1950
step << Mage
    .goto Thousand Needles,78.29,75.70
    >>Parle à |cRXP_FRIENDLY_Magus Tirth|r
    .turnin 1950 >>Rends Trouver le Scoop
    .accept 1951 >>Accepte Rituels du Pouvoir
    .target 6548
    .isOnQuest 1950

-- ===== Undercity =====
step
    #completewith Varimathras
    .goto Undercity,56.25,92.20,40 >>Va à Undercity
step
    #label Varimathras
    .goto Undercity,56.25,92.20
    >>Parle à |cRXP_FRIENDLY_Varimathras|r dans le Quartier royal
    .accept 1048 >>Accepte Au monastère écarlate
    .target 2425
    .xp <33,1
step
    .goto Undercity,48.82,69.28
    >>Parle au |cRXP_FRIENDLY_Maître apothicaire Faranell|r à l'Apothicarium
    .accept 1113 >>Accepte Des cœurs zélés
    .target 2055
    .isQuestTurnedIn 1109
step
    .goto Undercity,57.80,65.42
    >>Parle à |cRXP_FRIENDLY_Parqual Fintallas|r
    .turnin 1159 >>Rends L'épreuve de la Connaissance
    .accept 1160 >>Accepte L'épreuve de la Connaissance
    .target 4488
    .isOnQuest 1159
step
    .goto Undercity,57.80,65.42
    >>Parle à |cRXP_FRIENDLY_Parqual Fintallas|r
    .accept 1160 >>Accepte L'épreuve de la Connaissance
    .target 4488
    .isQuestTurnedIn 1159

-- ===== Thunder Bluff : Sage Truthseeker (pas les morts-vivants) =====
step << Orc/Tauren/Troll
    .goto Thunder Bluff,34.40,46.87
    >>Parle au |cRXP_FRIENDLY_Sage Truthseeker|r à Thunder Bluff
    .accept 1049 >>Accepte Compendium des Déchus
    .target 3978

-- ===== Instance : Cimetière =====
step
    #label EntreeSM
    .goto Tirisfal Glades,82.60,33.80,20 >>Va au Monastère écarlate, au nord-est des Clairières de Tirisfal. Entre dans le Cimetière
step
    #sticky
    >>Ramasse les |cRXP_LOOT_Cœurs zélés|r sur les humains écarlates des quatre ailes
    >>|cRXP_WARN_Farm long en duo (~120 kills) : chacun doit looter ses objets|r
    .complete 1113,1 --Coeur zélé (20)
    .isOnQuest 1113
step
    >>Parle à |cRXP_FRIENDLY_Vorrel Sengutz|r, mourant au début du Cimetière
    .accept 1051 >>Accepte La vengeance de Vorrel
    .target 3981

-- ===== Instance : Bibliothèque =====
step
    >>Entre dans la Bibliothèque. Tue le |cRXP_ENEMY_Maître-chien Loksey|r au premier grand couloir
    .complete 1048,4 --Maître-chien Loksey
    .mob 3974
    .isOnQuest 1048
step
    >>Ramasse la |cRXP_PICK_Naissance de la menace des morts-vivants|r sur une étagère de la Bibliothèque
    .complete 1160,1 --Naissance de la menace des morts-vivants
    .isOnQuest 1160
step << Mage
    >>Ramasse les |cRXP_PICK_Rituels du Pouvoir|r dans la Bibliothèque
    .complete 1951,1 --Rituels du Pouvoir
    .isOnQuest 1951
step << Orc/Tauren/Troll
    >>Ramasse le |cRXP_PICK_Compendium des Déchus|r, sur une étagère de la dernière salle de la Bibliothèque (après Loksey)
    .complete 1049,1 --Compendium des Déchus
    .isOnQuest 1049

-- ===== Instance : Armurerie et Cathédrale =====
step
    >>Entre dans l'Armurerie et tue |cRXP_ENEMY_Herod|r dans la dernière salle
    .complete 1048,3 --Herod
    .mob 3975
    .isOnQuest 1048
step
    >>Entre dans la Cathédrale. Tue le |cRXP_ENEMY_Commandant écarlate Mograine|r, puis le |cRXP_ENEMY_Grand Inquisiteur Whitemane|r qui vient le relever
    .complete 1048,1 --Grand Inquisiteur Whitemane
    .complete 1048,2 --Commandant écarlate Mograine
    .mob 3976
    .mob 3977
    .isOnQuest 1048

-- ===== Undercity : rendus =====
step
    .goto Undercity,56.25,92.20
    >>Retourne voir |cRXP_FRIENDLY_Varimathras|r
    .turnin 1048 >>Rends Au monastère écarlate
    .target 2425
    .isQuestComplete 1048
step
    .goto Undercity,48.82,69.28
    >>Parle au |cRXP_FRIENDLY_Maître apothicaire Faranell|r
    .turnin 1113 >>Rends Des cœurs zélés
    .target 2055
    .isQuestComplete 1113
step
    .goto Undercity,57.80,65.42
    >>Parle à |cRXP_FRIENDLY_Parqual Fintallas|r
    .turnin 1160 >>Rends L'épreuve de la Connaissance
    .accept 6628 >>Accepte L'épreuve de la Connaissance
    .target 4488
    .isQuestComplete 1160
step
    .goto Undercity,57.80,65.42
    >>Réponds à la question de |cRXP_FRIENDLY_Parqual Fintallas|r, puis parle-lui de nouveau
    .complete 6628,1 --Répondre à Parqual
    .turnin 6628 >>Rends L'épreuve de la Connaissance
    .target 4488
    .isOnQuest 6628

-- ===== Vorrel : Alterac puis Moulin-de-Tarren =====
step
    .goto Alterac Mountains,32.33,32.78
    >>Va dans les Montagnes d'Alterac et tue |cRXP_ENEMY_Nancy Vishas|r pour l'|cRXP_LOOT_Anneau de mariage de Vorrel|r
    .complete 1051,1 --Anneau de mariage de Vorrel
    .mob 3984
    .isOnQuest 1051
step
    .goto Hillsbrad Foothills,62.67,18.88
    >>Va à Moulin-de-Tarren et parle à |cRXP_FRIENDLY_Monika Sengutz|r
    .turnin 1051 >>Rends La vengeance de Vorrel
    .target 3982
    .isOnQuest 1051

-- ===== Thunder Bluff : Compendium =====
step << Orc/Tauren/Troll
    .goto Thunder Bluff,34.40,46.87
    >>Parle au |cRXP_FRIENDLY_Sage Truthseeker|r à Thunder Bluff
    .turnin 1049 >>Rends Compendium des Déchus
    .target 3978
    .isOnQuest 1049

-- ===== Mage : fin de la baguette =====
step << Mage
    .goto Arathi Highlands,52.00,50.80
    >>Va dans les Hautes-terres d'Arathi et ramasse le |cRXP_PICK_Roncier de foudre|r (Branche électrifiée)
    >>|cRXP_WARN_Il te faut aussi une |cRXP_LOOT_Jade|r : minage ou hôtel des ventes|r
    .complete 1948,2 --Roncier de foudre
    .isOnQuest 1948
step << Mage
    .goto Dustwallow Marsh,46.06,57.09
    >>Retourne voir |cRXP_FRIENDLY_Tabetha|r au Marécage d'Âprefange
    .turnin 1948 >>Rends Les Objets de Puissance
    .turnin 1951 >>Rends Rituels du Pouvoir
    .target 6546
    .isQuestComplete 1948
    .isQuestComplete 1951
step << Mage
    #label FinMonastere
    .goto Dustwallow Marsh,46.06,57.09
    >>Parle à |cRXP_FRIENDLY_Tabetha|r et attends la fin de son rituel
    .accept 1952 >>Accepte La baguette du mage
    .turnin 1952 >>Rends La baguette du mage
    .target 6546
    .isQuestTurnedIn 1948
]])

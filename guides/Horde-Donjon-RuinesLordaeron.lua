if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde des Ruines de Lordaeron (donjon Forever, accès depuis Undercity),
-- toutes classes.
-- Givers : Tabitha Tissecœur (Le Sépulcre), Nécrogarde Kristof (Brill), Morbin
-- Plaie-lumineuse et Theodore Griffs (Undercity). Écu de Lordaeron et Tête abominable
-- tombent dans l'instance ; la Tête lance Tourment interminable (97288-97292, Undercity).
-- Protégées : 92422 La colère de Rath'mael (après 356/99156, Brill) et 95216 La peste
-- nouvelle (après 450/451, Une recette mortelle).
-- Données : QuestieDB Forever (tools/questiedb.py), XP inconnue pour ces quêtes Forever.
-- Entrée : Undercity 71.4,11.5, convertie des coordonnées monde du guide RXP Forever.
-- Dans l'instance, QuestieDB n'a pas de coordonnées : pas d'ordre de boss connu.

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 18-22 Ruins of Lordaeron
#displayname [FDP] Ruines de Lordaeron (18-22)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Le Sépulcre : Tabitha =====
step
    #completewith Tabitha
    .goto Silverpine Forest,44.52,43.02,40 >>Va au Sépulcre, dans la Forêt des Pins-Argentés
step
    #label Tabitha
    .goto Silverpine Forest,44.52,43.02
    >>Parle à |cRXP_FRIENDLY_Tabitha Tissecœur|r
    .accept 92401 >>Accepte Une requête apeurée
    .target 250686

-- ===== Brill et Undercity =====
step
    .goto Tirisfal Glades,65.25,60.20
    >>Va à Brill et parle au |cRXP_FRIENDLY_Nécrogarde Kristof|r
    .accept 92422 >>Accepte La colère de Rath'mael
    .target 251001
    .isQuestTurnedIn 99156
step
    .goto Undercity,58.08,89.51
    >>Parle à |cRXP_FRIENDLY_Morbin Plaie-lumineuse|r, dans le Quartier royal d'Undercity
    .accept 92421 >>Accepte Justice de la Lumière
    .target 266484
step
    .goto Undercity,46.31,71.91
    >>Parle à |cRXP_FRIENDLY_Theodore Griffs|r à l'Apothicarium
    .accept 95216 >>Accepte La peste nouvelle
    .target 11835
    .isQuestTurnedIn 451

-- ===== Instance =====
step
    #label EntreeROL
    .goto Undercity,71.40,11.50,15 >>Entre dans les Ruines de Lordaeron depuis Undercity
step
    #completewith SortieROL
    >>Tue tous les morts-vivants de l'instance pour les |cRXP_LOOT_Membres intacts|r
    >>|cRXP_WARN_Nettoie toute l'instance, sinon il risque d'en manquer|r
    .complete 92421,1 --Membres intacts (25)
    .mob 250656
    .mob 255109
    .mob 255964
step
    #completewith SortieROL
    >>Ramasse l'|cRXP_LOOT_Écu de Lordaeron|r (cinq emplacements possibles) et utilise-le pour lancer la quête
    .collect 275521,1,95204,1 --Écu de Lordaeron
    .accept 95204 >>Accepte Écu de Lordaeron
    .use 275521
step
    >>Tue |cRXP_ENEMY_Witherfang|r et ramasse la |cRXP_LOOT_Souche hautement toxique|r
    .complete 95216,1 --Souche hautement toxique
    .mob 250483
    .isOnQuest 95216
step
    >>Tue |cRXP_ENEMY_The Baron|r et ramasse la |cRXP_LOOT_Tête abominable|r. Utilise-la pour lancer la quête
    .collect 280438,1,97288,1 --Tête abominable
    .accept 97288 >>Accepte Tourment interminable
    .use 280438
    .mob 250660
step
    >>Tue |cRXP_ENEMY_Rath'mael|r
    .complete 92422,1 --Rath'mael
    .mob 250657
    .isOnQuest 92422
step
    >>Approche-toi du corps d'|cRXP_FRIENDLY_Edward Heartweaver|r, près de Rath'mael
    .complete 92401,1 --Enquêter sur Edward Heartweaver
step
    #label SortieROL
    >>Finis les |cRXP_LOOT_Membres intacts|r avant de sortir
    .complete 92421,1 --Membres intacts (25)

-- ===== Undercity : rendus =====
step
    .goto Undercity,58.08,89.51
    >>Parle à |cRXP_FRIENDLY_Morbin Plaie-lumineuse|r
    .turnin 92421 >>Rends Justice de la Lumière
    .target 266484
step
    .goto Undercity,46.31,71.91
    >>Parle à |cRXP_FRIENDLY_Theodore Griffs|r
    .turnin 95216 >>Rends La peste nouvelle
    .target 11835
    .isOnQuest 95216
step
    .goto Undercity,73.06,32.85
    >>Parle à |cRXP_FRIENDLY_Oran Snakewrithe|r au Quartier des mages
    .turnin 95204 >>Rends Écu de Lordaeron
    .target 7825
    .isOnQuest 95204
step
    .goto Undercity,48.82,69.28
    >>Parle au |cRXP_FRIENDLY_Maître apothicaire Faranell|r
    .turnin 97288 >>Rends Tourment interminable
    .accept 97289 >>Accepte Tourment interminable
    .target 2055
    .isOnQuest 97288
step
    .goto Undercity,45.88,61.70
    >>Apporte la tête à l'|cRXP_FRIENDLY_Abomination inachevée|r, le corps d'Othmar
    .turnin 97289 >>Rends Tourment interminable
    .accept 97290 >>Accepte Tourment interminable
    .target 271613
    .isOnQuest 97289
step
    .goto Undercity,48.82,69.28
    >>Retourne voir le |cRXP_FRIENDLY_Maître apothicaire Faranell|r
    .turnin 97290 >>Rends Tourment interminable
    .accept 97291 >>Accepte Tourment interminable
    .target 2055
    .isOnQuest 97290
step
    .goto Undercity,65.19,49.84
    >>Achète une |cRXP_LOOT_Toxic Skullcap|r à |cRXP_FRIENDLY_Tawny Grisette|r, qui se promène dans le Quartier marchand
    .complete 97291,1 --Toxic Skullcap
    .target 4554
    .isOnQuest 97291
step
    .goto Undercity,54.00,49.30
    >>Ramasse une |cRXP_PICK_Cloquette|r près du maître herboriste
    .complete 97291,2 --Cloquette
    .isOnQuest 97291
step
    .goto Undercity,75.20,51.18
    >>Achète une |cRXP_LOOT_Essence d'agonie|r à |cRXP_FRIENDLY_Ezekiel Graves|r, marchand de poisons du Quartier des voleurs
    .complete 97291,3 --Essence d'agonie
    .target 4585
    .isOnQuest 97291
step
    .goto Undercity,48.82,69.28
    >>Parle au |cRXP_FRIENDLY_Maître apothicaire Faranell|r
    .turnin 97291 >>Rends Tourment interminable
    .accept 97292 >>Accepte Tourment interminable
    .target 2055
    .isOnQuest 97291
step
    .goto Undercity,45.98,61.92
    >>Injecte le |cRXP_LOOT_Sérum sifflant|r dans le dispositif au-dessus du corps d'Othmar
    .complete 97292,1 --Tête d'Othmar
    .isOnQuest 97292
step
    .goto Undercity,48.82,69.28
    >>Parle au |cRXP_FRIENDLY_Maître apothicaire Faranell|r
    .turnin 97292 >>Rends Tourment interminable
    .target 2055
    .isOnQuest 97292

-- ===== Brill et Le Sépulcre =====
step
    .goto Tirisfal Glades,65.25,60.20
    >>Parle au |cRXP_FRIENDLY_Nécrogarde Kristof|r à Brill
    .turnin 92422 >>Rends La colère de Rath'mael
    .target 251001
    .isOnQuest 92422
step
    #label FinRuines
    .goto Silverpine Forest,44.52,43.02
    >>Retourne voir |cRXP_FRIENDLY_Tabitha Tissecœur|r au Sépulcre
    .turnin 92401 >>Rends Une requête apeurée
    .target 250686
]])

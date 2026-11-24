if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde des Excavations : les Paluns (donjon Forever), toutes classes.
-- Givers : Borstan (Orgrimmar), Zaruk (Trépas-d'Orgrim, Hautes-terres d'Arathi), Agent
-- Traqueur noir (collines au-dessus du camp Gueule-de-Dragon). La Relique des Titans tombe
-- d'un Relic Guardian et lance Le savoir des anciens (95664 -> 98823, Thunder Bluff puis Mulgore).
-- Données : QuestieDB Forever (tools/questiedb.py), XP et taux inconnus pour ces quêtes.
-- L'Agent Traqueur noir est à Paluns 51.5,59.3 (QuestieDB). Gueule-de-bois (95682) n'a pas
-- d'objectif chiffré : case à cocher. Mobs de l'instance sans nom français : noms anglais.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 28-34 Excavation Site Wetlands
#displayname [FDP] Excavations : les Paluns (28-34)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Orgrimmar : Borstan =====
step
    #completewith Borstan
    .goto Orgrimmar,57.20,53.32,40 >>Va à Orgrimmar, dans la Vallée de la Force
step
    #label Borstan
    .goto Orgrimmar,57.20,53.32
    >>Parle à |cRXP_FRIENDLY_Borstan|r, le marchand de viande
    .accept 95697 >>Accepte Goûts changeants
    .target 3368

-- ===== Trépas-d'Orgrim : Zaruk =====
step
    #completewith Zaruk
    .goto Arathi Highlands,74.54,35.64,40 >>Va au Trépas-d'Orgrim, dans les Hautes-terres d'Arathi (zeppelin vers Undercity, puis vol)
step
    #label Zaruk
    .goto Arathi Highlands,74.54,35.64
    >>Parle à |cRXP_FRIENDLY_Zaruk|r
    .accept 95663 >>Accepte Rumeurs sur les Gueules-de-Dragon
    .target 2787

-- ===== Paluns : l'Agent Traqueur noir =====
step
    #completewith Agent
    .goto Wetlands,47.79,56.16,60 >>Passe le pont de Thandol et descends dans les Paluns jusqu'au site de fouilles
step
    #label Agent
    .goto Wetlands,51.48,59.30
    >>Trouve l'|cRXP_FRIENDLY_Agent Traqueur noir|r dans les collines au-dessus du camp Gueule-de-Dragon, près du site de fouilles
    .turnin 95663 >>Rends Rumeurs sur les Gueules-de-Dragon
    .accept 95682 >>Accepte Gueule-de-bois
    .target 13155

-- ===== Instance =====
step
    #label EntreeES
    .goto Wetlands,47.79,56.16,15 >>Entre dans les Excavations
step
    #completewith SortieES
    >>Tue les raptors |cRXP_ENEMY_Thicket|r pour la |cRXP_LOOT_Viande de raptor des fourrés|r
    .complete 95697,1 --Viande de raptor des fourrés
    .mob 260800
    .mob 260801
    .mob 271732
    .mob 260325
step
    #completewith SortieES
    >>Si un |cRXP_ENEMY_Relic Guardian|r lâche la |cRXP_LOOT_Relique des Titans|r, utilise-la pour lancer la quête
    .collect 270866,1,95664,1 --Relique des Titans
    .accept 95664 >>Accepte Le savoir des anciens
    .use 270866
    .mob 260326
step
    +|cRXP_WARN_Tue les forces Gueule-de-Dragon de l'instance et ramasse ce qu'elles lâchent. Coche quand c'est fait|r
    .isOnQuest 95682
step
    #label SortieES
    >>Finis la |cRXP_LOOT_Viande de raptor des fourrés|r avant de sortir
    .complete 95697,1 --Viande de raptor des fourrés

-- ===== Rendus =====
step
    .goto Wetlands,51.48,59.30
    >>Sors et retourne voir l'|cRXP_FRIENDLY_Agent Traqueur noir|r
    .turnin 95682 >>Rends Gueule-de-bois
    .target 13155
    .isOnQuest 95682
step
    .goto Thunder Bluff,71.06,34.19
    >>Va à Thunder Bluff, sur la Cime des Anciens, et parle à |cRXP_FRIENDLY_Bashana Runetotem|r
    .turnin 95664 >>Rends Le savoir des anciens
    .accept 98823 >>Accepte Écho terrestre
    .target 9087
    .isOnQuest 95664
step
    .goto Mulgore,33.41,22.59
    >>Apporte la relique à |cRXP_FRIENDLY_Muln Rageterre|r, sur le plateau des Guetteurs du ciel au nord-ouest de Mulgore
    .turnin 98823 >>Rends Écho terrestre
    .target 259118
    .isOnQuest 98823
step
    #label FinExcavations
    .goto Orgrimmar,57.20,53.32
    >>Retourne à Orgrimmar et parle à |cRXP_FRIENDLY_Borstan|r
    .turnin 95697 >>Rends Goûts changeants
    .target 3368
]])

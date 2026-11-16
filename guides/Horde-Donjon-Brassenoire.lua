if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde des Profondeurs de Brassenoire (Ashenvale), toutes classes.
-- Toutes les quêtes se prennent et se rendent chez Je'neu Sancrea à Zoram'gar.
-- Données : QuestieDB Forever (tools/questiedb.py). Les saphirs et les Prêtresses des
-- marées sont dans la grotte d'accès (zone Ashenvale) ; dans l'instance, QuestieDB n'a
-- pas de coordonnées (Pierre de la Brasse, Baron Aquanis, Lorgus Jett).

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 22-28 Blackfathom Deeps
#displayname [FDP] Profondeurs de Brassenoire (22-28)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Zoram'gar : quêtes de Je'neu =====
step
    #completewith Jeneu
    .goto Ashenvale,12.24,33.80,40 >>Va à l'avant-poste de Zoram'gar, sur la côte ouest d'Ashenvale
step
    .goto Ashenvale,12.24,33.80
    >>Parle à |cRXP_FRIENDLY_Andruk|r
    .fp Zoram'gar Outpost >>Prends le point de vol de Zoram'gar
    .target 11901
step
    .goto Ashenvale,11.56,34.29
    >>Parle à |cRXP_FRIENDLY_Je'neu Sancrea|r
    .turnin 6562 >>Rends Problèmes dans les profondeurs
    .target 12736
    .isOnQuest 6562
step
    #label Jeneu
    .goto Ashenvale,11.56,34.29
    >>Parle à |cRXP_FRIENDLY_Je'neu Sancrea|r
    .accept 6563 >>Accepte L'Essence d'Aku'Mai
    .accept 6921 >>Accepte Parmi les ruines
    .target 12736

-- ===== Grotte d'accès : saphirs et Note humide =====
step
    #completewith Saphirs
    >>Tue les |cRXP_ENEMY_Prêtresses des marées de Brassenoire|r (élites) et ramasse la |cRXP_LOOT_Note humide|r si elle tombe. Utilise-la pour lancer la quête
    .collect 16790,1,6564,1 --Note humide
    .accept 6564 >>Accepte Allégeance aux Dieux très anciens
    .use 16790
    .mob 4802
    .isQuestTurnedIn 6562
step
    #label Saphirs
    .goto Ashenvale,13.59,13.14,10,0
    .goto Ashenvale,13.53,11.85,10,0
    .goto Ashenvale,13.73,10.61,10,0
    .goto Ashenvale,13.17,13.49
    >>Ramasse les |cRXP_PICK_Saphirs d'Aku'Mai|r sur les parois de la grotte, au nord de Zoram'gar
    >>|cRXP_WARN_Chacun doit ramasser ses propres saphirs (20 chacun)|r
    .complete 6563,1 --Saphir d'Aku'Mai (20)

-- ===== Instance =====
step
    >>Entre dans l'instance. Clique sur la |cRXP_PICK_Pierre de la Brasse|r dans l'eau pour le |cRXP_LOOT_Noyau de la Brasse|r
    >>|cRXP_WARN_Cliquer la pierre fait apparaître le |cRXP_ENEMY_Baron Aquanis|r (élite 28)|r
    .complete 6921,1 --Noyau de la Brasse
step
    >>Tue le |cRXP_ENEMY_Baron Aquanis|r et ramasse le |cRXP_LOOT_Globe d'eau étrange|r. Utilise-le pour lancer la quête
    .collect 16782,1,6922,1 --Globe d'eau étrange
    .accept 6922 >>Accepte Baron Aquanis
    .use 16782
    .mob 12876
step
    >>Tue |cRXP_ENEMY_Lorgus Jett|r si tu as déjà la suite d'Allégeance aux Dieux très anciens
    .complete 6565,1 --Lorgus Jett
    .mob 12902
    .isOnQuest 6565

-- ===== Zoram'gar : rendus =====
step
    .goto Ashenvale,11.56,34.29
    >>Retourne voir |cRXP_FRIENDLY_Je'neu Sancrea|r à Zoram'gar
    .turnin 6563 >>Rends L'Essence d'Aku'Mai
    .turnin 6921 >>Rends Parmi les ruines
    .target 12736
step
    .goto Ashenvale,11.56,34.29
    >>Parle à |cRXP_FRIENDLY_Je'neu Sancrea|r
    .turnin 6922 >>Rends Baron Aquanis
    .target 12736
    .isOnQuest 6922
step
    .goto Ashenvale,11.56,34.29
    >>Parle à |cRXP_FRIENDLY_Je'neu Sancrea|r
    .turnin 6564 >>Rends Allégeance aux Dieux très anciens
    .accept 6565 >>Accepte Allégeance aux Dieux très anciens
    .target 12736
    .isOnQuest 6564

-- ===== Deuxième passage : Lorgus Jett =====
step
    >>Retourne dans les Profondeurs de Brassenoire et tue |cRXP_ENEMY_Lorgus Jett|r
    .complete 6565,1 --Lorgus Jett
    .mob 12902
    .isOnQuest 6565
step
    .goto Ashenvale,11.56,34.29
    >>Parle à |cRXP_FRIENDLY_Je'neu Sancrea|r
    .turnin 6565 >>Rends Allégeance aux Dieux très anciens
    .target 12736
    .isQuestComplete 6565
]])

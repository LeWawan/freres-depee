if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Paladin Horde (Forever), Lumina Chantelevent (niveau 18-24).
-- QuestieDB réserve le début aux Morts-vivants. Danitha Morr envoie au Sépulcre (Silverpine)
-- puis à l'île de Fenris. La suite, Une lame caressée par la lune (95036), demande du bois
-- de chêne de blanchepierre des Mortemines et la gemme de Kor : quêtes de donjon, hors guide.

RXPGuides.RegisterGuide([[
#classic
<< Horde Paladin
#name 18 Lumina Chantelevent
#displayname [FDP] Paladin 18 : Lumina Chantelevent
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 18 >>Monte au niveau 18, requis pour la quête
step
    .goto Tirisfal Glades,22.09,44.66
    >>Parle à |cRXP_FRIENDLY_Danitha Morr|r au donjon de Bandarion
    .accept 91858 >>Accepte Incident diplomatique
    .target 246378
step
    .goto Silverpine Forest,43.40,41.10
    >>Parle à |cRXP_FRIENDLY_Trevan Rol|r au Sépulcre
    .turnin 91858 >>Rends Incident diplomatique
    .accept 91859 >>Accepte Un curieux duo
    .target 248840
step
    .goto Silverpine Forest,45.81,41.88
    >>Parle au |cRXP_FRIENDLY_Nécrogarde Baldren|r
    .turnin 91859 >>Rends Un curieux duo
    .accept 91860 >>Accepte Un sort terrible
    .target 259611
step
    .goto Silverpine Forest,65.02,34.10
    >>Va sur l'île de Fenris et examine les |cRXP_PICK_Restes carbonisés|r
    .turnin 91860 >>Rends Un sort terrible
    .accept 91861 >>Accepte Dans le donjon de Fenris
step
    .goto Silverpine Forest,65.55,23.27
    >>Entre dans le donjon de Fenris et trouve |cRXP_FRIENDLY_Lumina Chantelevent|r
    .turnin 91861 >>Rends Dans le donjon de Fenris
    .accept 91862 >>Accepte Lumina Chantelevent
    .target 248755
step
    .goto Silverpine Forest,66.36,23.50
    >>Tue les gnolls |cRXP_ENEMY_Poil-Putride|r du donjon jusqu'à la |cRXP_LOOT_Clé de l'île de Fenris|r
    .complete 91862,1 --Clé de l'île de Fenris (1)
    .mob 1942
    .mob 1943
step
    .goto Silverpine Forest,65.55,23.27
    >>Libère |cRXP_FRIENDLY_Lumina Chantelevent|r
    .turnin 91862 >>Rends Lumina Chantelevent
    .accept 96204 >>Accepte La colère de la Sculpte-vent
    .target 248755
step
    .goto Silverpine Forest,65.70,29.70
    >>Escorte |cRXP_FRIENDLY_Lumina Chantelevent|r hors du donjon de Fenris. Tue ce qui l'attaque
    .complete 96204,1
step
    .goto Silverpine Forest,43.40,40.99
    >>Retourne au Sépulcre et parle à |cRXP_FRIENDLY_Lumina Chantelevent|r
    .turnin 96204 >>Rends La colère de la Sculpte-vent
    .accept 95034 >>Accepte La dette
    .target 259620
step
    #label FinLumina
    .goto Silverpine Forest,43.40,40.99
    >>Écoute |cRXP_FRIENDLY_Lumina Chantelevent|r jusqu'au bout
    >>|cRXP_WARN_La suite (Une lame caressée par la lune) passe par les Mortemines : elle n'est pas dans ce guide|r
    .complete 95034,1
    .turnin 95034 >>Rends La dette
    .target 259620
]])

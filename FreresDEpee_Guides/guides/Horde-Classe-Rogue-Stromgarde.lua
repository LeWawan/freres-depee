if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Rogue Horde, le Syndicat de Stromgarde (quêtes Forever niveau 36).
-- Suite du guide « 24 Ravenholdt » : Myrokos Silentform (manoir de Ravenholdt).
-- Extraction clandestine (96782) est réservée à l'Alliance. Les objets de Stromgarde
-- (96785, 96786) n'ont pas de position dans QuestieDB.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Rogue
#name 34 Syndicat de Stromgarde
#displayname [FDP] Voleur 34 : Syndicat de Stromgarde
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    #sticky
    #completewith FinStromgarde
    .isQuestAvailable 6681
    .xp 61 >>|cRXP_WARN_Fais d'abord le guide « 24 Ravenholdt » : ces quêtes en sont la suite|r
step
    .xp 34 >>Monte au niveau 34 : Barton et Stromgarde sont niveau 35-36
step
    .goto Alterac Mountains,84.93,80.38
    >>Parle à |cRXP_FRIENDLY_Myrokos Silentform|r dans le manoir de Ravenholdt
    .accept 96781 >>Accepte Qu'est-ce qu'ils manigancent ?
    .accept 96783 >>Accepte Un moyen d'infiltration
    .target 13085
    .isQuestTurnedIn 6681
step
    .goto Alterac Mountains,59.95,45.63
    >>Fais les poches de |cRXP_ENEMY_Barton|r pour son |cRXP_LOOT_Rapport de reconnaissance|r
    .complete 96781,1 --Rapport de reconnaissance de Barton (1)
    .target 266357
step
    .goto Arathi Highlands,32.29,26.57
    >>Ouvre la |cRXP_PICK_Cantine du Syndicat|r au manoir de Northfold pour voler un uniforme
    .turnin 96783 >>Rends Un moyen d'infiltration
    .accept 96784 >>Accepte Maître du déguisement
step
    .goto Arathi Highlands,26.81,64.44
    >>Déguisé en membre du Syndicat, entre dans Stromgarde et parle à |cRXP_FRIENDLY_Anastasia Miller|r
    .turnin 96784 >>Rends Maître du déguisement
    .accept 96785 >>Accepte Motus
    .target 266847
step
    .goto Arathi Highlands,26.81,64.44
    >>Fouille Stromgarde pour trouver les |cRXP_LOOT_Fonds dérobés|r
    >>|cRXP_WARN_Position absente de QuestieDB : cherche dans le donjon de Stromgarde|r
    .complete 96785,1 --Fonds dérobés (1)
step
    .goto Arathi Highlands,26.81,64.44
    >>Parle à |cRXP_FRIENDLY_Anastasia Miller|r
    .turnin 96785 >>Rends Motus
    .accept 96786 >>Accepte La piqûre du Syndicat
    .target 266847
step
    .goto Arathi Highlands,26.81,64.44
    >>Interromps l'échange secret dans Stromgarde et prends l'|cRXP_LOOT_Envoi intercepté|r
    >>|cRXP_WARN_Position absente de QuestieDB|r
    .complete 96786,1 --Envoi intercepté (1)
step
    #label FinStromgarde
    .goto Alterac Mountains,84.93,80.38
    >>Retourne voir |cRXP_FRIENDLY_Myrokos Silentform|r à Ravenholdt
    .turnin 96781 >>Rends Qu'est-ce qu'ils manigancent ?
    .turnin 96786 >>Rends La piqûre du Syndicat
    .target 13085
]])

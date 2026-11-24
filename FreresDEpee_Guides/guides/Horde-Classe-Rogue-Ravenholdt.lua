if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Rogue Horde, Ravenholdt (niveau 24).
-- La Lettre élégante (17126) lance la chaîne : elle arrive par la poste au niveau 24.
-- Suite Forever de Myrokos Silentform : Sabotage du Syndicat (Durnholde).
-- Les quêtes 36 de Myrokos sont dans le guide « 34 Syndicat de Stromgarde ».

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Rogue
#name 24 Ravenholdt
#displayname [FDP] Voleur 24 : Ravenholdt
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 24 >>Monte au niveau 24, requis pour la quête
step
    >>Ouvre la |cRXP_LOOT_Lettre élégante|r reçue par la poste pour lancer la quête
    .collect 17125,1,6681,1
    .accept 6681 >>Accepte Ravenholdt, le manoir
    .use 17126
step
    .goto Hillsbrad Foothills,78.64,17.84
    >>Va à l'entrée cachée de Ravenholdt, au nord-est de Hillsbrad, et passe le Rite d'astuce
    .complete 6681,1 --Rite d'astuce
step
    .goto Alterac Mountains,84.45,80.32
    >>Parle à |cRXP_FRIENDLY_Fahrad|r dans le manoir de Ravenholdt
    .turnin 6681 >>Rends Ravenholdt, le manoir
    .target 6707
step
    .goto Alterac Mountains,84.93,80.38
    >>Parle à |cRXP_FRIENDLY_Myrokos Silentform|r, juste à côté
    .accept 96779 >>Accepte Sabotage du Syndicat
    .target 13085
step
    .goto Hillsbrad Foothills,76.99,46.07
    >>Entre dans le donjon de Durnholde et tue le |cRXP_ENEMY_Seigneur Tomas|r
    .complete 96779,1 --Seigneur Tomas
    .mob 266216
step
    #label FinRavenholdt
    .goto Alterac Mountains,84.93,80.38
    >>Retourne voir |cRXP_FRIENDLY_Myrokos Silentform|r à Ravenholdt
    .turnin 96779 >>Rends Sabotage du Syndicat
    .target 13085
]])

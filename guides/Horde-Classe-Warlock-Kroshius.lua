if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warlock Horde, Le noyau infernal de Kroshius (Éclat de la Flamme verte, niveau 50-55).
-- Niby et Démonet (Gangrebois), trois gangressences parfaites (Azshara, Jaedenar, Terres foudroyées),
-- puis Kroshius (élite niveau 55) à Shatter Scar Vale.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde Warlock
#name 50 Noyau de Kroshius
#displayname [FDP] Démoniste 50 : Noyau de Kroshius
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    .xp 50 >>Monte au niveau 50, requis pour la quête
step
    .goto Felwood,41.38,44.85
    >>Parle à |cRXP_FRIENDLY_Niby le Tout-puissant|r au sud de Jaedenar (Gangrebois)
    .accept 7601 >>Accepte Les Commandements de Niby
    .target 14469
step
    .goto Felwood,41.36,45.02
    >>Parle à |cRXP_FRIENDLY_Démonet|r, juste à côté
    .turnin 7601 >>Rends Les Commandements de Niby
    .accept 7602 >>Accepte La gangressence parfaite
    .target 14470
step
    .goto Felwood,36.23,45.87
    >>Tue les |cRXP_ENEMY_Légionnaires de Jaedenar|r pour la |cRXP_LOOT_Gangressence parfaite (Jaedenar)|r
    .complete 7602,2 --Gangressence parfaite (Jaedenar) (1)
    .mob 9862
step
    .goto Azshara,65.96,16.48
    >>Tue les satyres |cRXP_ENEMY_Legashi|r au nord-est d'Azshara pour la |cRXP_LOOT_Gangressence parfaite (Azshara)|r
    >>|cRXP_WARN_Taux QuestieDB très bas (objet de quête) : farm possiblement long|r
    .complete 7602,1 --Gangressence parfaite (Azshara) (1)
    .mob 6200
    .mob 6201
    .mob 6202
step
    .goto Blasted Lands,57.73,50.62
    >>Tue les |cRXP_ENEMY_Gangregardes sentinelles|r près de la Porte des ténèbres pour la |cRXP_LOOT_Gangressence parfaite (Porte des ténèbres)|r (~15 %)
    .complete 7602,3 --Gangressence parfaite (Porte des ténèbres) (1)
    .mob 6011
step
    .goto Felwood,41.36,45.02
    >>Parle à |cRXP_FRIENDLY_Démonet|r. Il te donne le |cRXP_LOOT_Gangrefeu|r
    .turnin 7602 >>Rends La gangressence parfaite
    .accept 7603 >>Accepte Le noyau infernal de Kroshius
    .target 14470
step
    .goto Felwood,45.70,34.76
    >>Utilise le |cRXP_LOOT_Gangrefeu|r près des restes de Kroshius, tue |cRXP_ENEMY_Kroshius|r et prends son |cRXP_LOOT_Noyau infernal|r
    >>|cRXP_WARN_Élite niveau 55 : à faire en duo|r
    .complete 7603,1 --Kroshius
    .complete 7603,2 --Noyau infernal de Kroshius (1)
    .use 18626
    .mob 14467
step
    #label FinKroshius
    .goto Felwood,41.38,44.85
    >>Parle à |cRXP_FRIENDLY_Niby le Tout-puissant|r et prends l'|cRXP_LOOT_Éclat de la Flamme verte|r
    .turnin 7603 >>Rends Le noyau infernal de Kroshius
    .target 14469
]])

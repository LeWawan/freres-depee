if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde du Gouffre de Ragefeu (Orgrimmar), toutes classes.
-- Givers : Rahauro à Thunder Bluff, Neeru Fireblade et Thrall à Orgrimmar.
-- Ennemis cachés (5728) suit 5726/5727 (Insigne de lieutenant, Durotar) : protégée.
-- Coupée : 5725 Le pouvoir de détruire... (deux livres à ~2,3 % chacun, ~90 kills en duo).
-- Données : QuestieDB Forever (tools/questiedb.py). Dans l'instance, QuestieDB n'a pas de
-- coordonnées : ordre des boss décrit dans le texte.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 13-18 Ragefire Chasm
#displayname [FDP] Gouffre de Ragefeu (13-18)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Thunder Bluff : Rahauro =====
step
    #completewith Rahauro
    .goto Thunder Bluff,70.14,29.52,40 >>Va à Thunder Bluff, sur la Cime des Anciens
step
    #label Rahauro
    .goto Thunder Bluff,70.14,29.52
    >>Parle à |cRXP_FRIENDLY_Rahauro|r
    .accept 5722 >>Accepte À la recherche de la sacoche perdue
    .accept 5723 >>Accepte Tester la force de l'ennemi
    .target 11833

-- ===== Orgrimmar : Neeru et Thrall =====
step
    #completewith Neeru
    .goto Orgrimmar,49.47,50.59,40 >>Va à Orgrimmar (vol ou zeppelin), dans la Faille de l'Ombre
step
    #label Neeru
    .goto Orgrimmar,49.47,50.59
    >>Parle à |cRXP_FRIENDLY_Neeru Fireblade|r
    .accept 5761 >>Accepte Tuer la bête
    .target 3216
step
    .goto Orgrimmar,49.47,50.59
    >>Parle encore à |cRXP_FRIENDLY_Neeru Fireblade|r avec l'|cRXP_LOOT_Insigne de lieutenant|r et choisis le dialogue de la Lame brûlante
    .complete 5727,1 --Jauger la réaction de Neeru
    .target 3216
    .isOnQuest 5727
step
    .goto Orgrimmar,31.73,37.82
    >>Parle à |cRXP_FRIENDLY_Thrall|r dans la Salle de Thrall
    .turnin 5727 >>Rends Ennemis cachés
    .accept 5728 >>Accepte Ennemis cachés
    .target 4949
    .isQuestComplete 5727
step
    .goto Orgrimmar,31.73,37.82
    >>Parle à |cRXP_FRIENDLY_Thrall|r dans la Salle de Thrall
    .accept 5728 >>Accepte Ennemis cachés
    .target 4949
    .isQuestTurnedIn 5727

-- ===== Instance =====
step
    #label EntreeRFC
    .goto Orgrimmar,52.77,48.97,15 >>Entre dans le Gouffre de Ragefeu, au fond de la Faille de l'Ombre
step
    #completewith Taragaman
    >>Tue les |cRXP_ENEMY_Troggs Ragefeu|r et les |cRXP_ENEMY_Chamans Ragefeu|r du début de l'instance
    .complete 5723,1 --Trogg Ragefeu (8)
    .complete 5723,2 --Chaman Ragefeu (8)
    .mob 11318
    .mob 11319
step
    >>Fouille le cadavre de |cRXP_FRIENDLY_Maur Grimtotem|r, au bord de la lave après les premiers troggs
    .turnin 5722 >>Rends À la recherche de la sacoche perdue
    .accept 5724 >>Accepte Rapporter la sacoche perdue
    .target 11834
step
    >>Tue les |cRXP_ENEMY_Troggs Ragefeu|r et les |cRXP_ENEMY_Chamans Ragefeu|r
    .complete 5723,1 --Trogg Ragefeu (8)
    .complete 5723,2 --Chaman Ragefeu (8)
    .mob 11318
    .mob 11319
step
    #label Taragaman
    >>Tue |cRXP_ENEMY_Taragaman l'Affameur|r (grande salle de lave) et ramasse son |cRXP_LOOT_Cœur|r
    .complete 5761,1 --Coeur de Taragaman l'Affameur
    .mob 11520
step
    >>Tue |cRXP_ENEMY_Jergosh l'Invocateur|r puis |cRXP_ENEMY_Bazzalan|r, au fond de l'instance chez les sectateurs de la Lame brûlante
    .complete 5728,1 --Bazzalan
    .complete 5728,2 --Jergosh l'Invocateur
    .mob 11518
    .mob 11519
    .isOnQuest 5728

-- ===== Orgrimmar : rendus =====
step
    .goto Orgrimmar,49.47,50.59
    >>Sors et parle à |cRXP_FRIENDLY_Neeru Fireblade|r
    .turnin 5761 >>Rends Tuer la bête
    .target 3216
step
    .goto Orgrimmar,31.73,37.82
    >>Parle à |cRXP_FRIENDLY_Thrall|r
    .turnin 5728 >>Rends Ennemis cachés
    .accept 5729 >>Accepte Ennemis cachés
    .target 4949
    .isQuestComplete 5728
step
    .goto Orgrimmar,49.47,50.59
    >>Parle à |cRXP_FRIENDLY_Neeru Fireblade|r
    .turnin 5729 >>Rends Ennemis cachés
    .accept 5730 >>Accepte Ennemis cachés
    .target 3216
    .isOnQuest 5729
step
    .goto Orgrimmar,31.73,37.82
    >>Parle à |cRXP_FRIENDLY_Thrall|r
    .turnin 5730 >>Rends Ennemis cachés
    .target 4949
    .isOnQuest 5730

-- ===== Thunder Bluff : Rahauro =====
step
    #label FinRFC
    .goto Thunder Bluff,70.14,29.52
    >>Retourne voir |cRXP_FRIENDLY_Rahauro|r à Thunder Bluff
    .turnin 5723 >>Rends Tester la force de l'ennemi
    .turnin 5724 >>Rends Rapporter la sacoche perdue
    .target 11833
]])

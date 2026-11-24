if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde de Hache-tripes (Dire Maul, Féralas), toutes classes.
-- Givers : Gorlach le Hurleguerre (Orgrimmar, envoi 7492), Talo Thornhoof et Sage Korolusk
-- (camp Mojache), Azj'Tordin (pavillon de Lariss, au nord-est de Mojache), Ancienne de
-- Shen'Dralar, Capitaine Kromcrush et Knot Thimblejack (instance).
-- Données : QuestieDB Forever (tools/questiedb.py), zone 2557 (quêtes et PNJ de l'instance,
-- sous-zones 10022 à 10027). XP de xpDB-classic.lua. Dans l'instance, QuestieDB n'a pas de
-- coordonnées : ordre des salles décrit dans le texte. Entrées (RXP Classic-0.5.lua et
-- Classic-Attunements.lua) : est Kalimdor 43.84,67.41, nord 43.39,66.52, ouest 42.98,67.73.
-- Ordre des ailes : est (Pusillin donne la Clé en croissant, nécessaire pour le nord et
-- l'ouest), puis nord, puis ouest, puis retour au nord. Le Gantelet de puissance gordok (7703)
-- sort du Coffre du prince (ouest), objet de quête qu'on ne peut sans doute pas ramasser sans
-- la quête, et la quête n'est donnée que par Kromcrush après une run Tribut au nord. D'où :
-- nord (Tribut, accept), ouest (gantelet), retour dans la même instance nord pour le rendu.
-- Si l'instance nord est réinitialisée, Kromcrush redevient hostile.
-- Exception à la règle des kills en duo : Filet de Lethtendris (18426, 19,5 %) et Livre des
-- Incantations (18261, 36 %), taux wowheadData dilués par les joueurs sans la quête ; ce sont
-- des objets de boss, un par run. Clé des menottes gordok (18250) : 46,6 % sur les Gordok
-- Bushwacker, 13-15 % sur les gardes, ~6,5 % sur les autres ogres.
-- Envois protégés : 7492 (Orgrimmar) n'est pris que si 7489 est encore disponible.
-- Coupées :
--   1318 et 84555 (sans donneur dans QuestieDB, doublons de 7703 et 7507),
--   1193 Un piège cassé, 5519 et 7429 (répétables), 5528 La dégustation gordok (sans XP,
--   buff Tribut), 5518 La tenue d'ogre gordok (matériaux d'artisan : étoffe runique, cuir
--   robuste, fil runique, tanin d'ogre),
--   7483/7484/7485 Librams (matériaux de raid, Gardien du savoir Lydros),
--   7498-7506 livres de classe, 7463 (mage), 7631 (démoniste), 7643/7644 (paladin) : quêtes
--   de classe,
--   7507/7508/7509 Quel'Serrar (niveau 60, chaîne d'Onyxia),
--   7649/7650/7651 (forge), 9015 Le défi, 8948/8949/8950, 8967, 8990 (chaînes du set de
--   donjon 0.5, prérequis hors d'Hache-tripes),
--   7462, 7482, 7488, 7494 (Alliance).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 55-60 Dire Maul
#displayname [FDP] Hache-tripes (55-60)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Orgrimmar et camp Mojache =====
step
    .goto Orgrimmar,37.68,75.16
    >>Parle à |cRXP_FRIENDLY_Gorlach le Hurleguerre|r à Orgrimmar (ou au Messager Balthazad à Undercity, au Messager Windstrider à Thunder Bluff)
    .accept 7492 >>Accepte Camp Mojache
    .target 10880
    .isQuestAvailable 7489
step
    #completewith Talo
    .goto Feralas,76.18,43.83,40 >>Va au camp Mojache, à l'est de Féralas (vol vers le camp Mojache)
step
    .goto Feralas,74.80,45.18
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Greul|r
    .home >>Fixe ta pierre de foyer au camp Mojache
    .target 7737
step
    .goto Feralas,76.18,43.83
    >>Parle à |cRXP_FRIENDLY_Talo Thornhoof|r
    .turnin 7492 >>Rends Camp Mojache
    .target 7776
    .isOnQuest 7492
step
    #label Talo
    .goto Feralas,76.18,43.83
    >>Parle à |cRXP_FRIENDLY_Talo Thornhoof|r
    .accept 7489 >>Accepte Le filet de Lethtendris
    .target 7776
step
    .goto Feralas,74.40,44.00
    >>Parle au |cRXP_FRIENDLY_Sage Korolusk|r
    .accept 7481 >>Accepte Légendes elfiques
    .target 14373
step
    .goto Feralas,76.91,37.35
    >>Monte au pavillon de Lariss, au nord-est du camp, et parle à |cRXP_FRIENDLY_Azj'Tordin|r
    .accept 7441 >>Accepte Pusillin et l'Ancien Azj'Tordin
    .target 14355

-- ===== Aile est =====
step
    .goto Kalimdor,43.84,67.41,20 >>Va à Hache-tripes, au centre de Féralas, et entre dans l'aile est
step
    >>Poursuis le diablotin |cRXP_ENEMY_Pusillin|r à travers l'aile est (parle-lui à chaque arrêt) jusqu'à ce qu'il se batte. Tue-le pour le |cRXP_LOOT_Livre des Incantations|r et la |cRXP_LOOT_Clé en croissant|r
    >>|cRXP_WARN_Garde la Clé en croissant : elle ouvre les ailes nord et ouest|r
    .complete 7441,1 --Livre des Incantations
    .mob 14354
    .isOnQuest 7441
step
    >>Tue |cRXP_ENEMY_Lethtendris|r, sur la terrasse après la fosse, pour le |cRXP_LOOT_Filet de Lethtendris|r
    .complete 7489,1 --Filet de Lethtendris
    .mob 14327
    .isOnQuest 7489
step
    +Finis l'aile est par |cRXP_ENEMY_Alzzin le Modeleur|r si tu veux son butin, puis sors. Coche pour continuer
    .mob 11492

-- ===== Aile nord : run Tribut =====
step
    .goto Kalimdor,43.39,66.52,20 >>Entre dans l'aile nord (Clé en croissant)
step
    >>Va voir |cRXP_FRIENDLY_Knot Thimblejack|r, enchaîné dans l'aile nord
    .accept 5525 >>Accepte Libérez Knot !
    .target 14338
    .xp <57,1
step
    #sticky
    >>Tue les ogres |cRXP_ENEMY_Gordok|r pour une |cRXP_LOOT_Clé des menottes gordok|r chacun (surtout les |cRXP_ENEMY_Gordok Bushwacker|r)
    .complete 5525,1 --Clé des menottes gordok
    .mob 14351
    .isOnQuest 5525
step
    +Run Tribut : |cRXP_WARN_ne tue ni le Garde Mol'dar, ni Kreeg le Marteleur, ni le Garde Fengus, ni le Garde Slip'kik, ni le Capitaine Kromcrush|r. Tue le |cRXP_ENEMY_Roi Gordok|r : Kromcrush et Cho'Rush deviennent amicaux. Coche pour continuer
    .mob 11501
step
    >>Parle au |cRXP_FRIENDLY_Capitaine Kromcrush|r, près du trône
    .accept 7703 >>Accepte Affaires inachevées chez les Gordok
    .target 14325
    .xp <56,1
step
    >>Retourne voir |cRXP_FRIENDLY_Knot Thimblejack|r et donne-lui la |cRXP_LOOT_Clé des menottes gordok|r. |cRXP_WARN_Pas de clé : continue, l'étape passe toute seule|r
    .turnin 5525 >>Rends Libérez Knot !
    .target 14338
    .isQuestComplete 5525
step
    +Sors de l'aile nord sans la réinitialiser : tu y reviens après l'aile ouest pour Kromcrush. Coche pour continuer
    .isOnQuest 7703

-- ===== Aile ouest =====
step
    .goto Kalimdor,42.98,67.73,20 >>Entre dans l'aile ouest (Clé en croissant)
step
    >>Dans la cour, parle à l'|cRXP_FRIENDLY_Ancienne de Shen'Dralar|r
    .accept 7461 >>Accepte Folie intérieure
    .target 14358
    .xp <56,1
step
    >>Cherche le |cRXP_PICK_Squelette de Telmius Cherche-Rêve|r dans l'aile ouest et examine-le
    >>|cRXP_WARN_QuestieDB n'a pas sa position : regarde bien chaque salle en avançant|r
    .complete 7481,1 --Squelette de Telmius Cherche-Rêve
    .isOnQuest 7481
step
    >>Tue les gardiens des 5 pylônes, puis |cRXP_ENEMY_Immol'thar|r dans sa prison. Va ensuite à l'Athenaeum et tue le |cRXP_ENEMY_Prince Tortheldrin|r
    .complete 7461,1 --Immol'thar
    .complete 7461,2 --Prince Tortheldrin
    .mob 11496
    .mob 11486
    .isOnQuest 7461
step
    >>Ouvre |cRXP_PICK_Le coffre du prince|r, apparu à la mort de Tortheldrin, pour le |cRXP_LOOT_Gantelet de puissance gordok|r
    .complete 7703,1 --Gantelet de puissance gordok
    .isOnQuest 7703
step
    >>Retourne voir l'|cRXP_FRIENDLY_Ancienne de Shen'Dralar|r dans la cour
    .turnin 7461 >>Rends Folie intérieure
    .target 14358
    .isQuestComplete 7461
step
    >>Parle à l'|cRXP_FRIENDLY_Ancienne de Shen'Dralar|r
    .accept 7877 >>Accepte Le trésor des Shen'dralar
    .target 14358
    .isQuestTurnedIn 7461
    .xp <56,1
step
    >>Retourne à l'Athenaeum et ouvre le |cRXP_PICK_Trésor des Shen'dralar|r
    .turnin 7877 >>Rends Le trésor des Shen'dralar
    .isOnQuest 7877

-- ===== Retour à l'aile nord =====
step
    .goto Kalimdor,43.39,66.52,20 >>Retourne dans l'aile nord, la même instance
    .isQuestComplete 7703
step
    >>Parle au |cRXP_FRIENDLY_Capitaine Kromcrush|r, près du trône
    .turnin 7703 >>Rends Affaires inachevées chez les Gordok
    .target 14325
    .isQuestComplete 7703

-- ===== Rendus : camp Mojache =====
step
    .hs >>Utilise ta pierre de foyer pour le camp Mojache
step
    .goto Feralas,76.91,37.35
    >>Monte au pavillon de Lariss et parle à |cRXP_FRIENDLY_Azj'Tordin|r
    .turnin 7441 >>Rends Pusillin et l'Ancien Azj'Tordin
    .target 14355
    .isQuestComplete 7441
step
    .goto Feralas,76.18,43.83
    >>Parle à |cRXP_FRIENDLY_Talo Thornhoof|r
    .turnin 7489 >>Rends Le filet de Lethtendris
    .target 7776
    .isQuestComplete 7489
step
    #label FinHacheTripes
    .goto Feralas,74.40,44.00
    >>Parle au |cRXP_FRIENDLY_Sage Korolusk|r
    .turnin 7481 >>Rends Légendes elfiques
    .target 14373
    .isQuestComplete 7481
]])

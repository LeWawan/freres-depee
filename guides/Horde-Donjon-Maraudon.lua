if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde de Maraudon (Désolace), toutes classes, en groupe.
-- Givers : Uthel'nay (Orgrimmar), Olana Sabot-Brillant (Thunder Bluff, Mulgore 32.6,24.2),
-- Vark Battlescar et Selendra (village de Shadowprey), Paria centaure (sud de la Désolace),
-- Saule (centre-est de la Désolace), Cavindra (entrée de Maraudon), Celebras le Racheté et
-- l'Esprit de Zaetar (instance).
-- Itinéraire : Orgrimmar -> Thunder Bluff -> Shadowprey -> Paria -> Saule -> grottes
-- extérieures (Prophète sans nom, Kolk, Gelk, Magra, Ombréclats, bassin orange) -> aile
-- violette -> aile orange -> Maraudon intérieur (Celebras, Theradras) -> Saule -> Paria ->
-- Shadowprey -> Thunder Bluff -> Orgrimmar -> Reflet-de-Lune (Graine de vie).
-- Gravures théradriques (7028) : 15 chacun, 20-44 % sur 8 des 32 mobs (vignes, dryades,
-- pétriers), moins de 20 % sur les autres et les boss : ~70 à 150 kills en duo, couverts par un
-- passage complet de l'instance.
-- Fragments d'Ombréclat (7068) : 75 % (wowheadData), ~27 kills en duo, quête niveau 42
-- (XP pleine jusqu'au niveau 47), gardée parce que la route passe par Orgrimmar.
-- La radiance d'An'she (96776) : quête Forever sans XP connue, objet sans emplacement dans
-- QuestieDB, gardée parce que la route passe par Thunder Bluff.
-- Coupées :
--   93404 Pourriture et regret (après 93594 du guide Shen'dralas : XP inconnue, la chaîne
--   voisine donne 360-390 xp, objet sans emplacement, deux allers-retours dans Shen'dralas),
--   93601, 93604 et 93606 (suites de 93404, Souilles de Tranchebauge),
--   7041 La corruption de Vylelangue, 7065 Corruption de la terre et de la graine, 7070
--   Fragments d'Ombréclat (versions Alliance),
--   8635 L'Ancien Splitrock (Fête lunaire, saisonnière, rendu dans Maraudon).
--   Pas de quête de réputation gelkis ou magram propre à Maraudon dans QuestieDB.
--   Les autres quêtes liées à Maraudon (555, 4201, 8410, 8582...) ne demandent qu'un
--   composant d'artisanat qui y tombe aussi : hors sujet.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua. Dans
-- l'instance, QuestieDB n'a pas de coordonnées : ordre des ailes décrit dans le texte.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 45-51 Maraudon
#displayname [FDP] Maraudon (45-51)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Orgrimmar et Thunder Bluff =====
step
    .goto Orgrimmar,39.16,86.27
    >>Parle à |cRXP_FRIENDLY_Uthel'nay|r dans la Vallée des Esprits à Orgrimmar
    .accept 7068 >>Accepte Fragments d'Ombréclat
    .target 7311
step
    #completewith Olana
    .fly Thunder Bluff >>Vole vers Thunder Bluff
    .zoneskip Thunder Bluff
step
    #label Olana
    .goto Mulgore,32.63,24.20
    >>Parle à |cRXP_FRIENDLY_Olana Sabot-Brillant|r à Thunder Bluff
    .accept 96776 >>Accepte La radiance d’An’she
    .target 268557

-- ===== Désolace : Shadowprey, le Paria, Saule =====
step
    #completewith Vark
    .fly Shadowprey Village >>Vole vers le village de Shadowprey, en Désolace
    .zoneskip Desolace
step
    #label Vark
    .goto Desolace,23.22,70.33
    >>Parle à |cRXP_FRIENDLY_Vark Battlescar|r. Il te donne la |cRXP_LOOT_Fiole céruléenne renforcée|r
    .accept 7029 >>Accepte La corruption de Vylelangue
    .target 11823
step
    .goto Desolace,26.87,77.67
    >>Parle à |cRXP_FRIENDLY_Selendra|r, au sud du village
    .accept 7064 >>Accepte Corruption de la terre et de la graine
    .target 13699
step
    .goto Desolace,50.42,86.65
    >>Va à l'est voir le |cRXP_FRIENDLY_Paria centaure|r, au sud de la Désolace. Lis les |cRXP_LOOT_Instructions du Paria|r qu'il te donne
    .accept 7067 >>Accepte Les instructions du paria
    .target 13717
step
    .goto Desolace,62.20,39.63
    >>Monte vers le nord-est et parle à |cRXP_FRIENDLY_Saule|r
    .accept 7028 >>Accepte Forces maléfiques retorses
    .target 13656
step
    .goto Desolace,31.90,63.80
    >>Va à l'ouest jusqu'à Maraudon et parle à |cRXP_FRIENDLY_Cavindra|r, à l'entrée des grottes
    .accept 7044 >>Accepte Légendes de Maraudon
    .target 13697

-- ===== Grottes extérieures (Désolace) =====
step
    #sticky
    >>Pendant tout le donjon, ramasse les |cRXP_LOOT_Gravures de cristal théradriques|r sur les mobs. Les |cRXP_ENEMY_Dryades de Celebrian|r, les |cRXP_ENEMY_Engeances de Noxxious|r et le |cRXP_ENEMY_Prophète sans nom|r en lâchent le plus
    >>|cRXP_WARN_Farm long en duo (~120 kills) : chacun doit looter ses objets. Un passage complet de l'instance suffit en général|r
    .complete 7028,1 --Gravure de cristal théradrique (15)
    .isOnQuest 7028
step
    .goto Desolace,28.15,62.39
    >>Dans les grottes, tue le |cRXP_ENEMY_Prophète sans nom|r (élite, il erre près de l'entrée) pour l'|cRXP_LOOT_Amulette des esprits|r
    .collect 17757,1,7067 --Amulette des esprits
    .mob 13718
    .isOnQuest 7067
step
    .goto Desolace,29.66,60.48
    >>Tue l'esprit de |cRXP_ENEMY_Kolk|r (élite) pour la |cRXP_LOOT_Gemme du premier khan|r
    .collect 17761,1,7067 --Gemme du premier khan
    .mob 12240
    .isOnQuest 7067
step
    .goto Desolace,29.43,56.93
    >>Plus au nord, tue l'esprit de |cRXP_ENEMY_Gelk|r (élite) pour la |cRXP_LOOT_Gemme du deuxième khan|r
    .collect 17762,1,7067 --Gemme du deuxième khan
    .mob 12239
    .isOnQuest 7067
step
    .goto Desolace,27.50,55.50
    >>Au nord-ouest des grottes, tue les |cRXP_ENEMY_Grondeurs Ombréclat|r et les |cRXP_ENEMY_Fracasseurs Ombréclat|r (élites) pour les |cRXP_LOOT_Fragments d'Ombréclat|r
    .complete 7068,1 --Fragment Ombréclat (10)
    .mob 11777
    .mob 11778
    .isOnQuest 7068
step
    .goto Desolace,35.79,60.43
    >>Va à l'est des grottes et tue l'esprit de |cRXP_ENEMY_Magra|r (élite) pour la |cRXP_LOOT_Gemme du troisième khan|r
    .collect 17763,1,7067 --Gemme du troisième khan
    .mob 12241
    .isOnQuest 7067
step
    .goto Desolace,33.22,65.67
    >>Utilise la |cRXP_LOOT_Fiole céruléenne renforcée|r au |cRXP_PICK_Bassin de cristal orange de Maraudon|r pour la remplir
    .collect 17696,1,7029 --Fiole céruléenne remplie
    .use 17693
    .isOnQuest 7029

-- ===== Instance : aile violette, aile orange =====
step
    #sticky
    >>Ramasse la |cRXP_LOOT_Radiance d'An'she|r sur un |cRXP_PICK_Tesson de Lumière pure|r. |cRXP_WARN_Son emplacement n'est pas dans QuestieDB : ouvre l'oeil dans tout le donjon|r
    .complete 96776,1 --Radiance d'An'she
    .isOnQuest 96776
step
    >>Entre dans l'aile violette (portail violet). Utilise la |cRXP_LOOT_Fiole céruléenne remplie|r sur les |cRXP_PICK_Lianes|r (Vylestem Vine) et tue les |cRXP_ENEMY_Engeances de Noxxious|r qui en sortent
    .complete 7029,1 --Lianes soignées (8)
    .use 17696
    .mob 13696
    .isOnQuest 7029
step
    >>Dans l'aile violette, tue l'|cRXP_ENEMY_Esprit de Veng|r pour la |cRXP_LOOT_Gemme du cinquième khan|r
    .collect 17765,1,7067 --Gemme du cinquième khan
    .mob 12243
    .isOnQuest 7067
step
    >>Tue le |cRXP_ENEMY_Seigneur Vylelangue|r, boss de l'aile violette, pour le |cRXP_LOOT_Diamant de Celebras|r
    .complete 7044,1 --Diamant de Celebras
    .mob 12236
    .isOnQuest 7044
step
    >>Ressors et entre dans l'aile orange (portail orange). Tue l'|cRXP_ENEMY_Esprit de Maraudos|r pour la |cRXP_LOOT_Gemme du quatrième khan|r
    .collect 17764,1,7067 --Gemme du quatrième khan
    .mob 12242
    .isOnQuest 7067
step
    >>Tue |cRXP_ENEMY_Noxxion|r, boss de l'aile orange, pour le |cRXP_LOOT_Bâtonnet de Celebras|r. |cRXP_WARN_Environ 34 % : il faudra peut-être un second passage|r
    .complete 7044,2 --Bâtonnet de Celebras
    .mob 13282
    .isOnQuest 7044
step
    >>Utilise l'|cRXP_LOOT_Amulette des esprits|r avec les cinq gemmes pour former l'|cRXP_LOOT_Amulette d'union|r. |cRXP_WARN_Combinaison non vérifiée en jeu|r
    .complete 7067,1 --Amulette d'union
    .use 17757
    .isOnQuest 7067

-- ===== Instance : Maraudon intérieur =====
step
    >>Passe dans Maraudon intérieur et tue |cRXP_ENEMY_Celebras le Maudit|r, puis parle à |cRXP_FRIENDLY_Celebras le Racheté|r qui apparaît
    .turnin 7044 >>Rends Légendes de Maraudon
    .accept 7046 >>Accepte Le sceptre de Celebras
    .mob 12225
    .target 13716
    .isQuestComplete 7044
step
    >>Reste près de |cRXP_FRIENDLY_Celebras le Racheté|r pendant qu'il forge le sceptre et protège-le, puis parle-lui
    .complete 7046,1 --Incantation de Celebras
    .turnin 7046 >>Rends Le sceptre de Celebras
    .timer 60,Rituel de Celebras
    .target 13716
    .isOnQuest 7046
step
    #label Theradras
    >>Descends aux chutes de Chanteterre et tue la |cRXP_ENEMY_Princesse Theradras|r, dernier boss (après Glissement de terrain, l'artisan Gizlock et Grippe-charogne)
    .complete 7064,1 --Princesse Theradras
    .mob 12201
    .isOnQuest 7064
step
    >>Parle à l'|cRXP_FRIENDLY_Esprit de Zaetar|r qui apparaît après la mort de Theradras. Il te donne la |cRXP_LOOT_Graine de vie|r
    .accept 7066 >>Accepte Graine de vie
    .target 12238
-- ===== Rendus : Désolace =====
step
    .goto Desolace,62.20,39.63
    >>Sors de l'instance et retourne voir |cRXP_FRIENDLY_Saule|r au centre-est de la Désolace
    .turnin 7028 >>Rends Forces maléfiques retorses
    .target 13656
    .isOnQuest 7028
step
    .goto Desolace,50.42,86.65
    >>Va voir le |cRXP_FRIENDLY_Paria centaure|r au sud
    .turnin 7067 >>Rends Les instructions du paria
    .target 13717
    .isOnQuest 7067
step
    .goto Desolace,26.87,77.67
    >>Retourne voir |cRXP_FRIENDLY_Selendra|r près de Shadowprey
    .turnin 7064 >>Rends Corruption de la terre et de la graine
    .target 13699
    .isOnQuest 7064
step
    .goto Desolace,23.22,70.33
    >>Parle à |cRXP_FRIENDLY_Vark Battlescar|r au village de Shadowprey
    .turnin 7029 >>Rends La corruption de Vylelangue
    .target 11823
    .isOnQuest 7029

-- ===== Rendus : villes, puis Reflet-de-Lune =====
step
    .goto Mulgore,32.63,24.20
    >>Vole vers Thunder Bluff et parle à |cRXP_FRIENDLY_Olana Sabot-Brillant|r
    .turnin 96776 >>Rends La radiance d’An’she
    .target 268557
    .isOnQuest 96776
step
    .goto Orgrimmar,39.16,86.27
    >>Vole vers Orgrimmar et parle à |cRXP_FRIENDLY_Uthel'nay|r dans la Vallée des Esprits
    .turnin 7068 >>Rends Fragments d'Ombréclat
    .target 7311
    .isOnQuest 7068
step
    #label FinMaraudon
    .goto Moonglade,36.18,41.79
    >>Va à Reflet-de-Lune et donne la |cRXP_LOOT_Graine de vie|r au |cRXP_FRIENDLY_Gardien Remulos|r. |cRXP_WARN_Vol si tu as le point de vol de Reflet-de-Lune (ou téléportation druide), sinon depuis Bloodvenom Post (Gangrebois) par le repaire des Grumegueules (trajet non vérifié)|r
    .turnin 7066 >>Rends Graine de vie
    .target 11832
    .isOnQuest 7066
]])

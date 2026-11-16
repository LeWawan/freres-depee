if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde d'Uldaman (nord des Terres ingrates), toutes classes.
-- Givers : Patrick Garrett (Undercity), Dran Droffers (Orgrimmar), Jarkal Mossmeld
-- (Kargath), Theldurin l'Egaré (sud des Terres ingrates), Disques de Norgannon (instance).
-- Chaîne du collier (2283 -> 2341, ~17 000 xp) : trois passages, car le paladin, la
-- traduction à Kargath et les gemmes se suivent. Chaque partie est protégée par .isOnQuest.
-- Protégée : 2202 Rechercher les composants à Uldaman (après 2258, quête des Terres ingrates).
-- Coupée : 2418 Les pierres de puissance (8 + 8 pierres à ~15 %, ~210 kills en duo).
-- Les Disques de platine (2278, niveau 47) se prennent dès le niveau 40.
-- Mage : chaîne céleste de Tabetha (1953-1958) ; seule la Source d'énergie en obsidienne
-- (1956) est dans Uldaman, l'Orbe infernal (1954) tombe en Désolace.
-- Données : QuestieDB Forever (tools/questiedb.py). Dans l'instance, QuestieDB n'a pas de
-- coordonnées : ordre des salles décrit dans le texte.

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 37-44 Uldaman
#displayname [FDP] Uldaman (37-44)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Undercity et Orgrimmar =====
step
    .goto Undercity,62.32,48.61
    >>Parle à |cRXP_FRIENDLY_Patrick Garrett|r, dans le Quartier des voleurs à Undercity
    .accept 2342 >>Accepte Des Trésors à recouvrer
    .target 5651
step << Mage
    .goto Undercity,85.14,10.03
    >>Parle à |cRXP_FRIENDLY_Anastasia Hartwell|r, maître des mages (ou Deino à Orgrimmar, Ursyn Ghull à Thunder Bluff)
    .accept 1953 >>Accepte Retourner dans le Marais
    .target 4568
    .xp <35,1
step
    .goto Orgrimmar,59.49,36.57
    >>Parle à |cRXP_FRIENDLY_Dran Droffers|r dans la Vallée de l'Honneur à Orgrimmar
    .accept 2283 >>Accepte Réparer le Collier
    .target 6986
    .xp <37,1

-- ===== Mage : Tabetha et l'Orbe infernal =====
step << Mage
    .goto Dustwallow Marsh,46.06,57.09
    >>Va voir |cRXP_FRIENDLY_Tabetha|r au Marécage d'Âprefange
    .turnin 1953 >>Rends Retourner dans le Marais
    .accept 1954 >>Accepte L'orbe infernal
    .target 6546
    .xp <35,1
step << Mage
    .goto Desolace,80.30,76.98
    >>Va en Désolace et tue les |cRXP_ENEMY_Invocateurs de la Lame ardente|r pour l'|cRXP_LOOT_Orbe infernal|r
    .complete 1954,1 --Orbe infernal
    .mob 4668
    .isOnQuest 1954
step << Mage
    .goto Dustwallow Marsh,46.06,57.09
    >>Retourne voir |cRXP_FRIENDLY_Tabetha|r
    .turnin 1954 >>Rends L'orbe infernal
    .accept 1955 >>Accepte L'Exorcisme
    .target 6546
    .isQuestComplete 1954
step << Mage
    .goto Dustwallow Marsh,45.79,56.97
    >>Tue le |cRXP_ENEMY_Démon de l'Orbe|r qui apparaît à côté de Tabetha, puis parle-lui
    .complete 1955,1 --Démon de l'Orbe
    .mob 6549
    .isOnQuest 1955
step << Mage
    .goto Dustwallow Marsh,46.06,57.09
    >>Parle à |cRXP_FRIENDLY_Tabetha|r
    .turnin 1955 >>Rends L'Exorcisme
    .accept 1956 >>Accepte L'Energie d'Uldaman
    .target 6546
    .isQuestComplete 1955

-- ===== Terres ingrates : Kargath et Theldurin =====
step
    #completewith Jarkal
    .goto Badlands,2.42,46.06,40 >>Va à Kargath, à l'ouest des Terres ingrates
step
    #label Jarkal
    .goto Badlands,2.42,46.06
    >>Parle à |cRXP_FRIENDLY_Jarkal Mossmeld|r
    .accept 2202 >>Accepte Rechercher les composants à Uldaman
    .target 6868
    .isQuestTurnedIn 2258
step
    .goto Badlands,51.39,76.87
    >>Va voir |cRXP_FRIENDLY_Theldurin l'Egaré|r, au sud des Terres ingrates
    .accept 709 >>Accepte La solution à la malédiction
    .target 2785

-- ===== Uldaman : premier passage =====
step
    #sticky
    >>Tue les nains |cRXP_ENEMY_Ombreforge|r et les troggs |cRXP_ENEMY_Cavepierre|r pour le |cRXP_LOOT_Collier brisé|r
    .complete 2283,1 --Collier brisé
    .mob 4844
    .mob 4845
    .mob 4846
    .mob 4851
    .mob 4852
    .mob 4856
    .isOnQuest 2283
step
    #sticky
    >>Ramasse les |cRXP_PICK_Champignons magenta|r dans l'instance
    .complete 2202,1 --Champignon magenta (12)
    .isOnQuest 2202
step
    #label EntreeUlda
    .goto Badlands,44.60,12.10,20 >>Va au site de fouilles d'Uldaman, au nord des Terres ingrates, et entre dans l'instance
step
    >>Ouvre le |cRXP_PICK_Coffre ancien|r dans la zone des troggs pour la |cRXP_LOOT_Tablette de Ryun'eh|r
    .complete 709,1 --Tablette de Ryun'eh
step
    >>Ouvre le |cRXP_PICK_Coffre de la famille Garrett|r dans la Salle commune sud
    .complete 2342,1 --Trésor de la famille Garrett
step
    >>Parle aux |cRXP_FRIENDLY_Restes d'un paladin|r
    .turnin 2284 >>Rends Réparer le Collier, deuxième prise
    .accept 2318 >>Accepte La Traduction du Journal
    .target 6912
    .isOnQuest 2284
step
    >>Gemmes du collier : le |cRXP_LOOT_Rubis|r dans la |cRXP_PICK_Cachette d'Ombreforge|r (zone barricadée des Ombreforge), la |cRXP_LOOT_Topaze|r dans l'|cRXP_PICK_Urne ostentatoire|r (zone des troggs, près des nains de l'Alliance), le |cRXP_LOOT_Saphir|r sur |cRXP_ENEMY_Grimlok|r
    .complete 2339,1 --Rubis de collier brisé
    .complete 2339,2 --Saphir de collier brisé
    .complete 2339,3 --Topaze de collier brisé
    .mob 4854
    .isOnQuest 2339
step << Mage
    >>Tue la |cRXP_ENEMY_Sentinelle d'obsidienne|r et ramasse la |cRXP_LOOT_Source d'énergie en obsidienne|r
    .complete 1956,1 --Source d'énergie en obsidienne
    .mob 7023
    .isOnQuest 1956
step
    >>Avant Archaedas, parle au |cRXP_FRIENDLY_Gardien du savoir de Norgannon|r, puis active |cRXP_PICK_Les Disques de Norgannon|r
    .accept 2278 >>Accepte Les Disques de platine
    .complete 2278,1 --Gardien du savoir de Norgannon
    .turnin 2278 >>Rends Les Disques de platine
    .accept 2280 >>Accepte Les Disques de platine
    .xp <40,1
step
    >>Tue |cRXP_ENEMY_Archaedas|r, dernier boss, si tu as la quête des gemmes : il porte la |cRXP_LOOT_Source d'énergie du collier brisé|r
    .complete 2339,4 --Source d'énergie du collier brisé
    .mob 2748
    .isOnQuest 2339
step
    >>Finis les |cRXP_PICK_Champignons magenta|r avant de sortir
    .complete 2202,1 --Champignon magenta (12)
    .isOnQuest 2202

-- ===== Rendus : Terres ingrates =====
step
    .goto Badlands,51.39,76.87
    >>Retourne voir |cRXP_FRIENDLY_Theldurin l'Egaré|r
    .turnin 709 >>Rends La solution à la malédiction
    .target 2785
step
    .goto Badlands,2.42,46.06
    >>Parle à |cRXP_FRIENDLY_Jarkal Mossmeld|r à Kargath
    .turnin 2202 >>Rends Rechercher les composants à Uldaman
    .target 6868
    .isOnQuest 2202
step
    .goto Badlands,2.42,46.06
    >>Parle à |cRXP_FRIENDLY_Jarkal Mossmeld|r et laisse-lui le collier : il traduit le journal
    .turnin 2318 >>Rends La Traduction du Journal
    .accept 2338 >>Accepte La Traduction du Journal
    .turnin 2338 >>Rends La Traduction du Journal
    .accept 2339 >>Accepte Trouver les Gemmes et la Source d'énergie
    .target 6868
    .isOnQuest 2318
step
    .goto Badlands,2.42,46.06
    >>Parle à |cRXP_FRIENDLY_Jarkal Mossmeld|r
    .turnin 2339 >>Rends Trouver les Gemmes et la Source d'énergie
    .accept 2340 >>Accepte Livrer les Gemmes
    .target 6868
    .isQuestComplete 2339

-- ===== Rendus : villes =====
step
    .goto Orgrimmar,59.49,36.57
    >>Parle à |cRXP_FRIENDLY_Dran Droffers|r à Orgrimmar
    .turnin 2283 >>Rends Réparer le Collier
    .accept 2284 >>Accepte Réparer le Collier, deuxième prise
    .target 6986
    .isQuestComplete 2283
step
    .goto Orgrimmar,59.49,36.57
    >>Parle à |cRXP_FRIENDLY_Dran Droffers|r
    .turnin 2340 >>Rends Livrer les Gemmes
    .accept 2341 >>Accepte Réparer le collier, troisième prise
    .target 6986
    .isOnQuest 2340
step
    .goto Thunder Bluff,34.40,46.87
    >>Parle au |cRXP_FRIENDLY_Sage Truthseeker|r à Thunder Bluff
    .turnin 2280 >>Rends Les Disques de platine
    .accept 2440 >>Accepte Les Disques de platine
    .target 3978
    .isOnQuest 2280
step
    .goto Thunder Bluff,46.62,33.17
    >>Parle à |cRXP_FRIENDLY_Bena Winterhoof|r
    .turnin 2440 >>Rends Les Disques de platine
    .target 3009
    .isOnQuest 2440
step
    .goto Undercity,62.32,48.61
    >>Parle à |cRXP_FRIENDLY_Patrick Garrett|r à Undercity
    .turnin 2342 >>Rends Des Trésors à recouvrer
    .target 5651

-- ===== Mage : fin de la chaîne céleste =====
step << Mage
    .goto Dustwallow Marsh,46.06,57.09
    >>Retourne voir |cRXP_FRIENDLY_Tabetha|r au Marécage d'Âprefange
    .turnin 1956 >>Rends L'Energie d'Uldaman
    .accept 1957 >>Accepte Les éruptions de mana
    .target 6546
    .isQuestComplete 1956
step << Mage
    .goto Dustwallow Marsh,45.83,56.94
    >>Tue 12 |cRXP_ENEMY_Eruptions de mana|r autour de Tabetha avant la fin du temps imparti
    .complete 1957,1 --Eruption de mana (12)
    .mob 6550
    .isOnQuest 1957
step << Mage
    .goto Dustwallow Marsh,46.06,57.09
    >>Parle à |cRXP_FRIENDLY_Tabetha|r
    .turnin 1957 >>Rends Les éruptions de mana
    .accept 1958 >>Accepte L'Energie céleste
    .turnin 1958 >>Rends L'Energie céleste
    .target 6546
    .isQuestComplete 1957

-- ===== Collier : deuxième passage (paladin) et troisième (gemmes) =====
step
    >>Retourne dans Uldaman et parle aux |cRXP_FRIENDLY_Restes d'un paladin|r
    .turnin 2284 >>Rends Réparer le Collier, deuxième prise
    .accept 2318 >>Accepte La Traduction du Journal
    .target 6912
    .isOnQuest 2284
step
    .goto Badlands,2.42,46.06
    >>Parle à |cRXP_FRIENDLY_Jarkal Mossmeld|r à Kargath et laisse-lui le collier
    .turnin 2318 >>Rends La Traduction du Journal
    .accept 2338 >>Accepte La Traduction du Journal
    .turnin 2338 >>Rends La Traduction du Journal
    .accept 2339 >>Accepte Trouver les Gemmes et la Source d'énergie
    .target 6868
    .isOnQuest 2318
step
    >>Retourne dans Uldaman. |cRXP_LOOT_Rubis|r dans la |cRXP_PICK_Cachette d'Ombreforge|r, |cRXP_LOOT_Topaze|r dans l'|cRXP_PICK_Urne ostentatoire|r, |cRXP_LOOT_Saphir|r sur |cRXP_ENEMY_Grimlok|r, |cRXP_LOOT_Source d'énergie|r sur |cRXP_ENEMY_Archaedas|r
    .complete 2339,1 --Rubis de collier brisé
    .complete 2339,2 --Saphir de collier brisé
    .complete 2339,3 --Topaze de collier brisé
    .complete 2339,4 --Source d'énergie du collier brisé
    .mob 4854
    .mob 2748
    .isOnQuest 2339
step
    .goto Badlands,2.42,46.06
    >>Parle à |cRXP_FRIENDLY_Jarkal Mossmeld|r à Kargath
    .turnin 2339 >>Rends Trouver les Gemmes et la Source d'énergie
    .accept 2340 >>Accepte Livrer les Gemmes
    .target 6868
    .isQuestComplete 2339
step
    .goto Orgrimmar,59.49,36.57
    >>Parle à |cRXP_FRIENDLY_Dran Droffers|r à Orgrimmar
    .turnin 2340 >>Rends Livrer les Gemmes
    .accept 2341 >>Accepte Réparer le collier, troisième prise
    .target 6986
    .isOnQuest 2340
step
    #label FinUldaman
    .goto Badlands,2.42,46.06
    >>Retourne voir |cRXP_FRIENDLY_Jarkal Mossmeld|r à Kargath
    .turnin 2341 >>Rends Réparer le collier, troisième prise
    .target 6868
    .isOnQuest 2341
]])

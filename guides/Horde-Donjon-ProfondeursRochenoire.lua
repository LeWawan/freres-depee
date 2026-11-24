if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde des Profondeurs de Rochenoire (Mont Rochenoire), toutes classes.
-- Givers : Kargath (Thunderheart, Galamav, Goretooth, Lexlort, Vivian Lagrave, affiches),
-- Crête de la flamme (Maxwort Uberglint, Yuka Screwspigot), Cyrus Therepentous (est des
-- Steppes ardentes), Franclorn Forgewright (fantôme du Mont Rochenoire), Thrall (Orgrimmar),
-- Alaana Marchetempête (Mulgore), Gor'shak et Moira (instance).
-- Données : QuestieDB Forever (tools/questiedb.py), zones 1584 (quêtes), 25 (Mont Rochenoire)
-- et 1585 (PNJ de l'instance). XP de xpDB-classic.lua ; 97197 et 82062 absentes des deux
-- fichiers XP (XP inconnue). Dans l'instance, QuestieDB n'a pas de coordonnées : ordre des
-- salles décrit dans le texte. Noms français des salles non sourcés (nom anglais entre
-- parenthèses).
-- Les blacklists « Removed with cata » de Questie ne s'appliquent pas à Forever ; seule 7704
-- est vraiment blacklistée.
-- Taux de drop : les objets de boss (Souillefer 39 %, Tablette de Kurniya 9 %, Tête de Ribbly
-- 36 %, recette 12-23 % wowheadData, 100 % cmangosData) se lootent sur un seul kill par
-- passage pour qui a la quête : la règle des 40 kills ne s'applique pas. Clé du coffret à
-- relique 11078 ~12,7 % (wowheadData) sur les nains Ragenclume, objet normal partagé par le
-- groupe : ~95 kills de nains pour les 12 clés, faits pendant les passages.
-- Itinéraire en trois passages :
--   préparation : Kargath (pierre de foyer, prises) -> Crête de la flamme -> Cyrus ->
--   Franclorn et Pyron (Mont Rochenoire) -> foyer Kargath (suites de Pyron) ;
--   passage 1 : bloc de détention (Gerstahn, Gor'shak, Kharan, chambre forte), Anneau de la
--   Loi, Fineous, Incendius, Bael'Gar, monument de Franclorn, Grim Guzzler -> foyer Kargath ;
--   Orgrimmar (Thrall) et Mulgore (Alaana) ;
--   passage 2 : officiers Sombrefer, Lycée, Magmus, empereur Dagran Thaurissan -> Kargath ->
--   Steppes ardentes (rendus, escorte de Grark) -> Kargath ;
--   passage 3 : général Forgehargne -> Kargath -> Orgrimmar -> Mulgore (fin).
-- Protégées (prises ailleurs) : 4022 Un goût de flammes (.isQuestTurnedIn 3481, sinon 4023),
-- 4324 Yuka Screwspigot (.isOnQuest), 4133 Vivian Lagrave (.isOnQuest), 82062 Au-delà
-- (.isOnQuest, pas de donneur dans QuestieDB). Le Coeur de la montagne (4123) reste offert
-- par .isOnQuest tant qu'il est dans le journal.
-- Coupées :
--   4062/4063 La révolte des machines (rendu à Lotwil Veriatus à l'ouest des Terres ingrates ;
--   10 Noyaux d'élémentaire intacts à 2,8-6,2 % wowheadData, ~440 kills en duo, et les golems
--   de la Manufacture ne suffisent pas ; cmangosData donne 80 %, ~25 kills),
--   7201 Le dernier élément (10 Essences des éléments à 0,5-3 % wowheadData, ~800 kills en
--   duo ; 33 % cmangosData, encore 60 kills pour 5450 xp),
--   4133 Vivian Lagrave (envoi d'Undercity, 560 xp, détour ; rendu protégé),
--   4201 Le philtre d'amour (Sang-royal, Filons d'argent géant et fiole à remplir : récolte et
--   farm hors instance), 4083 Le Calice spectral (Minage 230), 4295 La bière de Rocknot
--   (répétable, pas d'XP), 7704 Regardez un peu la taille ! (blacklistée), 7604 Un contrat
--   astreignant (niveau 60), 9015 Le défi et la chaîne de Bodley 8960-8996 et 9032 (niveau 60,
--   Pic Rochenoire), 7848 Harmonisation avec le Coeur (Coeur du Magma, raid), 96075 (niveau 60,
--   Pic Rochenoire), quêtes Alliance : 4126, 4128, 4241, 4242, 4262, 4263, 4264, 4282, 4286,
--   4322, 4341, 4342, 4361, 4362, 4363.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 52-58 Blackrock Depths
#displayname [FDP] Profondeurs de Rochenoire (52-58)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Kargath : prises =====
step
    #completewith ArriveeKargath
    .goto Badlands,3.99,44.78,40 >>Va à Kargath, à l'ouest des Terres ingrates
step
    #label ArriveeKargath
    .goto Badlands,3.99,44.78
    >>Parle à |cRXP_FRIENDLY_Gorrik|r
    .fp Kargath >>Prends le point de vol de Kargath
    .target 2861
step
    .goto Badlands,2.82,45.86
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Shul'kar|r : chaque passage se termine par la pierre de foyer
    .home >>Fixe ta pierre de foyer à Kargath
    .target 9356
step
    .goto Badlands,3.33,48.26
    >>Parle à |cRXP_FRIENDLY_Thunderheart|r
    .accept 3906 >>Accepte Discordance des flammes
    .target 9084
step
    .goto Badlands,2.90,47.76
    >>Parle à l'|cRXP_FRIENDLY_Ombremage Vivian Lagrave|r
    .turnin 4133 >>Rends Vivian Lagrave
    .target 9078
    .isOnQuest 4133
step
    .goto Badlands,2.90,47.76
    >>Parle à l'|cRXP_FRIENDLY_Ombremage Vivian Lagrave|r
    .accept 4134 >>Accepte La recette perdue de Thunderbrew
    .target 9078
step
    .goto Badlands,3.74,47.43
    >>Lis l'|cRXP_PICK_affiche de recherche|r (WANTED) près du chef de guerre
    .accept 4081 >>Accepte TUER A VUE : nains Sombrefer

-- ===== Steppes ardentes : Crête de la flamme et Cyrus =====
step
    #completewith ArriveeCrete
    .goto Burning Steppes,65.69,24.22,40 >>Vole vers la Crête de la flamme, à l'est des Steppes ardentes
step
    #label ArriveeCrete
    .goto Burning Steppes,65.69,24.22
    >>Parle à |cRXP_FRIENDLY_Vahgruk|r
    .fp Flame Crest >>Prends le point de vol de la Crête de la flamme
    .target 13177
step
    .goto Burning Steppes,65.15,23.91
    >>Parle à |cRXP_FRIENDLY_Maxwort Uberglint|r
    .accept 4123 >>Accepte Le Coeur de la montagne
    .target 9536
step
    .goto Burning Steppes,66.06,21.95
    >>Parle à |cRXP_FRIENDLY_Yuka Screwspigot|r
    .turnin 4324 >>Rends Yuka Screwspigot
    .target 9544
    .isOnQuest 4324
step
    .goto Burning Steppes,66.06,21.95
    >>Parle à |cRXP_FRIENDLY_Yuka Screwspigot|r
    .accept 4136 >>Accepte Ribbly Screwspigot
    .target 9544
step
    #completewith Cyrus
    .goto Burning Steppes,95.09,31.56,40 >>Va voir |cRXP_FRIENDLY_Cyrus Therepentous|r, tout à l'est des Steppes ardentes
    .isQuestTurnedIn 3481
step
    #label Cyrus
    .goto Burning Steppes,95.09,31.56
    >>Parle à |cRXP_FRIENDLY_Cyrus Therepentous|r. |cRXP_WARN_Le Drake noir frénétique (élite) rôde à côté|r
    .accept 4022 >>Accepte Un goût de flammes
    .turnin 4022 >>Rends Un goût de flammes
    .accept 4024 >>Accepte Un goût de flammes
    .target 9459
    .isQuestTurnedIn 3481
step
    .goto Burning Steppes,95.09,31.56
    >>Parle à |cRXP_FRIENDLY_Cyrus Therepentous|r
    .accept 4024 >>Accepte Un goût de flammes
    .target 9459
    .isQuestTurnedIn 4023

-- ===== Mont Rochenoire : Franclorn et Pyron =====
step
    .goto Burning Steppes,28.96,28.93
    >>Entre dans le Mont Rochenoire par l'ouest des Steppes ardentes. |cRXP_FRIENDLY_Franclorn Forgewright|r est un fantôme sur la plateforme centrale, au-dessus de la lave
    >>|cRXP_WARN_Il faut être un fantôme pour le voir : chacun meurt dans la lave, libère son esprit et revient jusqu'à lui. Ressuscite ensuite à ton corps|r
    .accept 3801 >>Accepte Héritage Sombrefer
    .turnin 3801 >>Rends Héritage Sombrefer
    .accept 3802 >>Accepte Héritage Sombrefer
    .target 8888
step
    >>Descends par les chaînes jusqu'au portail des Profondeurs de Rochenoire et tue le |cRXP_ENEMY_Grand seigneur Pyron|r, dans la carrière juste devant le portail (élite 52, faisable en duo)
    .complete 3906,1 --Grand seigneur Pyron
    .mob 9026
step
    .hs >>Utilise ta pierre de foyer pour Kargath
step
    .goto Badlands,3.33,48.26
    >>Parle à |cRXP_FRIENDLY_Thunderheart|r |cRXP_WARN_Pas finie : refais une run des Profondeurs puis reviens, ou passe l'étape|r
    .turnin 3906 >>Rends Discordance des flammes
    .accept 3907 >>Accepte Discordance des flammes
    .target 9084
    .isOnQuest 3906
step
    .goto Badlands,5.96,47.73
    >>Parle à |cRXP_FRIENDLY_Galamav le Tireur d'élite|r
    .accept 3981 >>Accepte Le commandant Gor'shak
    .target 9081
    .isQuestTurnedIn 3906

-- ===== Profondeurs de Rochenoire : premier passage =====
step
    #completewith EntreeBRD1
    .goto Searing Gorge,34.84,30.87,40 >>Vole vers la Halte du Thorium (Gorge des Vents brûlants)
step
    #label EntreeBRD1
    .goto Searing Gorge,34.80,83.80,20 >>Va au sud jusqu'à l'entrée du Mont Rochenoire, descends jusqu'au portail et entre dans les Profondeurs de Rochenoire. |cRXP_WARN_Groupe de 5 conseillé|r
step
    #sticky
    >>Tue les nains |cRXP_ENEMY_Ragenclume|r pendant tout le passage
    .complete 4081,1 --Garde Ragenclume (15)
    .complete 4081,2 --Gardien Ragenclume (10)
    .complete 4081,3 --Fantassin Ragenclume (5)
    .mob 8891
    .mob 8890
    .mob 8892
    .isOnQuest 4081
step
    #sticky
    >>Garde les |cRXP_LOOT_Clés du coffret à relique|r des nains Ragenclume (~1 sur 8). Avec 12 clés, ouvre les 12 |cRXP_PICK_Coffrets à relique|r de la chambre forte (The Vault), près du bloc de détention : la |cRXP_ENEMY_Sentinelle Doomgrip|r et ses golems apparaissent. Tue-les puis ouvre le |cRXP_PICK_Coffre-fort secret|r
    >>|cRXP_WARN_~95 nains pour les 12 clés : souvent au deuxième passage|r
    .complete 4123,1 --Le Coeur de la montagne
    .mob 9476
    .isOnQuest 4123
step
    >>Dans le bloc de détention (Detention Block), tue le |cRXP_ENEMY_Grand Interrogateur Gerstahn|r pour la |cRXP_LOOT_Clé de la prison|r (un voleur peut crocheter), ouvre la cellule de |cRXP_FRIENDLY_Gor'shak|r et parle-lui
    .turnin 3981 >>Rends Le commandant Gor'shak
    .accept 3982 >>Accepte Que se passe-t-il ?
    .target 9020
    .mob 9018
    .isOnQuest 3981
step
    >>Défends |cRXP_FRIENDLY_Gor'shak|r contre les vagues de nains
    .complete 3982,1 --Défendre Gor'shak
    .isOnQuest 3982
step
    >>Parle à |cRXP_FRIENDLY_Gor'shak|r
    .turnin 3982 >>Rends Que se passe-t-il ?
    .accept 4001 >>Accepte Que se passe-t-il ?
    .target 9020
    .isQuestComplete 3982
step
    >>Ouvre la cellule voisine de |cRXP_FRIENDLY_Kharan Mighthammer|r et écoute son récit
    .complete 4001,1 --Kharan Mighthammer
    .target 9021
    .isOnQuest 4001
step
    +Va à l'Anneau de la Loi (Ring of Law) : le |cRXP_ENEMY_Juge Supérieur Grimstone|r lance des vagues puis un boss au hasard. Tue-les pour ouvrir la suite. Coche pour continuer
step
    >>Continue vers l'Enclume noire (Black Anvil) et tue |cRXP_ENEMY_Fineous Darkvire|r, qui patrouille devant la salle d'Incendius, pour |cRXP_LOOT_Souillefer|r
    .complete 3802,1 --Souillefer
    .mob 9056
    .isOnQuest 3802
step
    >>Tue le |cRXP_ENEMY_Seigneur Incendius|r sur l'Enclume noire et ramasse la |cRXP_LOOT_Tablette de Kurniya|r
    .complete 3907,1 --Seigneur Incendius
    .complete 3907,2 --Tablette de Kurniya
    .mob 9017
    .isOnQuest 3907
step
    >>Tue |cRXP_ENEMY_Bael'Gar|r, le géant de lave près de la Forge noire (Black Forge), puis utilise la |cRXP_LOOT_Cuir de dragon noir altéré|r sur son corps
    .complete 4024,1 --Essence féerique enchâssée
    .use 11231
    .mob 9016
    .isOnQuest 4024
step
    >>Retourne au-dessus de l'Anneau de la Loi et pose Souillefer sur le |cRXP_PICK_Monument de Franclorn Forgewright|r. Tu reçois la |cRXP_LOOT_Clé d'Ombreforge|r |cRXP_WARN_Pas finie : refais une run des Profondeurs puis reviens, ou passe l'étape|r
    .turnin 3802 >>Rends Héritage Sombrefer
    .isOnQuest 3802
step
    >>Dans la taverne du Grim Guzzler, casse les tonneaux de lager Thunderbrew pour faire venir |cRXP_ENEMY_Hurley Blackbreath|r et ses compères, puis ramasse la |cRXP_LOOT_Recette perdue de la Thunderbrew|r
    .complete 4134,1 --Recette perdue de la Thunderbrew
    .mob 9537
    .mob 9541
    .isOnQuest 4134
step
    >>Tue |cRXP_ENEMY_Ribbly Screwspigot|r au Grim Guzzler pour sa |cRXP_LOOT_Tête|r
    .complete 4136,1 --Tête de Ribbly
    .mob 9543
    .isOnQuest 4136
step
    #label FinBRD1
    .hs >>Sors et utilise ta pierre de foyer pour Kargath

-- ===== Kargath : rendus du premier passage =====
step
    .goto Badlands,3.33,48.26
    >>Parle à |cRXP_FRIENDLY_Thunderheart|r
    .turnin 3907 >>Rends Discordance des flammes
    .target 9084
    .isQuestComplete 3907
step
    .goto Badlands,2.90,47.76
    >>Parle à l'|cRXP_FRIENDLY_Ombremage Vivian Lagrave|r
    .turnin 4134 >>Rends La recette perdue de Thunderbrew
    .target 9078
    .isQuestComplete 4134
step
    .goto Badlands,5.81,47.52
    >>Parle au |cRXP_FRIENDLY_Chef de guerre Goretooth|r |cRXP_WARN_Pas finie : refais une run des Profondeurs puis reviens, ou passe l'étape|r
    .turnin 4081 >>Rends TUER A VUE : nains Sombrefer
    .target 9077
    .isOnQuest 4081
step
    .goto Badlands,3.94,46.73
    >>Lis l'affiche |cRXP_PICK_TUER A VUE|r
    .accept 4082 >>Accepte TUER A VUE : Officiers de haut rang Sombrefer
    .isQuestTurnedIn 4081

-- ===== Orgrimmar : Thrall, puis Mulgore : Alaana =====
step
    #completewith Thrall
    .goto Orgrimmar,31.73,37.82,40 >>Va à Orgrimmar : vol vers Undercity ou Grom'gol puis zeppelin. Thrall est dans la Vallée de la Sagesse
    .isOnQuest 4001
step
    #label Thrall
    .goto Orgrimmar,31.73,37.82
    >>Parle à |cRXP_FRIENDLY_Thrall|r
    .turnin 4001 >>Rends Que se passe-t-il ?
    .accept 4002 >>Accepte Les Royaumes de l'est
    .turnin 4002 >>Rends Les Royaumes de l'est
    .accept 4003 >>Accepte Un sauvetage royal
    .target 4949
    .isQuestComplete 4001
step
    #completewith Alaana
    .goto Mulgore,33.37,22.57,40 >>Vole vers Thunder Bluff et va voir |cRXP_FRIENDLY_Alaana Marchetempête|r au nord-ouest de Mulgore
    .isOnQuest 4003
step
    #label Alaana
    .goto Mulgore,33.37,22.57
    >>Parle à |cRXP_FRIENDLY_Alaana Marchetempête|r
    .accept 97197 >>Accepte Fragment des terres de Feu
    .target 259119
    .isOnQuest 4003

-- ===== Profondeurs de Rochenoire : deuxième passage =====
step
    #completewith EntreeBRD2
    .goto Searing Gorge,34.84,30.87,40 >>Retourne à la Halte du Thorium (zeppelin pour Undercity ou Grom'gol, puis vol)
step
    #label EntreeBRD2
    .goto Searing Gorge,34.80,83.80,20 >>Entre à nouveau dans les Profondeurs de Rochenoire. |cRXP_WARN_Groupe de 5 conseillé|r
step
    #sticky
    >>Tue les |cRXP_ENEMY_Médecins|r, |cRXP_ENEMY_Soldats|r et |cRXP_ENEMY_Officiers Ragenclume|r après l'Anneau de la Loi, sur la route d'Ombreforge
    .complete 4082,1 --Médecin Ragenclume (10)
    .complete 4082,2 --Soldat Ragenclume (10)
    .complete 4082,3 --Officier Ragenclume (10)
    .mob 8894
    .mob 8893
    .mob 8895
    .isOnQuest 4082
step
    >>Si tu ne l'as pas eu au premier passage : |cRXP_ENEMY_Seigneur Incendius|r et la |cRXP_LOOT_Tablette de Kurniya|r
    .complete 3907,1 --Seigneur Incendius
    .complete 3907,2 --Tablette de Kurniya
    .mob 9017
    .isOnQuest 3907
step
    >>Si tu ne l'as pas eue : tue |cRXP_ENEMY_Bael'Gar|r et utilise la |cRXP_LOOT_Cuir de dragon noir altéré|r sur son corps
    .complete 4024,1 --Essence féerique enchâssée
    .use 11231
    .mob 9016
    .isOnQuest 4024
step
    >>Si elle manque encore : |cRXP_LOOT_Recette perdue de la Thunderbrew|r sur |cRXP_ENEMY_Hurley Blackbreath|r au Grim Guzzler
    .complete 4134,1 --Recette perdue de la Thunderbrew
    .mob 9537
    .mob 9541
    .isOnQuest 4134
step
    >>Si elle manque encore : |cRXP_LOOT_Tête de Ribbly|r au Grim Guzzler
    .complete 4136,1 --Tête de Ribbly
    .mob 9543
    .isOnQuest 4136
step
    >>Ouvre la serrure d'Ombreforge avec la clé, passe le Grim Guzzler et allume les deux braseros du Lycée (Lyceum). Tue |cRXP_ENEMY_Magmus|r devant la salle du trône pour le |cRXP_LOOT_Fragment des terres de Feu|r
    .complete 97197,1 --Fragment des terres de Feu
    .mob 9938
    .isOnQuest 97197
step
    >>Tue l'|cRXP_ENEMY_Empereur Dagran Thaurissan|r. |cRXP_WARN_Ne tue pas la Princesse Moira, même si elle soigne l'empereur : il faut lui parler ensuite|r
    .complete 4003,1 --Empereur Dagran Thaurissan
    .mob 9019
    .isOnQuest 4003
step
    >>Parle à la |cRXP_FRIENDLY_Princesse Moira Bronzebeard|r
    .turnin 4003 >>Rends Un sauvetage royal
    .accept 4004 >>Accepte La Princesse sauvée ?
    .target 8929
    .isQuestComplete 4003
step
    #label FinBRD2
    .hs >>Sors et utilise ta pierre de foyer pour Kargath

-- ===== Kargath : rendus du deuxième passage =====
step
    .goto Badlands,3.33,48.26
    >>Parle à |cRXP_FRIENDLY_Thunderheart|r
    .turnin 3907 >>Rends Discordance des flammes
    .target 9084
    .isQuestComplete 3907
step
    .goto Badlands,2.90,47.76
    >>Parle à l'|cRXP_FRIENDLY_Ombremage Vivian Lagrave|r
    .turnin 4134 >>Rends La recette perdue de Thunderbrew
    .target 9078
    .isQuestComplete 4134
step
    .goto Badlands,5.81,47.52
    >>Parle au |cRXP_FRIENDLY_Chef de guerre Goretooth|r |cRXP_WARN_Pas finie : refais une run des Profondeurs puis reviens, ou passe l'étape|r
    .turnin 4082 >>Rends TUER A VUE : Officiers de haut rang Sombrefer
    .target 9077
    .isOnQuest 4082
step
    .goto Badlands,5.88,47.63
    >>Parle à |cRXP_FRIENDLY_Lexlort|r : il te donne les |cRXP_LOOT_Chaînes en thorium|r
    .accept 4122 >>Accepte Grark Lorkrub
    .target 9080
    .isQuestTurnedIn 4082

-- ===== Steppes ardentes : rendus et Grark =====
step
    #completewith RenduCrete
    .goto Burning Steppes,65.69,24.22,40 >>Vole vers la Crête de la flamme
step
    #label RenduCrete
    .goto Burning Steppes,65.15,23.91
    >>Parle à |cRXP_FRIENDLY_Maxwort Uberglint|r. |cRXP_WARN_Coeur pas trouvé : refais la chambre forte au passage suivant, puis reviens|r
    .turnin 4123 >>Rends Le Coeur de la montagne
    .target 9536
    .isOnQuest 4123
step
    .goto Burning Steppes,66.06,21.95
    >>Parle à |cRXP_FRIENDLY_Yuka Screwspigot|r |cRXP_WARN_Pas finie : refais une run des Profondeurs puis reviens, ou passe l'étape|r
    .turnin 4136 >>Rends Ribbly Screwspigot
    .target 9544
    .isOnQuest 4136
step
    #completewith RenduCyrus
    .goto Burning Steppes,95.09,31.56,40 >>Va voir |cRXP_FRIENDLY_Cyrus Therepentous|r, tout à l'est
    .isQuestComplete 4024
step
    #label RenduCyrus
    .goto Burning Steppes,95.09,31.56
    >>Parle à |cRXP_FRIENDLY_Cyrus Therepentous|r |cRXP_WARN_Pas finie : refais une run des Profondeurs puis reviens, ou passe l'étape|r
    .turnin 4024 >>Rends Un goût de flammes
    .target 9459
    .isOnQuest 4024
step
    .goto Burning Steppes,40.20,34.24
    >>Monte dans le Rocher Noir (Blackrock Stronghold) jusqu'à |cRXP_FRIENDLY_Grark Lorkrub|r, utilise les |cRXP_LOOT_Chaînes en thorium|r sur lui puis parle-lui
    >>|cRXP_WARN_Orcs élites niveau 55 à 58 partout : à faire avec le groupe du donjon|r
    .use 11286
    .turnin 4122 >>Rends Grark Lorkrub
    .accept 4121 >>Accepte Situation précaire
    .target 9520
    .isOnQuest 4122
step
    .goto Burning Steppes,25.73,27.10
    >>Escorte |cRXP_FRIENDLY_Grark Lorkrub|r hors de la forteresse vers le Mont Rochenoire. Tue ce qui l'attaque. |cRXP_WARN_Point d'arrivée de QuestieDB, non vérifié en jeu|r
    .complete 4121,1 --Situation précaire
    .isOnQuest 4121
step
    .goto Burning Steppes,35.80,19.80
    >>Parle au |cRXP_FRIENDLY_Voyageur robuste|r (Rugged Traveler)
    .turnin 82062 >>Rends Au-delà
    .target 222530
    .isOnQuest 82062

-- ===== Kargath : Grark et Forgehargne =====
step
    #completewith RenduLexlort
    .goto Badlands,5.88,47.63,40 >>Retourne à Kargath (par le Mont Rochenoire et la Halte du Thorium, ou vol depuis la Crête de la flamme)
    .isOnQuest 4121
step
    #label RenduLexlort
    .goto Badlands,5.88,47.63
    >>Parle à |cRXP_FRIENDLY_Lexlort|r
    .turnin 4121 >>Rends Situation précaire
    .target 9080
    .isQuestComplete 4121
step
    .goto Badlands,5.81,47.52
    >>Parle au |cRXP_FRIENDLY_Chef de guerre Goretooth|r
    .accept 4132 >>Accepte Opération : Mort à Forgehargne
    .target 9077
    .isQuestTurnedIn 4121

-- ===== Profondeurs de Rochenoire : troisième passage =====
step
    #completewith EntreeBRD3
    .goto Searing Gorge,34.84,30.87,40 >>Vole vers la Halte du Thorium
    .isOnQuest 4132
step
    #label EntreeBRD3
    .goto Searing Gorge,34.80,83.80,20 >>Entre une troisième fois dans les Profondeurs de Rochenoire
    .isOnQuest 4132
step
    >>Tue le |cRXP_ENEMY_Général Forgehargne|r dans la garnison ouest d'Ombreforge (West Garrison). |cRXP_WARN_Il appelle des renforts quand il faiblit|r
    .complete 4132,1 --Général Forgehargne
    .mob 9033
    .isOnQuest 4132
step
    >>Si tu ne l'as pas eu : |cRXP_ENEMY_Magmus|r et le |cRXP_LOOT_Fragment des terres de Feu|r
    .complete 97197,1 --Fragment des terres de Feu
    .mob 9938
    .isOnQuest 97197
step
    >>Si tu ne l'as pas fait : tue l'|cRXP_ENEMY_Empereur Dagran Thaurissan|r sans tuer Moira
    .complete 4003,1 --Empereur Dagran Thaurissan
    .mob 9019
    .isOnQuest 4003
step
    >>Parle à la |cRXP_FRIENDLY_Princesse Moira Bronzebeard|r
    .turnin 4003 >>Rends Un sauvetage royal
    .accept 4004 >>Accepte La Princesse sauvée ?
    .target 8929
    .isQuestComplete 4003
step
    .hs >>Sors et utilise ta pierre de foyer pour Kargath
    .isOnQuest 4132
step
    .goto Badlands,5.81,47.52
    >>Parle au |cRXP_FRIENDLY_Chef de guerre Goretooth|r
    .turnin 4132 >>Rends Opération : Mort à Forgehargne
    .target 9077
    .isQuestComplete 4132

-- ===== Rendus finaux : Orgrimmar et Mulgore =====
step
    #completewith RenduThrall
    .goto Orgrimmar,31.73,37.82,40 >>Va à Orgrimmar (vol vers Undercity ou Grom'gol puis zeppelin)
    .isOnQuest 4004
step
    #label RenduThrall
    .goto Orgrimmar,31.73,37.82
    >>Parle à |cRXP_FRIENDLY_Thrall|r
    .turnin 4004 >>Rends La Princesse sauvée ?
    .target 4949
    .isOnQuest 4004
step
    #completewith FinRochenoire
    .goto Mulgore,33.37,22.57,40 >>Vole vers Thunder Bluff et retourne voir |cRXP_FRIENDLY_Alaana Marchetempête|r au nord-ouest de Mulgore
    .isOnQuest 97197
step
    #label FinRochenoire
    .goto Mulgore,33.37,22.57
    >>Parle à |cRXP_FRIENDLY_Alaana Marchetempête|r
    .turnin 97197 >>Rends Fragment des terres de Feu
    .target 259119
    .isOnQuest 97197
]])

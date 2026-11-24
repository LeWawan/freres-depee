if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde du Bas du pic Rochenoire (Mont Rochenoire, entre la Gorge des Vents
-- brûlants et les Steppes ardentes), toutes classes.
-- Givers : Chef de guerre Goretooth, Galamav le Tireur d'élite, Lexlort et Ombremage Vivian
-- Lagrave (Kargath, Terres ingrates), Kibler et John le Loqueteux (Crête de la flamme, Steppes
-- ardentes), Warosh et Bijou (dans l'instance). Suite : Eitrigg et Thrall à Orgrimmar.
-- Données : QuestieDB Forever (tools/questiedb.py), zone 1583 (le Sommet du pic partage la zone).
-- XP de xpDB-classic.lua, 98325 Sang et tonnerre de xpDB-traces.lua (660 xp). Les entrées de
-- blacklist de 4903/4941 (>= Wotlk) et 4724/4866 (>= Cata) ne s'appliquent pas : Forever est Era.
-- Dans l'instance, QuestieDB n'a pas de coordonnées : ordre des salles décrit dans le texte.
-- Entrée : Eastern Kingdoms 48.95,63.89 (RXP Classic-Attunements.lua).
-- Itinéraire : Kargath -> Crête de la flamme -> Bas du pic Rochenoire (Pierre-du-pic, cité de
-- Hordemar et Bijou, Vosh'gajin et Voone, araignées et Matriarche Couveuse, Omokk et Urok,
-- Zigris, Halycon, Gizrul, Wyrmthalak) -> Crête de la flamme -> Kargath -> Orgrimmar (fin).
-- Les rendus sont protégés par .isOnQuest : ils restent proposés après un deuxième passage
-- (documents de Rochenoire à apparition aléatoire, 15 oeufs chacun en duo).
-- Entrantes : 4729, 4862 et 4866 (coupées par le guide des Steppes ardentes) sont prises ici.
-- Coupées :
--   4734 Un oeuf congelé, 4735 La collecte d'oeufs, 4907 Tinkee Steamboil et la suite 5522
--   (oeufs de la Colonie, au Sommet du pic Rochenoire ; prérequis 4810, chaîne de Felnok au
--   Berceau-de-l'Hiver, Kalimdor),
--   4769 Vivian Lagrave et la tablette de Darkstone (suggestion d'Undercity, 660 xp : détour ;
--   4768 se prend directement à Kargath),
--   4742/4743 Le sceau de l'ascension (accès au Sommet du pic Rochenoire),
--   7761 Les ordres de Blackhand (Drakkisath, Sommet du pic), 4974 Pour la Horde ! (Rend,
--   Sommet du pic, suite de 4941), 5160 Le Protectorat de la matrone (Awbee, Sommet du pic,
--   Berceau-de-l'Hiver), 5047 Pépin Preste-Jugeote (La Bête, Sommet du pic, Long-guet),
--   6569 Illusions d'Occulus, 6602 Le sang du champion des dragons noirs et 6821 Oeil du
--   Prophète ardent (chaînes d'Onyxia, Sommet du pic et raid), 5166/5167 (vol chromatique,
--   Sommet du pic), chaîne d'Onyxia et Repaire de l'Aile noire coupées en entier,
--   8966/8989/8995 Valthalak (ensemble de donjon 2, niveau 60, chaîne d'Anthion),
--   4788 Les dernières tablettes (après 5065, qui suit 3528, chaîne de Mosh'aru coupée par les
--   guides de Tanaris et de Zul'Farrak ; giver à Tanaris, Kalimdor),
--   5127 La forge démoniaque, 5306 Pierre du serpent, 5141/5145 Travail du cuir de dragon
--   (métiers), librams 4463/4481/4482/4483/4484 (Mathredis Firestar, Steppes ardentes, pas
--   d'XP, objets aléatoires),
--   Alliance : 4701, 4764, 4765, 4766, 5001, 5002, 5081, 5089, 5102, 6502.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 55-60 Lower Blackrock Spire
#displayname [FDP] Bas du pic Rochenoire (55-60)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Kargath =====
step
    #completewith Goretooth
    .goto Badlands,5.81,47.52,40 >>Va à Kargath, à l'ouest des Terres ingrates
step
    #label Goretooth
    .goto Badlands,5.81,47.52
    >>Parle au |cRXP_FRIENDLY_Chef de guerre Goretooth|r
    .accept 4903 >>Accepte Ordre du chef de guerre
    .target 9077
step
    .goto Badlands,5.81,47.52
    >>Parle encore au |cRXP_FRIENDLY_Chef de guerre Goretooth|r. |cRXP_WARN_Quête Forever sans objectif, non vérifiée en jeu : passe l'étape si elle n'est pas proposée|r
    .accept 98325 >>Accepte Sang et tonnerre
    .turnin 98325 >>Rends Sang et tonnerre
    .target 9077
step
    .goto Badlands,5.96,47.73
    >>Parle à |cRXP_FRIENDLY_Galamav le Tireur d'élite|r
    .accept 4724 >>Accepte La maîtresse de meute
    .target 9081
step
    .goto Badlands,5.88,47.63
    >>Parle à |cRXP_FRIENDLY_Lexlort|r
    .accept 4981 >>Accepte Agent Bijou
    .target 9080
step
    .goto Badlands,2.90,47.76
    >>Parle à l'|cRXP_FRIENDLY_Ombremage Vivian Lagrave|r
    .accept 4768 >>Accepte La tablette de Darkstone
    .target 9078
    .xp <57,1

-- ===== Crête de la flamme =====
step
    #completewith Kibler
    .goto Burning Steppes,65.89,21.92,40 >>Vole vers la Crête de la flamme, au nord-est des Steppes ardentes
step
    #label Kibler
    .goto Burning Steppes,65.89,21.92
    >>Parle à |cRXP_FRIENDLY_Kibler|r. Il te donne une |cRXP_LOOT_Cage de jeune worg vide|r
    .accept 4729 >>Accepte Les animaux exotiques de Kibler
    .accept 4862 >>Accepte Mauvais
    .target 10260
step
    .goto Burning Steppes,65.01,23.76
    >>Parle à |cRXP_FRIENDLY_John le Loqueteux|r
    .accept 4866 >>Accepte Le lait matriarcal
    .target 9563

-- ===== Bas du pic Rochenoire =====
step
    #sticky
    >>Ramasse les |cRXP_PICK_Documents discrets|r : ils apparaissent au hasard près d'un des boss (Omokk, Voone ou Wyrmthalak). |cRXP_WARN_Absents de cette run : refais-la plus tard, le rendu reste proposé|r
    .complete 4903,4 --Importants documents de Rochenoire
    .isOnQuest 4903
step
    #label EntreePic
    .goto Eastern Kingdoms,48.95,63.89,20 >>Va au Mont Rochenoire (au nord des Steppes ardentes), monte jusqu'à l'entrée du Pic Rochenoire et entre dans l'instance avec ton groupe
step
    >>Traverse les orcs |cRXP_ENEMY_Pierre-du-pic|r jusqu'à la cité de Hordemar. Trouve |cRXP_FRIENDLY_Bijou|r, la gnome cachée au début de la cité
    .turnin 4981 >>Rends Agent Bijou
    .accept 4982 >>Accepte Les effets de Bijou
    .target 10257
    .isOnQuest 4981
step
    >>Descends à l'étage du bas de la cité et ramasse les |cRXP_PICK_Affaires de Bijou|r
    .complete 4982,1 --Affaires de Bijou
    .isOnQuest 4982
step
    >>Retourne voir |cRXP_FRIENDLY_Bijou|r
    .turnin 4982 >>Rends Les effets de Bijou
    .accept 4983 >>Accepte Rapport de reconnaissance de Bijou
    .target 10257
    .isOnQuest 4982
step
    >>Parle à |cRXP_FRIENDLY_Warosh|r, troll amical près du territoire des |cRXP_ENEMY_Smolderthorn|r, puis lis le |cRXP_LOOT_Parchemin de Warosh|r. |cRXP_WARN_Emplacement non vérifié en jeu|r
    .accept 4867 >>Accepte Urok Hurleruine
    .target 10799
step
    >>Tue la |cRXP_ENEMY_Chasseresse des ombres Vosh'gajin|r et ramasse la |cRXP_PICK_Tablette de Darkstone|r dans sa salle
    .complete 4768,1 --Tablette de Darkstone
    .mob 9236
    .isOnQuest 4768
step
    >>Tue le |cRXP_ENEMY_Maître de guerre Voone|r, chef des trolls Smolderthorn
    .complete 4903,3 --Maître de guerre Voone
    .mob 9237
    .isOnQuest 4903
step
    >>Passe dans les tunnels des araignées et ramasse les |cRXP_PICK_Oeufs d'araignée du pic|r. |cRXP_WARN_15 oeufs chacun en duo : chaque joueur doit ramasser les siens|r
    .complete 4862,1 --Oeuf d'araignée du pic (15)
    .mob 10374
    .isOnQuest 4862
step
    >>Engage la |cRXP_ENEMY_Matriarche Couveuse|r au fond des tunnels et laisse-la t'empoisonner, puis tue-la. |cRXP_WARN_Ne dissipe pas le poison et ne meurs pas : il faut l'avoir sur toi chez John le Loqueteux. Regarde sa durée sur l'icône ; si elle est courte, sors tout de suite à la Crête de la flamme (non vérifié en jeu)|r
    +Coche une fois empoisonné par la |cRXP_ENEMY_Matriarche Couveuse|r
    .mob 10596
    .isOnQuest 4866
step
    >>Tue le |cRXP_ENEMY_Généralissime Omokk|r, chef des ogres. Ramasse la |cRXP_LOOT_Tête d'Omokk|r et la |cRXP_PICK_Pique de fortune|r près de lui
    .complete 4903,2 --Généralissime Omokk
    .mob 9196
    .isOnQuest 4903
step
    >>Assemble la tête et la pique au |cRXP_PICK_Tribut d'Urok|r : des vagues d'ogres arrivent, puis |cRXP_ENEMY_Urok Hurleruine|r (élite). Ramasse le |cRXP_LOOT_Mojo de Warosh|r
    .complete 4867,1 --Mojo de Warosh
    .mob 10584
    .isOnQuest 4867
step
    >>Retourne voir |cRXP_FRIENDLY_Warosh|r
    .turnin 4867 >>Rends Urok Hurleruine
    .target 10799
    .isOnQuest 4867
step
    >>Après l'|cRXP_ENEMY_Intendant Zigris|r, tue |cRXP_ENEMY_Halycon|r dans l'antre des worgs
    .complete 4724,1 --Halycon
    .mob 10220
    .isOnQuest 4724
step
    >>Utilise la |cRXP_LOOT_Cage de jeune worg vide|r sur un |cRXP_ENEMY_Jeune worgen Bloodaxe|r près de Halycon
    .complete 4729,1 --Jeune worg en cage
    .use 12262
    .mob 10221
    .isOnQuest 4729
step
    >>Tue |cRXP_ENEMY_Gizrul l'esclavagiste|r, qui arrive après Halycon, puis le |cRXP_ENEMY_Seigneur Wyrmthalak|r, dernier boss
    .complete 4903,1 --Seigneur Wyrmthalak
    .mob 10268
    .mob 9568
    .isOnQuest 4903

-- ===== Rendus : Crête de la flamme =====
step
    .goto Burning Steppes,65.01,23.76
    >>Sors de l'instance et va voir |cRXP_FRIENDLY_John le Loqueteux|r à la Crête de la flamme, encore empoisonné
    .complete 4866,1 --Traite par John le Loqueteux
    .turnin 4866 >>Rends Le lait matriarcal
    .target 9563
    .isOnQuest 4866
step
    .goto Burning Steppes,65.89,21.92
    >>Parle à |cRXP_FRIENDLY_Kibler|r
    .turnin -4729 >>Rends Les animaux exotiques de Kibler
    .turnin -4862 >>Rends Mauvais
    .target 10260
    .isOnQuest 4729
step
    .goto Burning Steppes,65.89,21.92
    >>Parle à |cRXP_FRIENDLY_Kibler|r
    .turnin 4862 >>Rends Mauvais
    .target 10260
    .isOnQuest 4862

-- ===== Rendus : Kargath =====
step
    .goto Badlands,5.88,47.63
    >>Vole vers Kargath et parle à |cRXP_FRIENDLY_Lexlort|r
    .turnin 4983 >>Rends Rapport de reconnaissance de Bijou
    .target 9080
    .isOnQuest 4983
step
    .goto Badlands,5.96,47.73
    >>Parle à |cRXP_FRIENDLY_Galamav le Tireur d'élite|r
    .turnin 4724 >>Rends La maîtresse de meute
    .target 9081
    .isOnQuest 4724
step
    .goto Badlands,2.90,47.76
    >>Parle à l'|cRXP_FRIENDLY_Ombremage Vivian Lagrave|r
    .turnin 4768 >>Rends La tablette de Darkstone
    .target 9078
    .isOnQuest 4768
step
    .goto Badlands,5.81,47.52
    >>Parle au |cRXP_FRIENDLY_Chef de guerre Goretooth|r
    .turnin 4903 >>Rends Ordre du chef de guerre
    .accept 4941 >>Accepte Sagesse d'Eitrigg
    .target 9077
    .isOnQuest 4903
step
    .goto Badlands,5.81,47.52
    >>Parle au |cRXP_FRIENDLY_Chef de guerre Goretooth|r
    .accept 4941 >>Accepte Sagesse d'Eitrigg
    .target 9077
    .isQuestTurnedIn 4903

-- ===== Orgrimmar : Eitrigg et Thrall =====
step
    .goto Orgrimmar,34.28,39.35
    >>Va à Orgrimmar, dans la salle de Thrall (Vallée de la Sagesse), et parle à |cRXP_FRIENDLY_Eitrigg|r jusqu'au bout de la discussion
    .complete 4941,1 --Discussion avec Eitrigg
    .target 3144
    .isOnQuest 4941
step
    #label FinPicRochenoire
    .goto Orgrimmar,31.73,37.82
    >>Parle à |cRXP_FRIENDLY_Thrall|r. |cRXP_WARN_La suite, Pour la Horde !, se fait au Sommet du pic Rochenoire : ce guide s'arrête là|r
    .turnin 4941 >>Rends Sagesse d'Eitrigg
    .target 4949
    .isOnQuest 4941
]])

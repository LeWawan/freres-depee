if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Silithus, Horde, toutes classes, en duo. Dernière région de
-- la route FDP. Indépendant des autres régions : La reconquête de Silithus (8276, émissaire
-- Blackhoof à Orgrimmar) et La dévastation (1124, Rabine Saturna à Reflet-de-Lune) sont
-- protégées par .isOnQuest, la chaîne du Repos des Vaillants par
-- .isQuestTurnedIn (1125 après 1124, 1126 après 1125).
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-classic.lua. Taux de drop
-- wowheadData : pince de Poigne-de-mort ~80 %, chapitres du Lexique ~97 %, dards et crocs
-- des chaînes de Noggle 10-18 % (cmangosData dit 80 % : si c'est le vrai taux en jeu, la
-- chaîne 8277 / 8278 / 8282 vaut la peine d'être ajoutée), cerveaux de silithides < 1 %,
-- textes cryptés ~33 %, objet incrusté ~52 %.
-- Accès : à pied depuis le cratère d'Un'Goro (passage au nord-ouest, arrivée au Repos des
-- Vaillants), le point de vol du Fort cénarien n'est pas encore connu.
-- Itinéraire : Repos des Vaillants et village de Sudevent (si 1124) -> Fort cénarien ->
-- ouest et nord-ouest (frappeurs, fragments de tablette) -> Fort -> Ortell l'ermite (sud-est)
-- -> campement de Bronzebeard et Poigne-de-mort (sud) -> Exeter (sud-ouest) -> par l'est de
-- la Ruche'Zora jusqu'à Havunth, aux écraseurs et à Mayna (ouest) -> Fort -> Ortell ->
-- pierre de foyer -> Fort (fin).
-- XP gardée : ~52200 en quêtes (jusqu'à ~69450 avec 8276 et la chaîne 1124), environ un
-- tiers de niveau à 58 : la route s'arrête ici, la fin vers 60 se fait au farm ou en donjon.
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   8277 Venin mortel du désert (8 dards à ~18 % + 8 crocs à ~18 % = ~176 kills), donc 8278
--   (3 + 3 + 3 objets à 10-16 % = ~150 kills) et 8282, chaîne à ~55 xp/kill ;
--   8306 L'antre de la folie (Natalia, élite 61-62 au fond de la Ruche'Regal) ;
--   8309 À la poursuite des glyphes (cristaux gardés par des élites aux trois ruches, cristal
--   de la Ruche'Regal dans la ruche même, aller-retour au campement de Bronzebeard),
--   8310 Déchiffrer le code (cerveaux à moins de 1 %), donc 8314, 8315 (Émissaire qiraji,
--   groupe) et 8316, 8376-8382 (récompenses de classe) ;
--   6844 Umber, Archiviste (rendue à Reflet-de-Lune) ;
--   8318, 8319, 8323, 8324 (10 textes cryptés à ~33 % = ~60 kills ; 8319 et 8324 répétables) ;
--   8320, 8321 (niveau 60 requis) ; 9416, 9422 (silithyste, objectif JcJ) ;
--   8308 (lettre de Brann sur les silithides, sans taux de drop connu) ;
--   8331-8333, 8341-8343, 8348, 8349, 8351, 8352, 8361-8364, 9248 (templiers, ducs et
--   seigneurs abyssaux : réputation et invocations en groupe) ;
--   8286, 8288, 8301-8303, 8305, 8519, 8743, 8745 (Sceptre des Sables changeants, Couvée de
--   Nozdormu, gong) ; 8857-8859 (liste noire Questie) ; 9023 (raids AQ20 / ZG) ;
--   effort de guerre d'Ahn'Qiraj et réputation cénarienne : 8496-8498, 8501, 8502, 8507,
--   8508, 8534-8541, 8548, 8572-8574, 8687, 8731, 8732, 8737-8740, 8770-8787, 8800,
--   8804-8810, 8829, 8856, 9338 ; 9415, 9419 (Alliance).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 57-60 Silithus
#displayname [FDP] Silithus (57-60)
#version 1
#group Guide FDP (Horde)
#subgroup Régions

-- ===== Repos des Vaillants (si tu viens de Reflet-de-Lune) =====
step
    .goto Silithus,81.87,18.93
    >>Depuis le cratère d'Un'Goro, prends le passage au nord-ouest. À l'entrée de Silithus, parle à |cRXP_FRIENDLY_Layo Starstrike|r au cimetière du Repos des Vaillants
    .turnin 1124 >>Rends La dévastation
    .target 13220
    .isOnQuest 1124
step
    .goto Silithus,81.87,18.93
    >>Parle à |cRXP_FRIENDLY_Layo Starstrike|r
    .accept 1125 >>Accepte Les esprits de Sudevent
    .target 13220
    .isQuestTurnedIn 1124
step
    .goto Silithus,62.10,52.60
    >>Libère les esprits du village de Sudevent : tue les |cRXP_ENEMY_Druides torturés|r et les |cRXP_ENEMY_Sentinelles torturées|r
    .complete 1125,1 --Druide torturé libéré (8)
    .complete 1125,2 --Sentinelle torturée libérée (8)
    .mob 12178
    .mob 12179
    .isOnQuest 1125
step
    .goto Silithus,81.87,18.93
    >>Retourne voir |cRXP_FRIENDLY_Layo Starstrike|r
    .turnin 1125 >>Rends Les esprits de Sudevent
    .target 13220
    .isOnQuest 1125
step
    .goto Silithus,81.87,18.93
    >>Parle à |cRXP_FRIENDLY_Layo Starstrike|r
    .accept 1126 >>Accepte Une ruche dans la tour
    .target 13220
    .isQuestTurnedIn 1125
step
    .goto Silithus,60.36,52.56
    >>Monte au sommet de la tour du village de Sudevent, ouvre le |cRXP_PICK_Reliquaire poussiéreux|r et tue les |cRXP_ENEMY_Embusquées de la Ruche'Ashi|r qui surgissent pour l'|cRXP_LOOT_Objet silithide incrusté|r. |cRXP_WARN_Un objet par joueur : si un seul tombe, attends que le reliquaire réapparaisse|r
    .complete 1126,1 --Objet silithide incrusté
    .mob 13301
    .isOnQuest 1126
step
    .goto Silithus,81.87,18.93
    >>Retourne voir |cRXP_FRIENDLY_Layo Starstrike|r
    .turnin 1126 >>Rends Une ruche dans la tour
    .target 13220
    .isOnQuest 1126

-- ===== Fort cénarien =====
step
    #completewith ArriveeFort
    .goto Silithus,48.68,36.67,40 >>Va au Fort cénarien, au centre-nord de Silithus. |cRXP_WARN_Depuis Un'Goro, par le passage au nord-ouest du cratère puis la route vers l'ouest (non vérifié en jeu)|r
step
    #label ArriveeFort
    .goto Silithus,48.68,36.67
    >>Parle à |cRXP_FRIENDLY_Runk Windtamer|r
    .fp Cenarion Hold >>Prends le point de vol du Fort cénarien
    .target 15178
step
    .goto Silithus,51.89,39.16
    >>Parle à l'|cRXP_FRIENDLY_aubergiste Calandrath|r
    .home >>Fixe ta pierre de foyer au Fort cénarien
    .target 15174
step
    .goto Silithus,51.15,38.29
    >>Parle à l'|cRXP_FRIENDLY_Imploratrice céleste Proudhorn|r
    .turnin 8276 >>Rends La reconquête de Silithus
    .target 15191
    .isOnQuest 8276
step
    .goto Silithus,51.15,38.29
    >>Parle à l'|cRXP_FRIENDLY_Imploratrice céleste Proudhorn|r
    .accept 8280 >>Accepte Sécuriser les lignes d'approvisionnement
    .target 15191
step
    .goto Silithus,51.35,38.27
    >>Lis l'|cRXP_PICK_Avis de recherche : Poigne-de-mort|r à côté
    .accept 8283 >>Accepte ON RECHERCHE : Poigne-de-mort, Terreur des sables
step
    .goto Silithus,49.67,37.46
    >>Parle à la |cRXP_FRIENDLY_Géologue Larksbane|r
    .accept 8284 >>Accepte Le mystère du Crépuscule
    .target 15183
step
    .goto Silithus,49.20,34.18
    >>Parle au |cRXP_FRIENDLY_Commandant Mar'alith|r
    .accept 8304 >>Accepte Chère Natalia
    .target 15181
    .xp <58,1

-- ===== Ouest et nord-ouest : frappeurs et fragments =====
step
    #completewith FinFragments
    >>Tue les |cRXP_ENEMY_Frappeurs térébrants|r sur la route du nord-ouest
    .complete 8280,1 --Frappeur térébrant (15)
    .mob 11740
step
    #label FinFragments
    .goto Silithus,23.50,12.50
    >>Ramasse les |cRXP_PICK_Fragments de la Tablette du crépuscule|r au nord-ouest. |cRXP_WARN_Chacun ramasse ses 8 fragments : attends les réapparitions si besoin|r
    .complete 8284,1 --Fragment de la Tablette du crépuscule (8)
step
    .goto Silithus,36.00,29.00
    >>Finis les |cRXP_ENEMY_Frappeurs térébrants|r à l'ouest du Fort en rentrant
    .complete 8280,1 --Frappeur térébrant (15)
    .mob 11740
step
    .goto Silithus,51.15,38.29
    >>Retourne voir l'|cRXP_FRIENDLY_Imploratrice céleste Proudhorn|r
    .turnin 8280 >>Rends Sécuriser les lignes d'approvisionnement
    .accept 8281 >>Accepte Améliorer la sécurité
    .target 15191
step
    .goto Silithus,49.67,37.46
    >>Retourne voir la |cRXP_FRIENDLY_Géologue Larksbane|r
    .turnin 8284 >>Rends Le mystère du Crépuscule
    .accept 8285 >>Accepte Le déserteur
    .target 15183
step
    .goto Silithus,49.20,34.18
    >>Parle au |cRXP_FRIENDLY_Commandant Mar'alith|r
    .accept 8304 >>Accepte Chère Natalia
    .target 15181
    .xp <58,1

-- ===== Grande boucle du sud et de l'ouest =====
step
    #completewith FinEcraseurs
    >>Tue les |cRXP_ENEMY_Écraseurs térébrants|r croisés en route (au sud du Fort et à l'ouest)
    .complete 8281,1 --Écraseur térébrant (20)
    .mob 11741
step
    .goto Silithus,67.19,69.76
    >>Va au sud-est et parle à |cRXP_FRIENDLY_Ortell l'ermite|r
    .turnin 8285 >>Rends Le déserteur
    .accept 8279 >>Accepte Le Lexique du crépuscule
    .target 15194
step
    .goto Silithus,40.81,88.86
    >>Au campement de Bronzebeard, au sud, parle à |cRXP_FRIENDLY_Frankal Stonebridge|r
    .complete 8304,1 --Interroger Frankal Stonebridge
    .target 15171
    .isOnQuest 8304
step
    .goto Silithus,41.28,88.45
    >>Parle à |cRXP_FRIENDLY_Rutgar Glyphshaper|r
    .complete 8304,2 --Interroger Rutgar Glyphshaper
    .target 15170
    .isOnQuest 8304
step
    .goto Silithus,45.07,92.31
    >>Tue |cRXP_ENEMY_Poigne-de-mort|r et ramasse sa |cRXP_LOOT_Pince|r. |cRXP_WARN_Élite 59 : en duo, à pleine vie. Une pince par joueur : si une seule tombe, attends la réapparition. Trop dur ? Abandonne la quête et passe l'étape|r
    .complete 8283,1 --Pince de Poigne-de-mort
    .mob 15196
    .unitscan 15196
step
    .goto Silithus,16.09,86.37
    >>Va au camp du Crépuscule du sud-ouest et tue le |cRXP_ENEMY_Gardien du crépuscule Exeter|r pour le |cRXP_LOOT_Chapitre 2|r. |cRXP_WARN_Un chapitre par joueur : si un seul tombe, attends la réapparition|r
    .complete 8279,2 --Lexique du crépuscule - Chapitre 2
    .mob 11803
step
    .goto Silithus,40.86,42.22
    >>Remonte vers le nord par l'est de la Ruche'Zora (pleine d'élites) et tue le |cRXP_ENEMY_Gardien du crépuscule Havunth|r pour le |cRXP_LOOT_Chapitre 3|r. |cRXP_WARN_Un chapitre par joueur|r
    .complete 8279,3 --Lexique du crépuscule - Chapitre 3
    .mob 11804
step
    #label FinEcraseurs
    .goto Silithus,30.50,43.00
    >>Finis les |cRXP_ENEMY_Écraseurs térébrants|r à l'ouest
    .complete 8281,1 --Écraseur térébrant (20)
    .mob 11741
step
    .goto Silithus,26.35,36.62
    >>Tue la |cRXP_ENEMY_Gardienne du crépuscule Mayna|r pour le |cRXP_LOOT_Chapitre 1|r. |cRXP_WARN_Un chapitre par joueur|r
    .complete 8279,1 --Lexique du crépuscule - Chapitre 1
    .mob 15200

-- ===== Retour au Fort =====
step
    .goto Silithus,51.15,38.29
    >>Rentre au Fort cénarien et parle à l'|cRXP_FRIENDLY_Imploratrice céleste Proudhorn|r
    .turnin 8281 >>Rends Améliorer la sécurité
    .target 15191
step
    .goto Silithus,50.75,33.65
    >>Parle à |cRXP_FRIENDLY_Vish Kozus|r, capitaine de la garde
    .turnin 8283 >>Rends ON RECHERCHE : Poigne-de-mort, Terreur des sables
    .target 15182
    .isQuestComplete 8283
step
    .goto Silithus,49.20,34.18
    >>Parle au |cRXP_FRIENDLY_Commandant Mar'alith|r
    .turnin 8304 >>Rends Chère Natalia
    .target 15181
    .isOnQuest 8304

-- ===== Dernier aller-retour chez Ortell =====
step
    .goto Silithus,67.19,69.76
    >>Retourne voir |cRXP_FRIENDLY_Ortell l'ermite|r au sud-est
    .turnin 8279 >>Rends Le Lexique du crépuscule
    .accept 8287 >>Accepte Un terrible but
    .target 15194
step
    .hs >>Utilise ta pierre de foyer vers le Fort cénarien (sinon rentre à monture)
step
    .goto Silithus,49.20,34.18
    >>Parle au |cRXP_FRIENDLY_Commandant Mar'alith|r
    .turnin 8287 >>Rends Un terrible but
    .target 15181
step
    #label FinSilithus
    +|cRXP_WARN_Fin de la route FDP. Pas encore 60 ? Farme les camps du Crépuscule ou fais un donjon|r. Coche pour terminer
]])

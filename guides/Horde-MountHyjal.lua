if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de région Mont Hyjal (Mount Hyjal, zone Forever, uiMap 2482, area 616),
-- Horde, toutes classes, en duo. Indépendant des autres régions : Un cousin à l'étranger
-- (97319, Tirisfal), La chasse aux chasseurs de démons (91877, Azshara) et le Grand Livre
-- d'Hol'anyee (92020, Un'Goro) sont protégés par .isOnQuest. La corruption et sa source
-- (91952) se prend chez Greta Mosshoof, au sanctuaire d'Émeraude, au début du guide.
-- Données : QuestieDB Forever (tools/questiedb.py), XP de xpDB-traces.lua. Aucun taux de
-- drop connu dans la zone : 35 % supposés partout. Beaucoup de quêtes n'ont pas d'objectifs
-- dans QuestieDB : RXP les lit dans le jeu.
-- Accès : Ketharas se tient à la fois au sanctuaire d'Émeraude (Gangrebois 51.2,82.2) et à
-- l'entrée des contreforts Corrompus (Hyjal 73.3,81.9). Le passage entre les deux n'est pas
-- vérifié en jeu. Points de vol Horde : contreforts Corrompus (Jacinth) relié à Long-guet,
-- et sommet d'Éternité. Le voyage à Reflet-de-Lune (Long-guet puis Nighthaven) suppose ces
-- points de vol, ou un trajet à pied non vérifié.
-- Itinéraire : Ketharas -> contreforts (Fraxinus, Kaylaena) -> Corbeau curieux et
-- Gangrechique (gelées, os) -> Ketharas -> Long-guet et Reflet-de-Lune -> Ketharas ->
-- Corbeau -> Kaylaena -> sanctuaire d'Aviana -> berceau de la Tranquillité (dieux sauvages)
-- -> Elderwild et ruines du Fléau -> terrier Peau-d'écorce -> Elderwild -> Renalard ->
-- Dae'gun -> sommet d'Éternité -> Kaylaena et Ketharas -> pacte Noirépine -> Ketharas.
-- Coupées (duo : kills = 2 x nombre x 100 / taux) :
--   93747 Que la violence s'efface (engins détruits absents de QuestieDB) et 90487 Alliés
--   anciens (demande 93747), 99670 Retournez voir Jereman (660 xp, retour au berceau),
--   96145 Par-delà ailes et griffes (620 xp, détour), 92147 Requête hauteplume (18 plumes =
--   ~103 kills), 93827 Protections balayées (16 amulettes = ~91 kills), 93834 Les hannetons
--   fouisseurs (10 morceaux = ~57 kills pour 3000 xp), 93615 Chatons filous (chatons
--   dispersés aux quatre coins), 96616, 96622 (silphium, rendu à Elderwild après un
--   aller-retour), 95107 Chef Cri-Puissant (rendu au terrier après un aller-retour),
--   92446 Gratte-tête (élite 60, rendu à Elderwild), 91794 Mémoires de nos patriarches
--   (rendu à Elderwild après Dae'gun), 92017, 92016, 96302, 96301 (Marn : un seul point
--   d'apparition des saute-vents, puits d'Éternité introuvable), 96303 Brume du souvenir
--   (lieu absent), 93444 L'appât et la bête (Ghansurok élite 61), 93197, 93406, 93269
--   (courrier de Long-guet, deuxième voyage), 97490 Gare à la grêle (Berceau-de-l'Hiver),
--   84138, 84146, 84211, 84212 (Nami : Berceau-de-l'Hiver, Steppes ardentes), 96998, 96999
--   (envoi à Sen'jin), 92100 gardée mais 92101, 92102, 93510, 93551, 93567, 96558 (vétéran :
--   Mille Pointes, Les Carmines), 97000, 97001, 97006, 97007 (Fossoyeuse, autre continent),
--   90854 (kits d'armure, travail du cuir), 95769 (étoffe runique, couture), 97119 (Bouchées
--   de cerf, cuisine), 94504, 96666 (réputation Peau-d'écorce), 93925 (pas de données),
--   92094, 96561 (pas de donneur dans QuestieDB), 92842 et 91882 (rendues à des PNJ de
--   l'Alliance).
--   Alliance : 90702, 90750, 91564, 91688, 91881, 92014, 92015, 92064, 92189, 92433, 92449,
--   92591, 92593, 92702, 93383, 94832, 95027, 95218, 95793, 96077, 96494, 96529, 96559,
--   96674, 96676, 96833, 96992.

-- Paliers de difficulté : 96983, 96003 et 93422 ne sont proposées qu'au niveau 59 (Xarkul élite 61,
-- Mazzogore et Bethra'zel élites 60, coursier noirépine élite 60). 92592, 93521 et 93547 : niveau requis 57.

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 56-60 Mount Hyjal
#displayname [FDP] Mont Hyjal (56-60)
#version 1
#group Guide FDP (Horde)
#subgroup Régions
#next 57-60 Eastern Plaguelands

-- ===== Arrivée : sanctuaire d'Émeraude et Ketharas =====
step
    .goto Felwood,51.21,82.11
    >>Au sanctuaire d'Émeraude (sud de Gangrebois), parle à |cRXP_FRIENDLY_Greta Mosshoof|r
    .accept 91952 >>Accepte La corruption et sa source
    .target 10922
step
    .goto Felwood,51.23,82.16
    >>Parle à |cRXP_FRIENDLY_Ketharas|r, l'ermite à côté de Greta. |cRXP_WARN_Son autre position est l'entrée du mont Hyjal (contreforts Corrompus) : chemin non vérifié en jeu|r
    .turnin 91952 >>Rends La corruption et sa source
    .accept 95568 >>Accepte Les graines d'une nouvelle saison
    .accept 95569 >>Accepte Une lueur d'espoir pour les oisillons
    .target 256222
step
    .goto 2482,75.30,77.40
    >>Ramasse le |cRXP_PICK_Rouage détaché|r au nord de la grotte de Ketharas
    .accept 94479 >>Accepte Ça peut toujours servir
step
    #completewith Oeufs
    .goto 2482,77.00,73.50,0
    >>Cueille les |cRXP_PICK_Fleurs non corrompues|r pour leurs graines
    .complete 95568,1 --Graine non corrompue (10)
step
    #label Oeufs
    .goto 2482,75.30,75.50
    >>Ramasse les |cRXP_PICK_Oeufs de chouette d'Hyjal|r autour des arbres
    .complete 95569,1 --Oeuf de chouette d'Hyjal (12)
step
    .goto 2482,79.94,70.69
    >>Parle à |cRXP_FRIENDLY_Thark Gorax|r
    .turnin 97319 >>Rends Un cousin à l'étranger
    .target 266802
    .isOnQuest 97319
step
    .goto 2482,79.94,70.69
    >>Parle à |cRXP_FRIENDLY_Thark Gorax|r
    .accept 96830 >>Accepte Don de long-voyance
    .target 266802
step
    .goto 2482,80.50,72.00
    >>Finis les |cRXP_PICK_Fleurs non corrompues|r, plus nombreuses à l'est
    .complete 95568,1 --Graine non corrompue (10)
step
    .goto 2482,73.34,81.88
    >>Retourne voir |cRXP_FRIENDLY_Ketharas|r
    .turnin 94479 >>Rends Ça peut toujours servir
    .turnin 95568 >>Rends Les graines d'une nouvelle saison
    .turnin 95569 >>Rends Une lueur d'espoir pour les oisillons
    .accept 96796 >>Accepte Atelier dans les bois
    .accept 93759 >>Accepte Les trésors de la nature
    .target 256222
step
    #completewith Tubercules
    .goto 2482,70.00,71.00,0
    >>Tue les |cRXP_ENEMY_Cerfs d'Hyjal|r sains (pas les corrompus) pour leur |cRXP_LOOT_Venaison|r
    .complete 93759,1 --Morceau de venaison d'Hyjal (2)
    .mob 248041
step
    #label Tubercules
    .goto 2482,67.30,74.80
    >>Ramasse les |cRXP_PICK_Tubercules-flèches écarlates|r
    .complete 93759,2 --Tubercule-flèche écarlate (6)
step
    .goto 2482,70.00,71.00
    >>Finis les |cRXP_ENEMY_Cerfs d'Hyjal|r pour leur |cRXP_LOOT_Venaison|r
    .complete 93759,1 --Morceau de venaison d'Hyjal (2)
    .mob 248041
step
    .goto 2482,73.34,81.88
    >>Retourne voir |cRXP_FRIENDLY_Ketharas|r
    .turnin 93759 >>Rends Les trésors de la nature
    .accept 95611 >>Accepte Les rites du respect
    .target 256222
step
    .goto 2482,73.34,81.88,15
    >>Enterre les restes au sanctuaire de Ketharas, près de sa grotte. |cRXP_WARN_Emplacement exact absent de QuestieDB|r
    .complete 95611,1
    .use 269998
step
    .goto 2482,73.34,81.88
    >>Parle à |cRXP_FRIENDLY_Ketharas|r
    .turnin 95611 >>Rends Les rites du respect
    .target 256222

-- ===== Contreforts Corrompus : Fraxinus et Kaylaena =====
step
    .goto 2482,55.01,82.74
    >>Va à l'ouest et parle à |cRXP_FRIENDLY_Jacinth|r
    .fp Tainted Foothills >>Prends le point de vol des contreforts Corrompus
    .target 260626
step
    .goto 2482,54.05,84.39
    >>Parle à |cRXP_FRIENDLY_Hyacinthe|r
    .accept 91754 >>Accepte Pour une poignée de terre
    .accept 91755 >>Accepte Massifs élagués
    .target 248367
step
    .goto 2482,54.83,84.56
    >>Parle à |cRXP_FRIENDLY_Thylaen|r
    .accept 91923 >>Accepte Celastrus l'Amer
    .target 265586
step
    .goto 2482,58.00,86.00
    >>Ramasse les |cRXP_PICK_Sols non corrompus|r à l'est du campement
    .complete 91754,1 --Sol non corrompu (6)
step
    #completewith Kaylaena
    >>Tue les |cRXP_ENEMY_Massifs corrompus|r pour leurs |cRXP_LOOT_Feuilles verdoyantes|r
    .complete 91755,1 --Feuille verdoyante (12)
    .mob 248395
step
    .goto 2482,60.50,73.00
    >>Tue |cRXP_ENEMY_Celastrus l'Amer|r, un ancien qui patrouille entre Fraxinus et l'atelier, et prends sa |cRXP_LOOT_Fronde brisée|r. |cRXP_WARN_Élite 57 : en duo|r
    .complete 91923,1 --Fronde brisée de Celastrus
    .mob 249051
    .unitscan 249051
step
    #label Kaylaena
    .goto 2482,60.10,61.18
    >>Monte au nord voir |cRXP_FRIENDLY_Kaylaena Murmeprintemps|r à son atelier
    .turnin 96796 >>Rends Atelier dans les bois
    .accept 92594 >>Accepte Bois d'allumage
    .accept 92008 >>Accepte Pièces de premier choix
    .target 249235
step
    .goto 2482,61.00,66.00
    >>Détruis les |cRXP_ENEMY_Massifs corrompus|r autour de l'atelier et finis leurs |cRXP_LOOT_Feuilles|r
    .complete 92594,1 --Massif corrompu (15)
    .complete 91755,1 --Feuille verdoyante (12)
    .mob 248395
step
    .goto 2482,60.10,61.18
    >>Retourne voir |cRXP_FRIENDLY_Kaylaena Murmeprintemps|r
    .turnin 92594 >>Rends Bois d'allumage
    .target 249235
step
    .goto 2482,54.05,84.39
    >>Retourne au sud voir |cRXP_FRIENDLY_Hyacinthe|r
    .turnin 91754 >>Rends Pour une poignée de terre
    .turnin 91755 >>Rends Massifs élagués
    .accept 91770 >>Accepte Érosion d'écorce
    .target 248367
step
    .goto 2482,54.83,84.56
    >>Parle à |cRXP_FRIENDLY_Thylaen|r
    .turnin 91923 >>Rends Celastrus l'Amer
    .target 265586
step
    .goto 2482,53.40,84.33
    >>Applique le cataplasme sur |cRXP_FRIENDLY_Fraxinus|r
    .complete 91770,1 --Fraxinus soigné
    .target 248366
step
    .goto 2482,53.40,84.33
    >>Parle à |cRXP_FRIENDLY_Fraxinus|r
    .turnin 91770 >>Rends Érosion d'écorce
    .accept 92959 >>Accepte Les anciens mourants
    .accept 95766 >>Accepte Une prodigieuse amie à plumes
    .target 248366
step
    .goto 2482,63.00,76.00
    >>Tue |cRXP_ENEMY_Fracécorce|r, l'ancien corrompu à l'est, puis plante la graine dans ses restes. |cRXP_WARN_Élite 56 : en duo|r
    .complete 92959,1
    .use 248975
    .mob 248709
    .unitscan 248709
step
    .goto 2482,53.40,84.33
    >>Retourne voir |cRXP_FRIENDLY_Fraxinus|r
    .turnin 92959 >>Rends Les anciens mourants
    .target 248366

-- ===== Corbeau curieux et Gangrechique =====
step
    .goto 2482,48.26,85.72
    >>Va au sud-ouest voir le |cRXP_FRIENDLY_Corbeau curieux|r
    .turnin 95766 >>Rends Une prodigieuse amie à plumes
    .accept 95317 >>Accepte Prise de notes
    .accept 95320 >>Accepte Une curieuse question
    .target 257753
step
    .goto 2482,48.58,73.54
    >>Monte au nord voir |cRXP_FRIENDLY_Gangrechique|r, le démon prisonnier
    .turnin 95320 >>Rends Une curieuse question
    .accept 95318 >>Accepte Un goût de cendre
    .target 263757
step
    .goto 2482,49.50,70.00
    >>Tue les |cRXP_ENEMY_Acolytes des cendres|r et ramasse leurs |cRXP_LOOT_Notes d'expérience|r. |cRXP_WARN_Farm long en duo (~69 kills) : chacun doit looter ses objets|r
    .complete 95318,1 --Acolyte des cendres (12)
    .complete 95317,1 --Notes d'expérience gangrecendre (12)
    .mob 260422
step
    .goto 2482,48.58,73.54
    >>Retourne voir |cRXP_FRIENDLY_Gangrechique|r
    .turnin 95318 >>Rends Un goût de cendre
    .accept 95319 >>Accepte Collection cristalline
    .target 263757
step
    .goto 2482,48.26,85.72
    >>Retourne voir le |cRXP_FRIENDLY_Corbeau curieux|r
    .turnin 95317 >>Rends Prise de notes
    .accept 95380 >>Accepte Une source prolifique
    .accept 96262 >>Accepte Pommes de pin piquantes
    .target 257753
step
    .goto 2482,46.70,86.20
    >>Ramasse les |cRXP_PICK_Pommes de pin piquantes|r sous les arbres sains
    .complete 96262,1 --Pomme de pin piquante (10)
step
    .goto 2482,48.06,82.64
    >>Ramasse la |cRXP_PICK_Gelée gangrenée cristallisée intacte|r
    .complete 95319,2 --Cristal de gelée gangrenée intact
step
    .goto 2482,44.00,79.00
    >>Autour des bassins de gelée, ramasse les |cRXP_PICK_Gelées gangrenées cristallisées|r et tue les |cRXP_ENEMY_Gelées nocives|r pour leur |cRXP_LOOT_Limon|r
    .complete 95319,1 --Cristal de gelée gangrenée (8)
    .complete 95380,1 --Limon de gelée gangrenée (8)
    .mob 243509
step
    .goto 2482,48.26,85.72
    >>Retourne voir le |cRXP_FRIENDLY_Corbeau curieux|r
    .turnin 95380 >>Rends Une source prolifique
    .turnin 96262 >>Rends Pommes de pin piquantes
    .accept 95316 >>Accepte La méthode expérimentale
    .target 257753
step
    .goto 2482,48.58,73.54
    >>Retourne voir |cRXP_FRIENDLY_Gangrechique|r
    .turnin 95319 >>Rends Collection cristalline
    .accept 95378 >>Accepte Les têtes de l'hydre
    .accept 95379 >>Accepte Une si douce vengeance
    .target 263757
step
    .goto 2482,49.50,70.50
    >>Lance les pommes de pin sur les établis du Règne des cendres dans le camp des acolytes. |cRXP_WARN_Établis absents de QuestieDB : cherche-les dans le camp|r
    .complete 95316,1
    .use 273323
step
    .goto 2482,47.50,70.00
    >>Tue |cRXP_ENEMY_Brashann Mornesombre|r et prends sa pierre d'âme, puis les trois chefs : |cRXP_ENEMY_Tyaeha Noirserment|r, |cRXP_ENEMY_Dazka Noirsommeil|r et |cRXP_ENEMY_Frezzlie Popsiffle|r (vers les bassins au sud-ouest)
    .complete 95379,1 --Brashann Mornesombre
    .complete 95378,1 --Os de Tyaeha
    .complete 95378,2 --Os de Dazka
    .complete 95378,3 --Os de Frezzlie
    .mob 260440
    .mob 260444
    .mob 260443
    .mob 260818
step
    .goto 2482,48.58,73.54
    >>Retourne voir |cRXP_FRIENDLY_Gangrechique|r
    .turnin 95378 >>Rends Les têtes de l'hydre
    .turnin 95379 >>Rends Une si douce vengeance
    .accept 96435 >>Accepte Une fin de circonstance
    .target 263757
step
    .goto 2482,40.80,80.20
    >>Jette les os sur le |cRXP_PICK_Tas d'os|r près des bassins de gelée
    .turnin 96435 >>Rends Une fin de circonstance
    .accept 96255 >>Accepte Amalgame de moelle
step
    .goto 2482,40.71,80.36
    >>Tue la |cRXP_ENEMY_Gelée gangrecendre éveillée|r. |cRXP_WARN_Élite 58 : en duo|r
    .complete 96255,1 --Gelée gangrecendre éveillée
    .mob 264306
step
    .goto 2482,36.67,78.25
    >>Va un peu à l'ouest voir |cRXP_FRIENDLY_Vélician|r
    .accept 96321 >>Accepte Le dieu mourant
    .target 278305
step
    .goto 2482,48.58,73.54
    >>Retourne voir |cRXP_FRIENDLY_Gangrechique|r
    .turnin 96255 >>Rends Amalgame de moelle
    .accept 96322 >>Accepte Une si amère vengeance
    .target 263757
step
    .goto 2482,48.26,85.72
    >>Retourne voir le |cRXP_FRIENDLY_Corbeau curieux|r
    .turnin 95316 >>Rends La méthode expérimentale
    .turnin 96322 >>Rends Une si amère vengeance
    .turnin 96321 >>Rends Le dieu mourant
    .accept 96131 >>Accepte Vieux débris et vieil ami
    .accept 94782 >>Accepte Le poste ouest
    .target 257753

-- ===== Ketharas, Long-guet et Reflet-de-Lune =====
step
    .goto 2482,73.34,81.88
    >>Retourne à l'est voir |cRXP_FRIENDLY_Ketharas|r
    .turnin 96131 >>Rends Vieux débris et vieil ami
    .accept 92612 >>Accepte De l'aide de Reflet-de-Lune
    .target 256222
step
    .goto Winterspring,61.33,36.92
    >>Au point de vol de |cRXP_FRIENDLY_Jacinth|r, vole vers Long-guet et parle à |cRXP_FRIENDLY_Nami|r. |cRXP_WARN_Il faut le point de vol de Long-guet|r
    .turnin 92008 >>Rends Pièces de premier choix
    .accept 92009 >>Accepte Cargaison délicate
    .target 228216
step
    .goto Moonglade,56.21,30.64
    >>Va à Reflet-de-Lune et parle à |cRXP_FRIENDLY_Dendrite Starblaze|r à Nighthaven. |cRXP_WARN_Vol depuis Long-guet si tu as le point de vol de Reflet-de-Lune, sinon à pied par le repaire des Grumegueules (trajet non vérifié)|r
    .turnin 92612 >>Rends De l'aide de Reflet-de-Lune
    .accept 96209 >>Accepte Orokai l'ancien
    .target 11802
step
    .goto Moonglade,41.45,43.63
    >>Parle à |cRXP_FRIENDLY_Orokai|r, l'ancien près du lac
    .turnin 96209 >>Rends Orokai l'ancien
    .accept 95006 >>Accepte Puissance dérobée
    .target 216289
step
    .goto Moonglade,56.21,30.64
    >>Retourne voir |cRXP_FRIENDLY_Dendrite Starblaze|r
    .turnin 95006 >>Rends Puissance dérobée
    .accept 93773 >>Accepte Le Pacte
    .target 11802
step
    .goto Moonglade,32.09,66.61
    >>Parle à |cRXP_FRIENDLY_Faustron|r
    .fp Moonglade >>Prends le point de vol de Reflet-de-Lune
    .target 12740
step
    .goto 2482,73.34,81.88
    >>Vole vers Long-guet puis les contreforts Corrompus, et retourne voir |cRXP_FRIENDLY_Ketharas|r
    .turnin 93773 >>Rends Le Pacte
    .accept 96930 >>Accepte La corneille capricieuse
    .accept 92171 >>Accepte Prendre de la hauteur
    .target 256222
step
    .goto 2482,48.26,85.72
    >>Retourne voir le |cRXP_FRIENDLY_Corbeau curieux|r
    .turnin 96930 >>Rends La corneille capricieuse
    .accept 96931 >>Accepte En haut de la montagne
    .target 257753
step
    .goto 2482,60.10,61.18
    >>Apporte la caisse à |cRXP_FRIENDLY_Kaylaena Murmeprintemps|r
    .turnin 92009 >>Rends Cargaison délicate
    .accept 92011 >>Accepte Fouille de débris
    .target 249235

-- ===== Sanctuaire d'Aviana =====
step
    .goto 2482,54.31,63.95
    >>Parle au |cRXP_FRIENDLY_Seigneur du ciel Omnuron|r au sanctuaire d'Aviana
    .turnin 92171 >>Rends Prendre de la hauteur
    .accept 92500 >>Accepte Un morceau de ciel
    .accept 91883 >>Accepte La lance du seigneur du ciel
    .target 254131
step
    .goto 2482,54.48,63.91
    >>Parle à |cRXP_FRIENDLY_Phoebe Hauteplume|r
    .accept 96252 >>Accepte Trésors ternis
    .target 260825
step
    #completewith Joyau
    .goto 2482,49.00,58.50,0
    >>Fouille les nids des harpies pour les |cRXP_PICK_Bracelets ternis|r et tue |cRXP_ENEMY_Zarrat Aile-de-ver|r pour la |cRXP_LOOT_Lance d'Omnuron|r
    .complete 96252,1 --Bracelet terni des Hauteplume (8)
    .complete 91883,1 --Lance d'Omnuron
    .mob 260826
    .mob 249221
    .mob 249222
step
    #label Joyau
    .goto 2482,47.75,59.45
    >>Prends le |cRXP_PICK_Joyau de l'horizon|r dans un nid
    .complete 92500,1 --Le Joyau de l'horizon
step
    .goto 2482,48.50,56.30
    >>Clique l'|cRXP_PICK_Excroissance corrompue|r
    .accept 96296 >>Accepte Corruption fétide
step
    .goto 2482,48.50,56.30
    >>Arrache les |cRXP_PICK_Noeuds corrompus|r des arbres voisins
    .complete 96296,1 --Noeud corrompu (6)
step
    .goto 2482,49.00,58.50
    >>Finis les |cRXP_PICK_Bracelets ternis|r et |cRXP_ENEMY_Zarrat Aile-de-ver|r
    .complete 96252,1 --Bracelet terni des Hauteplume (8)
    .complete 91883,1 --Lance d'Omnuron
    .mob 260826
    .unitscan 260826
step
    .goto 2482,54.48,63.91
    >>Retourne voir |cRXP_FRIENDLY_Phoebe Hauteplume|r
    .turnin 96252 >>Rends Trésors ternis
    .turnin 96296 >>Rends Corruption fétide
    .target 260825
step
    .goto 2482,54.31,63.95
    >>Parle au |cRXP_FRIENDLY_Seigneur du ciel Omnuron|r
    .turnin 91883 >>Rends La lance du seigneur du ciel
    .target 254131

-- ===== Berceau de la Tranquillité : les dieux sauvages =====
step
    .goto 2482,41.27,45.33
    >>Va au berceau de la Tranquillité. Touche l'effigie de corbeau sur le pont qui le surplombe, puis parle à |cRXP_FRIENDLY_Jereman|r. |cRXP_WARN_Effigie absente de QuestieDB|r
    .turnin 96931 >>Rends En haut de la montagne
    .accept 96939 >>Accepte L'équilibre entre la vie et la mort
    .accept 96964 >>Accepte Une créature intelligente
    .accept 96978 >>Accepte Venaison violente
    .target 267158
step
    .goto 2482,28.68,43.04
    >>Va à l'ouest voir |cRXP_FRIENDLY_Kala'th|r
    .turnin 96978 >>Rends Venaison violente
    .accept 93617 >>Accepte Proies et prédateurs
    .target 255693
step
    .goto 2482,33.00,42.50
    >>Dissuade les |cRXP_ENEMY_Cerfs d'Hyjal prédateurs|r
    .complete 93617,1 --Cerf prédateur dissuadé
    .mob 256809
step
    .goto 2482,28.68,43.04
    >>Retourne voir |cRXP_FRIENDLY_Kala'th|r
    .turnin 93617 >>Rends Proies et prédateurs
    .target 255693
step
    .goto 2482,27.10,49.99
    >>Va au sud voir |cRXP_FRIENDLY_Marrosis|r
    .turnin 96939 >>Rends L'équilibre entre la vie et la mort
    .accept 92317 >>Accepte Vie volée
    .accept 96957 >>Accepte Reposer ses vieux os
    .target 267113
step
    .goto 2482,32.89,54.44
    >>Parle à |cRXP_FRIENDLY_Galvinquam Feuilsyre|r
    .accept 96979 >>Accepte Sacré rafraîchissement
    .target 267109
step
    .goto 2482,32.89,54.44,20
    >>Remplis la gourde de Galvinquam à la cascade juste devant. |cRXP_WARN_Cascade absente de QuestieDB|r
    .complete 96979,1
    .use 275991
step
    .goto 2482,32.89,54.44
    >>Retourne voir |cRXP_FRIENDLY_Galvinquam Feuilsyre|r
    .turnin 96979 >>Rends Sacré rafraîchissement
    .accept 96991 >>Accepte Assistance d'expédition
    .target 267109

-- ===== Elderwild et ruines du Fléau =====
step
    .goto 2482,20.38,59.20
    >>Va à l'ouest et parle au |cRXP_FRIENDLY_Vétéran de la Troisième guerre|r
    .accept 92100 >>Accepte Ne restons pas ici
    .target 255009
step
    .goto 2482,18.80,62.01
    >>Parle à |cRXP_FRIENDLY_Eluneth|r
    .accept 90865 >>Accepte Les ruines ont des yeux
    .target 264089
step
    .goto 2482,13.82,54.75
    >>Au camp de la Horde d'Elderwild, parle à |cRXP_FRIENDLY_Zet'gan|r
    .turnin 94782 >>Rends Le poste ouest
    .accept 95026 >>Accepte Le Fléau, c'est fini
    .accept 92609 >>Accepte Vol de plumes
    .target 244511
step
    .goto 2482,13.82,54.75
    >>Parle à |cRXP_FRIENDLY_Zet'gan|r
    .accept 92592 >>Accepte Mort de chez mort
    .target 244511
    .xp <57,1
step
    .goto 2482,12.93,52.85
    >>Parle à |cRXP_FRIENDLY_Ortak Lomgok|r, l'aubergiste
    .turnin 96830 >>Rends Don de long-voyance
    .target 244512
step
    .goto 2482,8.79,46.46
    >>Au belvédère au nord-ouest, ramasse le |cRXP_PICK_Fourreau brodé|r
    .turnin 92100 >>Rends Ne restons pas ici
    .accept 96550 >>Accepte Rappel du combat
step
    .goto 2482,8.79,46.46,10
    >>Utilise le |cRXP_LOOT_Fourreau brodé|r pour faire venir le vétéran et écoute son histoire
    .complete 96550,1
    .use 274795
step
    .goto 2482,8.79,46.46
    >>Parle au |cRXP_FRIENDLY_Vétéran de la Troisième guerre|r
    .turnin 96550 >>Rends Rappel du combat
    .target 255038
step
    #completewith Ruines
    >>Dans les ruines du Fléau, tue les |cRXP_ENEMY_Voraces écorcheurs|r et les |cRXP_ENEMY_Soldats oubliés|r et ramasse une |cRXP_LOOT_Goutte de vie volée|r. |cRXP_WARN_Attention aux Pleureuses de la mort (élites rares 61)|r
    .complete 95026,1 --Soldat oublié (3)
    .complete 95026,2 --Vorace écorcheur (12)
    .complete 92317,1 --Goutte de vie volée
    .mob 249228
    .mob 249247
step
    .goto 2482,22.60,47.50
    >>Utilise la |cRXP_LOOT_Torche du survivant|r sur le tas d'os près des |cRXP_ENEMY_Réanimateurs du Fléau|r, puis ramasse l'|cRXP_LOOT_Amulette du réanimateur|r
    .complete 92592,1 --Amulette du réanimateur
    .use 274411
    .mob 260148
    .isOnQuest 92592
step
    .goto 2482,22.89,46.00
    >>Tue les |cRXP_ENEMY_Factionnaires éternels|r (gargouilles du camp de l'Alliance détruit) pour leurs |cRXP_LOOT_Yeux|r. |cRXP_WARN_Farm long en duo (~46 kills) : chacun doit looter ses objets|r
    .complete 90865,1 --Oeil du guetteur (8)
    .mob 249237
step
    #label Ruines
    .goto 2482,24.40,52.40
    >>Ramasse les |cRXP_PICK_Piles d'os blanchis|r
    .complete 96957,1 --Os blanchi par le soleil (20)
step
    .goto 2482,22.00,53.00
    >>Finis les |cRXP_ENEMY_Voraces|r, les |cRXP_ENEMY_Soldats oubliés|r et la |cRXP_LOOT_Goutte de vie volée|r
    .complete 95026,1 --Soldat oublié (3)
    .complete 95026,2 --Vorace écorcheur (12)
    .complete 92317,1 --Goutte de vie volée
    .mob 249228
    .mob 249247
step
    .goto 2482,27.10,49.99
    >>Retourne voir |cRXP_FRIENDLY_Marrosis|r
    .turnin 96957 >>Rends Reposer ses vieux os
    .target 267113

-- ===== Terrier Peau-d'écorce et tanière Mort-bois =====
step
    .goto 2482,31.50,58.62
    >>Parle à la |cRXP_FRIENDLY_Matriarche peau-d'écorce|r dans sa cage
    .accept 91698 >>Accepte L'évasion des Peau-d'écorce
    .target 244425
step
    .goto 2482,28.00,59.00
    >>Tue un |cRXP_ENEMY_Gardien mort-bois|r pour sa |cRXP_LOOT_Clé|r
    .complete 91698,1 --Clé mort-bois
    .mob 259874
step
    .goto 2482,31.50,58.62
    >>Libère la |cRXP_FRIENDLY_Matriarche peau-d'écorce|r et lance l'escorte
    .turnin 91698 >>Rends L'évasion des Peau-d'écorce
    .accept 91696 >>Accepte La saison est ouverte
    .target 244425
step
    .goto 2482,20.56,71.73
    >>Escorte la |cRXP_FRIENDLY_Matriarche|r hors de la tanière et jusqu'au terrier Peau-d'écorce. Tue ce qui l'attaque, puis parle à |cRXP_FRIENDLY_Brerufa|r
    .turnin 91696 >>Rends La saison est ouverte
    .accept 93952 >>Accepte L'équilibre par la force
    .target 256978
step
    .goto 2482,20.16,77.99
    >>Parle à |cRXP_FRIENDLY_Fennar Crin-de-mousse|r au terrier
    .accept 93828 >>Accepte Les herbes du creux
    .accept 93830 >>Accepte L'eau d'Hyjal
    .target 256626
step
    .goto 2482,21.00,78.50
    >>Ramasse les |cRXP_PICK_Herbes séchées suspendues|r autour du terrier
    .complete 93828,1
step
    .goto 2482,36.00,68.50
    >>Va à la tanière Mort-bois à l'est. Tue les |cRXP_ENEMY_Gardes-tanière mort-bois|r et remplis l'outre à la mare devant la tanière
    .complete 93952,1 --Garde-tanière mort-bois (9)
    .complete 93830,1 --Outre d'eau d'Hyjal remplie
    .use 263029
    .mob 252063
step
    .goto 2482,20.56,71.73
    >>Retourne voir |cRXP_FRIENDLY_Brerufa|r
    .turnin 93952 >>Rends L'équilibre par la force
    .accept 92111 >>Accepte Des amis et des fourrures
    .target 256978
step
    .goto 2482,20.16,77.99
    >>Parle à |cRXP_FRIENDLY_Fennar Crin-de-mousse|r
    .turnin 93828 >>Rends Les herbes du creux
    .turnin 93830 >>Rends L'eau d'Hyjal
    .accept 95273 >>Accepte L'eau d'Hyjal (tonique)
    .target 256626
step
    .goto 2482,21.08,80.19
    >>Entre dans le terrier et parle à |cRXP_FRIENDLY_Osi Patte-de-brume|r
    .turnin 92111 >>Rends Des amis et des fourrures
    .accept 93831 >>Accepte Confiture patte-douce
    .target 256646
step
    #completewith Baies
    >>Ramasse les |cRXP_PICK_Nids de chouette d'Hyjal|r et tue les |cRXP_ENEMY_Chouettes d'Hyjal|r pour leurs |cRXP_LOOT_Plumes|r
    .complete 92609,1 --Plume de chouette d'Hyjal (9)
    .mob 249053
step
    #label Baies
    .goto 2482,28.20,71.00
    >>Ramasse les |cRXP_PICK_Baies des ours|r à l'est du terrier
    .complete 93831,1 --Baie des ours (30)
step
    .goto 2482,21.08,80.19
    >>Retourne voir |cRXP_FRIENDLY_Osi Patte-de-brume|r
    .turnin 93831 >>Rends Confiture patte-douce
    .accept 91697 >>Accepte Rencontre avec les anciens
    .target 256646
step
    .goto 2482,21.77,78.98
    >>Parle à l'|cRXP_FRIENDLY_Ancienne Patte-de-brume|r
    .turnin 91697 >>Rends Rencontre avec les anciens
    .accept 93826 >>Accepte Semer la mort au bois
    .target 256627
step
    .goto 2482,21.77,79.18
    >>Parle à l'|cRXP_FRIENDLY_Ancien Parlepin|r
    .accept 93833 >>Accepte Sagesse corrompue
    .accept 95108 >>Accepte Mélange mystique
    .target 256650
step
    .goto 2482,20.80,79.80
    >>Parle à |cRXP_FRIENDLY_Suma Crin-de-mousse|r
    .accept 93825 >>Accepte Bénédictions liées par l'écorce
    .target 260661
step
    #completewith Taniere
    >>Ramasse la |cRXP_PICK_Mousse voile-de-lune|r, tue les |cRXP_ENEMY_Chouettes d'Hyjal|r pour leurs |cRXP_LOOT_Corps|r et finis les |cRXP_LOOT_Plumes|r
    .complete 93825,1 --Mousse voile-de-lune (12)
    .complete 93833,1 --Corps de chouette intact (5)
    .complete 92609,1 --Plume de chouette d'Hyjal (9)
    .mob 249053
step
    #label Taniere
    .goto 2482,33.20,69.00
    >>Dans la tanière Mort-bois, tue les |cRXP_ENEMY_Totémiques|r et |cRXP_ENEMY_Soigne-gangrène|r, deux mystiques de la mort et leurs chaudrons, et vide le tonique dans l'eau au fond de la tanière
    .complete 93826,1 --Totémique mort-bois (8)
    .complete 93826,2 --Soigne-gangrène mort-bois (8)
    .complete 95108,1
    .complete 95273,1
    .use 274373
    .mob 252116
    .mob 252096
step
    .goto 2482,34.50,68.00
    >>Finis la |cRXP_PICK_Mousse|r, les |cRXP_LOOT_Corps|r et les |cRXP_LOOT_Plumes de chouette|r
    .complete 93825,1 --Mousse voile-de-lune (12)
    .complete 93833,1 --Corps de chouette intact (5)
    .complete 92609,1 --Plume de chouette d'Hyjal (9)
    .mob 249053
step
    .goto 2482,21.77,79.18
    >>Retourne au terrier voir l'|cRXP_FRIENDLY_Ancien Parlepin|r
    .turnin 93826 >>Rends Semer la mort au bois
    .turnin 93833 >>Rends Sagesse corrompue
    .target 256650
step
    .goto 2482,21.77,78.98
    >>Parle à l'|cRXP_FRIENDLY_Ancienne Patte-de-brume|r
    .turnin 95108 >>Rends Mélange mystique
    .target 256627
step
    .goto 2482,20.80,79.80
    >>Parle à |cRXP_FRIENDLY_Suma Crin-de-mousse|r
    .turnin 93825 >>Rends Bénédictions liées par l'écorce
    .target 260661
step
    .goto 2482,20.16,77.99
    >>Parle à |cRXP_FRIENDLY_Fennar Crin-de-mousse|r
    .turnin 95273 >>Rends L'eau d'Hyjal (tonique)
    .target 256626
step
    .goto 2482,18.80,62.01
    >>Remonte au nord voir |cRXP_FRIENDLY_Eluneth|r
    .turnin 90865 >>Rends Les ruines ont des yeux
    .target 264089
step
    .goto 2482,13.82,54.75
    >>Retourne voir |cRXP_FRIENDLY_Zet'gan|r à Elderwild
    .turnin 95026 >>Rends Le Fléau, c'est fini
    .turnin 92609 >>Rends Vol de plumes
    .target 244511
step
    .goto 2482,13.82,54.75
    >>Parle à |cRXP_FRIENDLY_Zet'gan|r
    .turnin 92592 >>Rends Mort de chez mort
    .target 244511
    .isOnQuest 92592
step
    .goto 2482,13.82,54.75
    >>Parle à |cRXP_FRIENDLY_Zet'gan|r
    .accept 95248 >>Accepte Au sommet d'Éternité
    .target 244511
    .isQuestTurnedIn 92592

-- ===== Renalard et Dae'gun =====
step
    .goto 2482,60.04,49.35
    >>Traverse le berceau vers l'est et parle à |cRXP_FRIENDLY_Renalard|r, au pied du sommet
    .turnin 96964 >>Rends Une créature intelligente
    .accept 92335 >>Accepte Les cendres de l'ascension de la Légion
    .accept 96971 >>Accepte Plus rusé qu'un démon
    .target 259695
step
    .goto 2482,43.77,32.24
    >>Monte à Dae'gun au nord-ouest et parle à |cRXP_FRIENDLY_Elaena Murmelune|r
    .accept 92960 >>Accepte Essence éphémère siphonnée
    .target 263406
step
    .goto 2482,49.33,32.63
    >>Parle à |cRXP_FRIENDLY_Yashiro|r
    .accept 96959 >>Accepte Les feux de joie des maîtres-lames
    .target 267121
step
    .goto 2482,49.39,34.48
    >>Prends une pincée de cendres sur le |cRXP_PICK_Cadavre d'Azgalor|r
    .complete 92335,1 --Cendres d'Azgalor
step
    .goto 2482,50.50,34.00,20
    >>Allume les deux feux de joie de Dae'gun. |cRXP_WARN_Feux absents de QuestieDB : cherche-les dans les ruines|r
    .complete 96959,1
step
    .goto 2482,54.50,37.00
    >>Dans l'ancienne base de la Horde, ramasse les |cRXP_PICK_Fournitures abandonnées|r, les |cRXP_PICK_Enchevêtrements de câbles|r, les |cRXP_PICK_Excréments calcifiés|r et le métal (|cRXP_PICK_Dômes ternis|r, |cRXP_PICK_Morceaux de métal|r)
    .complete 96971,1 --Fournitures abandonnées (8)
    .complete 92011,1 --Fil endommagé (5)
    .complete 92011,2 --Excrément calcifié (5)
    .complete 92011,3 --Morceau de métal déformé (5)
step
    .goto 2482,63.32,25.89
    >>Va au nord-est voir |cRXP_FRIENDLY_Maerion Thaelemaches|r
    .turnin 91877 >>Rends La chasse aux chasseurs de démons
    .target 267097
    .isOnQuest 91877
step
    .goto 2482,63.32,25.89
    >>Parle à |cRXP_FRIENDLY_Maerion Thaelemaches|r
    .accept 97009 >>Accepte La détresse de Maerion
    .target 267097
step
    .goto 2482,62.00,33.00
    >>Tue les |cRXP_ENEMY_Molosses profanateurs|r pour leurs |cRXP_LOOT_Pointes|r et leurs |cRXP_LOOT_Essences éphémères|r. |cRXP_WARN_Farm long en duo (~69 kills) : chacun doit looter ses objets|r
    .complete 97009,1 --Pointe de molosse (12)
    .complete 92960,1 --Essence éphémère (6)
    .mob 249230
step
    .goto 2482,63.32,25.89
    >>Retourne voir |cRXP_FRIENDLY_Maerion Thaelemaches|r
    .turnin 97009 >>Rends La détresse de Maerion
    .accept 97010 >>Accepte Vengeance aveugle
    .target 267097
step
    .goto 2482,63.32,25.89,30
    >>Monte en haut de la tour des mages de la Horde et lance un |cRXP_LOOT_Éclat runique explosif|r pour donner le signal. |cRXP_WARN_Tour absente de QuestieDB : elle est dans Dae'gun|r
    .complete 97010,1
    .use 276145
step
    .goto 2482,63.32,25.89
    >>Retourne voir |cRXP_FRIENDLY_Maerion Thaelemaches|r
    .turnin 97010 >>Rends Vengeance aveugle
    .target 267097
step
    .goto 2482,49.33,32.63
    >>Retourne voir |cRXP_FRIENDLY_Yashiro|r
    .turnin 96959 >>Rends Les feux de joie des maîtres-lames
    .target 267121
step
    .goto 2482,49.33,32.63
    >>Parle à |cRXP_FRIENDLY_Yashiro|r
    .accept 96983 >>Accepte La marche du vent de Yashiro
    .target 267121
    .xp <59,1
step
    .goto 2482,58.00,30.00
    >>Traverse Dae'gun avec |cRXP_FRIENDLY_Yashiro|r et tue le |cRXP_ENEMY_Garde funeste Xarkul|r. |cRXP_WARN_Élite 61 : en duo, avec Yashiro|r
    .complete 96983,1 --Garde funeste Xarkul
    .mob 267439
    .isOnQuest 96983
step
    .goto 2482,49.33,32.63
    >>Retourne voir |cRXP_FRIENDLY_Yashiro|r
    .turnin 96983 >>Rends La marche du vent de Yashiro
    .target 267121
    .isOnQuest 96983
step
    .goto 2482,43.77,32.24
    >>Retourne voir |cRXP_FRIENDLY_Elaena Murmelune|r
    .turnin 92960 >>Rends Essence éphémère siphonnée
    .target 263406
step
    .goto 2482,43.77,32.24
    >>Parle à |cRXP_FRIENDLY_Elaena Murmelune|r
    .accept 96003 >>Accepte À bas la malveillance
    .target 263406
    .xp <59,1
step
    .goto 2482,50.40,38.20
    >>Utilise l'|cRXP_LOOT_Oeil de l'influence sans fin|r sur |cRXP_ENEMY_Mazzotripe|r puis sur |cRXP_ENEMY_Bethra'zel|r (plus à l'est) et achève-les. |cRXP_WARN_Élites 60 : en duo|r
    .complete 96003,1 --Bethra'zel
    .complete 96003,2 --Mazzotripe
    .use 271879
    .mob 252457
    .mob 263394
    .isOnQuest 96003
step
    .goto 2482,43.77,32.24
    >>Retourne voir |cRXP_FRIENDLY_Elaena Murmelune|r
    .turnin 96003 >>Rends À bas la malveillance
    .accept 96025 >>Accepte À vol d'oiseau
    .target 263406
    .isOnQuest 96003
step
    .goto 2482,60.04,49.35
    >>Retourne voir |cRXP_FRIENDLY_Renalard|r
    .turnin 96971 >>Rends Plus rusé qu'un démon
    .target 259695

-- ===== Sommet d'Éternité =====
step
    .goto 2482,68.71,46.80
    >>Monte au sommet d'Éternité et parle à |cRXP_FRIENDLY_Fayran Elthas|r
    .fp Summit of Eternity >>Prends le point de vol du sommet d'Éternité
    .target 41861
step
    .goto 2482,68.85,50.60
    >>Parle à |cRXP_FRIENDLY_Tiala Blanchetête|r
    .turnin 92020 >>Rends Le Grand Livre des gros lézards d'Hol'anyee
    .target 40833
    .isOnQuest 92020
step
    .goto 2482,68.85,50.60
    >>Parle à |cRXP_FRIENDLY_Tiala Blanchetête|r
    .accept 93407 >>Accepte Une épine dans la patte
    .target 40833
step
    .goto 2482,68.99,49.99
    >>Parle à |cRXP_FRIENDLY_Thisalee Corbeau|r
    .turnin 96025 >>Rends À vol d'oiseau
    .target 254915
    .isOnQuest 96025
step
    .goto 2482,68.99,49.99
    >>Parle à |cRXP_FRIENDLY_Thisalee Corbeau|r
    .turnin 95248 >>Rends Au sommet d'Éternité
    .target 254915
    .isOnQuest 95248
step
    .goto 2482,68.99,49.99
    >>Parle à |cRXP_FRIENDLY_Thisalee Corbeau|r
    .accept 93584 >>Accepte Dissolution du culte
    .target 254915
step
    .goto 2482,68.30,46.71
    >>Parle à |cRXP_FRIENDLY_Marn Eucorne|r
    .turnin 96991 >>Rends Assistance d'expédition
    .target 264795
step
    .goto 2482,68.88,48.35
    >>Parle à |cRXP_FRIENDLY_Toron Sabot-de-roche|r
    .accept 92533 >>Accepte Outils corrompus
    .target 243855
step
    .goto 2482,70.66,51.25
    >>Parle à |cRXP_FRIENDLY_Rhylin Pierrépine|r
    .accept 93422 >>Accepte Obscurcissement noirépine
    .target 255151
    .xp <59,1

-- ===== Retour aux contreforts : Kaylaena et Ketharas =====
step
    .goto 2482,60.10,61.18
    >>Vole vers les contreforts Corrompus, puis monte voir |cRXP_FRIENDLY_Kaylaena Murmeprintemps|r
    .turnin 92011 >>Rends Fouille de débris
    .accept 92328 >>Accepte Ingénierie de siège
    .target 249235
step
    .goto 2482,60.10,61.18,10
    >>Tourne les deux engrenages et connecte les deux bornes de la baliste à glaives de Kaylaena
    .complete 92328,1
step
    .goto 2482,60.10,61.18
    >>Parle à |cRXP_FRIENDLY_Kaylaena Murmeprintemps|r
    .turnin 92328 >>Rends Ingénierie de siège
    .accept 92329 >>Accepte Tambour de guerre
    .target 249235
step
    .goto 2482,57.20,64.50,15
    >>Sur la crête au sud de l'atelier, fais assez de bruit pour attirer la chimère |cRXP_ENEMY_Ghansurok|r à portée de la baliste. |cRXP_WARN_Élite 61 : laisse la baliste travailler|r
    .complete 92329,1
    .mob 251488
step
    .goto 2482,60.10,61.18
    >>Retourne voir |cRXP_FRIENDLY_Kaylaena Murmeprintemps|r
    .turnin 92329 >>Rends Tambour de guerre
    .target 249235
step
    .goto 2482,73.34,81.88
    >>Va voir |cRXP_FRIENDLY_Ketharas|r
    .turnin 92317 >>Rends Vie volée
    .turnin 92335 >>Rends Les cendres de l'ascension de la Légion
    .turnin 92500 >>Rends Un morceau de ciel
    .target 256222
step
    .goto 2482,73.34,81.88
    >>Parle à |cRXP_FRIENDLY_Ketharas|r
    .accept 90647 >>Accepte Le bâton de la montagne
    .target 256222

-- ===== Le pacte Noirépine =====
step
    .goto 2482,68.85,50.60
    >>Vole vers le sommet d'Éternité et apporte le bâton à |cRXP_FRIENDLY_Tiala Blanchetête|r
    .turnin 90647 >>Rends Le bâton de la montagne
    .accept 92169 >>Accepte L'heure est à la vengeance
    .target 40833
step
    #completewith Epines
    .goto 2482,73.00,38.00,0
    >>Utilise le |cRXP_LOOT_Bâton de la montagne|r sur les membres du pacte Noirépine pour briser leurs protections, puis tue-les. Prends au passage un |cRXP_LOOT_Kriss|r (sectateurs) et un |cRXP_LOOT_Bâton|r (adeptes)
    .complete 92169,1
    .complete 93584,1 --Sectateur noirépine (10)
    .complete 93584,2 --Adepte noirépine (10)
    .complete 92533,1 --Kriss de ritualiste maléfique
    .complete 92533,2 --Bâton de noueux-écorce
    .use 267079
    .mob 264570
    .mob 249551
step
    #label Epines
    .goto 2482,74.70,40.10
    >>Ramasse les |cRXP_PICK_Graines d'épine|r sur les buissons épineux
    .complete 93407,1 --Graine d'épine
step
    .goto 2482,75.80,34.20
    >>Tue la |cRXP_ENEMY_Messagère noirépine|r qui patrouille et prends son message. |cRXP_WARN_Élite 60 : en duo|r
    .complete 93422,1 --Messagère noirépine
    .complete 93422,2 --Renseignements noirépine
    .mob 264508
    .unitscan 264508
    .isOnQuest 93422
step
    .goto 2482,76.90,35.40
    >>Lis l'|cRXP_PICK_Étagère de livres|r
    .accept 93521 >>Accepte Le provocateur des dieux
    .xp <57,1
step
    .goto 2482,73.00,38.00
    >>Finis le pacte Noirépine : les protections, les |cRXP_ENEMY_Adeptes|r, les |cRXP_ENEMY_Sectateurs|r et les deux armes
    .complete 92169,1
    .complete 93584,1 --Sectateur noirépine (10)
    .complete 93584,2 --Adepte noirépine (10)
    .complete 92533,1 --Kriss de ritualiste maléfique
    .complete 92533,2 --Bâton de noueux-écorce
    .use 267079
    .mob 264570
    .mob 249551
step
    .goto 2482,68.85,50.60
    >>Retourne voir |cRXP_FRIENDLY_Tiala Blanchetête|r
    .turnin 92169 >>Rends L'heure est à la vengeance
    .turnin 93407 >>Rends Une épine dans la patte
    .accept 92833 >>Accepte La chute de Ve'han
    .accept 93127 >>Accepte Sentinelles du sommet
    .target 40833
step
    .goto 2482,68.85,50.60
    >>Parle à |cRXP_FRIENDLY_Tiala Blanchetête|r
    .turnin 93521 >>Rends Le provocateur des dieux
    .target 40833
    .isOnQuest 93521
step
    .goto 2482,68.85,50.60
    >>Parle à |cRXP_FRIENDLY_Tiala Blanchetête|r
    .accept 93547 >>Accepte Une solution épineuse
    .target 40833
    .xp <57,1
step
    .goto 2482,70.70,51.00,15
    >>Plante les graines d'épine près de l'auberge, de la tour de stockage et du bosquet du camp des druides loyalistes
    .complete 93547,1
    .use 259268
    .isOnQuest 93547
step
    .goto 2482,68.99,49.99
    >>Parle à |cRXP_FRIENDLY_Thisalee Corbeau|r
    .turnin 93584 >>Rends Dissolution du culte
    .target 254915
step
    .goto 2482,68.88,48.35
    >>Parle à |cRXP_FRIENDLY_Toron Sabot-de-roche|r
    .turnin 92533 >>Rends Outils corrompus
    .target 243855
step
    .goto 2482,70.66,51.25
    >>Parle à |cRXP_FRIENDLY_Rhylin Pierrépine|r
    .turnin 93422 >>Rends Obscurcissement noirépine
    .target 255151
    .isOnQuest 93422
step
    .goto 2482,73.50,39.00,20
    >>Réactive les pierres sentinelles au nord, à l'ouest et au sud des sectateurs Noirépine. |cRXP_WARN_Pierres absentes de QuestieDB|r
    .complete 93127,1
step
    .goto 2482,75.90,34.50
    >>Utilise le |cRXP_LOOT_Bâton de la montagne|r sur |cRXP_ENEMY_Ve'han Poigneserre|r pour lui retirer son pouvoir, puis tue-le. |cRXP_WARN_Élite 60 : en duo|r
    .complete 92833,1 --Ve'han Poigneserre
    .use 267079
    .mob 267182
step
    .goto 2482,68.85,50.60
    >>Retourne voir |cRXP_FRIENDLY_Tiala Blanchetête|r
    .turnin 92833 >>Rends La chute de Ve'han
    .turnin 93127 >>Rends Sentinelles du sommet
    .turnin -93547 >>Rends Une solution épineuse
    .target 40833
step
    .goto 2482,68.85,50.60
    >>Parle à |cRXP_FRIENDLY_Tiala Blanchetête|r
    .accept 93848 >>Accepte Un excellent travail
    .target 40833
step
    .goto 2482,73.34,81.88
    >>Vole vers les contreforts Corrompus et va voir |cRXP_FRIENDLY_Ketharas|r
    .turnin 93848 >>Rends Un excellent travail
    .target 256222
step
    #label FinHyjal
    +|cRXP_WARN_Niveau conseillé pour la suite : 60. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer
]])

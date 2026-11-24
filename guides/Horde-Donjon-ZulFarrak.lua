if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde de Zul'Farrak (nord-ouest de Tanaris), toutes classes.
-- Givers : Mazu'kon (Mulgore), Tabetha (Marécage d'Âprefange), Bilgewhizzle, Trenton
-- Lighthammer et Tran'rek (Gadgetzan). Mage : La mission de Tabetha (2861) chez Deino à
-- Orgrimmar, rendue à Tabetha en même temps que l'accept de La tiare des abysses.
-- Données : QuestieDB Forever (tools/questiedb.py), zones 978 (quêtes) et 1176 (mobs de
-- l'instance). XP de xpDB-classic.lua ; 96775 Tête de Zum'rah absente des deux fichiers XP
-- (XP inconnue). Taux de drop wowheadData : bâtonnet 8548 ~67 % (Sergent Bly), tiare 9234
-- ~61 % (Velratha), carapace 9238 ~10 % (Scarabées, ~100 kills en duo), agent durcissant
-- 9523 12-20 % (trolls Sandfury, ~235 kills en duo pour 20 + 20 : souvent deux passages).
-- Itinéraire : Orgrimmar (mage) -> Mulgore (Mazu'kon) -> Mur-de-Fougères (Tabetha) ->
-- Gadgetzan -> Zul'Farrak -> pierre de foyer Gadgetzan -> Tabetha -> Mazu'kon (fin).
-- Dans l'instance, QuestieDB n'a pas de coordonnées : ordre des boss décrit dans le texte.
-- Entrée : Tanaris 38.69,20.20 (RXP SoD/Rogue.lua).
-- Protégée : 2864 Tran'rek (envoi de Krazek à Baie-du-Butin, autre continent, 390 xp ;
-- 2865 ne l'exige pas), rendu protégé par .isOnQuest.
-- L'agent durcissant (3042) demande souvent deux passages : son rendu, protégé par .isOnQuest,
-- reste affiché tant que la quête est dans le journal (refaire une run puis revenir). Il tombe aussi,
-- moins souvent, sur d'autres trolls de l'instance (2 à 16 %, Ruuzlu et Ukorz compris).
-- Coupées :
--   2770 Gahz'rilla (Gahz'rilla n'apparaît qu'avec le Maillet de Zul'Farrak, chaîne des
--   Hinterlands à Jintha'Alor ; rendu aux Salines miroitantes, sans point de vol Horde),
--   2936 Le dieu-araignée (prérequis 2933-2935 : Hinterlands puis Moulin-de-Tarren, chaîne
--   coupée par le guide des Hinterlands),
--   3527 La prophétie de Mosh'aru (prérequis 3520 Esprits de Hurleurs en Féralas, coupé par
--   le guide de Tanaris),
--   96770 La tête du féticheur et 2991 Médaillon de Nekrum (Alliance).

RXPGuides.RegisterGuide([[
#classic
#forever
<< Horde
#name 44-50 Zul'Farrak
#displayname [FDP] Zul'Farrak (44-50)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Orgrimmar (mage) et Mulgore =====
step << Mage
    .goto Orgrimmar,38.45,86.13
    >>Parle à |cRXP_FRIENDLY_Deino|r, maître des mages dans la Vallée de la Sagesse (ou Anastasia Hartwell à Undercity)
    .accept 2861 >>Accepte La mission de Tabetha
    .target 5885
step
    #completewith Mazukon
    .goto Mulgore,32.50,20.66,40 >>Va voir |cRXP_FRIENDLY_Mazu'kon|r au nord-ouest de Mulgore (vol vers Thunder Bluff)
step
    #label Mazukon
    .goto Mulgore,32.50,20.66
    >>Parle à |cRXP_FRIENDLY_Mazu'kon|r
    .accept 96775 >>Accepte Tête de Zum’rah
    .target 264074

-- ===== Marécage d'Âprefange : Tabetha =====
step
    #completewith Tabetha
    .goto Dustwallow Marsh,46.06,57.09,40 >>Va à la maison de |cRXP_FRIENDLY_Tabetha|r, au centre du Marécage d'Âprefange (vol vers Mur-de-Fougères)
step << Mage
    .goto Dustwallow Marsh,46.06,57.09
    >>Parle à |cRXP_FRIENDLY_Tabetha|r
    .turnin 2861 >>Rends La mission de Tabetha
    .accept 2846 >>Accepte La tiare des abysses
    .target 6546
    .isOnQuest 2861
step
    #label Tabetha
    .goto Dustwallow Marsh,46.06,57.09
    >>Parle à |cRXP_FRIENDLY_Tabetha|r
    .accept 2846 >>Accepte La tiare des abysses
    .target 6546

-- ===== Gadgetzan =====
step
    #completewith ArriveeGadgetzan
    .goto Tanaris,51.60,25.44,40 >>Va à Gadgetzan, au nord de Tanaris
step
    #label ArriveeGadgetzan
    .goto Tanaris,51.60,25.44
    >>Parle à |cRXP_FRIENDLY_Bulkrek Ragefist|r
    .fp Gadgetzan >>Prends le point de vol de Gadgetzan
    .target 7824
step
    .goto Tanaris,52.51,27.91
    >>Parle à l'|cRXP_FRIENDLY_Aubergiste Fizzgrimble|r : tu reviendras ici par la pierre de foyer après l'instance
    .home >>Fixe ta pierre de foyer à Gadgetzan
    .target 7733
step
    .goto Tanaris,52.46,28.51
    >>Parle à l'|cRXP_FRIENDLY_Ingénieur en chef Bilgewhizzle|r
    .accept 2768 >>Accepte Le bâtonnet divino-matic
    .target 7407
step
    .goto Tanaris,51.41,28.75
    >>Parle à |cRXP_FRIENDLY_Trenton Lighthammer|r
    .accept 3042 >>Accepte Agent durcissant troll
    .target 7804
step
    .goto Tanaris,51.57,26.76
    >>Parle à |cRXP_FRIENDLY_Tran'rek|r
    .turnin 2864 >>Rends Tran'rek
    .target 7876
    .isOnQuest 2864
step
    .goto Tanaris,51.57,26.76
    >>Parle à |cRXP_FRIENDLY_Tran'rek|r
    .accept 2865 >>Accepte Les carapaces de Scarabées
    .target 7876

-- ===== Zul'Farrak =====
step
    #sticky
    >>Tue les trolls |cRXP_ENEMY_Sandfury|r pendant toute l'instance pour l'|cRXP_LOOT_Agent durcissant troll|r
    >>|cRXP_WARN_Farm long en duo (~235 kills) : chacun doit looter ses objets. Souvent deux passages ; rends-la seulement si elle est finie|r
    .complete 3042,1 --Agent durcissant troll (20)
    .mob 5648
    .mob 5649
    .mob 5650
    .mob 7246
    .mob 7247
    .mob 7274
    .isOnQuest 3042
step
    #sticky
    >>Tue les |cRXP_ENEMY_Scarabées|r, nombreux autour de Theka le Martyr, pour les |cRXP_LOOT_Carapaces de scarabée intactes|r
    >>|cRXP_WARN_Farm long en duo (~100 kills) : chacun doit looter ses objets|r
    .complete 2865,1 --Carapace de scarabée intacte (5)
    .mob 7269
    .isOnQuest 2865
step
    #label EntreeZF
    .goto Tanaris,38.69,20.20,20 >>Va à Zul'Farrak, au nord-ouest de Tanaris, et entre dans l'instance
step
    >>Monte au cimetière, gardé par les morts-vivants, et tue le |cRXP_ENEMY_Sorcier-docteur Zum'rah|r pour la |cRXP_LOOT_Tête de Zum'rah|r
    .complete 96775,1 --Tête de Zum'rah
    .mob 7271
    .isOnQuest 96775
step
    >>Au bassin sacré, tue l'|cRXP_ENEMY_Hydromancienne Velratha|r pour la |cRXP_LOOT_Tiare des abysses|r
    .complete 2846,1 --Tiare des abysses
    .mob 7795
    .isOnQuest 2846
step
    >>Pyramide : tue le |cRXP_ENEMY_Bourreau Sandfury|r pour la |cRXP_LOOT_Clé du bourreau|r, ouvre la cage du |cRXP_FRIENDLY_Sergent Bly|r pour lancer l'événement des marches et tiens les vagues de trolls. A la fin, |cRXP_ENEMY_Bly|r et son équipe se retournent contre toi : tue-le pour le |cRXP_LOOT_Bâtonnet divino-matic|r
    .complete 2768,1 --Bâtonnet divino-matic
    .mob 7274
    .mob 7604
    .isOnQuest 2768
step
    +Termine par |cRXP_ENEMY_Chef Ukorz Scalpessable|r et |cRXP_ENEMY_Ruuzlu|r, derrière la pyramide. Finis les carapaces et l'agent durcissant avant de sortir si tu le peux. Coche pour continuer
    .mob 7267
    .mob 7797
step
    .hs >>Utilise ta pierre de foyer pour Gadgetzan

-- ===== Rendus : Gadgetzan =====
step
    .goto Tanaris,52.46,28.51
    >>Parle à l'|cRXP_FRIENDLY_Ingénieur en chef Bilgewhizzle|r
    .turnin 2768 >>Rends Le bâtonnet divino-matic
    .target 7407
    .isQuestComplete 2768
step
    .goto Tanaris,51.41,28.75
    >>Parle à |cRXP_FRIENDLY_Trenton Lighthammer|r. |cRXP_WARN_Agent durcissant pas fini : refais une run de Zul'Farrak sur les trolls Furie-des-sables, puis reviens|r
    .turnin 3042 >>Rends Agent durcissant troll
    .target 7804
    .isOnQuest 3042
step
    .goto Tanaris,51.57,26.76
    >>Parle à |cRXP_FRIENDLY_Tran'rek|r
    .turnin 2865 >>Rends Les carapaces de Scarabées
    .target 7876
    .isQuestComplete 2865

-- ===== Rendus : Tabetha et Mazu'kon =====
step
    #completewith RenduTabetha
    .goto Dustwallow Marsh,46.06,57.09,40 >>Retourne chez |cRXP_FRIENDLY_Tabetha|r (vol vers Mur-de-Fougères)
    .isQuestComplete 2846
step
    #label RenduTabetha
    .goto Dustwallow Marsh,46.06,57.09
    >>Parle à |cRXP_FRIENDLY_Tabetha|r
    .turnin 2846 >>Rends La tiare des abysses
    .target 6546
    .isQuestComplete 2846
step
    #completewith FinZulFarrak
    .goto Mulgore,32.50,20.66,40 >>Retourne voir |cRXP_FRIENDLY_Mazu'kon|r au nord-ouest de Mulgore (vol vers Thunder Bluff)
    .isQuestComplete 96775
step
    #label FinZulFarrak
    .goto Mulgore,32.50,20.66
    >>Parle à |cRXP_FRIENDLY_Mazu'kon|r
    .turnin 96775 >>Rends Tête de Zum’rah
    .target 264074
    .isQuestComplete 96775
]])

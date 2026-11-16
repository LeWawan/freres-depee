if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : guide de classe Warrior Horde, Cyclonien (arme Tourbillon, niveau 40).
-- Suite du guide « 30 Posture berserker » : La Vigie des vents mène à Bath'rah (Alterac).
-- Le Cyclonien est élite niveau 40. QuestieDB ne donne pas le nombre de Défenses de Bloodscalp.

RXPGuides.RegisterGuide([[
#classic
<< Horde Warrior
#name 38 Arme tourbillon
#displayname [FDP] Guerrier 38 : Arme tourbillon
#version 1
#group Guide FDP (Horde)
#subgroup Classe

step
    #sticky
    #completewith FinTourbillon
    .isQuestAvailable 1719
    .isNotOnQuest 1719
    .xp 61 >>|cRXP_WARN_Fais d'abord le guide « 30 Posture berserker » : cette chaîne en est la suite|r
step
    .xp 38 >>Monte au niveau 38 : exilés 38-39 et Cyclonien élite 40
step
    .goto The Barrens,68.62,49.16
    >>Parle à |cRXP_FRIENDLY_Klannoc Macleod|r sur l'île de la Dispute
    .accept 1791 >>Accepte La Vigie des vents
    .target 6236
    .isQuestTurnedIn 1719
step
    #completewith Bathrah1
    .goto Alterac Mountains,80.50,66.92,40 >>Va voir |cRXP_FRIENDLY_Bath'rah|r dans l'est des montagnes d'Alterac (depuis Tarren Mill)
step
    #label Bathrah1
    .goto Alterac Mountains,80.50,66.92
    >>Parle à |cRXP_FRIENDLY_Bath'rah la Vigie des vents|r
    .turnin 1791 >>Rends La Vigie des vents
    .accept 1712 >>Accepte Cyclonien
    .target 6176
step
    #completewith FinTourbillon
    >>|cRXP_LOOT_Vietérule|r : achète-la à l'hôtel des ventes ou chez |cRXP_FRIENDLY_Montarr|r (poste de Librevent, Thousand Needles 45,51), ou cueille-la si tu es herboriste
    .complete 1712,1 --Vietérule
    .isOnQuest 1712

-- ===== Strangleronce : défenses de Bloodscalp =====
step
    .goto Stranglethorn Vale,29.82,19.10
    >>Tue les trolls |cRXP_ENEMY_Bloodscalp|r pour leurs |cRXP_LOOT_Défenses de Bloodscalp|r (nombre dans le journal de quête, ~17 % par kill)
    .complete 1712,2 --Défense de Bloodscalp
    .mob 587
    .mob 588
    .mob 595

-- ===== Hautes-terres d'Arathi : les trois charmes =====
step
    .goto Arathi Highlands,25.64,28.53
    >>Tue un |cRXP_ENEMY_Exilé ardent|r pour le |cRXP_LOOT_Charme ardent|r (~3 kills)
    .collect 4479,1,1712,1
    .mob 2760
step
    .goto Arathi Highlands,52.11,49.40
    >>Tue un |cRXP_ENEMY_Exilé foudroyant|r pour le |cRXP_LOOT_Charme de tonnerre|r (~3 kills)
    .collect 4480,1,1712,1
    .mob 2762
step
    .goto Arathi Highlands,67.38,28.52
    >>Tue un |cRXP_ENEMY_Exilé grimpeur|r pour le |cRXP_LOOT_Charme armorié|r (~3 kills)
    .collect 4481,1,1712,1
    .mob 2761

-- ===== Retour chez Bath'rah =====
step
    .goto Alterac Mountains,79.32,66.80
    >>Clique sur le |cRXP_PICK_Chaudron de Bath'rah|r pour fondre les trois charmes en |cRXP_LOOT_Essence d'exil|r
    .accept 1714 >>Accepte Essence d'exil
    .turnin 1714 >>Rends Essence d'exil
step
    .goto Alterac Mountains,80.50,66.92
    >>Parle à |cRXP_FRIENDLY_Bath'rah la Vigie des vents|r
    .turnin 1712 >>Rends Cyclonien
    .accept 1713 >>Accepte L'invocation
    .target 6176
step
    .goto Alterac Mountains,80.32,62.14
    >>Tue le |cRXP_ENEMY_Cyclonien|r et ramasse le |cRXP_LOOT_Coeur de tourbillon|r
    >>|cRXP_WARN_Élite niveau 40 : à faire en duo. Si personne n'est là, demande à Bath'rah comment l'invoquer|r
    .complete 1713,1 --Coeur de tourbillon (1)
    .mob 6239
step
    #label FinTourbillon
    .goto Alterac Mountains,80.50,66.92
    >>Parle à |cRXP_FRIENDLY_Bath'rah la Vigie des vents|r et choisis ton arme Tourbillon (hache, marteau ou épée)
    .turnin 1713 >>Rends L'invocation
    .accept 1792 >>Accepte Arme Tourbillon
    .turnin 1792 >>Rends Arme Tourbillon
    .target 6176
]])

if not RXPGuides then return end -- RestedXP absent : guides ignorés
-- Guide FDP : quêtes Horde de la Cité submergée (donjon Forever, Récif infâme, Strangleronce),
-- toutes classes.
-- Givers : Kin'weelay et Commandant Aggro'gosh (Grom'gol), Krazek (Baie-du-Butin).
-- Protégées : 95775 La cité Submergée (après 95770, faite dans le guide Strangleronce) et
-- 95776 Le seul bon Écaille-de-mer... (après 95770 et 95773 Des adversaires sous les flots,
-- coupée par le guide Strangleronce). Suite 96078 rendue à Sen'jin (Durotar).
-- Données : QuestieDB Forever (tools/questiedb.py), XP et taux inconnus pour ces quêtes.
-- Les mobs de l'instance n'ont pas de nom français dans QuestieDB : noms anglais.

RXPGuides.RegisterGuide([[
#classic
<< Horde
#name 35-40 The Drowned City
#displayname [FDP] Cité submergée (35-40)
#version 1
#group Guide FDP Donjons (Horde)
#subgroup Donjons

-- ===== Grom'gol =====
step
    #completewith Kinweelay
    .goto Stranglethorn Vale,32.27,27.71,40 >>Va au camp de base de Grom'gol (zeppelin depuis Orgrimmar ou Undercity)
step
    #label Kinweelay
    .goto Stranglethorn Vale,32.27,27.71
    >>Parle à |cRXP_FRIENDLY_Kin'weelay|r
    .accept 95775 >>Accepte La cité Submergée
    .target 2519
    .isQuestTurnedIn 95770
step
    .goto Stranglethorn Vale,32.17,28.90
    >>Parle au |cRXP_FRIENDLY_Commandant Aggro'gosh|r
    .accept 95776 >>Accepte Le seul bon Écaille-de-mer…
    .target 2464
    .isQuestTurnedIn 95770
    .isQuestTurnedIn 95773

-- ===== Baie-du-Butin : Krazek =====
step
    #completewith Krazek
    .goto Stranglethorn Vale,26.95,77.21,40 >>Va à Baie-du-Butin (vol depuis Grom'gol)
    .xp <34,1
step
    #label Krazek
    .goto Stranglethorn Vale,26.95,77.21
    >>Parle à |cRXP_FRIENDLY_Krazek|r, au sommet de l'auberge
    .accept 95789 >>Accepte Sel-augures véreux
    .accept 95791 >>Accepte Le capitaine sel-augure
    .target 773
    .xp <34,1

-- ===== Instance =====
step
    #label EntreeTDC
    .goto Stranglethorn Vale,22.43,27.25,15 >>Retourne à Grom'gol puis plonge au Récif infâme, à l'ouest : l'entrée de la Cité submergée est une caverne sous l'eau
step
    #completewith SortieTDC
    >>Tue les pirates |cRXP_ENEMY_Saltseer|r pour les |cRXP_LOOT_Artéfacts imprégnés de magie vaudoue|r
    .complete 95789,1 --Artéfact imprégné de magie vaudoue (10)
    .mob 259979
    .mob 259981
    .mob 259987
    .mob 260353
    .isOnQuest 95789
step
    >>Utilise le cuir et le charbon sur les quatre |cRXP_PICK_Tablettes d'I'lalai|r pour en faire des empreintes
    .complete 95775,1 --La première tablette d'I'lalai
    .complete 95775,2 --La deuxième tablette d'I'lalai
    .complete 95775,3 --La troisième tablette d'I'lalai
    .complete 95775,4 --La quatrième tablette d'I'lalai
    .isOnQuest 95775
step
    >>Tue 3 |cRXP_ENEMY_Saltseer Coroners|r et le |cRXP_ENEMY_Captain Dreadrise|r
    .complete 95791,1 --Captain Dreadrise
    .complete 95791,2 --Saltseer Coroner (3)
    .mob 260042
    .mob 260353
    .isOnQuest 95791
step
    >>Tue |cRXP_ENEMY_Var'Taka|r
    .complete 95776,1 --Var'Taka
    .mob 258924
    .isOnQuest 95776
step
    #label SortieTDC
    >>Finis les |cRXP_LOOT_Artéfacts imprégnés de magie vaudoue|r avant de sortir
    .complete 95789,1 --Artéfact imprégné de magie vaudoue (10)
    .isOnQuest 95789

-- ===== Rendus =====
step
    .goto Stranglethorn Vale,32.27,27.71
    >>Retourne à Grom'gol et parle à |cRXP_FRIENDLY_Kin'weelay|r
    .turnin 95775 >>Rends La cité Submergée
    .accept 96078 >>Accepte Une histoire au coin du feu
    .target 2519
    .isOnQuest 95775
step
    .goto Stranglethorn Vale,32.17,28.90
    >>Parle au |cRXP_FRIENDLY_Commandant Aggro'gosh|r
    .turnin 95776 >>Rends Le seul bon Écaille-de-mer…
    .target 2464
    .isOnQuest 95776
step
    .goto Stranglethorn Vale,26.95,77.21
    >>Va à Baie-du-Butin et parle à |cRXP_FRIENDLY_Krazek|r
    .turnin 95789 >>Rends Sel-augures véreux
    .turnin 95791 >>Rends Le capitaine sel-augure
    .target 773
    .isOnQuest 95791
step
    #label FinCiteSubmergee
    .goto Durotar,56.00,74.70
    >>Va au village de Sen'jin (bateau vers Cabestan, ou zeppelin vers Orgrimmar) et parle à |cRXP_FRIENDLY_Maître Gadrin|r
    .turnin 96078 >>Rends Une histoire au coin du feu
    .target 3188
    .isOnQuest 96078
]])

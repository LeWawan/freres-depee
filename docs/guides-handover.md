# Writing FDP guides: handover

Notes for anyone (human or agent) adding a RestedXP guide to `FreresDEpee_Guides/guides/`. Read
[`rxp-custom-guides.md`](rxp-custom-guides.md) for the full command list.

## Scope

- **Start at 22.** RestedXP's free "Speedrun Guide 1-22" covers 1-22 in French. Don't copy
  RestedXP guides: they are CC BY-NC-SA 4.0, this repo is MIT. Build routes from QuestieDB.
- **The reference is `FreresDEpee_Guides/guides/Horde-ThousandNeedles.lua`.** It works well in game: copy its
  structure (alert stickies, `.isOnQuest`/`.isQuestTurnedIn` guards, `.goto x,y,R` radii,
  `#completewith` travel chains, level gates, numeric ids, closing `#label`).
- **Testing.** The game always runs the local copy: `scripts/link.sh` links the repo into
  `AddOns/FreresDEpee`.

## The setup

- **Client.** WoW Forever, `## Interface: 16001`, French client. It is a modern client under
  the hood (`C_QuestLog`, `C_Item`, `C_SuperTrack`, quest log inside the world map), with
  Classic content plus Forever-only zones and quests.
- **Guide addon.** RestedXP (`RXPGuides`). Its free Forever guides stop at level 22. Its
  other guides target TBC/WotLK: fine for coordinates and style, never for quest ids or
  levels.
- **Quest data.** QuestieDB Forever is the source of truth for ids, levels, prerequisites,
  givers, spawns and objectives. Check every quest against it, not against Wowhead.
- **Where guides live.** One file per guide in `FreresDEpee_Guides/guides/`, listed in `FreresDEpee_Guides/FreresDEpee_Guides.toc`. Each
  file starts with `if not RXPGuides then return end`, so the addon loads fine without
  RestedXP (`OptionalDeps: RXPGuides` makes RXP load first when present).

## Conventions

| Header | Value |
|---|---|
| `#classic` | always, followed by `#forever` (the official Forever guides carry `#forever`; with both tags RXP loads the guide on both clients, `GuideLoader.lua:1171`) |
| `<< Horde` | faction filter for the whole guide (add the class for class guides: `<< Horde Warrior`) |
| `#name` | `<min>-<max> <Zone>`, starts with the minimum level: the linter reads it |
| `#displayname` | `[FDP] <Zone> (<min>-<max>)` |
| `#group` | `Guide FDP (Horde)` |
| `#subgroup` | `Régions` for zone guides, `Classe` for class quests |
| `#next` | next guide by `#name`, see the chaining section |

- **One guide per region.** It must work whatever the player did before: quests that come
  from elsewhere are guarded (see "Independence"). Don't mix zones in one guide except to
  reach the zone or to turn in a quest right next to it.
- **All classes.** Class-only steps use `<< Warrior` on the step. A class quest gets its own
  guide in `Classe`.
- **Text in French**, using RXP colour tags: `|cRXP_FRIENDLY_…|r` NPCs to talk to,
  `|cRXP_ENEMY_…|r` mobs, `|cRXP_LOOT_…|r` items, `|cRXP_PICK_…|r` objects to click,
  `|cRXP_WARN_…|r` warnings. Quest names come from QuestieDB's French l10n
  (`questiedb.py` `fr_name`).
- **Never rename** a published guide's `#group`, `#subgroup` or `#name`. Progress is saved
  under `group|subgroup|name` (`RXPGuides/GuideLoader.lua:797`, `BuildGuideKey`), so a rename
  restarts players at step 1. `#version` is not part of the key.

## RXP rules that bite

All checked in the RXPGuides source.

- **Every step needs an element that can complete.** A step whose elements are all
  text-only is marked done at once and skipped (`GuideWindow.lua:690`). Text-only elements:
  `>>text` alone, `*note`, `.target`, `.mob`, `.unitscan`, `.goto` without a radius or with
  radius `0`. Completable: `.accept`, `.turnin`, `.complete`, `.xp`, `.fp`, `.home`, `.hs`,
  `.collect`, `.goto x,y,R` with `R > 0`, a `+Text` manual checkbox, and the rest of the list
  in `tools/lint_guide.py`.
- **`.accept` is done** when the quest is in the log or already turned in, so a duplicate
  accept is harmless.
- **Condition semantics** (each one skips the step when false):
  - `.isOnQuest id`: quest is in the log. A `-` prefix (`.turnin -1234`) applies it to that
    element only.
  - `.isQuestTurnedIn id`: quest was turned in.
  - `.isQuestAvailable id`: quest is not turned in yet (reverse of the previous one).
  - `.isNotOnQuest id`: quest is not in the log.
  - `.isQuestComplete id`: objectives are done.
  - `.maxlevel N`: player is at most level N (re-evaluated on XP gain).
- **Use numeric ids** for `.target`, `.mob` and `.unitscan`. RXP resolves them to the
  localised name, which keeps the French client working.
- **Forever-only zones** missing from RXP's map table take a numeric uiMapID:
  `.goto 2548,59.4,45.6`, `.zone 2548` (`map.lua:1573` falls back to `tonumber(zone)`).
  Riverglades is 2548.
- **`--` comments** inside the guide text are stripped by the loader, so annotate freely
  (`.complete 4841,1 --Eclaireur galak (12)`).
- **No custom code.** `_G.RXPGuides` exposes only `RegisterGuide` and `ImportGuide`, and there
  is no `loadstring`. Anything beyond the documented commands is impossible inside a guide.
  Display tricks go in the addon itself (as the Quest Chain panel does).

## Traps found while writing guides

- **Forever XP** is in `QuestieDB/support/Forever/QuestXP/xpDB-traces.lua`. `xpDB-classic.lua`
  only covers Classic quests.
- **`.xp <N,1` skips the whole step**, turn-ins included. Never put a `.turnin` on a step that
  has a level-gated `.accept`: split it into a turn-in step and a gated accept step.
  `audit_guide.py` flags it.
- **`disabledByQuest`**: while that quest is in the log, this one is not offered (Questie
  `QuestieDB.lua:910`). Accept this one first (Rig Wars 2841 before Scooty 2842).
- **`preQuestGroup`** means every listed quest must be turned in, **`preQuestSingle`** means any
  one of them. Print them separately when routing.
- **`.complete q,i` is done once the quest is complete** (`IsQuestTurnedIn(id) or
  IsQuestComplete(id)`, `functions.lua` `UpdateQuestCompletionData`). Many Forever quests have
  no objectives in QuestieDB: `.complete q,1` still works, and the lint accepts it.
- **A step skipped by its guard never comes back.** A quest started by a drop must be turned in
  after the last place the drop can happen, not before.
- **Gather objects of a quest can't be looted before the quest is accepted.** No pre-collect.
- **Race bit 32 is Skyborne**, playable by both factions. A mask of bit 32 only is not
  Alliance.
- **Blacklist hits under `LoadAutoBlacklistWotlk`** (`QuestieQuestBlacklist.lua:7309` and below)
  don't apply to Forever (quest 1048 is one).
- **`json.loads`** turns QuestieDB's integer dict keys (objectives `{3: [...]}`) into strings:
  call `questiedb.get` again instead of reusing JSON dumps.
- **Two drop tables** sit in `classicItemDrops.lua`: `wowheadData` first, then `cmangosData`.
  Use the `wowheadData` rate when the item has one, the `cmangosData` rate otherwise, and
  35 % when neither has it. Say which one in the header when a cut depends on it.
- **Run both checks** on every guide: `lint_guide.py` (RXP can run it) and `audit_guide.py`
  (it is right: givers, coordinates, faction, metadata, cuts).

## Chaining guides

- `#next <name>` loads the next guide when the current one ends. It takes a `;` list and
  picks the first one that applies (`functions.lua:3858`, `addon.functions.next`).
- The name is looked up in the current guide's `#group`. To jump to another group, write
  `#next <Group>\<name>`.
- Header tags accept class and faction filters: `#next 30 Posture berserker << Warrior`. The
  same `applies()` check as step filters handles them.
- Prefer `#next` over a `.next` step element: no official guide uses `.next`, and a `.next`
  step that jumps back creates a loop.
- A `#next` pointing to a guide that isn't shipped does nothing. Keep the chain to guides in
  `FreresDEpee_Guides/guides/`.

## Independence: quests from other regions

- **Turn-in of a quest picked up elsewhere:** guard the step with `.isOnQuest id`.
- **Follow-up of a quest done elsewhere:** guard the accept with `.isQuestTurnedIn <prereq>`.
- **Missed high-XP quest whose prerequisite is elsewhere:** add a sticky warning at the top
  of the guide, visible while the quest still gives full XP:

  ```
  step
      #sticky
      #completewith FinMillePointes
      .isQuestAvailable 1153
      .isNotOnQuest 1153
      .maxlevel 34
      .xp 35 >>|cRXP_WARN_Quête manquée : Un nouveau minerai (~2350 xp). Chez …|r
  ```

  `FinMillePointes` is the `#label` of the guide's last step. A warning only shows while its
  guide is loaded, not in the Blizzard quest log.
- **XP falloff** (Questie `Database/QuestXP/QuestieXP.lua:66`, from cmangos): full XP up to
  quest level + 5, then 80, 60, 40, 20 %, and a 10 % floor from quest level + 10. So
  `.maxlevel` for a warning is the quest level + 5.

## Step patterns

**Talk to an NPC**

```
step
    .goto Thousand Needles,46.14,51.71
    >>Parle à |cRXP_FRIENDLY_Rau Cliffrunner|r
    .turnin 1196 >>Rends La flamme sacrée
    .accept 1197 >>Accepte La flamme sacrée
    .target 4722
```

Group every action at the same NPC in one step. Merge NPCs that stand within a few map
units of each other only if the text stays clear.

**Kill or loot in the background** while doing other things, ended by a label:

```
step
    #completewith Brasero
    >>Tue les |cRXP_ENEMY_Eclaireurs galaks|r
    .complete 4841,1 --Eclaireur galak (12)
    .mob 4094
```

**Quest started by a dropped item**

```
step
    #completewith NoteAssassin
    .goto Thousand Needles,39.40,33.10,0
    >>Tue le |cRXP_ENEMY_Messager galak|r s'il est là et ramasse l'|cRXP_LOOT_Engagement d'assassin|r
    >>|cRXP_WARN_Utilise l'objet pour lancer la quête|r
    .collect 12564,1,4881,1
    .accept 4881 >>Accepte Complot d'assassinat
    .use 12564
    .unitscan 10617
```

The turn-in is a separate step guarded by `.isOnQuest`, since the drop may never happen.

**Escort:** one step to accept, then the escort step at the escort's **end point**, right
after it:

```
step
    .goto Thousand Needles,37.95,26.45
    >>Parle à |cRXP_FRIENDLY_Lakota Windsong|r pour lancer l'escorte
    .accept 4904 >>Accepte Libre, enfin !
    .target 10646
step
    .goto Thousand Needles,30.93,37.12
    >>Escorte |cRXP_FRIENDLY_Lakota Windsong|r hors du pic. Tue ce qui l'attaque
    .complete 4904,1
```

Never place an escort after unrelated steps: the NPC leaves.

**Travel:** `#completewith <label>` on a `.goto x,y,R` chain, see the elevator steps in
`Horde-ThousandNeedles.lua`.

**RP or wait:** `.timer seconds,Text` right below the `.accept` or `.turnin` it follows.

**Levels: never force a farm.** The user accepts a small gap between guides, filled by a
bit of farming or a dungeon, but the guide only hints at it.

- A quest above the player's level is skipped, not waited for: add `.xp <N,1` to its accept
  step (skips the step below level N, `functions.lua:3410`) and guard its objective and
  turn-in steps with `.isOnQuest`.
- The last step of a guide carries the closing `#label` and a manual checkbox:
  `+|cRXP_WARN_Niveau conseillé pour la suite : N. En dessous, farme un peu sur la route ou fais un donjon|r. Coche pour continuer`.
- A plain `.xp N >>Monte au niveau N, requis pour …` gate is a last resort, for a block of
  quests the route can't skip.

## Choosing and routing quests

**The goal, set by the user: level as fast as possible.** A Guide FDP is a speed route, not
a completionist list. Skip every quest that is useless, not worth its XP, or a "loot X items"
quest on mobs that take ages to drop them. Each kept quest must earn its place on XP per
minute, travel and kill time included.

How to judge a quest:

- **XP per time.** Quest XP from `QuestieDB/support/Forever/QuestXP/xpDB-classic.lua`
  (counting the whole chain), against the walk to reach it and the kills it needs. A quest
  off the route is worth it only if its chain pays for the detour.
- **Location and logic.** Order quests by position along the path: pick up everything at a
  hub, do the objectives that sit together in one sweep, come back once to turn them all in
  and take the follow-ups. No ping-pong between hubs, no going back to an area already
  cleared.
- **Report the cuts.** Whoever writes or reviews a guide lists every cut quest with its
  reason (low XP, slow drop, too far, elite, blacklisted). The user checks that list.

Detailed rules:

- **Played in duo** (two players). For item drops each player must loot their own items:
  expected kills = 2 × count × 100 / drop rate. Drop rates are in
  `QuestieDB/support/Forever/DropTables/classicItemDrops.lua`; assume 35 % when unknown.
- **Cut a quest** when it needs more than 40 kills, unless its chain (its XP plus every
  follow-up's) gives at least 100 XP per kill. Cutting a quest cuts its follow-ups. Keep a
  long farm only with a `|cRXP_WARN_Farm long en duo (~N kills) : chacun doit looter ses objets|r`
  line.
- **Skip:** Season of Discovery and blacklisted quests (Questie
  `Database/Corrections/QuestieQuestBlacklist.lua`), elites unless doable in duo (warn), seasonal events, quests whose
  objectives point to another continent.
- **No dungeon quests in region guides.** They go in dungeon guides (see "Dungeon guides").
- **Faction.** Filter on `requiredRaces`. Vendors and quest NPCs must be Horde or neutral.
  Don't use QuestieDB's `friendlyToFaction` to decide
  whether a mob can be attacked: neutral beasts carry `AH` too.
- **`.mob` lines.** Only mobs that spawn in the step's zone near its `.goto`, at most 6. Mobs
  pulled from a drop table can belong to other continents.
- **Quest log.** Keep at most 15 quests open at once, to leave room for quests picked up
  elsewhere.
- **Route order.** Respect accept < objectives < turn-in and prerequisite turn-in < accept,
  and keep escorts right after their accept.
- **Missing data.** Some Forever objects have no spawns in QuestieDB. Point the step to the
  NPC or place named in the objective text and say so in a warning.

Region candidates for the next guides (Horde, 40-50): Dustwallow Marsh, Swamp of Sorrows,
Badlands. Riverglades (Forever-only, uiMap 2548, area 16591) has its guide,
`Horde-Riverglades.lua`; its Forever XP comes from `xpDB-traces.lua`, not `xpDB-classic.lua`.
Other Forever additions: Shen'dralas, Mount Hyjal (60), Excavation Site: Wetlands.

## Dungeon guides

Modelled on RXP's `RestedXP Forever Dungeon Guide (H)` (`RXPGuides/Guides/forever/dungeon/`).

- One self-contained guide per dungeon: travel to the givers, accept, run, turn in,
  follow-ups. File `FreresDEpee_Guides/guides/<Faction>-Donjon-<Dungeon>.lua`, `#group Guide FDP Donjons (Horde)`,
  `#subgroup Donjons`, `#name <min>-<max> <Dungeon>`.
- Quests started by a drop inside the dungeon get their own accept step after the drop.
- Dungeon quests set aside by the region guides, for the next dungeon guides:
  - City of Dalaran (Forever, entrance Alterac 8.5,59.2): 92434, 96984, 97287, 96986.
  - The Drowned City (Forever): 95775, 96078, 95776, 95789, 95791.
  - Maraudon: 7028, 7029, 7044, 7064, 7067 (Desolace givers).
  - Scarlet Monastery: 1051 (turned in at Tarren Mill).
- Planned: chain dungeon guides and region guides into one dungeon route with `#next`
  (`#next <Group>\<name>` across groups), as RXP does.

## Tools

Both scripts need `WOW_ADDONS`, the client's `Interface/AddOns` folder.

```bash
export WOW_ADDONS=".../World of Warcraft/_forever_/Interface/AddOns"
python3 -I tools/questiedb.py quest 4821   # one quest, all fields
python3 -I tools/questiedb.py npc 4630
python3 -I tools/questiedb.py zone 400     # every quest whose zoneOrSort is 400 (Thousand Needles)
python3 -I tools/lint_guide.py FreresDEpee_Guides/guides/*.lua
```

- `questiedb.py` decodes QuestieDB Forever: base64 CBOR rows stored as
  `## X-<Entity>-<id>-<field>` lines in `QuestieDB_Forever.toc` (long values split in `~N~`
  chunks). `fr_name(entity, id)` reads the French names from the zlib CBOR
  `X-l10n-frFR-<Entity>` blocks.
- `lint_guide.py` checks: a completable element in every step, known labels, quest ids that
  exist, objective indexes in range, `.complete`/`.turnin` after an `.accept` unless
  guarded, `requiredLevel` against the guide's minimum level, and prerequisites turned in
  earlier in the guide unless gated.

Other data worth knowing:

| Data | Where |
|---|---|
| Quest XP | `QuestieDB/support/Forever/QuestXP/xpDB-classic.lua` |
| Drop rates | `QuestieDB/support/Forever/DropTables/classicItemDrops.lua` |
| areaId to uiMapID | `QuestieDB/support/Forever/Zones/areaIdToUiMapId.lua` |
| RXP zone names | `RXPGuides/DB/forever/` |
| Blacklisted quests | `Questie/Database/Corrections/QuestieQuestBlacklist.lua` |

## Checklist for a new guide

1. List the zone's quests with `questiedb.py zone <areaId>`, filter them with the rules
   above and pick the route.
2. Write `FreresDEpee_Guides/guides/<Faction>-<Zone>.lua` with the header conventions, add it to
   `FreresDEpee_Guides/FreresDEpee_Guides.toc` and mention it in the README "Dependencies" section (both languages).
3. Run `python3 -I tools/lint_guide.py FreresDEpee_Guides/guides/*.lua` and `python3 -I tools/audit_guide.py
   FreresDEpee_Guides/guides/*.lua` (0 errors each, read every warning), `luac5.1 -p FreresDEpee_Guides/guides/*.lua`, then
   `lua5.1 tests/smoke.lua .`. List every cut quest in the header comment, under `Coupées`:
   the audit warns about zone quests that are neither in the guide nor in that list.
4. Test in game: `/reload`, check chat for "Error parsing guide", load the guide from the
   RXP menu under "Guide FDP (Horde)", walk the first steps. Things only the game shows:
   stickies at guide start, `#next` jumps, escort end points, objects missing from
   QuestieDB.
5. Commit only when the user says so, as `feat: add the <zone> guide` (a new guide is a
   minor release, see `CONTRIBUTING.md`). Never push.

## Open points

- `Horde-ThousandNeedles.lua`: where the stolen Freewind supplies (98069) are found is
  unknown; the alerts, the Test of Faith jump and the escort end points have not been
  checked in game.
- `#next 30 Posture berserker << Warrior` has not been seen working in game.
- The Berserker guide has no `#next` yet: it should lead to the next region guide.
- The sticky warnings are written by hand. A generator (QuestieDB prerequisites plus the
  XP falloff) was planned but not built.

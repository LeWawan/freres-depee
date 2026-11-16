# RestedXP custom guides syntax

Source: https://community.restedxp.com/custom-guides/ (copied 2026-11-15, the page blocks
automated fetches). Content below is the original text, reformatted as tables.

## Text Tutor

These commands are used to display instructional or conditional text within your guide steps. You can add notes, set objective text, and target specific classes, races, or game versions to show or hide content accordingly. Especially useful for creating dynamic and personalized guide experiences.

| Syntax | Effect |
|---|---|
| `*Text` | Creates a note in the step window but not the guide/map |
| `"+Text"` | Objective text box |
| `>>Text` | Default text, can be on its own line or after a syntax |
| `<< Class` (`<< Race`) | Shows text to one class or race |
| `<< Class/Class/Class` | Shows text to multiple class/races |
| `<< !Class` | Shows text to everyone but that class or race |
| `<< !Class !Class` | Shows text to everyone but those classes/races |
| `<< tbc << wotlk` | Skips step if server is not on a tbc or wotlk patch |

How to combine: spaces are an "AND" operator, `/` is an "OR" operator, `!` is a "NOT" operator. Priority system is `!` > space > `/`.

## .xp Expert

These commands control how experience grinding steps are handled in your guide. You can specify the exact level or experience percentage to grind to, set conditions to skip or complete steps based on the player's current level or progress, and control step visibility depending on level thresholds. Ideal for precise leveling instructions tailored to the player's current XP status.

| Syntax | Effect |
|---|---|
| `.xp 10` | Makes you grind to level 10 |
| `.xp 10+200` | Grind to level 10 and 200 exp |
| `.xp 10-300` | Grind til you are 300 exp from level 10 |
| `.xp 10.5` | Grind til 50% into level 10 |
| `.xp 10.5,1` | Skip step if you are above 50% of 10 |
| `.xp <10,1` | Completes step if below level 10 |
| `.maxlevel X` | Skips step if you're above level X |
| `#level n` | Step will only show if player is greater or equal to n. Only use on stickies! Use `.maxlevel` otherwise |

## Quest Coach

These commands help automate and track quest-related steps within your guide. They cover accepting, completing, turning in, and abandoning quests, as well as tracking quest objectives and reputation requirements. Additionally, commands can check quest status (complete, available, turned in), handle daily quests, and scan for relevant units. Ideal for creating smooth, responsive questing instructions that adapt to the player's progress.

| Syntax | Effect |
|---|---|
| `.collect itemId,n,questId,skipIfTurnedIn` | Auto completes the step when you have n items of itemId, or if you have accepted questId (questId is optional, set skipIfTurnedIn to 1 if you want the task to complete if the quest is turned in already) |
| `.collect itemId,amount,questId,objectiveBitMask,-1` | objBitMask variant |
| `.complete id,obj` | Track quest objective |
| `.accept id,n,nid` | Accepts quest id |
| `.turnin id,n` | Turns in quest id. n autoselects the nth reward |
| `.abandon id` | Abandons quest id |
| `.isQuestComplete id` | Skips step if quest is incomplete |
| `.isQuestTurnedIn id` | Skips step if quest id isn't turned in |
| `.isQuestAvailable id` | Skips step if quest id isn't able to be accepted |
| `.isOnQuest id` | Skips step if quest id isn't in quest log. A `-` before a quest id (`.turnin -1234 >>`) applies `.isOnQuest` to that quest, good for steps with multiple quests |
| `.unitscan` | Adds unitscan of enemy |
| `.reputation factionID,standing,value` | Completes when you have required rep |
| `.daily id1,id2,id3,id4` | Accepts daily quests, completes when you accept at least 1 |
| `.dailyturnin id1,id2,id3,id4` | Turns in daily quests, completes when you turn in at least 1 |

## Misc Mentor

These miscellaneous commands add extra functionality and convenience to your guide steps. They include clickable links, death skip instructions, skill level checks, cooldown timers, conditional step visibility based on zones, and special instructions like taming animals for hunters.

| Syntax | Effect |
|---|---|
| `.link url` | Clickable hyperlink in step |
| `.deathskip` | Tells the player to go die. Completes on spirit rez |
| `.skill Name,n,skipStep` | Completes if skill is = or greater than n |
| `.cooldown type,id,timeRemaining,updateOnlyOnce` | Cooldown check |
| `.zoneskip zoneNameOrID,1` | Skips the step if player is in the given zoneID. Adding a 1 reverses the logic, shows the step only to people in that zoneID |
| `.timer timeInSeconds,TimerText` | Latches to `.accept` or `.turnin` directly above and shows a timer bar |
| `.tame npcID` | Instructs hunters to tame the specified animal id |

## Inventory Instructor

These commands manage inventory-related actions within your guide. They allow you to buy and use items, deposit or withdraw items from the bank, check money amounts to conditionally skip steps, destroy items, and verify item counts.

| Syntax | Effect |
|---|---|
| `.buy id,n` | Purchases item with id from vendor |
| `.use id` | Creates clickable item window |
| `.bankwithdraw id1,id2` | Withdraws items from bank |
| `.bankdeposit id1,id2` | Deposits items into bank |
| `.money <0.01` | Skips step if you have less than 1 silver |
| `.money >0.01` | Skips step if you have more than 1 silver |
| `.destroy id` | Completes obj if you destroy item |
| `.bronzetube` | Skips step if player has a bronze tube or has completed Duskwood BT quest |
| `.itemcount id,n` | Skips step if user doesn't have n or greater of item id |

## NPC Conversation Counselor

These commands help automate interactions with NPCs, such as talking to trainers, learning spells, using flight masters, stables, or vehicles, and setting or using your hearthstone. They also include options to skip NPC dialogue and perform emotes at specific NPCs.

| Syntax | Effect |
|---|---|
| `.trainer` | Obj completes when you talk to a class trainer |
| `.train spellID` | Obj to train specific spell |
| `.fly` / `.fp` | Use flightmaster (`.fly Menethil Harbor`) / Get flightpath |
| `.stable id` | Obj completes when you talk to a stable master, id optional |
| `.skipgossip` | Skips dialogue with NPCs |
| `.home` / `.hs` | Set hearthstone / Cast hearthstone |
| `.vehicle id` | Obj completes when vehicle UI shows up |
| `.emote EmoteToken,NPCID` | Emotes at NPC |

## Header Hero

All steps must eventually autocomplete!

These commands control step visibility, completion, and conditional progression within your guide. Server-specific headers allow showing or hiding steps based on reputation, game phases, expansions, or gameplay modes (e.g., hardcore).

| Syntax | Effect |
|---|---|
| `#sticky` | Step won't disappear until completed |
| `#completewith next` | Step completes once next step is finished, good for ending stickies |
| `#label MyLabel` | Labels the step as MyLabel |
| `#completewith MyLabel` | Step completes once MyLabel is complete, good for ending stickies |
| `#requires MyLabel` | Step will only show up if MyLabel is complete |

### TBC headers

| Syntax | Effect |
|---|---|
| `#scryer` | Skips step if rep with Scryers is below friendly |
| `#aldor` | Skips step if rep with Aldor is below friendly |

### Vanilla headers

| Syntax | Effect |
|---|---|
| `#phase1-4` | Step only shows if server is phase 1-4 |
| `#phase5` | Step only shows if server is phase 5+ |
| `#era` | Only shows step on era servers |
| `#som` | Only shows step on SoM servers |

### Hardcore headers

| Syntax | Effect |
|---|---|
| `#softcore` | Only shows step if hardcore is disabled |
| `#hardcore` | Only shows step if hardcore is enabled |

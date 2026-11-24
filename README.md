# Frères d'Épée

<img src="media/logo.png" alt="Frères d'Épée" width="128" align="right">

*The addon's in-game text is in French. Type `/fdp` to open the options.*

A small leveling companion: it handles the chores for you and shows, for every quest, the whole chain ahead of you. Everything is set in a single window, `/fdp`.

## Auto

- **Sells grey items** at the vendor, one by one, checking each slot again before selling.
- **Repairs** your gear, with guild funds if you want.
- **Accepts resurrections** automatically out of combat.
- **Accepts and turns in quests** automatically (off by default). A quest with a reward choice is never turned in for you.
- **Chat summary**: gold earned, repair cost.

Hold **Shift** while talking to an NPC to pause the automations for that interaction.

## Quest Chain

A panel opens next to the NPC's quest window or the quest log and shows:

- **the full chain** of the quest, step by step, with what is done and what is left;
- **prerequisites**, green when met, red when not;
- **the quest giver** of each step and where to find them;
- **rewards**: XP, reputation, plus gold and items once the game knows them;
- **efficiency**: estimated XP per hour, solo or duo, then your real time once the quest is turned in;
- at an NPC, **every quest** that NPC offers.

Drag the panel by its header. Right-click the header to put it back in place.

## Macros

Import and export macros as text in the window opened by `/fdp macros` or from `/fdp` > Macros, one block per macro.

```
### Burst
#showtooltip {spell:12328}
/cast {spell:12328}
/use 13
```

- `### Name` starts a macro (16 characters at most); lines starting with `--` are comments.
- `{spell:ID}` becomes the spell's name in your client's language, so one text works in every locale.
- `{name}` is a variable with any name you like. On import, a form asks for each value, offers your equipment sets as buttons, and remembers it for next time. `@var name = default | help` gives a variable its suggested value and an explanation. The form only opens when a value is missing or the import replaces existing macros. Packs assume equipment sets named in lowercase, `dps` and `tank`. Saved values are in `/fdp` > Macros > Saved variables.
- `{shields}` becomes the shield category for `[equipped:...]`.
- A macro with the same name is rewritten in place, once the import form has listed it. Otherwise it is created in the character or account tab, as set in the options.
- **Export** writes your current macros in the same format, ready to share.
- **Class packs** ship with the addon (warrior for now): a pack opens in the window, you check it, then import.

## Modules

**Auto**, **Quest Chain**, **Macros** and **Guides** are separate addons. Switch any of them off in the game's AddOns list or in the left column of `/fdp`, then reload the interface. `Frères d'Épée` itself is the core they all need, with the `/fdp` window and the saved settings.

## Commands

| Command | Effect |
|---|---|
| `/fdp` | Open or close the options window |
| `/fdp macros` | Open the macro import/export window |
| `/fdp <id>` | Show the chain of quest `<id>` |
| `/fdp duo` / `/fdp solo` | Efficiency calculation mode |
| `/fdp debug` | Explain in chat why the panel shows or not |

## Dependencies

- **Questie** (with QuestieDB) is installed alongside by the CurseForge app: it provides quest chains, prerequisites and quest givers. Without it, the Quest Chain panel only shows what the game knows about the quest.
- **RestedXP Guides** is optional. When installed, the Guide FDP shows up in its menu: a Horde speed route from level 22 to 60, after RestedXP's own 1-22 guide (Stonetalon, Hillsbrad, Ashenvale, Thousand Needles, Alterac, Desolace, Stranglethorn, Arathi, Riverglades, Badlands, Swamp of Sorrows, Stranglethorn again, Dustwallow Marsh, Shen'dralas, Feralas, Tanaris, the Hinterlands, Searing Gorge, Azshara, Un'Goro, Felwood, Burning Steppes, Blasted Lands, Western Plaguelands, Winterspring, Mount Hyjal, Eastern Plaguelands, Silithus), class quest guides for every Horde class, and dungeon guides from Ragefire Chasm to Stratholme (Gnomeregan included, reached through Booty Bay), Forever dungeons included. Without it, the guides are skipped.
- The Auto part works on its own.

## Feedback

Found a bug or have an idea? Leave a comment. For a panel display issue, type `/fdp debug`, repeat the action and paste the `[fdp]` lines from chat in your message.

---

## Development

The core addon lives at the root of this repository and each module in a `FreresDEpee_*` folder; `link.sh` links each of them into the AddOns folder.

```bash
# play the working copy in game: links the repo into the AddOns folder (safe to rerun)
export WOW_ADDONS="/path/to/World of Warcraft/_forever_/Interface/AddOns"
./scripts/link.sh
```

| Path | Content |
|---|---|
| `FreresDEpee.toc`, `Core.lua` | The core: the `/fdp` window, the module list and `ns.Register`, shared through the `FreresDEpee` global. |
| `FreresDEpee_Auto/` | Junk selling, repairs, quest and resurrection automations. |
| `FreresDEpee_QuestChain/` | `QuestChain.lua`: the panel. `Profit.lua`: efficiency estimates and recorded runs. |
| `FreresDEpee_Macros/` | `Macros.lua`: import, export and tokens. `Packs.lua`: class packs. |
| `FreresDEpee_Guides/` | RestedXP guides in `guides/`, registered only when RXPGuides is loaded. |
| `docs/` | RestedXP guide syntax and the handover notes for writing new guides (`guides-handover.md`). |
| `tools/` | `questiedb.py` reads QuestieDB Forever, `lint_guide.py` checks guides against it. Both need `WOW_ADDONS`. |
| `tests/smoke.lua` | Loads the core and every module against a fake WoW API, runs the panel through its states, imports a macro pack and builds the windows. |
| `scripts/package.sh` | Builds `dist/FreresDEpee-<version>.zip` for a manual upload. |
| `scripts/link.sh` | Links the core and each module into the game's AddOns folder. |
| `media/` | Logo (SVG source and PNG). |
| `.pkgmeta`, `.github/workflows/` | CI on every push, and a CurseForge and GitHub release on every `v*` tag. |

```bash
lua5.1 tests/smoke.lua .   # smoke test
./scripts/package.sh       # release zip
```

The release workflow needs `## X-Curse-Project-ID` in `FreresDEpee.toc` and a `CF_API_KEY` repository secret to upload to CurseForge.

Quest data comes from QuestieDB at runtime. Nothing from other addons is bundled.

## License

MIT, see [LICENSE](LICENSE).

---

# Version française

Un petit compagnon de route pour le leveling : il fait les corvées à ta place et te montre, pour chaque quête, toute la suite qui t'attend. Tout se règle dans une seule fenêtre, `/fdp`.

## Auto

- **Vente des objets gris** chez le marchand, un par un, en revérifiant chaque emplacement avant de vendre.
- **Réparation** de l'équipement, avec la banque de guilde si tu le veux.
- **Résurrections** acceptées automatiquement hors combat.
- **Quêtes** acceptées et rendues automatiquement (désactivé par défaut). Une quête avec un choix de récompense n'est jamais rendue à ta place.
- **Bilan dans le chat** : or gagné, coût de réparation.

Maintiens **Maj (Shift)** en parlant à un PNJ pour suspendre les automatisations le temps d'une interaction.

## Quest Chain

Un panneau s'ouvre à côté de la fenêtre du PNJ ou du journal de quêtes et te montre :

- **la suite complète** de la quête, étape par étape, avec ce qui est fait et ce qui reste ;
- **les prérequis**, en vert s'ils sont remplis, en rouge sinon ;
- **le donneur** de chaque étape et sa position ;
- **les gains** : XP, réputation, et l'argent et les objets dès que le jeu les connaît ;
- **la rentabilité** estimée en XP par heure, en solo ou en duo, puis ton vrai temps une fois la quête rendue ;
- chez un PNJ, **la liste de toutes les quêtes** qu'il donne.

Le panneau se déplace par son en-tête. Un clic droit sur l'en-tête le remet à sa place.

## Macros

Importe et exporte des macros en texte dans la fenêtre ouverte par `/fdp macros` ou depuis `/fdp` > Macros, un bloc par macro.

```
### Burst
#showtooltip {spell:12328}
/cast {spell:12328}
/use 13
```

- `### Nom` commence une macro (16 caractères au plus) ; les lignes qui commencent par `--` sont des commentaires.
- `{spell:ID}` devient le nom du sort dans la langue de ton client : un même texte marche partout.
- `{nom}` est une variable, avec le nom que tu veux. À l'import, un formulaire demande chaque valeur, propose tes sets d'équipement en boutons, et la retient pour la fois suivante. `@var nom = défaut | aide` donne à une variable sa valeur proposée et une explication. Le formulaire ne s'ouvre que s'il manque une valeur ou si l'import remplace des macros existantes. Les packs partent de sets d'équipement nommés en minuscules, `dps` et `tank`. Les valeurs retenues sont dans `/fdp` > Macros > Variables enregistrées.
- `{shields}` devient la catégorie bouclier pour `[equipped:...]`.
- Une macro du même nom est réécrite sur place, une fois listée dans le formulaire d'import. Sinon elle est créée dans l'onglet personnage ou compte, selon le réglage.
- **Exporter** écrit tes macros actuelles dans le même format, prêtes à partager.
- **Des packs par classe** sont livrés avec l'addon (guerrier pour l'instant) : le pack s'ouvre dans la fenêtre, tu relis, puis tu importes.

## Modules

**Auto**, **Quest Chain**, **Macros** et **Guides** sont des addons à part. Coupe celui que tu veux dans la liste des addons du jeu ou dans la colonne de gauche de `/fdp`, puis recharge l'interface. `Frères d'Épée` lui-même est le noyau dont ils ont tous besoin, avec la fenêtre `/fdp` et les réglages enregistrés.

## Commandes

| Commande | Effet |
|---|---|
| `/fdp` | Ouvre ou ferme la fenêtre d'options |
| `/fdp macros` | Ouvre la fenêtre d'import et d'export des macros |
| `/fdp <id>` | Affiche la suite de la quête `<id>` |
| `/fdp duo` / `/fdp solo` | Mode de calcul de la rentabilité |
| `/fdp debug` | Explique dans le chat pourquoi le panneau s'affiche ou non |

## Dépendances

- **Questie** (avec QuestieDB) est installé en même temps par l'appli CurseForge : il fournit les données des suites de quêtes, des prérequis et des donneurs. Sans lui, le panneau Quest Chain n'affiche que ce que le jeu sait de la quête.
- **RestedXP Guides** est optionnel. S'il est installé, le Guide FDP apparaît dans son menu : une route Horde rapide du niveau 22 à 60, après le guide 1-22 de RestedXP (Serres-Rocheuses, Hillsbrad, Orneval, Mille pointes, Alterac, Désolace, Strangleronce, Arathi, Rives Claires, Terres ingrates, Marais des Chagrins, Strangleronce encore, Marécage d'Âprefange, Shen'dralas, Féralas, Tanaris, les Hinterlands, Gorge des Vents brûlants, Azshara, Un'Goro, Gangrebois, Steppes ardentes, Terres foudroyées, Maleterres de l'Ouest, Berceau-de-l'Hiver, mont Hyjal, Maleterres de l'Est, Silithus), des guides de quêtes de classe pour toutes les classes Horde, et des guides de donjon du Gouffre de Ragefeu à Stratholme (Gnomeregan compris, par Baie-du-Butin), donjons de Forever compris. Sans lui, les guides sont ignorés.
- La partie Auto fonctionne seule.

## Retours

Un bug, une idée ? Laisse un commentaire. Pour un souci d'affichage du panneau, tape `/fdp debug`, refais l'action et colle les lignes `[fdp]` du chat dans ton message.

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

## Commands

| Command | Effect |
|---|---|
| `/fdp` | Open or close the options window |
| `/fdp <id>` | Show the chain of quest `<id>` |
| `/fdp duo` / `/fdp solo` | Efficiency calculation mode |
| `/fdp debug` | Explain in chat why the panel shows or not |

## Dependencies

- **Questie** (with QuestieDB) is installed alongside by the CurseForge app: it provides quest chains, prerequisites and quest givers. Without it, the Quest Chain panel only shows what the game knows about the quest.
- **RestedXP Guides** is optional. When installed, the Guide FDP for Thousand Needles (Horde, 27-33, work in progress) shows up in its menu, followed for Warriors by the berserker stance quest. Without it, the guide is skipped.
- The Auto part works on its own.

## Feedback

Found a bug or have an idea? Leave a comment. For a panel display issue, type `/fdp debug`, repeat the action and paste the `[fdp]` lines from chat in your message.

---

## Development

The addon lives at the root of this repository, so the repository itself can be the addon folder.

```bash
# play the working copy in game (adjust the AddOns path to your install)
ln -s "$PWD" "/path/to/World of Warcraft/_forever_/Interface/AddOns/FreresDEpee"
```

| Path | Content |
|---|---|
| `FreresDEpee.toc`, `*.lua` | The addon. `Core.lua`: automations and the `/fdp` window. `QuestChain.lua`: the panel. `Profit.lua`: efficiency estimates and recorded runs. |
| `guides/` | RestedXP guides, registered only when RXPGuides is loaded. |
| `docs/` | RestedXP guide syntax and the handover notes for writing new guides (`guides-handover.md`). |
| `tools/` | `questiedb.py` reads QuestieDB Forever, `lint_guide.py` checks guides against it. Both need `WOW_ADDONS`. |
| `tests/smoke.lua` | Loads the addon against a fake WoW API and runs the panel through its states. |
| `scripts/package.sh` | Builds `dist/FreresDEpee-<version>.zip` for a manual upload. |
| `media/` | Logo (SVG source and PNG). |
| `.pkgmeta`, `.github/workflows/` | CI on every push, and a CurseForge and GitHub release on every `v*` tag. |

```bash
lua5.1 tests/smoke.lua .   # smoke test
./scripts/package.sh       # release zip
```

The release workflow needs `## X-Curse-Project-ID` in the `.toc` and a `CF_API_KEY` repository secret to upload to CurseForge.

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

## Commandes

| Commande | Effet |
|---|---|
| `/fdp` | Ouvre ou ferme la fenêtre d'options |
| `/fdp <id>` | Affiche la suite de la quête `<id>` |
| `/fdp duo` / `/fdp solo` | Mode de calcul de la rentabilité |
| `/fdp debug` | Explique dans le chat pourquoi le panneau s'affiche ou non |

## Dépendances

- **Questie** (avec QuestieDB) est installé en même temps par l'appli CurseForge : il fournit les données des suites de quêtes, des prérequis et des donneurs. Sans lui, le panneau Quest Chain n'affiche que ce que le jeu sait de la quête.
- **RestedXP Guides** est optionnel. S'il est installé, le Guide FDP Mille pointes (Horde, 27-33, en cours d'écriture) apparaît dans son menu, suivi pour les guerriers de la quête de la Posture berserker. Sans lui, le guide est ignoré.
- La partie Auto fonctionne seule.

## Retours

Un bug, une idée ? Laisse un commentaire. Pour un souci d'affichage du panneau, tape `/fdp debug`, refais l'action et colle les lignes `[fdp]` du chat dans ton message.

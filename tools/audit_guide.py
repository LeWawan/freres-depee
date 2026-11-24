"""Second check of RXP guides against QuestieDB Forever, after lint_guide.py.

    WOW_ADDONS=... python3 -I tools/audit_guide.py FreresDEpee_Guides/guides/*.lua

lint_guide.py checks that RXP can run a guide. This script checks that the guide is right
and that its metadata follows the conventions in docs/guides-handover.md:

- header: #classic, << Horde, #name '<min>-<max> X', #displayname '[FDP] ... (<min>-<max>)'
  matching #name, #version, known #group / #subgroup, file listed in FreresDEpee_Guides.toc;
- #next targets exist among the shipped guides;
- region guides end on a #label step with a manual checkbox;
- every .accept / .turnin names, with .target, an NPC that starts / ends the quest, and its
  .goto sits next to that NPC's spawn in the same zone;
- no Alliance-only quest, at most 6 .mob per step, mobs spawning in the step's zone,
  at most 15 quests open at once;
- no .turnin on a step skipped by a level gate (.xp <N,1 skips the whole step);
- region guides: every Horde quest of the zone in the guide's level range is either in the
  guide or listed in the header comment (the 'Coupées' list).

ERR lines must be fixed. WARN lines need a look: QuestieDB has gaps for Forever content.
"""
import glob, math, os, re, sys
sys.path.insert(0, os.path.dirname(__file__))
import questiedb as Q

ROOT = os.path.join(os.path.dirname(__file__), '..')
GROUPS = {'Guide FDP (Horde)': {'Régions', 'Classe'}, 'Guide FDP Donjons (Horde)': {'Donjons'}}
HORDE = 0xB2 | (1 << 33)  # orc, undead, tauren, troll, Forever Horde bit
SKYBORNE = 1 << 32  # Skyborne, before they pick a faction; also set in Alliance masks

def horde_ok(rr):
    return not rr or bool(rr & HORDE) or rr == SKYBORNE
lookup = open(os.path.join(os.environ['WOW_ADDONS'], 'Questie/Localization/lookups/lookupZones.lua'),
              encoding='utf-8').read()
AREA, AREA_NAME = {}, {}
for a, n in re.findall(r'\[(\d+)\]\s*=\s*"([^"]+)"', lookup):
    AREA.setdefault(n, int(a)); AREA_NAME.setdefault(int(a), n)

def lookup_has(area, name):
    return AREA_NAME.get(area) == name

# Forever uiMapIDs missing from RXP's map table (.goto 2548,x,y): uiMapID -> areaId
_ui = open(os.path.join(os.environ['WOW_ADDONS'], 'QuestieDB/support/Forever/Zones/areaIdToUiMapId.lua'),
           encoding='utf-8').read()
NUMERIC_ZONES = {}  # several areas share a uiMapID: keep the one named after the map
for a, u, name in re.findall(r'\[(\d+)\]\s*=\s*(\d+),?\s*(?:--\s*(.*))?', _ui):
    if u not in NUMERIC_ZONES or name.strip() and lookup_has(int(a), name.strip()):
        NUMERIC_ZONES[u] = int(a)


errors = warnings = 0
def err(msg):
    global errors; errors += 1; print('ERR ', msg)
def warn(msg):
    global warnings; warnings += 1; print('WARN', msg)

def area_of(zone):
    zone = zone.strip()
    return NUMERIC_ZONES.get(zone) or AREA.get(zone)

def spawns(entity, eid, area):
    d = Q.get(entity, eid) or {}
    return [p for p in (d.get('spawns') or {}).get(area, []) if p and p[0] != -1]

def npc_list(field):
    if isinstance(field, list) and field and field[0]: return field[0]
    return []

toc = open(os.path.join(ROOT, 'FreresDEpee_Guides', 'FreresDEpee_Guides.toc'), encoding='utf-8').read()
files = sys.argv[1:]
guides = {}  # (group, name) -> path, over every shipped guide so #next can be resolved
for path in glob.glob(os.path.join(ROOT, 'FreresDEpee_Guides', 'guides', '*.lua')):
    for g in re.findall(r'RegisterGuide\(\[\[(.*?)\]\]\)', open(path, encoding='utf-8').read(), re.S):
        n = re.search(r'^\s*#name (.*)$', g, re.M); gr = re.search(r'^\s*#group (.*)$', g, re.M)
        if n and gr: guides[(gr.group(1).strip(), n.group(1).strip())] = path

def horde_start(q):
    """A Horde player can pick the quest up: an NPC not Alliance-only, or an object or item."""
    sb = q.get('startedBy')
    if isinstance(sb, dict): sb = [sb.get(1), sb.get(2), sb.get(3)]
    if not sb: return False
    npcs, others = (sb[0] or []), [x for x in sb[1:] if x]
    if others: return True
    return any(str((Q.get('Npc', n) or {}).get('friendlyToFaction')) != 'A' for n in npcs)

def comment_ids(text):
    """Quest ids named in the file's header comment, ranges like 95295-95327 included."""
    head = text.split('RegisterGuide')[0]
    ids = set()
    for a, b in re.findall(r'(\d{3,6})(?:\s*-\s*(\d{3,6}))?', head):
        a = int(a); b = int(b) if b else a
        ids.update(range(a, b + 1) if 0 <= b - a < 200 else (a, b))
    return ids

for path in files:
    base = os.path.basename(path)
    if f'guides/{base}' not in toc: err(f'{base}: absent de FreresDEpee_Guides.toc')
    text = open(path, encoding='utf-8').read()
    for g in re.findall(r'RegisterGuide\(\[\[(.*?)\]\]\)', text, re.S):
        g = re.sub(r'--[^\n]*', '', g)
        hdr, *steps = re.split(r'^\s*step\b([^\n]*)$', g, flags=re.M)
        h = {}
        for l in hdr.splitlines():
            m = re.match(r'\s*(#\w+|<<)\s*(.*)$', l)
            if m: h.setdefault(m.group(1), []).append(m.group(2).strip())
        name = (h.get('#name') or ['?'])[0]
        where = f'{base} [{name}]'
        # ---- header
        if '#classic' not in h: err(f'{where}: #classic manquant')
        if '#forever' not in h: err(f'{where}: #forever manquant')
        if not any(x.startswith('Horde') for x in h.get('<<', [])): err(f'{where}: filtre << Horde manquant')
        if '#version' not in h: err(f'{where}: #version manquant')
        group = (h.get('#group') or [''])[0]; sub = (h.get('#subgroup') or [''])[0]
        if group not in GROUPS: err(f'{where}: #group inconnu « {group} »')
        elif sub not in GROUPS[group]: err(f'{where}: #subgroup « {sub} » hors de {sorted(GROUPS[group])}')
        rng = re.match(r'(\d+)(?:-(\d+))? ', name)
        if not rng: err(f'{where}: #name doit commencer par le niveau')
        disp = (h.get('#displayname') or [''])[0]
        if not disp.startswith('[FDP] '): err(f'{where}: #displayname doit commencer par « [FDP] »')
        elif sub in ('Régions', 'Donjons') and rng and rng.group(2):
            want = f'({rng.group(1)}-{rng.group(2)})'
            if not disp.endswith(want): err(f'{where}: #displayname « {disp} » ne finit pas par {want}')
        for nxt in h.get('#next', []):
            for target in nxt.split(';'):
                target = re.sub(r'\s*<<.*$', '', target).strip()
                tg, _, tn = target.rpartition('\\')
                if (tg or group, tn) not in guides: err(f'{where}: #next « {target} » ne correspond à aucun guide livré')
        # ---- steps
        body = steps[1::2]
        if sub == 'Régions' and body:
            last = body[-1]
            if '#label' not in last or not re.search(r'^\s*\+', last, re.M):
                err(f'{where}: la dernière étape doit porter le #label de fin et une case à cocher +')
        opened, peak, gated = set(), 0, set()
        for i, s in enumerate(body, 1):
            sw = f'{where} step {i}'
            lines = [l.strip() for l in s.splitlines() if l.strip()]
            gotos = [(z, float(x), float(y)) for l in lines
                     for z, x, y in re.findall(r'^\.goto ([^,]+),([\d.]+),([\d.]+)', l)]
            targets = [int(t) for l in lines for t in re.findall(r'^\.target (\d+)', l)]
            mobs = [int(t) for l in lines for t in re.findall(r'^\.mob (\d+)', l)]
            if len(mobs) > 6: err(f'{sw}: {len(mobs)} lignes .mob (6 au plus)')
            gate = any(re.match(r'\.xp <\d+,1', l) for l in lines)
            here = {int(x) for x in re.findall(r'^\.accept -?(\d+)', '\n'.join(lines), re.M)}
            if gate:
                for t in re.findall(r'^\.turnin -?(\d+)', '\n'.join(lines), re.M):
                    if int(t) not in gated and int(t) not in here:  # its accept was not gated: the turn-in is lost
                        err(f'{sw}: .turnin {t} dans une étape sautée sous le niveau (.xp <N,1) : sépare le rendu')
                gated |= here
            zone = gotos[-1] if gotos else None
            area = area_of(zone[0]) if zone else None
            if zone and not area and not zone[0].strip().isdigit() and zone[0].strip() not in ('Eastern Kingdoms', 'Kalimdor'):
                warn(f'{sw}: zone « {zone[0]} » inconnue de Questie')
            for mob in mobs:
                if area and not spawns('Npc', mob, area) and (Q.get('Npc', mob) or {}).get('spawns'):
                    warn(f'{sw}: mob {mob} sans apparition dans la zone {zone[0]}')
            for kind, qid in re.findall(r'^\.(accept|turnin) -?(\d+)', '\n'.join(lines), re.M):
                qid = int(qid); q = Q.get('Quest', qid)
                if not q: continue
                rr = q.get('requiredRaces') or 0
                if not horde_ok(rr): err(f'{sw}: {qid} est une quête Alliance')
                if kind == 'accept': opened.add(qid)
                else: opened.discard(qid)
                peak = max(peak, len(opened))
                givers = npc_list(q.get('startedBy' if kind == 'accept' else 'finishedBy'))
                if not givers or not targets: continue
                if not set(targets) & set(givers):
                    err(f'{sw}: .{kind} {qid} avec .target {targets}, QuestieDB donne {givers}')
                    continue
                if area:
                    pts = [p for n in set(targets) & set(givers) for p in spawns('Npc', n, area)]
                    if pts:
                        d = min(math.hypot(zone[1] - a, zone[2] - b) for a, b in pts)
                        if d > 2.5: err(f'{sw}: .goto à {d:.1f} du PNJ de {qid} ({pts[0]})')
            if peak > 15: warn(f'{sw}: {peak} quêtes ouvertes (15 au plus)'); peak = 0
        # ---- completeness of a region guide
        if sub == 'Régions' and rng and rng.group(2):
            lo, hi = int(rng.group(1)), int(rng.group(2))
            zones = [area_of(z) for z in re.findall(r'^\s*\.goto ([^,\n]+),', g, re.M)]
            zones = [z for z in zones if z]
            if zones:
                zone = max(set(zones), key=zones.count)
                used = {int(x) for x in re.findall(r'^\s*\.(?:accept|turnin|complete|is\w+) -?(\d+)', g, re.M)}
                named = comment_ids(text)
                missing = []
                for q in Q.quests_in_zone(zone):
                    rr = q.get('requiredRaces') or 0
                    if not horde_ok(rr) or rr == SKYBORNE or q.get('requiredClasses'): continue
                    if not horde_start(q): continue
                    if (q.get('requiredLevel') or 0) > hi or (q.get('questLevel') or 0) < lo - 5: continue
                    if q['id'] not in used and q['id'] not in named: missing.append(q['id'])
                if missing:
                    warn(f'{where}: quêtes de la zone {zone} ni dans le guide ni dans « Coupées » : {missing}')

print(f'{errors} erreur(s), {warnings} avertissement(s)')
sys.exit(1 if errors else 0)

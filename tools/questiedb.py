"""Read the QuestieDB Forever data baked into QuestieDB_Forever.toc (set WOW_ADDONS first).

Values are base64 CBOR stored as `## X-<Entity>-<id>-<field>` metadata lines,
long ones split in `~N~` chunks (see QuestieDB/src/read/baked.lua).

    python3 -I tools/questiedb.py quest 1110
    python3 -I tools/questiedb.py zone 400      # quests whose zoneOrSort is 400
    python3 -I tools/questiedb.py npc 4630
"""
import base64, json, os, re, struct, sys

# Dossier AddOns du client Forever (celui qui contient QuestieDB/), par exemple :
#   export WOW_ADDONS="$HOME/.steam/steam/steamapps/compatdata/<id>/pfx/drive_c/Program Files (x86)/World of Warcraft/_forever_/Interface/AddOns"
ADDONS = os.environ.get('WOW_ADDONS') or sys.exit('WOW_ADDONS non défini : chemin du dossier AddOns du client Forever')
TOC = os.path.join(ADDONS, 'QuestieDB', 'QuestieDB_Forever.toc')

QUEST = ['name', 'startedBy', 'finishedBy', 'requiredLevel', 'questLevel', 'requiredRaces',
         'requiredClasses', 'objectivesText', 'triggerEnd', 'objectives', 'sourceItemId',
         'preQuestGroup', 'preQuestSingle', 'childQuests', 'inGroupWith', 'exclusiveTo',
         'zoneOrSort', 'requiredSkill', 'requiredMinRep', 'requiredMaxRep', 'requiredSourceItems',
         'nextQuestInChain', 'questFlags', 'specialFlags', 'parentQuest', 'reputationReward',
         'breadcrumbForQuestId', 'breadcrumbs', 'extraObjectives', 'requiredSpell',
         'requiredSpecialization', 'requiredMaxLevel', 'availableUntilCompleted',
         'availableStartingWith', 'requiredRanks', 'disabledByQuest']
NPC = ['name', 'minLevelHealth', 'maxLevelHealth', 'minLevel', 'maxLevel', 'rank', 'spawns',
       'waypoints', 'zoneID', 'questStarts', 'questEnds', 'factionID', 'friendlyToFaction',
       'subName', 'npcFlags']
OBJECT = ['name', 'questStarts', 'questEnds', 'spawns', 'zoneID', 'factionID', 'waypoints']
ITEM = ['name', 'npcDrops', 'objectDrops', 'itemDrops', 'startQuest', 'questRewards', 'flags', 'foodType', 'itemLevel', 'requiredLevel', 'ammoType', 'class', 'subClass', 'vendors', 'relatedQuests', 'teachesSpell']
FIELDS = {'Quest': QUEST, 'Npc': NPC, 'Object': OBJECT, 'Item': ITEM}


def cbor(b, i=0):
    ib = b[i]; mt, ai = ib >> 5, ib & 31; i += 1
    if ai < 24: n = ai
    elif ai == 24: n = b[i]; i += 1
    elif ai == 25: n = struct.unpack('>H', b[i:i+2])[0]; i += 2
    elif ai == 26:
        if mt == 7: return struct.unpack('>f', b[i:i+4])[0], i + 4
        n = struct.unpack('>I', b[i:i+4])[0]; i += 4
    elif ai == 27:
        if mt == 7: return struct.unpack('>d', b[i:i+8])[0], i + 8
        n = struct.unpack('>Q', b[i:i+8])[0]; i += 8
    else: raise ValueError('indefinite cbor')
    if mt == 7 and ai == 25:  # half float
        h = n; s = -1 if h >> 15 else 1; e = (h >> 10) & 31; f = h & 1023
        return s * (f / 1024 * 2 ** -14 if e == 0 else (1 + f / 1024) * 2 ** (e - 15)), i
    if mt == 0: return n, i
    if mt == 1: return -1 - n, i
    if mt == 2: return b[i:i+n].decode('utf-8', 'replace'), i + n
    if mt == 3: return b[i:i+n].decode('utf-8', 'replace'), i + n
    if mt == 4:
        out = []
        for _ in range(n):
            v, i = cbor(b, i); out.append(v)
        return out, i
    if mt == 5:
        out = {}
        for _ in range(n):
            k, i = cbor(b, i); v, i = cbor(b, i); out[k] = v
        return out, i
    if mt == 7: return {20: False, 21: True, 22: None, 23: None}[n], i
    raise ValueError(mt)


_raw = None
def raw():
    global _raw
    if _raw is None:
        _raw = {}
        for line in open(TOC, encoding='utf-8'):
            if line.startswith('## X-'):
                k, _, v = line[5:].rstrip('\n').partition(': ')
                _raw[k] = v
    return _raw


def stored(key):
    v = raw().get(key)
    if v and v.startswith('~') and re.fullmatch(r'~\d+~', v):
        v = ''.join(raw()[f'{key}-{i}'] for i in range(1, int(v[1:-1]) + 1))
    return v


def dec(v):
    return cbor(base64.b64decode(v))[0]


def get(entity, eid):
    s = stored(f'{entity}-{eid}-S')
    if s is None: return None
    row = dec(s)
    if isinstance(row, list): row = {i: v for i, v in enumerate(row, 1)}
    names = FIELDS[entity]
    out = {names[k-1]: v for k, v in row.items() if isinstance(k, int) and k <= len(names)}
    for idx, name in enumerate(names, 1):
        t = stored(f'{entity}-{eid}-{idx}')
        if t is not None and name not in out:
            out[name] = dec(t)
    out['id'] = eid
    return out


def quests_in_zone(zone):
    ids = {int(m.group(1)) for k in raw() for m in [re.match(r'Quest-(\d+)-S$', k)] if m}
    return [q for q in (get('Quest', i) for i in sorted(ids)) if q.get('zoneOrSort') == zone]


if __name__ == '__main__':
    kind, arg = sys.argv[1], int(sys.argv[2])
    if kind == 'zone':
        for q in quests_in_zone(arg):
            print(json.dumps(q, ensure_ascii=False, default=str))
    else:
        print(json.dumps(get(kind.capitalize(), arg), ensure_ascii=False, default=str, indent=1))


_ids, _l10n = {}, {}
def fr_name(entity, eid):
    """French name of an entity, None if untranslated (see QuestieDB/src/l10n/overlay.lua)."""
    import bisect, zlib
    if entity not in _ids:
        _ids[entity] = cbor(zlib.decompress(base64.b64decode(stored(f'{entity}-IDS'))))[0]
        _l10n[entity] = cbor(zlib.decompress(base64.b64decode(stored(f'l10n-frFR-{entity}'))))[0]
    ids = _ids[entity]
    pos = bisect.bisect_left(ids, eid)
    if pos == len(ids) or ids[pos] != eid:
        return None
    col = _l10n[entity][0]
    v = col[pos] if isinstance(col, list) and pos < len(col) else (col.get(pos + 1) if isinstance(col, dict) else None)
    return v if isinstance(v, str) else None

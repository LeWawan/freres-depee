"""Lint RXP guides against the RXPGuides parser rules and QuestieDB Forever.

    WOW_ADDONS=... python3 -I tools/lint_guide.py guides/*.lua

Checks: every step has an element that can complete (RXP skips a step made only of
text-only elements, GuideWindow.lua UpdateStepCompletion), labels exist, quest ids exist,
objective indexes exist, and quests are accepted before .complete / .turnin unless the
step is guarded by .isOnQuest / .isQuestComplete (quest from another region).
"""
import os, re, sys
sys.path.insert(0, os.path.dirname(__file__))
import questiedb as Q

COMPLETES = {'.accept', '.turnin', '.complete', '.xp', '.home', '.hs', '.fp', '.fly',
             '.train', '.trainer', '.collect', '.daily', '.dailyturnin', '.skill', '.reputation',
             '.deathskip', '.vehicle', '.stable', '.buy', '.destroy', '.use', '.cast'}
GUARDS = {'.isOnQuest', '.isQuestComplete'}

errors = 0
def err(msg):
    global errors
    errors += 1
    print('ERR', msg)

def goto_completes(line):
    args = [a.strip() for a in line.split('>>')[0][len('.goto'):].split(',')]
    return len(args) == 4 and float(args[3] or 0) > 0

def objective_count(q):
    o = q.get('objectives') or {}
    if isinstance(o, list): o = {i + 1: v for i, v in enumerate(o)}
    return sum(len([x for x in (v or []) if x]) for v in o.values()) + (1 if q.get('triggerEnd') else 0)

for path in sys.argv[1:]:
    text = open(path, encoding='utf-8').read()
    for g in re.findall(r'RegisterGuide\(\[\[(.*?)\]\]\)', text, re.S):
        g = re.sub(r'--[^\n]*', '', g)
        m = re.search(r'^\s*#name (.*)$', g, re.M)
        name = m.group(1) if m else '?'
        hdr, *steps = re.split(r'^\s*step\b[^\n]*$', g, flags=re.M)
        labels = set(re.findall(r'^\s*#label (\S+)', g, re.M))
        accepted, turned = set(), set()
        lvl = re.match(r'(\d+)', name)
        minlvl = int(lvl.group(1)) if lvl else None
        for i, s in enumerate(steps, 1):
            where = f'{os.path.basename(path)} [{name}] step {i}'
            lines = [l.strip() for l in s.splitlines() if l.strip()]
            cmds = [l.split()[0] for l in lines if l.startswith('.')]
            for l in lines:  # une étape .xp N sans ,1 fait monter le niveau minimum
                m = re.match(r'\.xp (\d+)(?!.*,1)', l)
                if m and minlvl and '#sticky' not in lines: minlvl = max(minlvl, int(m.group(1)))
            guarded = any(c in GUARDS for c in cmds)
            manual = any(l.startswith('+') for l in lines)  # case à cocher manuelle
            if not (manual or any(c in COMPLETES for c in cmds) or any(goto_completes(l) for l in lines if l.startswith('.goto'))):
                err(f'{where}: aucun élément complétable, RXP saute l\'étape ({lines[:1]})')
            for l in lines:
                for lab in re.findall(r'^#(?:completewith|requires) (\S+)', l):
                    if lab != 'next' and lab not in labels:
                        err(f'{where}: label inconnu {lab}')
                m = re.match(r'\.(accept|turnin|complete|isOnQuest|isQuestComplete|isQuestTurnedIn|isQuestAvailable|isNotOnQuest) -?(\d+)(?:,(\d+))?', l)
                if not m: continue
                kind, qid, obj = m.group(1), int(m.group(2)), m.group(3)
                q = Q.get('Quest', qid)
                if not q:
                    err(f'{where}: quête {qid} absente de QuestieDB Forever'); continue
                if kind == 'accept':
                    accepted.add(qid)
                    gated = any(c in GUARDS or c in ('.isQuestTurnedIn', '.xp') for c in cmds)
                    req = q.get('requiredLevel') or 0
                    if minlvl and req > minlvl and not gated:
                        err(f'{where}: {qid} demande le niveau {req}, le guide commence à {minlvl}')
                    pre = q.get('preQuestSingle') or []
                    grp = q.get('preQuestGroup') or []
                    if not gated and ((pre and not set(pre) & turned) or (grp and not set(grp) <= turned)):
                        err(f'{where}: prérequis de {qid} ({pre or grp}) pas rendus avant dans le guide')
                elif kind == 'complete':
                    if obj and objective_count(q) and int(obj) > objective_count(q):  # 0 = objectifs absents de QuestieDB, RXP les lit en jeu
                        err(f'{where}: {qid} n\'a que {objective_count(q)} objectif(s), index {obj}')
                    if qid not in accepted and not guarded:
                        err(f'{where}: .complete {qid} sans .accept avant ni garde')
                elif kind == 'turnin':
                    turned.add(qid)
                    if qid not in accepted and not guarded:
                        err(f'{where}: .turnin {qid} sans .accept avant ni garde')

print(f'{errors} erreur(s)')
sys.exit(1 if errors else 0)

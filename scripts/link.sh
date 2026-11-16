#!/usr/bin/env bash
# Relie ce dépôt au dossier AddOns du jeu, pour jouer toujours sur la copie locale.
# Usage : WOW_ADDONS=".../_forever_/Interface/AddOns" scripts/link.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
addons=${WOW_ADDONS:?définis WOW_ADDONS, le dossier Interface/AddOns du jeu}
target="$addons/FreresDEpee"

if [[ -L $target && $(readlink -f "$target") == "$root" ]]; then
    echo "déjà relié : $target -> $root"
elif [[ -e $target ]]; then
    echo "$target existe déjà et ne pointe pas ici, supprime-le d'abord" >&2
    exit 1
else
    ln -s "$root" "$target"
    echo "relié : $target -> $root"
fi

[[ -d $addons/Hoki_FuryGuide ]] && echo "attention : Hoki_FuryGuide est installé, ses guides doublonnent les Guides FDP" >&2
exit 0

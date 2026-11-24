#!/usr/bin/env bash
# Relie ce dépôt au dossier AddOns du jeu, pour jouer toujours sur la copie locale :
# le noyau (la racine du dépôt) et chaque module FreresDEpee_*/, car le jeu ne lit pas les sous-dossiers.
# Usage : WOW_ADDONS=".../_forever_/Interface/AddOns" scripts/link.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
addons=${WOW_ADDONS:?définis WOW_ADDONS, le dossier Interface/AddOns du jeu}

link() {
    local src=$1 target="$addons/$2"
    if [[ -L $target && $(readlink -f "$target") == "$src" ]]; then
        echo "déjà relié : $target -> $src"
    elif [[ -e $target ]]; then
        echo "$target existe déjà et ne pointe pas ici, supprime-le d'abord" >&2
        return 1
    else
        ln -s "$src" "$target"
        echo "relié : $target -> $src"
    fi
}
link "$root" FreresDEpee
for dir in "$root"/FreresDEpee_*/; do
    m=$(basename "$dir")
    link "$root/$m" "$m"
done

[[ -d $addons/Hoki_FuryGuide ]] && echo "attention : Hoki_FuryGuide est installé, ses guides doublonnent les Guides FDP" >&2
exit 0

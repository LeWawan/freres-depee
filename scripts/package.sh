#!/usr/bin/env bash
# Construit dist/FreresDEpee-<version>.zip à la main, pour un téléversement manuel sur CurseForge.
# Le zip contient un seul dossier FreresDEpee/ : les fichiers du .toc, LICENSE et CHANGELOG.md.
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"
version=$(sed -n 's/^## Version: *//p' FreresDEpee.toc | tr -d '\r')
files=(FreresDEpee.toc LICENSE CHANGELOG.md $(sed -n 's/\r//; /^[^#].*\.lua$/p' FreresDEpee.toc))
for f in "${files[@]}"; do [[ $f == *.lua ]] && luac5.1 -p "$f"; done
lua5.1 tests/smoke.lua . >/dev/null

stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT
mkdir "$stage/FreresDEpee"
cp "${files[@]}" "$stage/FreresDEpee/"
mkdir -p dist
out="$root/dist/FreresDEpee-$version.zip"
rm -f "$out"
(cd "$stage" && zip -qr "$out" FreresDEpee)
unzip -l "$out"

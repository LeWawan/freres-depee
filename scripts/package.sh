#!/usr/bin/env bash
# Construit dist/FreresDEpee-<version>.zip à la main, pour un téléversement manuel sur CurseForge.
# Le zip contient le noyau FreresDEpee/ (son .toc, LICENSE, CHANGELOG.md, l'icône) et un dossier par module
# FreresDEpee_*/ avec les fichiers de son .toc, comme le paquet de .pkgmeta.
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"
version=$(sed -n 's/^## Version: *//p' FreresDEpee.toc | tr -d '\r')
tocfiles() { sed -n 's/\r//; /^[^#].*\.lua$/p' "$1"; }
lua5.1 tests/smoke.lua . >/dev/null

stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT
copy() { # dossier source, dossier du zip, fichiers
    local src=$1 dst=$2; shift 2
    for f in "$@"; do [[ $f == *.lua ]] && luac5.1 -p "$src/$f"; done
    mkdir -p "$stage/$dst"
    (cd "$src" && cp --parents "$@" "$stage/$dst/")
}
copy . FreresDEpee FreresDEpee.toc LICENSE CHANGELOG.md media/icon.tga $(tocfiles FreresDEpee.toc)
for dir in FreresDEpee_*/; do
    m=${dir%/}
    copy "$m" "$m" "$m.toc" $(tocfiles "$m/$m.toc")
done
mkdir -p dist
out="$root/dist/FreresDEpee-$version.zip"
rm -f "$out"
(cd "$stage" && zip -qr "$out" .)
unzip -l "$out" | tail -n +4 | awk '{print $4}' | cut -d/ -f1 | sort | uniq -c

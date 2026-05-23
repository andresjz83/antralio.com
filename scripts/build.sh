#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dist_dir="$repo_root/dist"

mkdir -p "$dist_dir"
find "$dist_dir" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

cp "$repo_root"/*.html "$dist_dir"/
cp "$repo_root"/*.css "$dist_dir"/
cp "$repo_root"/favicon.svg "$dist_dir"/
cp "$repo_root"/hero-bg.jpg "$dist_dir"/
cp "$repo_root"/robots.txt "$dist_dir"/
cp -R "$repo_root"/images "$dist_dir"/

if [[ -d "$repo_root/the-memo" ]]; then
  cp -R "$repo_root/the-memo" "$dist_dir"/
fi

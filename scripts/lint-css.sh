#!/usr/bin/env bash
# Extract inline <style> blocks from index.html and run stylelint-browser-compat
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMPFILE=$(mktemp /tmp/lint-css-XXXXXX.css)
trap 'rm -f "$TMPFILE"' EXIT

# Extract CSS from all <style> blocks (excluding <noscript> styles)
python3 -c "
import re, sys
with open('$ROOT/index.html') as f:
    html = f.read()
# Remove noscript blocks first so we don't lint their override styles
html_no_noscript = re.sub(r'<noscript>.*?</noscript>', '', html, flags=re.DOTALL)
styles = re.findall(r'<style>(.*?)</style>', html_no_noscript, re.DOTALL)
for s in styles:
    print(s)
" > "$TMPFILE"

echo "Running browser compatibility check..."
cd "$ROOT"
npx stylelint --config .stylelintrc.json "$TMPFILE"
echo "✓ No browser compatibility issues found."

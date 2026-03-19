# antralio.com

Static landing page for Antralio. Hosted on GitHub Pages.

## Setup

Requires [mise](https://mise.jdx.dev/) (installs Node automatically).

```bash
npm install                              # install dev dependencies
mise trust                               # trust the mise.toml config
mise generate git-pre-commit --write     # install the pre-commit hook
```

## Pre-commit hook

Every commit that touches `index.html` runs a **CSS browser compatibility check** using [stylelint-browser-compat](https://github.com/3846masa/stylelint-browser-compat).

It extracts the inline `<style>` blocks from `index.html` and checks every CSS property and value against [MDN's browser-compat-data](https://github.com/mdn/browser-compat-data) for the browsers defined in `package.json`:

- Last 3 versions of Chrome, Firefox, Safari, Edge
- Last 2 iOS versions
- Firefox ESR

If you use a CSS feature that isn't supported by any of those browsers, the commit is blocked. If you've added a proper fallback (e.g. via `@supports`), add a `/* stylelint-disable-next-line plugin/browser-compat -- reason */` comment to suppress the warning.

### Run manually

```bash
mise run pre-commit     # or: ./scripts/lint-css.sh
```

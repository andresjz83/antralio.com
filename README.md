# antralio.com

Static landing page for Antralio. Hosted on Cloudflare Pages.

## Cloudflare Pages

Use these project settings:

- Build command: `npm run build`
- Build output directory: `dist`
- Node version: `22`

The custom domain (`antralio.com`) should be configured in Cloudflare Pages, not with a GitHub Pages `CNAME` file.

## Setup

Requires [mise](https://mise.jdx.dev/) (installs Node automatically).

```bash
npm install                              # install dev dependencies
mise trust                               # trust the mise.toml config
mise generate git-pre-commit --write     # install the pre-commit hook
```

## Build

```bash
npm run build
```

This copies the static site into `dist/`, which is what Cloudflare Pages deploys.

## Pre-commit hook

Every commit that touches `index.html` runs a **CSS browser compatibility check** using [stylelint-browser-compat](https://github.com/3846masa/stylelint-browser-compat).

It extracts the inline `<style>` blocks from `index.html` and checks every CSS property and value against [MDN's browser-compat-data](https://github.com/mdn/browser-compat-data) for the browsers defined in `package.json`:

- Last 3 versions of Chrome, Firefox, Safari, Edge
- Last 2 iOS versions
- Firefox ESR

If you use a CSS feature that isn't supported by any of those browsers, **the commit is blocked**. Fix it by either:

- Using a different CSS property/value that's universally supported
- Wrapping the feature in `@supports` with a visible fallback for unsupported browsers (see `.gradient-text` in `index.html` for an example)

### Run manually

```bash
mise run pre-commit     # or: ./scripts/lint-css.sh
```

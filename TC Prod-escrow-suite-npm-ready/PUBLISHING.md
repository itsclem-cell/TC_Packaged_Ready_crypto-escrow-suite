# Publishing Options

## Recommended option

### Publish to the public npm registry

Choose this if you want the package to be:
- installable by anyone with `npm install`
- easy to reference in docs and demos
- discoverable outside GitHub
- suitable for an open-source public project

This is usually the right choice for a reusable JavaScript or TypeScript package.

Official npm docs confirm that a package needs a `package.json` and that scoped packages should be published with public access on first publish. Public unscoped packages are always public, while scoped packages need `--access public` the first time. Trusted publishing is also available for CI-based releases. citeturn729062search12turn729062search4turn729062search2

## Alternative option

### Publish to GitHub Packages

Choose this if you mainly want:
- internal distribution
- tighter coupling to a GitHub repo
- team or organization package hosting
- private or GitHub-centric workflows

GitHub Packages works, but for a public open-source JavaScript package it is usually less convenient for broad adoption than npm. GitHub's docs show npm registry support, but it typically relies on GitHub authentication and package registry setup. citeturn729062search1turn729062search3turn729062search9

---

# What to choose

For your escrow SDK, choose:

## Public npm registry

That is the best fit if your goal is:
- public GitHub repo
- public open-source package
- easiest developer adoption

---

# Exact steps for npm

## 1. Update placeholders

Edit `package.json` and replace:

- `@YOUR_NPM_USERNAME/evm-escrow-suite`
- `YOUR_GITHUB_USERNAME`

## 2. Install dependencies

```bash
npm install
```

## 3. Compile and test locally

```bash
npm run compile
npm test
npm run build
npm pack --dry-run
```

## 4. Log in to npm

```bash
npm login
```

## 5. Publish

Because this package is scoped, the first publish should be:

```bash
npm publish --access public
```

npm's docs say scoped packages need `--access public` for the initial publish. citeturn729062search4turn729062search0

## 6. Install test

After publish:

```bash
npm install @YOUR_NPM_USERNAME/evm-escrow-suite
```

---

# Optional: trusted publishing from GitHub Actions

npm supports trusted publishing with OIDC so you can publish from CI without long-lived npm tokens. If you want automated releases later, this is the modern option to add. citeturn729062search2turn729062search5

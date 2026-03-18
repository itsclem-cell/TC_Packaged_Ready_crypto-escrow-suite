# Release Checklist

## Before first publish

- Update package name and GitHub links in `package.json`
- Confirm `README.md` install examples use the final package name
- Run `npm install`
- Run `npm run compile`
- Run `npm test`
- Run `npm run build`
- Run `npm pack --dry-run`
- Confirm package contents look correct
- Commit and tag the repo

## First publish

```bash
npm publish --access public
```

## After publish

- Install the package into a clean sample project
- Verify exported SDK symbols
- Add the npm package link to your GitHub README
- Create a GitHub release tagged `v1.0.0`

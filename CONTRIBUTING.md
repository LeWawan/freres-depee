# Contributing

Releases are automatic. Every push to `main` runs semantic-release, which reads the commit
messages since the last tag to pick the next version. It then updates `CHANGELOG.md` and the
`.toc`, tags the commit, creates the GitHub release and publishes to CurseForge. Commit
messages therefore have to follow [Conventional Commits](https://www.conventionalcommits.org/).

## Commit format

```
<type>(<optional scope>): <short summary in the imperative>

<optional body>

<optional footer>
```

Keep the summary lowercase, with no trailing period.

## Types

| Type       | Use it for                                        | Release |
|------------|---------------------------------------------------|---------|
| `feat`     | a new feature players can see                     | minor   |
| `fix`      | a bug fix                                         | patch   |
| `perf`     | a speed or memory improvement                     | patch   |
| `docs`     | README, CONTRIBUTING, comments                    | none    |
| `test`     | `tests/`                                          | none    |
| `build`    | packaging, `.pkgmeta`, `scripts/`                 | none    |
| `ci`       | `.github/workflows/`, `.releaserc.json`           | none    |
| `refactor` | code changes that alter no behaviour              | none    |
| `style`    | formatting only                                   | none    |
| `chore`    | anything else (`chore(release)` is reserved)      | none    |

## Breaking changes

Add `!` after the type, or a `BREAKING CHANGE:` footer. Either one triggers a major
release. For instance, a change that drops old saved variables:

```
feat!: store settings per character

BREAKING CHANGE: account-wide FreresDEpeeDB settings are reset.
```

## Examples

```
feat: add an auto-repair threshold
fix(questchain): hide the panel when the quest log closes
docs: explain the /fdp debug command
```

## Releases

Don't edit the version in the `.toc` files or the entries in `CHANGELOG.md` by hand, and
don't push `v*` tags yourself. The release job takes care of all three.

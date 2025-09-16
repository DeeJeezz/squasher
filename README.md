# squasher

Squash your commits before push to branch.

## Usage

Add following settings to your `.pre-commit-config.yaml` file.

```yaml
- repo: https://github.com/DeeJeezz/squasher
  rev: v0.1.0
  hooks:
    - id: squasher
```
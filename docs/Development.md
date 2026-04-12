# Development of module

Below you can find basic guidelines and rules that must be followed during module development.

## Using DSB Terraform Helpers

The [dsb-norge/terraform-helpers](https://github.com/dsb-norge/terraform-helpers) script provides commands for all common development tasks. Load it once per shell session:

```shell
# Load authenticated with GitHub CLI
source <(gh api -H "Accept: application/vnd.github.v3.raw" /repos/dsb-norge/terraform-helpers/contents/dsb-tf-proj-helpers.sh)

# Or if the above doesn't work (some shells/agents don't support process substitution)
eval "$(gh api -H 'Accept: application/vnd.github.v3.raw' /repos/dsb-norge/terraform-helpers/contents/dsb-tf-proj-helpers.sh)"
```

After loading, run `tf-help` to see all available commands, or `tf-status` for an overview of tools, authentication, and module structure.

## Validate your code

```shell
# Initialize the module (downloads providers)
tf-init

# Or upgrade dependencies to latest within version constraints
tf-upgrade

# Check formatting
tf-fmt

# Fix formatting
tf-fmt-fix

# Validate the module
tf-validate

# Lint the module
tf-lint

# Initialize all examples
tf-init-examples

# Validate all examples
tf-validate-examples

# Lint all examples (uses root .tflint.hcl config)
tf-lint-examples
```

## Run tests

### Unit tests (no Azure credentials needed)

```shell
# Run unit tests (uses mocked providers)
tf-test-unit
```

### Integration tests (deploys real Azure resources)

Integration tests require Azure authentication. You will be asked to confirm by typing the subscription name before tests run:

```shell
# Log in to Azure (if not already)
az-login

# Set the subscription for testing
az-select-sub

# Run integration tests (prompts for subscription name confirmation)
tf-test-integration

# Run all tests (unit + integration, prompts if integration tests exist)
tf-test
```

### Test individual examples manually

```shell
# Apply and destroy each example (prompts for subscription name confirmation)
tf-test-examples
```

## Bump dependencies

```shell
# Bump everything: registry modules, tflint plugins, CI/CD workflow versions,
# then upgrade terraform providers and show available upgrades
tf-bump

# Or bump individual categories
tf-bump-modules          # Registry module versions in .tf files
tf-bump-tflint-plugins   # TFLint plugin versions in .tflint.hcl
tf-bump-cicd             # Terraform/tflint versions in GitHub workflow files

# Show available provider upgrades
tf-show-provider-upgrades
```

## Release and versioning

This module uses [semantic versioning](https://semver.org).
Always use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) in your pull-requests.
Module is using [release-please action](https://github.com/googleapis/release-please-action) and it create release PR based on commit message after PR is merged to main.
Use [respective conventional commits](https://github.com/googleapis/release-please?tab=readme-ov-file#how-should-i-write-my-commits) to achieve correct [SemVer](https://semver.org) release version.

Refer to [release-please documentation](https://github.com/googleapis/release-please) for better understanding and when additional questions occur.

## Documentation

Repo CI action has step to generate terraform documentation automatically using [terraform-docs action](https://github.com/terraform-docs/gh-actions) and configuration files in repo.
It is, however, possible to run `terraform-docs` locally to check documentation during development or when other need occur.

### Generate terraform-docs

```shell
# Generate docs for root module (updates README.md)
tf-docs

# Generate docs for all examples (updates each example's README.md)
tf-docs-examples

# Generate both
tf-docs-all
```

### Install terraform-docs (if needed)

```shell
# Requires Go 1.17+
go install github.com/terraform-docs/terraform-docs@v0.19.0
export PATH=$PATH:$(go env GOPATH)/bin
```

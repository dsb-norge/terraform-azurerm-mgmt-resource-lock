<!--
  Scaffolded by https://github.com/dsb-infra/.github-private — customize freely.
  This file is NOT overwritten by the auto-generate script. It is yours to maintain.

  Read by: Claude Code, VS Code Copilot, GitHub.com Coding Agent.
  Purpose: Project-specific instructions that complement the auto-generated .claude/CLAUDE.md.
  Only add content here that is NOT already covered by README.md.
-->

# Project-Specific Instructions

## Purpose

This module creates Azure management locks (`azurerm_management_lock`) on one or more resources. It is a thin wrapper that standardises lock naming, notes, and defaults across the organisation.

## Architecture Decisions

- The single resource `azurerm_management_lock.protected_resource_lock` uses `for_each` over the `var.protected_resources` map, so every map key becomes a stable Terraform address.
- Lock level defaults to `CanNotDelete` when not specified; the only other valid value is `ReadOnly`.
- The `notes` field on every lock embeds `app_name`, `created_by`, and a description for auditability.
- `coalesce()` is used in locals and in the resource to fall back to defaults for optional fields — no `try()`.

## Design Constraints

- The module does **not** create the resources it locks. Callers must pass in existing resource IDs.
- Provider version range (`>= 3.0.0, < 5.0.0`) intentionally spans AzureRM v3 and v4 for migration flexibility.
- The `protected_resources` variable uses an `object` type with `optional()` fields; callers can omit `lock_level` and `description`.

## Testing Notes

- Unit tests in `tests/unit-tests.tftest.hcl` run with `command = plan` (no real resources) and use a mock provider only for the output test that requires `apply`.
- Test input is shared via `tests/common-test.auto.tfvars`.
- Integration tests apply the examples under `examples/` against a real Azure subscription and require `ARM_SUBSCRIPTION_ID` to be set.
- Helper modules under `tests/` (`generate-names`, `read-resource-locks`, `setup-resource-group`) are test infrastructure only — not part of the published module.

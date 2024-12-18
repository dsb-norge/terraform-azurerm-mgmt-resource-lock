# Terraform module for resource lock creation

Terraform module for adding [management locks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) to resources.

## Usage

Refer to [examples](https://github.com/dsb-norge/terraform-azurerm-mgmt-resource-lock/tree/main/examples) for usage of module.

<!-- BEGIN_TF_DOCS -->



```hcl
locals {
  default_lock_level = "CanNotDelete"
  lock_levels = { for name, spec in var.protected_resources :
    name => coalesce(spec.lock_level, local.default_lock_level)
  }
  descriptions = { for name, spec in var.protected_resources :
    name => coalesce(spec.description, "${local.lock_levels[name]} lock for ${spec.name}")
  }
}

resource "azurerm_management_lock" "protected_resource_lock" {
  for_each = var.protected_resources

  lock_level = coalesce(each.value.lock_level, "CanNotDelete")
  name       = "lock-${each.value.name}"
  scope      = each.value.id
  notes      = <<-NOTES
    ApplicationName: ${var.app_name}
    CreatedBy: ${var.created_by}
    Description: ${local.descriptions[each.key]}
  NOTES
}
```
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_management_lock_ids"></a> [management\_lock\_ids](#output\_management\_lock\_ids) | ids of the the management locks created by this module |
<!-- END_TF_DOCS -->

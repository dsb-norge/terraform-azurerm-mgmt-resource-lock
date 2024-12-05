# Terraform module for resource lock creation

Terraform module for adding [management locks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) to resources.

## Usage

Refer to [examples](https://github.com/dsb-norge/terraform-azurerm-mgmt-resource-lock/tree/main/examples) for usage of module.


<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-disable MD033 -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_lock.protected_resource_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |

<!-- markdownlint-disable MD013 -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of application/domain using resources | `string` | n/a | yes |
| <a name="input_created_by"></a> [created\_by](#input\_created\_by) | The terraform project managing the lock(s) | `string` | n/a | yes |
| <a name="input_protected_resources"></a> [protected\_resources](#input\_protected\_resources) | Map with configuration of what resources to lock and how. | <pre>map(object({<br/>    id : string,<br/>    name : string,<br/>    lock_level : optional(string),<br/>    description : optional(string),<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_management_lock_ids"></a> [management\_lock\_ids](#output\_management\_lock\_ids) | ids of the the management locks created by this module |

## Modules

No modules.
<!-- END_TF_DOCS -->

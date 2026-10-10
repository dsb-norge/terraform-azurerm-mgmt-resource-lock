# tflint-ignore-file: terraform_standard_module_structure, terraform_variable_separate, terraform_output_separate, azurerm_resource_tag

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0, < 4.0.0"
    }
  }
}

variable "naming_suffix" {
  description = "The suffix to append to the names of the resources"
  type        = list(string)
  default     = ["automated-testing"]
}

# random part of the name, so that test runs do not collide
resource "random_string" "unique" {
  length  = 4
  special = false
  upper   = false
}

output "unique_resource_group_name" {
  description = "Randomly generated name for a resource group"
  value       = substr(join("-", compact(concat(["rg"], var.naming_suffix, [random_string.unique.result]))), 0, 90)
}

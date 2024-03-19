terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

resource "random_id" "name_suffix" {
  byte_length = 8
}

resource "random_uuid" "subscription_id" {}

locals {
  name_suffix         = random_id.name_suffix.hex
  subscription_id     = random_uuid.subscription_id.result
  resource_group_name = "rg-${local.name_suffix}"
  app_name            = "func-${local.name_suffix}"
  app_service_plan_id = "/subscriptions/${random_uuid.subscription_id.result}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Web/serverFarms/asp-${local.name_suffix}"
}

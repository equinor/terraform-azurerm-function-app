# Terraform module for Azure Function App

Terraform module which creates Azure Function App resources.

## Features

- Linux Function App created by default.
- HTTPS enforced.
- Public network access denied by default.
- Identity-based connection to given Storage account configured by default (for Storage account requirements, see [notes](#storage-account-requirements)).
- Audit logs sent to given Log Analytics workspace by default.
- Changes to app settings `BUILD`, `BUILD_NUMBER` and `BUILD_ID` ignored, allowing them to be configured outside of Terraform (commonly in a CI/CD pipeline).

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure role `Web Plan Contributor` at the App Service plan scope.
- Azure role `Role Based Access Control Administrator` at the Storage account scope.
- Azure role `Log Analytics Contributor` at the Log Analytics workspace scope.

## Usage

```terraform
provider "azurerm" {
  storage_use_azuread = true

  features {}
}

module "function_app" {
  source  = "equinor/function-app/azurerm"
  version = "~> 5.6"

  app_name                   = "example-func"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  app_service_plan_id        = module.app_service.plan_id
  storage_account_id         = module.storage.account_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "northeurope"
}

module "app_service" {
  source  = "equinor/app-service/azurerm"
  version = "~> 2.1"

  plan_name           = "example-plan"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku_name            = "Y1"
}

module "storage" {
  source  = "equinor/storage/azurerm"
  version = "~> 12.11"

  account_name                 = "funcstorage"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  log_analytics_workspace_id   = module.log_analytics.workspace_id
  network_rules_default_action = "Allow"
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "~> 2.3"

  workspace_name      = "example-workspace"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}
```

## Notes

### Storage account requirements

You can't use a network-secured Storage account when your Function App is hosted in an App Service plan with the `Y1` SKU ([ref.](https://learn.microsoft.com/en-us/azure/azure-functions/storage-considerations?tabs=azure-cli#storage-account-requirements)).

## Testing

1. Initialize working directory:

    ```console
    terraform init
    ```

1. Execute tests:

    ```console
    terraform test
    ```

    See [`terraform test` command documentation](https://developer.hashicorp.com/terraform/cli/commands/test) for options.

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).

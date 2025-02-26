# Terraform module for Azure Function App

[![GitHub License](https://img.shields.io/github/license/equinor/terraform-azurerm-function-app)](https://github.com/equinor/terraform-azurerm-function-app/blob/main/LICENSE)
[![GitHub Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-function-app)](https://github.com/equinor/terraform-azurerm-function-app/releases/latest)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-function-app/badge)](https://developer.equinor.com/governance/scm-policy/)

Terraform module which creates Azure Function App resources.

## Features

- Linux Function App created by default.
- HTTPS enforced.
- Public network access denied by default.
- Audit logs sent to given Log Analytics workspace by default.
- Changes to app settings `BUILD`, `BUILD_NUMBER` and `BUILD_ID` ignored, allowing them to be configured outside of Terraform (commonly in a CI/CD pipeline).

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure role `Role Based Access Administrator` at the Storage account scope.
- Azure role `Log Analytics Contributor` at the Log Analytics workspace scope.

## Usage

1. Login to Azure:

    ```console
    az login
    ```

1. Create a Terraform configuration file `main.tf` and add the following example configuration:

    ```terraform
    provider "azurerm" {
      features {}
    }

    module "function_app" {
      source  = "equinor/function-app/azurerm"
      version = "~> 5.2"

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

      account_name               = "funcstorage"
      resource_group_name        = var.resource_group_name
      location                   = var.location
      log_analytics_workspace_id = module.log_analytics.workspace_id

      # You can't use a network-secured Storage account when your Function App is hosted in an App Service plan with the "Y1" SKU.
      # Ref: https://learn.microsoft.com/en-us/azure/azure-functions/storage-considerations?tabs=azure-cli#storage-account-requirements
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

1. Install required provider plugins and modules:

    ```console
    terraform init
    ```

1. Apply the Terraform configuration:

    ```console
    terraform apply
    ```

## Development

1. Read [this document](https://code.visualstudio.com/docs/devcontainers/containers).

1. Clone this repository.

1. Configure Terraform variables in a file `.devcontainer/devcontainer.env`:

    ```env
    TF_VAR_resource_group_name=
    TF_VAR_location=
    ```

1. Open repository in dev container.

## Testing

1. Change to the test directory:

    ```console
    cd test
    ```

1. Login to Azure:

    ```console
    az login
    ```

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Run tests:

    ```console
    go test -timeout 60m
    ```

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).

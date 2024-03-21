# Changelog

## [4.1.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v4.0.0...v4.1.0) (2024-03-21)


### Features

* use 32-bit worker worker process ([#58](https://github.com/equinor/terraform-azurerm-function-app/issues/58)) ([90afbe0](https://github.com/equinor/terraform-azurerm-function-app/commit/90afbe0e3de2b17bc2b79738543b6a723decd346))

## [4.0.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.6.0...v4.0.0) (2024-03-19)


### ⚠ BREAKING CHANGES

* split variable `application_stack` object properties into variables `application_stack_dotnet_version`, `application_stack_use_dotnet_isolated_runtime`, `application_stack_java_version`, `application_stack_node_version`, `application_stack_python_version` and `application_stack_powershell_core_version`. Option to set application stack `use_custom_runtime` has been removed.

### Features

* split application stack properties into variables ([#56](https://github.com/equinor/terraform-azurerm-function-app/issues/56)) ([ca18c23](https://github.com/equinor/terraform-azurerm-function-app/commit/ca18c23e2f297762d09ab61cada8aebcbe7ff71f))

## [3.6.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.5.2...v3.6.0) (2024-02-22)


### Features

* variable for diagnostic setting metric ([#53](https://github.com/equinor/terraform-azurerm-function-app/issues/53)) ([809263b](https://github.com/equinor/terraform-azurerm-function-app/commit/809263bd88a17f7e43188370148f19c626082816))

## [3.5.2](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.5.1...v3.5.2) (2023-12-20)


### Bug Fixes

* remove diagnostic setting retention policies ([#48](https://github.com/equinor/terraform-azurerm-function-app/issues/48)) ([f612009](https://github.com/equinor/terraform-azurerm-function-app/commit/f6120094ceb43ab7182043b318113cf25dd2d2f3))

## [3.5.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.5.0...v3.5.1) (2023-09-27)


### Bug Fixes

* user-assigned identities not being assigned ([#38](https://github.com/equinor/terraform-azurerm-function-app/issues/38)) ([81466d8](https://github.com/equinor/terraform-azurerm-function-app/commit/81466d89926e10811e8a471ce45ab4075c11b135)), closes [#37](https://github.com/equinor/terraform-azurerm-function-app/issues/37)

## [3.5.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.4.1...v3.5.0) (2023-09-25)


### Features

* auto assign Key Vault reference identity ID ([#34](https://github.com/equinor/terraform-azurerm-function-app/issues/34)) ([a3ec8a7](https://github.com/equinor/terraform-azurerm-function-app/commit/a3ec8a74c3c74ac6428d307e248ec95c116a3807))

## [3.4.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.4.0...v3.4.1) (2023-09-22)


### Bug Fixes

* set correct .NET runtime version ([#31](https://github.com/equinor/terraform-azurerm-function-app/issues/31)) ([6a57927](https://github.com/equinor/terraform-azurerm-function-app/commit/6a5792753b35f4216d5c298fce9def95d4748b41))

## [3.4.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.3.0...v3.4.0) (2023-09-20)


### Features

* set app scale limit ([#29](https://github.com/equinor/terraform-azurerm-function-app/issues/29)) ([86dc1b2](https://github.com/equinor/terraform-azurerm-function-app/commit/86dc1b2df35ef0c66fa2893a89cdd8ec9a115502))

## [3.3.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.2.1...v3.3.0) (2023-09-19)


### Features

* set pre-warmed instance count ([#27](https://github.com/equinor/terraform-azurerm-function-app/issues/27)) ([0711d2a](https://github.com/equinor/terraform-azurerm-function-app/commit/0711d2aa5b17459503b3fb511e0835622165551f))

## [3.2.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.2.0...v3.2.1) (2023-09-19)


### Bug Fixes

* remove unused variable `sku_name` ([#23](https://github.com/equinor/terraform-azurerm-function-app/issues/23)) ([5609cde](https://github.com/equinor/terraform-azurerm-function-app/commit/5609cdea0955ee91851907037af1c71844bf8b00))

## [3.2.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.1.2...v3.2.0) (2023-09-19)


### Features

* set minimum number of elastic instances ([#21](https://github.com/equinor/terraform-azurerm-function-app/issues/21)) ([c9fa4ca](https://github.com/equinor/terraform-azurerm-function-app/commit/c9fa4ca399346054c2597e61a44373f19c4fd590))

## [3.1.2](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.1.1...v3.1.2) (2023-09-15)


### Bug Fixes

* route all outbound traffic through vNet ([#19](https://github.com/equinor/terraform-azurerm-function-app/issues/19)) ([c63a9fc](https://github.com/equinor/terraform-azurerm-function-app/commit/c63a9fcbfc0935d331ac4368a82a3afab52a3d06))

## [3.1.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.1.0...v3.1.1) (2023-09-15)


### Bug Fixes

* configure vNet configuration for Windows app ([#17](https://github.com/equinor/terraform-azurerm-function-app/issues/17)) ([952c426](https://github.com/equinor/terraform-azurerm-function-app/commit/952c4265a5ea65cd09b500b04ac311e712f84c91))

## [3.1.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v3.0.0...v3.1.0) (2023-09-14)


### Features

* configure vNet integration ([#15](https://github.com/equinor/terraform-azurerm-function-app/issues/15)) ([a037a71](https://github.com/equinor/terraform-azurerm-function-app/commit/a037a71dbbf1729167bfec7a217ecdbce5bd307a))

## [3.0.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v2.1.2...v3.0.0) (2023-07-26)


### ⚠ BREAKING CHANGES

* remove variable `identity`, add variables `system_assigned_identity_enabled` and `identity_ids`.

### Code Refactoring

* simplify identity configuration ([#12](https://github.com/equinor/terraform-azurerm-function-app/issues/12)) ([811d911](https://github.com/equinor/terraform-azurerm-function-app/commit/811d911b319c0754227a3f231c5a24cddca11b1e))

## [2.1.2](https://github.com/equinor/terraform-azurerm-function-app/compare/v2.1.1...v2.1.2) (2023-07-26)


### Bug Fixes

* don't specify Log Analytics destination type ([#10](https://github.com/equinor/terraform-azurerm-function-app/issues/10)) ([b983a60](https://github.com/equinor/terraform-azurerm-function-app/commit/b983a60e4379abfe9afd1e2a57d677baee21b6e1))

## [2.1.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v2.1.0...v2.1.1) (2023-06-16)


### Bug Fixes

* set tags ([#8](https://github.com/equinor/terraform-azurerm-function-app/issues/8)) ([9e05caf](https://github.com/equinor/terraform-azurerm-function-app/commit/9e05caf30107d1c6da39c188ce7676eb726bf7c2))

## [2.1.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v2.0.0...v2.1.0) (2023-04-27)


### Features

* set diagnostic setting enabled log categories ([#6](https://github.com/equinor/terraform-azurerm-function-app/issues/6)) ([412bf2a](https://github.com/equinor/terraform-azurerm-function-app/commit/412bf2a4e10217502e72ae74eaa191576ad874c0))

## [2.0.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v1.0.0...v2.0.0) (2023-04-17)


### ⚠ BREAKING CHANGES

* submodule `app` is now main module.

### Code Refactoring

* one-to-one mapping of module calls to visible Azure resources ([#4](https://github.com/equinor/terraform-azurerm-function-app/issues/4)) ([181f49a](https://github.com/equinor/terraform-azurerm-function-app/commit/181f49a3924f12266310ac6a79013306d5c619a9))

## 0.1.0 (2023-02-16)


### Features

* create Function App ([#1](https://github.com/equinor/terraform-azurerm-function-app/issues/1)) ([b7e4fe1](https://github.com/equinor/terraform-azurerm-function-app/commit/b7e4fe1f7bb6fc0eafebd344914f937d4537f1a9))

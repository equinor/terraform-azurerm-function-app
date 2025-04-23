# Changelog

## [5.6.3](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.6.2...v5.6.3) (2025-04-23)


### Documentation

* fix indents in README ([55af1c5](https://github.com/equinor/terraform-azurerm-function-app/commit/55af1c53b9f470964e5ba2ea0713b062a68cf0ac))

## [5.6.2](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.6.1...v5.6.2) (2025-04-23)


### Documentation

* update README ([fd555f0](https://github.com/equinor/terraform-azurerm-function-app/commit/fd555f07f96e5ef7425783ca76cdc87328ea7f36))

## [5.6.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.6.0...v5.6.1) (2025-04-10)


### Reverts

* update app settings incrementally ([#104](https://github.com/equinor/terraform-azurerm-function-app/issues/104)) ([ea4185f](https://github.com/equinor/terraform-azurerm-function-app/commit/ea4185f89596917b4d671c369a89f297011f2b02))

## [5.6.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.5.0...v5.6.0) (2025-03-27)


### Features

* update app settings incrementally ([#104](https://github.com/equinor/terraform-azurerm-function-app/issues/104)) ([e0208fe](https://github.com/equinor/terraform-azurerm-function-app/commit/e0208fe6cc3340d69bcf74df901019e763167fbe))

## [5.5.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.4.0...v5.5.0) (2025-03-20)


### Features

* deploy local ZIP-packaged application ([#102](https://github.com/equinor/terraform-azurerm-function-app/issues/102)) ([c321337](https://github.com/equinor/terraform-azurerm-function-app/commit/c3213372705dc673bd9900a918d4fafdfa23666f))

## [5.4.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.3.2...v5.4.0) (2025-03-17)


### Features

* add variable `application_insights_key` ([#100](https://github.com/equinor/terraform-azurerm-function-app/issues/100)) ([34c4996](https://github.com/equinor/terraform-azurerm-function-app/commit/34c49961b10323d4850851b89d45a6c87a91494d))

## [5.3.2](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.3.1...v5.3.2) (2025-03-10)


### Documentation

* clarify Storage account requirements ([#98](https://github.com/equinor/terraform-azurerm-function-app/issues/98)) ([90288f4](https://github.com/equinor/terraform-azurerm-function-app/commit/90288f415612a18b8483f55cf88073d616018052))

## [5.3.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.3.0...v5.3.1) (2025-02-26)


### Bug Fixes

* unable to connect Storage using access key ([#96](https://github.com/equinor/terraform-azurerm-function-app/issues/96)) ([4ae4d0e](https://github.com/equinor/terraform-azurerm-function-app/commit/4ae4d0e4db2d49b99e7e7da23f94f9417d560b2f))

## [5.3.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.2.1...v5.3.0) (2025-02-26)


### Features

* add variable `storage_account_access_key` ([#94](https://github.com/equinor/terraform-azurerm-function-app/issues/94)) ([f9d11eb](https://github.com/equinor/terraform-azurerm-function-app/commit/f9d11eb672a4b1c28e4d974677d7715d7bccdde1))

## [5.2.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.2.0...v5.2.1) (2025-02-05)


### Bug Fixes

* prevent configuration of `AzureWebJobsStorage` app setting ([#92](https://github.com/equinor/terraform-azurerm-function-app/issues/92)) ([2634bf6](https://github.com/equinor/terraform-azurerm-function-app/commit/2634bf654e1b38cb969e8cc82a98ef8160ad76a7))
* prevent configuration of Application Insights app settings ([#91](https://github.com/equinor/terraform-azurerm-function-app/issues/91)) ([df8bdc6](https://github.com/equinor/terraform-azurerm-function-app/commit/df8bdc6317f553298acdf8acb6358e74719c78d7))

## [5.2.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.1.1...v5.2.0) (2025-01-30)


### Features

* configure sticky settings ([#76](https://github.com/equinor/terraform-azurerm-function-app/issues/76)) ([ebe5b41](https://github.com/equinor/terraform-azurerm-function-app/commit/ebe5b4156aea713cb3d5d32e1db4506658c18d88))

## [5.1.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.1.0...v5.1.1) (2025-01-03)


### Bug Fixes

* outdated modules in examples ([#88](https://github.com/equinor/terraform-azurerm-function-app/issues/88)) ([7297b2d](https://github.com/equinor/terraform-azurerm-function-app/commit/7297b2d63281f02809c728d726b8eeb30bc3a92e))

## [5.1.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.0.2...v5.1.0) (2024-11-26)


### Features

* configure basic authentication for publishing ([#77](https://github.com/equinor/terraform-azurerm-function-app/issues/77)) ([562a282](https://github.com/equinor/terraform-azurerm-function-app/commit/562a282b692ea083bea452240f9b0fbfd5af619d))
* configure client certificate mode ([#80](https://github.com/equinor/terraform-azurerm-function-app/issues/80)) ([c7c1859](https://github.com/equinor/terraform-azurerm-function-app/commit/c7c185930303b5af7fd773985aab1a3207750bf8))
* configure FTPS state ([#81](https://github.com/equinor/terraform-azurerm-function-app/issues/81)) ([815df1f](https://github.com/equinor/terraform-azurerm-function-app/commit/815df1f4a125b726894f1de1dbd099319afbd6fa))
* configure HTTP/2 protocol ([#82](https://github.com/equinor/terraform-azurerm-function-app/issues/82)) ([937d8b1](https://github.com/equinor/terraform-azurerm-function-app/commit/937d8b17ad3351ae52e850d64c5cb74cd2d42e76))
* disable built-in logging ([#79](https://github.com/equinor/terraform-azurerm-function-app/issues/79)) ([cdf5107](https://github.com/equinor/terraform-azurerm-function-app/commit/cdf5107365bb9facca1bcb84338d79584524ef7f))

## [5.0.2](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.0.1...v5.0.2) (2024-08-26)


### Documentation

* clarify prerequisite roles ([#74](https://github.com/equinor/terraform-azurerm-function-app/issues/74)) ([1d204e7](https://github.com/equinor/terraform-azurerm-function-app/commit/1d204e786661c7dc82daf0e424e3d81dd464bc3b))

## [5.0.1](https://github.com/equinor/terraform-azurerm-function-app/compare/v5.0.0...v5.0.1) (2024-08-23)


### Miscellaneous Chores

* update variable and output descriptions ([#72](https://github.com/equinor/terraform-azurerm-function-app/issues/72)) ([24ae031](https://github.com/equinor/terraform-azurerm-function-app/commit/24ae03189d1f67479e43648977e9a089c58522d7))

## [5.0.0](https://github.com/equinor/terraform-azurerm-function-app/compare/v4.1.0...v5.0.0) (2024-08-22)


### ⚠ BREAKING CHANGES

* remove variable `application_insights_key`. To migrate your project, use variable `application_insights_connection_string` instead.
* public network access denied by default. To keep public network access allowed by default, set the value of variables `ip_restriction_default_action` and `scm_ip_restriction_default_action` to `"Allow"`.
* changes to app settings will no longer be ignored. To migrate your project, configure app settings for your Function App using the new `app_settings` variable. Consider using App Configuration and Key Vault references to continue managing settings outside of Terraform.
* remove variables `storage_account_name`, `storage_account_key` and `system_assigned_identity_enabled`. Add required variable `storage_account_id`.

### Features

* configure app settings ([#68](https://github.com/equinor/terraform-azurerm-function-app/issues/68)) ([9f6408c](https://github.com/equinor/terraform-azurerm-function-app/commit/9f6408c86f006ebdc86d6572f0cf4080c4c11e5a))
* connect to Storage using RBAC ([#65](https://github.com/equinor/terraform-azurerm-function-app/issues/65)) ([1d97892](https://github.com/equinor/terraform-azurerm-function-app/commit/1d9789227a3c8094c7e28d8450eaa76390644ffb))
* deny public network access by default ([#69](https://github.com/equinor/terraform-azurerm-function-app/issues/69)) ([bce2065](https://github.com/equinor/terraform-azurerm-function-app/commit/bce2065f16cac92bb1c6cafa0dd66a0cf8b5df9e))
* remove deprecated App Insights instrumentation key ([#71](https://github.com/equinor/terraform-azurerm-function-app/issues/71)) ([43e401f](https://github.com/equinor/terraform-azurerm-function-app/commit/43e401ff9bb46a6b1f7bf18f85c016a214a7c35b))

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

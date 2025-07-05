locals {

  tags = {
    name        = "eg"
    app         = "boj"
    env         = "dev"
    zone        = "z1"
    CreatedDate = formatdate("YYYYMMDD", timestamp())
  }
}

module "naming" {
  source        = "Azure/naming/azurerm"
  version       = " >= 0.4.0"
  suffix        = ["test", "dev", "mbs"]
  unique-length = 3

}

module "avm-res-resources-resourcegroup" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  version  = "0.2.1"
  name     = module.naming.resource_group.name_unique
  location = "southeastasia"
  tags     = local.tags
}

module "avm-res-web-serverfarm" {
  source  = "Azure/avm-res-web-serverfarm/azurerm"
  version = "0.7.0"

  name                = module.naming.app_service_plan.name
  location            = "southeastasia"
  enable_telemetry    = false
  resource_group_name = module.avm-res-resources-resourcegroup.name
  os_type             = "Linux"
  sku_name            = "B1"
  tags                = local.tags
}

module "avm-res-web-site" {
  source                   = "Azure/avm-res-web-site/azurerm"
  version                  = "0.17.2"
  name                     = module.naming.static_web_app.name
  location                 = "southeastasia"
  resource_group_name      = module.avm-res-resources-resourcegroup.name
  os_type                  = "Linux"
  kind                     = "webapp"
  service_plan_resource_id = module.avm-res-web-serverfarm.resource_id
  enable_telemetry         = false
  tags                     = local.tags
}
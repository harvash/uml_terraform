# tenant.tf
# Resource definitions for tenant components

data "azurerm_resource_group" "tenants" {
  count = length(var.vms)
  name  = "${var.vms[count.index].rg_name}"

}


data "azurerm_virtual_network" "tenant_vnets" {
  count               = length(var.vms)
  name                = "${var.vms[count.index].virtual_network_name}"
  resource_group_name = "${var.vms[count.index].rg_name}"

}

data "azurerm_subnet" "tenant_subnets" {
  count                = length(var.vms)
  name                 = "default"
  resource_group_name  = "${var.vms[count.index].rg_name}"
  virtual_network_name = "${var.vms[count.index].virtual_network_name}"

}



resource "azurerm_resource_group" "umltfgroup" {
    name     = "umlresourcegroup"
    location = "eastus2"

    tags = {
        environment = data.azurerm_resource_group.tenants[count.index].tags
    }
}

resource "azurerm_virtual_network" "umltfnetwork" {
    name                = "umlnet"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus2"
    resource_group_name = azurerm_resource_group.umltfgroup.name

    tags = {
        environment = data.azurerm_resource_group.tenants[count.index].tags
    }
}

resource "azurerm_subnet" "umltfsubnet" {
    name                 = "umlsubnet"
    resource_group_name  = azurerm_resource_group.umltfgroup.name
    virtual_network_name = azurerm_virtual_network.umltfnetwork.name
    address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "umltfpubip" {
    name                         = "umlpubip"
    location                     = "eastus2"
    resource_group_name          = azurerm_resource_group.umltfgroup.name
    allocation_method            = "Dynamic"

    tags = {
        environment = data.azurerm_resource_group.tenants[count.index].tags
    }
}

resource "azurerm_network_security_group" "umltfnsg" {
    name                = "umlnsg"
    location            = "eastus2"
    resource_group_name = azurerm_resource_group.umltfgroup.name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = data.azurerm_resource_group.tenants[count.index].tags
    }
}

resource "azurerm_network_interface" "nic" {
  count               = length(var.vms)
  name                = "${var.prefix}-${var.vms[count.index].vm_name-NIC1}"
  location            = var.vms[count.index].rg_location
  resource_group_name = var.vms[count.index].rg_name

  ip_configuration {
    name                          = "${var.prefix}-${vm-nic1-conf}"
    subnet_id                     = data.azurerm_subnet.tenant_subnets[count.index].id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vms[count.index].vm_ip
  }

  tags = data.azurerm_resource_group.tenants[count.index].tags
}

resource "azurerm_virtual_machine" "vm" {
  count                 = length(var.vms)
  name                  = "${var.prefix}-${var.vms[count.index].vm_name}"
  location              = var.vms[count.index].rg_location
  resource_group_name   = var.vms[count.index].rg_name
  network_interface_ids = ["azurerm_network_interface.nic[count.index].id"]
  vm_size               = var.vms[count.index].vm_size

  storage_image_reference {
    publisher = var.vms[count.index].publisher
    offer     = var.vms[count.index].offer
    sku       = var.vms[count.index].sku
    version   = var.vms[count.index].version
  }
  storage_os_disk {
    name              = "${var.prefix}-${var.vms[count.index].vm_name-disk1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 50
  }
  os_profile {
    computer_name  = var.vms[count.index].vm_name
    admin_username = var.vm_admin_name
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = var.ssh_public_key
      path     = "/home/var.vm_admin_name/.ssh/authorized_keys"

    }
  }
  tags = data.azurerm_resource_group.tenants[count.index].tags
}

resource "azurerm_storage_account" "sa" {
  name                = "${var.prefix}_sa_random_string.random.result"
  resource_group_name = data.azurerm_resource_group.tenants.0.name
  location            = data.azurerm_resource_group.tenants.0.location

  account_kind             = "StorageV2"
  account_tier             = "Premium"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  count                 = length(var.vms)
  name                  = "${var.prefix}-storage-container"
  resource_group_name   = var.vms[count.index].rg_name
  container_access_type = "private"
  storage_account_name  = "azurerm_storage_account.sa.name"
}

resource "random_string" "random" {
  length  = 6
  upper   = false
  special = false
  #override_special = "/@£$"
}

resource "azurerm_managed_disk" "az_managed_disk" {
  count                = length(var.data_disks)
  name                 = "${var.prefix}-${var.data_disks[count.index].name}"
  location             = var.data_disks[count.index].rg_location
  resource_group_name  = data.azurerm_resource_group.tenants[0].name
  storage_account_type = var.data_disks[count.index].managed_disk_type
  create_option        = var.data_disks[count.index].create_option
  disk_size_gb         = var.data_disks[count.index].disk_size_gb
  tags                 = data.azurerm_resource_group.tenants[0].tags

}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  count              = length(var.data_disks)
  lun                = var.data_disks[count.index].lun_id
  caching            = var.data_disks[count.index].caching
  managed_disk_id    = azurerm_managed_disk.az_managed_disk[count.index].id
  virtual_machine_id = azurerm_virtual_machine.vm[var.data_disks[count.index].vm_index].id

}

# sandbox.tfvars
# Variable overrides for the sandbox workspace

# general

# tenant

vm_admin_name = "cxa791"
prefix        = "cxa"

#Replace the following value with your id_rsa.pub (Public ssh key)
ssh_public_key = ""

vms = [
  {
    rg_name              = "corpit-general-dmw-006-sandbox-rg"
    rg_location          = "EastUS2"
    vm_ip                = "172.21.2.101"
    vm_name              = "pocoel77a"
    virtual_network_name = "corpit-general-dmw-006-sandbox-vnet"
    publisher            = "Oracle"
    offer                = "Oracle-Linux"
    sku                  = "77"
    version              = "latest"
    ansible_playbook     = "./ansible_playbooks/ping.yml"
    vm_size              = "Standard_E4-2s_v3"
    env                  = "dev"

  },
  {
    rg_name              = "corpit-general-dmw-006-sandbox-rg"
    rg_location          = "EastUS2"
    vm_ip                = "172.21.2.102"
    vm_name              = "pocoel77b"
    virtual_network_name = "corpit-general-dmw-006-sandbox-vnet"
    publisher            = "Oracle"
    offer                = "Oracle-Linux"
    sku                  = "77"
    version              = "latest"
    ansible_playbook     = "./ansible_playbooks/ping.yml"
    vm_size              = "Standard_E4-2s_v3"
    env                  = "dev"

  }
]

data_disks = [
  {
    name              = "cxa-oel77-OSDisk1"
    caching           = "ReadWrite"
    create_option     = "Empty"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 128
    lun_id            = 1
    vm_index          = 0
    rg_location       = "EastUS2"
  },
  {
    name              = "cxa-oel77-ASMDisk1"
    caching           = "None"
    create_option     = "Empty"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 256
    lun_id            = 2
    vm_index          = 0
    rg_location       = "EastUS2"
  },
  {
    name              = "cxa-oel77-ASMDisk2"
    caching           = "None"
    create_option     = "Empty"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 256
    lun_id            = 3
    vm_index          = 0
    rg_location       = "EastUS2"
  },
  {
    name              = "cxa-oel77-ASMDisk3"
    caching           = "None"
    create_option     = "Empty"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 256
    lun_id            = 4
    vm_index          = 0
    rg_location       = "EastUS2"
  }
]


azurerm_dns_zone_azure      = "azuresb.sherwin.com"
azurerm_dns_zone_azure_type = "Public"
azurerm_dns_zone_azure_name = "sandbox_azurerm_dns_zone"

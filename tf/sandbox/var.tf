# var.tf
# Variable definitions

# general

variable "vms" {
  default = []
}

variable "data_disks" {
  default = []
}

variable "azure_sub_id" {
  default = ""
}

variable "azure_client_id" {
  default = ""
}

variable "azure_client_secret" {
  default = ""
}

variable "azure_tenant_id" {
  default = ""
}

variable "azurerm_dns_zone_azure_name" {
  default = ""
}

variable "virtual_network_name" {
  default = ""
}
variable "azurerm_dns_zone_azure_type" {
  default = ""

}

variable "vpn_connection_name" {
  default = ""
}

variable "vpn_connection_shared_key" {
  default = ""
}


variable "azurerm_dns_zone_azure" {
  default = ""
}



variable "vm_admin_name" {
  default = ""
}

variable "prefix" {
  default = ""
}

variable "ssh_public_key" {
  default = ""
}

variable "jenkins_ansible_username" {
  default = ""
}

variable "jenkins_ansible_password" {
  default = ""
}

variable "ssh_unix_public_key" {
  default = ""
}

variable "disk_count" {
  default = 0
}

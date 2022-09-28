variable "prefix" {
  default = "srv2-postgres-ubuntu"
}

locals {
  vm_name = "${var.prefix}-vm"
}

resource "azurerm_resource_group" "example2" {
  name     = "${var.prefix}-resources"
  location = "eastus"
}

resource "azurerm_managed_disk" "example2" {
  name                 = "${local.vm_name}-disk1"
  location             = azurerm_resource_group.example2.location
  resource_group_name  = azurerm_resource_group.example2.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}








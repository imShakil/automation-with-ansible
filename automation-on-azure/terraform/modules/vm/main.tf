resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = var.resource_group
  location            = var.region
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.prefix}-nic"
  location            = var.region
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "${var.prefix}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${var.prefix}-vm"
  resource_group_name             = var.resource_group
  location                        = var.region
  size                            = "Standard_B1s"
  admin_username                  = var.vm_admin
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.vm_admin
    public_key = file(var.ssh_key_path)
  }
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

}

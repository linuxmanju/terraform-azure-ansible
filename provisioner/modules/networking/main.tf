resource "azurerm_virtual_network" "companynews_myproj_vnet" {
    name                = "companynews_myproj_vnet_${var.prefix}"
    address_space       = ["${var.vnet_address_space}"]
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    tags = "${var.tag}"
    
        
}

resource "azurerm_subnet" "companynews_myproj_subnet" {
    name                 = "companynews_myproj_subnet_${var.prefix}"
    resource_group_name  = "${var.resource_group_name}"
    virtual_network_name = "${azurerm_virtual_network.companynews_myproj_vnet.name}"
    address_prefix       = "${cidrsubnet("${var.vnet_address_space}",8,1)}"
}


resource "azurerm_network_security_group" "companynews_app_sg" {
    name                = "companynews_app_sg_${var.prefix}"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges     = "${var.inbound_ports_to_allow}"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = "${var.tag}"
}

resource "azurerm_public_ip" "companynews_web_pub" {
    name                         = "companynews_myproj_pub-${var.prefix}-${count.index}"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group_name}"
    allocation_method            = "Static"

    count = "${var.repeat_count}"

    tags = "${var.tag}"
    
}

resource "azurerm_public_ip" "companynews_app_pub" {
    name                         = "companynews_app_pub-${var.prefix}-${count.index}"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group_name}"
    allocation_method            = "Static"

    count = "${var.repeat_count}"

    tags = "${var.tag}"
    
}
resource "azurerm_network_interface" "companynews_app_nic" {
     name                = "nic-app-${var.prefix}-${count.index}"
     location            = "${var.location}"
     resource_group_name = "${var.resource_group_name}"
     network_security_group_id = "${azurerm_network_security_group.companynews_app_sg.id}"

     ip_configuration {
         name                          = "myNicConfiguration"
         subnet_id                     = "${azurerm_subnet.companynews_myproj_subnet.id}"
         private_ip_address_allocation = "Dynamic"
         public_ip_address_id          = "${element(azurerm_public_ip.companynews_app_pub.*.id,count.index)}"
     }

     count = "${var.repeat_count}"

     #tags = "${var.tag}"
     tags = "${merge(var.tag, map("counter",count.index))}"
 }

 resource "azurerm_network_interface" "companynews_web_nic" {
     name                = "nic-web-${var.prefix}-${count.index}"
     location            = "${var.location}"
     resource_group_name = "${var.resource_group_name}"
     network_security_group_id = "${azurerm_network_security_group.companynews_app_sg.id}"

     ip_configuration {
         name                          = "myNicConfiguration"
         subnet_id                     = "${azurerm_subnet.companynews_myproj_subnet.id}"
         private_ip_address_allocation = "Dynamic"
         public_ip_address_id          = "${element(azurerm_public_ip.companynews_web_pub.*.id,count.index)}"
     }

     count = "${var.repeat_count}"

     #tags = "${var.tag}"
     tags = "${merge(var.tag, map("counter",count.index))}"
 }

resource "azurerm_virtual_machine" "companynews_app_vm" {
     name                  = "vm-app-${var.prefix}-${count.index}"
     location              = "${var.location}"
     resource_group_name   = "${var.resource_group_name}"
     network_interface_ids = ["${module.networking.app_nic_ids}"]
     vm_size               = "${var.vm_size}"
     availability_set_id  = "${module.base.availibilty_set_id}"

     storage_os_disk {
         name              = "myOsDisk-app-${count.index}"
         caching           = "ReadWrite"
         create_option     = "FromImage"
         managed_disk_type = "Premium_LRS"
     }

     storage_image_reference {
         publisher = "Canonical"
         offer     = "UbuntuServer"
         sku       = "16.04.0-LTS"
         version   = "latest"
     }

     os_profile {
         computer_name  = "${var.prefix}${count.index}"
         admin_username = "${var.vm_admin_user}"
     }

     os_profile_linux_config {
         disable_password_authentication = true
         ssh_keys {
             path     = "/home/${var.vm_admin_user}/.ssh/authorized_keys"
             key_data = "${file("${var.ssh_pub_key_file}")}"
         }
     }

     count = "${var.repeatcount}"
     tags = "${merge(var.tag, map("vmcount",count.index,"role","app_server"))}"
 }



resource "azurerm_virtual_machine" "companynews_web_vm" {
     name                  = "vm-web-${var.prefix}-${count.index}"
     location              = "${var.location}"
     resource_group_name   = "${var.resource_group_name}"
     network_interface_ids = ["${module.networking.web_nic_ids}"]
     vm_size               = "${var.vm_size}"
     availability_set_id  = "${module.base.availibilty_set_id}"

     storage_os_disk {
         name              = "myOsDisk-web-${count.index}"
         caching           = "ReadWrite"
         create_option     = "FromImage"
         managed_disk_type = "Premium_LRS"
     }

     storage_image_reference {
         publisher = "Canonical"
         offer     = "UbuntuServer"
         sku       = "16.04.0-LTS"
         version   = "latest"
     }

     os_profile {
         computer_name  = "${var.prefix}${count.index}"
         admin_username = "${var.vm_admin_user}"
     }

     os_profile_linux_config {
         disable_password_authentication = true
         ssh_keys {
             path     = "/home/${var.vm_admin_user}/.ssh/authorized_keys"
             key_data = "${file("${var.ssh_pub_key_file}")}"
         }
     }

     count = "${var.repeatcount}"

     tags = "${merge(var.tag, map("vmcount",count.index,"role","web_server"))}"
  
 }


data "template_file" "init" {
  template = "${file("./site.tpl")}"
  vars = {
    admin_user = "${var.vm_admin_user}"
  }
}

resource "null_resource" "run" {
  triggers {
        build_number = "${timestamp()}"
    }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.init.rendered}\" > ../ConfigManagement/site.yml"
  }
}

output "subnetid" {
  value = "${azurerm_subnet.companynews_myproj_subnet.id}"
}

output "sg_id" {
  value = "${azurerm_network_security_group.companynews_app_sg.id}"
}

output "app_public_ip" {
  value = "${azurerm_public_ip.companynews_app_pub.*.ip_address}"
}

output "web_public_ip" {
  value = "${azurerm_public_ip.companynews_web_pub.*.ip_address}"
}
output "app_nic_ids" {
  value = "${azurerm_network_interface.companynews_app_nic.*.id}"
}

output "web_nic_ids" {
  value = "${azurerm_network_interface.companynews_web_nic.*.id}"
}

output "app_private_ip" {
   value = "${azurerm_network_interface.companynews_app_nic.*.private_ip_address}"
}
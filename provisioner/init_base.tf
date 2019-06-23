provider "azurerm" {
  
}

module "base" {
  source = "./modules/base"
  location = "${var.location}"
  prefix = "${var.prefix}"
  tag = "${var.tag}"
}
module "networking" {
  source = "./modules/networking"
  location = "${var.location}"
  prefix = "${var.prefix}"
  tag = "${var.tag}"
  resource_group_name = "${module.base.azure_rg_name}"
  inbound_ports_to_allow = "${var.open_tcp_ports}"
  repeat_count = "${var.repeatcount}"

}
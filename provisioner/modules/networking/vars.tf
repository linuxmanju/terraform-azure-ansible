variable "vnet_address_space" {
    description = "Specify VirtualNetwork address space"
    default = "10.0.0.0/16"
}

# variable "subnet_address" {
#     description = "Define subnet address block here"
#     default = "${cidrsubnet("${var.vnet_address_space}",4,1)}"
# }

variable "location" {
  default = "westus"
}

variable "prefix" {
  default = "terratest"
}

variable "tag" {
   type = "map"
}

variable "repeat_count" {
    description = " change below to match the number of instances that you launch"
}

variable "resource_group_name" {
}

variable "inbound_ports_to_allow" {
    description = "Firewall/SecurityGroup ports to allow for inbound traffic. By default ssh is allowed"
    type = "list"
    default = [22]
  
}

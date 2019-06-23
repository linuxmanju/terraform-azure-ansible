variable "location" {
  default = "westus"
}

variable "prefix" {
  default = "CompanyNews"
}

#variable "tag" {
 # default = "Manju_test"
#}

variable "tag" {
   default = {
         environment = "SIT"
         product = "CompanyNews"
         service = "WebApp" 
   }
}


variable "repeatcount" {
    description = " change below to match the number of instances that you launch"
    default = 1
}



variable "open_tcp_ports" {
    type = "list"
    default = [22,8080]
  
}

variable "vm_admin_user" {
    default = "sysadmin"
  
}

variable "ssh_pub_key_file" {
    default = "~/.ssh/id_rsa.pub"
  
}

variable "vm_size" {

  default = "Standard_D4s_v3"
  
}

variable "approle" {
  default = "Web"
}

variable "resource_group_name" {
  default = "company_news_rg"
}




## end



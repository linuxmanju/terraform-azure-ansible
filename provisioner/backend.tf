 #terraform { 
#   backend  "azurerm" {
#     storage_account_name = "opsnextgen"
#     container_name       = "terraform-state"
#     key                  = "{{JOB_NAME}}-{{ROLE}}.terraform.tfstate"
    

#   }

#  }
resource "azurerm_resource_group" "company_news_rg" {
  name = "company_news_rg"
  location = "${var.location}"

  tags = "${var.tag}"
  }

resource "azurerm_availability_set" "comanynews_proj_set" {
  name                = "terraform_${var.prefix}"
  location            = "${azurerm_resource_group.company_news_rg.location}"
  resource_group_name = "${azurerm_resource_group.company_news_rg.name}"
  managed = "true"

  tags = "${var.tag}"
}
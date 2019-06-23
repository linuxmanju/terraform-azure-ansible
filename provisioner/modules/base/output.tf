output "azure_rg_name" {
  value = "${azurerm_resource_group.company_news_rg.name}"
}

output "availibilty_set_id" {
  value = "${azurerm_availability_set.comanynews_proj_set.id}"
}
resource "azurerm_resource_group" "RG" {
  name     = "${var.environment}_tf01"
  location = var.allowed_locations[0]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}_vnet"
  address_space       = ["${element(var.network_config, 0)}"]
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_subnet" "web_subnet" {
  name                 = "${var.environment}_${var.azurerm_subnet_name[0]}"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${element(var.network_config, 1)}/${element(var.network_config, 7)}"]
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "${var.environment}_${var.azurerm_subnet_name[1]}"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${element(var.network_config, 2)}/${element(var.network_config, 7)}"]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.environment}_${var.azurerm_subnet_name[2]}"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${element(var.network_config, 3)}/${element(var.network_config, 7)}"]
}

resource "azurerm_subnet" "asp_subnet" {
  name                 = "${var.environment}_${var.azurerm_subnet_name[3]}"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${element(var.network_config, 4)}/${element(var.network_config, 7)}"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.environment}_${var.azurerm_subnet_name[4]}"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${element(var.network_config, 5)}/${element(var.network_config, 7)}"]
}

resource "azurerm_subnet" "pesn_subnet" {
  name                 = "${var.environment}_${var.azurerm_subnet_name[5]}"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${element(var.network_config, 6)}/${element(var.network_config, 7)}"]
}

resource "azurerm_network_security_group" "web_nsg" {
  name                = "${azurerm_subnet.web_subnet.name}-nsg"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

}

resource "azurerm_subnet_network_security_group_association" "web_nsg_association" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
  depends_on                = [azurerm_network_security_rule.web_nsg_rule_inbound]
}
resource "azurerm_subnet" "pesn" {
  name                 = "${var.environment}_${var.azurerm_subnet_name[5]}"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${element(var.network_config, 6)}/${element(var.network_config, 7)}"]
}




resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each                    = local.web_inbound_ports_map
  name                        = "Web-rule-inbound"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.RG.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

resource "azurerm_network_security_rule" "web_nsg_rule_outbound" {
  for_each                    = local.web_inbound_ports_map
  name                        = "Web-rule-outbound"
  priority                    = each.key
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.RG.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
  depends_on                  = [azurerm_network_security_rule.web_nsg_rule_inbound]
}


module "Storageaccount" { 
  source                   = "./modules/Storageaccount"
  SA = "gitkubesahub01"
  azurerm_private_endpoint = "gitkubesahub01_PE" 
  storage_account_location = "West Europe"
  random_prefix = "kube"
  azurerm_PE_subnet_name = var.azurerm_PE_subnet_name
  
}



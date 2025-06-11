resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}_vnet"
  address_space       = [element(var.network_config, 0)]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}


resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.network_config[each.value.index]}/${var.network_config[7]}"]
}

resource "azurerm_network_security_group" "pesn_nsg" {
  name                = "${azurerm_subnet.subnets["pesn"].name}-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

}

resource "azurerm_subnet_network_security_group_association" "pesn_nsg_association" {
  subnet_id                 = azurerm_subnet.subnets["pesn"].id
  network_security_group_id = azurerm_network_security_group.pesn_nsg.id
  depends_on                = [azurerm_network_security_group.pesn_nsg]
}



resource "azurerm_network_security_rule" "pesn_nsg_rule_inbound" {
  for_each                    = local.pesn_inbound_ports_map
  name                        = "pesn-rule-inbound-${each.key}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.pesn_nsg.name
  depends_on                  = [azurerm_network_security_group.pesn_nsg]
}

resource "azurerm_network_security_rule" "pesn_nsg_rule_outbound" {
  for_each                    = local.pesn_inbound_ports_map
  name                        = "pesn-rule-outbound-${each.key}"
  priority                    = each.key
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.pesn_nsg.name
  depends_on                  = [azurerm_network_security_group.pesn_nsg]
}
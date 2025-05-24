




resource "random_pet" "prefix" {
  prefix = var.random_prefix
  length = 3
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  location = var.storage_account_location
  name     = "${random_pet.prefix.id}-vnet"
}
resource "azurerm_storage_account" "SA" {
  name                     = var.SA
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.storage_account_location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"

  tags = {
    environment = "DEV"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "Kube_network" {
  name                = "${random_pet.prefix.id}-vnet"
  address_space       = ["10.180.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet 1
resource "azurerm_subnet" "PE_subnet" {
  name                 = "${random_pet.prefix.id}-PE"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.Kube_network.name
  address_prefixes     = ["10.180.1.0/27"]
}

# Public IP address for NAT gateway
resource "azurerm_public_ip" "kube_public_ip" {
  name                = "public-ip-nat"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# NAT Gateway
resource "azurerm_nat_gateway" "kube_nat_gateway" {
  name                = "nat-gateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Associate NAT Gateway with Public IP
resource "azurerm_nat_gateway_public_ip_association" "kube_NG" {
  nat_gateway_id       = azurerm_nat_gateway.kube_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.kube_public_ip.id
}

# Associate NAT Gateway with Subnet
resource "azurerm_subnet_nat_gateway_association" "kube_NG_SN" {
  subnet_id      = azurerm_subnet.PE_subnet.id
  nat_gateway_id = azurerm_nat_gateway.kube_nat_gateway.id
}

resource "azurerm_private_endpoint" "PE" {
  name                = var.azurerm_private_endpoint
  location            = var.storage_account_location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.PE_subnet.id

  private_service_connection {
    name                           = "kube_psc"
    private_connection_resource_id = azurerm_storage_account.SA.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "Kube_DNS_zone_group"
    private_dns_zone_ids = [azurerm_private_dns_zone.Kube_DNS_zone.id]
  }
}

resource "azurerm_private_dns_zone" "Kube_DNS_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "Kube_DNS_zone_vnet_link" {
  name                  = "Kube_DNS_zone_vnet_link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.Kube_DNS_zone.name
  virtual_network_id    = azurerm_virtual_network.Kube_network.id
}


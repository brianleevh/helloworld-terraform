resource "azurerm_resource_group" "main_rsg" {
  name     = "${local.prefix}-network"
  location = local.region

  tags = merge({
    costcenter = "it"
  }, local.common_tags)
}

# VNet & Subnet
module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.main_rsg.name
  vnet_name           = "${local.prefix}-vpc"
  address_spaces      = ["10.0.0.0/22"]
  subnet_prefixes     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  subnet_names        = ["${local.prefix}-sub-pub1", "${local.prefix}-sub-priv1", "${local.prefix}-sub-priv2"]

  tags = merge({
    costcenter = "it"
  }, local.common_tags)

  depends_on = [azurerm_resource_group.main_rsg]
}

# NAT Gateway
resource "azurerm_public_ip" "nat_gateway_pip" {
  name                = "${local.prefix}-nat-pip"
  location            = azurerm_resource_group.main_rsg.location
  resource_group_name = azurerm_resource_group.main_rsg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]

  tags = merge({
    costcenter = "it"
  }, local.common_tags)
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "${local.prefix}-nat-gateway"
  location                = azurerm_resource_group.main_rsg.location
  resource_group_name     = azurerm_resource_group.main_rsg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]

  tags = merge({
    costcenter = "it"
  }, local.common_tags)

}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_pip_associate" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gateway_subnet_associate" {
  count = 2
  subnet_id      = module.network.vnet_subnets[count.index + 1]
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id

  depends_on = [module.network.vnet_subnets]
}
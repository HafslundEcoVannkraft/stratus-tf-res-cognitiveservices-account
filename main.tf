data "azapi_resource" "rg" {
  type        = "Microsoft.Resources/resourceGroups@2021-04-01"
  resource_id = var.rg_id
}

resource "azapi_resource" "cognitive_account" {
  type      = "Microsoft.CognitiveServices/accounts@2024-10-01"
  parent_id = var.rg_id
  name      = var.cognitive_account_name
  location  = var.location == "" ? data.azapi_resource.rg.location : var.location
  identity {
    type         = "SystemAssigned"
    identity_ids = []
  }
  body = {
    kind = "OpenAI"
    properties = {
      allowedFqdnList               = []
      customSubDomainName           = var.corp_config == null ? null : var.corp_config.custom_domain_name
      apiProperties                 = {}
      disableLocalAuth              = true # guardrails requirement
      dynamicThrottlingEnabled      = false
      publicNetworkAccess           = var.corp_config == null ? "Enabled" : "Disabled"
      restrictOutboundNetworkAccess = true # guardrails requirement
    }
    sku = {
      name = var.sku
    }
  }
}

locals {
  pe_subnets_map = var.corp_config == null ? {} : {
    for subnet_id in var.corp_config.pe_subnets : subnet_id => {
      subnet_id   = subnet_id
      subnet_name = split("/", subnet_id)[10]
      # vnet_id is subnet_id except for terms 9 and 10
      vnet_id             = join("/", slice(split("/", subnet_id), 0, 9))
      resource_group_name = split("/", subnet_id)[4]
    }
  }
}

# Data source to fetch subnet details
data "azapi_resource" "vnets" {
  for_each    = local.pe_subnets_map
  type        = "Microsoft.Network/virtualNetworks@2023-04-01"
  resource_id = each.value.vnet_id
}

resource "azapi_resource" "private_endpoint" {
  for_each  = local.pe_subnets_map
  type      = "Microsoft.Network/privateEndpoints@2023-04-01"
  name      = "${var.cognitive_account_name}-pe-${data.azapi_resource.vnets[each.value.subnet_id].location}-${each.value.subnet_name}"
  parent_id = data.azapi_resource.rg.id
  location  = data.azapi_resource.vnets[each.value.subnet_id].location
  body = {
    properties = {
      subnet = {
        id = each.value.subnet_id
      }
      privateLinkServiceConnections = [
        {
          name = "cognitiveservices"
          properties = {
            privateLinkServiceId = azapi_resource.cognitive_account.id
            groupIds             = ["account"]
          }
        }
      ]
    }
  }
  lifecycle {
    ignore_changes = [body.properties.private_dns_zone_group]
  }
}
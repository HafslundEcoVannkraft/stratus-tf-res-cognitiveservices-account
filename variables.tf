variable "rg_id" {
  type        = string
  description = "Resource group id"
}

variable "cognitive_account_name" {
  type        = string
  description = "Name of the cognitive account"
}

variable "location" {
  type        = string
  description = "Location of the cognitive account. Defaults to resource group location."
  default     = ""
}

variable "sku" {
  type        = string
  description = "The SKU of the cognitive account"
  default     = "S0"
}

variable "corp_config" {
  type = object({
    pe_subnets         = list(string)
    custom_domain_name = string
  })
  description = "Block with necessary configuration parameters for corp environments. pe_subnets is a list of subnets to create private endpoints in, custom_domain_name is the custom domain name to use for the cognitive account."
  default     = null
}

variable "restrict_outbound_access" {
  type        = bool
  description = "Whether to restrict outbound network access"
  default     = true
}

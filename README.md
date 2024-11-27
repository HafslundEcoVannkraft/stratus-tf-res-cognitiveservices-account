<!-- BEGIN_TF_DOCS -->
# Stratus Terraform Verified Module Cognitive Services Account

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (>2.0.0)

## Resources

The following resources are used by this module:

- [azapi_resource.cognitive_account](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.private_endpoint](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.rg](https://registry.terraform.io/providers/Azure/azapi/latest/docs/data-sources/resource) (data source)
- [azapi_resource.vnets](https://registry.terraform.io/providers/Azure/azapi/latest/docs/data-sources/resource) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_cognitive_account_name"></a> [cognitive\_account\_name](#input\_cognitive\_account\_name)

Description: Name of the cognitive account

Type: `string`

### <a name="input_rg_id"></a> [rg\_id](#input\_rg\_id)

Description: Resource group id

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_corp_config"></a> [corp\_config](#input\_corp\_config)

Description: Block with necessary configuration parameters for corp environments. pe\_subnets is a list of subnets to create private endpoints in, custom\_domain\_name is the custom domain name to use for the cognitive account.

Type:

```hcl
object({
    pe_subnets         = list(string)
    custom_domain_name = string
  })
```

Default: `null`

### <a name="input_location"></a> [location](#input\_location)

Description: Location of the cognitive account. Defaults to resource group location.

Type: `string`

Default: `""`

### <a name="input_restrict_outbound_access"></a> [restrict\_outbound\_access](#input\_restrict\_outbound\_access)

Description: Whether to restrict outbound network access

Type: `bool`

Default: `true`

### <a name="input_sku"></a> [sku](#input\_sku)

Description: The SKU of the cognitive account

Type: `string`

Default: `"S0"`

## Outputs

The following outputs are exported:

### <a name="output_cognitive_account_resource_id"></a> [cognitive\_account\_resource\_id](#output\_cognitive\_account\_resource\_id)

Description: The resource ID of the created cognitive account

### <a name="output_identity"></a> [identity](#output\_identity)

Description: The system-assigned managed identity of the created cognitive account

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
<!-- END_TF_DOCS -->
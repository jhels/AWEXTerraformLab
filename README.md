# AWEXTerraformLab

Terraform Commands

```
terraform init

terraform plan

terraform apply

terraform validate

terraform fmt -recursive
```


Terraform resources have the format 'resource {resource_identifier} {my_resource_name}

Calling a Terraform module works the same way, using 'module {my_module_name}' and supplying source={path_to_module}' 

To reference module outputs, the convention is module.{my_module_name}.{module_output_var}. Resource components work in the same way ( {resource_name}.{my_resource_name}.{resource_attribute} )


Global variables required are in the variables.tf file. enter custom variable parameters inside the terraform.tfvars file ( format is var_name = var_value )

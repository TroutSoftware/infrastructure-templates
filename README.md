# infrastructure-templates
A set of Terraform templates to configure resources access

To launch a specific template:
- set the required variables in the `terraform.tfvars` file
- run `terraform init`
- run `terraform plan -var-file="terraform.tfvars" {filename}`
- run `terraform apply -var-file="terraform.tfvars" {filename}`

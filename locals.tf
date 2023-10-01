locals {
  ip_filepath = "ips.json"

  common_tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Managedby   = "Terraform"
    Owner       = "Juliherms Vasconcelos"
    UpdatedAt   = "2023-09-30"
  }
}
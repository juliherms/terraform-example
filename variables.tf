variable "environment" {
  type        = string
  description = ""
}

variable "aws_region" {
  type        = string
  description = ""
}

variable "instance_ami" {
  type        = string
  description = ""
  default     = "ami-03c3a7e4263fd998c"
}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t3.micro"
}

variable "instance_tags" {
  type        = map(string)
  description = ""
  default = {
    Name    = "Ubuntu"
    Project = "AWS Course with Terraform"
    Env     = "Dev"
  }
}
variable "sg_id" {}

variable "subnet_id" {}

variable "project_name" {
  type        = string
  description = "used in naming of resources (instances, sg, etc)"
}

variable "key_pair" {
  type = string
}

variable "instance_profile" {
  type        = string
  description = "role created in iam module to attach on to instance"
}

variable "lambdaURL" {
  type    = string
  default = ""
}


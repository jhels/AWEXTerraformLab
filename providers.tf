provider "aws" {
  profile = var.profile
  region  = "eu-west-2"
  default_tags {
    tags = {
      "Terraform" : "true"
      "Name" : "${var.project_name}"
      # "CreationDate" : formatdate("MMM DD YYYY HH:mmaa", timestamp())
    }
  }
}

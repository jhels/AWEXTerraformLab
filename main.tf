module "my-vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "instance-iam-role" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "instance-security" {
  source       = "./modules/security"
  project_name = var.project_name
  vpc_id       = module.my-vpc.vpc_id
}

module "web-server-instance" {
  source           = "./modules/instance"
  sg_id            = module.instance-security.security_group_id
  project_name     = var.project_name
  subnet_id        = module.my-vpc.vpc_subnet
  key_pair         = var.key_pair
  instance_profile = module.instance-iam-role.instance_profile
}
module "vpc" {
  source = "../modules/vpc"
  ipam_cidr            = var.ipam_cidr
  vpc_netmask_length   = var.vpc_netmask_length
  public_az            = var.public_az
  public_cidr_block    = var.public_cidr_block
  private_az           = var.private_az
  private_cidr_block   = var.private_cidr_block
  private_2_az         = var.private_2_az
  private_2_cidr_block = var.private_2_cidr_block
}

module "ec2" {
  source = "../modules/ec2"
  depends_on           = [module.vpc]
  ec2_instance         = var.ec2_instance
  vpc_ec2_id           = module.vpc.vpc_id
  ssh_cidr             = var.ssh_cidr
}

module "rds" {
  source = "../modules/rds"
  depends_on           = [module.vpc, module.ec2]
  db_instance         = var.db_instance
  private_subnet_1    = module.vpc.subnet_private_id
  private_subnet_2    = module.vpc.subnet_private2_id
  public_cidr_block   = var.public_cidr_block
  vpc_id              = module.vpc.vpc_id
  ec2_security_group  = module.ec2.ec2-sg
}
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}
module "ec2" {
  source = "../../modules/ec2"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
}

module "s3" {
  source = "../../modules/s3"

  bucket_name = "gorav-devops-project-bucket-2026"
}

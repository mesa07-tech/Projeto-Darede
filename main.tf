terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.74.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  

  shared_config_files      = ["C:/Users/47485187821/.aws/config"] 
  shared_credentials_files = ["C:/Users/47485187821/.aws/credentials"]

  default_tags {
  }
}

module "vpc" {
  source = "./modules/VPC"
  vpc_name = "darede-vpc"
  vpc_cidr = "172.16.0.0/16"
  azs = ["us-east-1a", "us-east-1b"]
  public_subnets = ["172.16.1.0/24", "172.16.2.0/24"]
  private_subnets = ["172.16.3.0/24", "172.16.4.0/24"]
}

module "cluster-eks" {
  source            = "./modules/EKS"
  cluster_name      = "darede-eks"
  nodes_name        = "darede-nodes"
  service_role_arn  = "arn:aws:iam::307946635677:role/eks-service-role"
  instance_role_arn = "arn:aws:iam::307946635677:role/eks-instance-role"
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
  private_subnets   = module.vpc.private_subnets
}

module "waf" {
  source = "./modules/WAF"
  waf_name = "darede-waf"
  waf_scope = "REGIONAL"
  resource_arn = module.cluster-eks.cluster_arn
}

module "rds" {
  source = "./modules/RDS"
  vpc_cidr_block = module.vpc.vpc_cidr
  vpc_id = module.vpc.vpc_id
  allocated_storage = 20  
  db_engine = "mysql"
  db_instance_class = "db.t3.micro"
  db_username = "admin"
  db_password = "Senai.134"
  publicly_accessible = true
  subnet_ids = module.vpc.private_subnets
}
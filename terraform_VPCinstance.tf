module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "csev-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a","eu-central-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "web" {
  instance_type          = "t2.micro" # free instance
  ami                    = "ami-0d527b8c289b4af7f"
  subnet_id              = module.vpc.public_subnets[0]
  

  tags = {
    Name = "csev-ec2"
  }
}
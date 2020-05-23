#vpc
data "aws_vpc" "vpc" {
  id = "vpc-xxxxxxxxx"   #enter your VPC ID or you can make a variable and use that variable here
}

# #Existing AWS ROle
data "aws_iam_role" "iam-role" {
  name = "eksrole"
}

data "aws_iam_role" "iam-role2" {
  name = "eks_NodeInstanceRole"
}

module "eks_cluster" {
  source                = "../../modules/EKS"
  name                  = var.name
  region                = var.region
  kubernetes-version    = var.kubernetes_version
  role-arn              = data.aws_iam_role.iam-role.name
  subnets               = [var.subnet-ids[0],var.subnet-ids[1]]
  security-group-id     = var.security-group-id
}



module "node_group" {
  
  source                = "../../modules/NODE_GROUP"
  cluster-name    = module.eks_cluster.name
  node-group-name = "nodes_testing"
  node-role-arn   = data.aws_iam_role.iam-role2.arn
  subnets         = [var.subnet-ids[0],var.subnet-ids[1]]
  ssh             = var.ssh-key
  instance-types   = var.instance-type
  security-group-id     = var.security-group-id

  scaling={
    desired_size  = 1
    max_size      = 2
    min_size      = 1
  }
  # dependencies= [module.eks_cluster]
  # dependencies = "${module.eks_cluster}"
  
}

# You can uncomment below code to create IAM ROles, Security Group, Subnet, Internet Gateway, NAT GAteway.


# data "aws_iam_role" "iam-role2" {
#   name = "eks_NodeInstanceRole"
# }

# #Security group
# data "aws_security_group" "security-group" {
#   id = "${var.security-group-id}"
# }


# #subnet
# data "aws_subnet" "private-subnet" {
#   id = var.private-subnet-id
# }
# data "aws_subnet" "public-subnet" {
#   id = var.public-subnet-id
# }

# #Existing Internet Gateway 
# data "aws_internet_gateway" "igw" {
#   filter {
#     name   = "attachment.vpc-id"
#     values = ["${var.vpc_id}"]
#   }
# }

# #Existing NAT Gateway
# data "aws_nat_gateway" "nat-gateway" {
#   vpc_id = var.vpc_id
# }

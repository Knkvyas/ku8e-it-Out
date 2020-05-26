#Existing AWS ROle
data "aws_iam_role" "iam-role" {
  name = "eksrole" #role name
}


data "aws_iam_role" "iam-role2" {
  name = "eks_NodeInstanceRole"    #role name
}

#Security group
data "aws_security_group" "security-group" {
  id = "${var.security-group-id}"
}


#subnet
data "aws_subnet" "private-subnet" {
  id = var.private-subnet-id
}
data "aws_subnet" "public-subnet" {
  id = var.public-subnet-id
}

#Existing Internet Gateway 
data "aws_internet_gateway" "igw" {
  filter {
    name   = "attachment.vpc-id"
    values = ["${var.vpc-id}"]
  }
}

#Existing NAT Gateway
data "aws_nat_gateway" "nat-gateway" {
  vpc_id = var.vpc-id
}




#create cluster 
resource "aws_eks_cluster" "eks-cluster" {
  name = var.name
  version = var.kubernetes-version
  role_arn = data.aws_iam_role.iam-role.arn
  
  vpc_config {
    subnet_ids = [var.subnets[0],var.subnets[1]]
    security_group_ids = [var.security-group-id]
  }
  tags={
      Environment = "Prod"
      Name = "ku8e-eks-cluster"
      Value = "product-ku8e"
  }
}

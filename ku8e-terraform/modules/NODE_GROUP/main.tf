
resource "aws_eks_node_group" "ku8e-node-group" {
  cluster_name    = var.cluster-name
  node_group_name = var.node-group-name
  node_role_arn   = var.node-role-arn
  subnet_ids      = [var.subnets[0],var.subnets[1]]
  instance_types  = [var.instance-types]
  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 2
  }
  remote_access {
      ec2_ssh_key  = var.ssh
      source_security_group_ids = [var.security-group-id]
  }
  
  tags={
      Environment = "Prod"
      Name = "ku8e-eks-group-node"
      Value = "product-ku8e"
  }

#   depends_on = [module.eks]
}


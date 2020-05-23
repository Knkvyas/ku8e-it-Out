output "endpoint" {
  value = "${aws_eks_cluster.eks-cluster.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.eks-cluster.certificate_authority.0.data}"
}

output "name"{
  value = "${aws_eks_cluster.eks-cluster.name}"
}

output "kubernetes-version"{
  value = "${aws_eks_cluster.eks-cluster.version}"
}

output "role-arn"{
  value = "${aws_eks_cluster.eks-cluster.role_arn}"
}

# output "vpc-id"{
#   value = "${aws_eks_cluster.eks-cluster.location}"
# }


output "depended_on" {
  value = "${aws_eks_cluster.eks-cluster.id}"
}
variable "enabled"{
    default = true
    description = "If enable it will create a new cluster"
}

# variable "namespace"{}
variable "name"{}
# variable "region"{}
variable "vpc-id"{
    default = "vpc-0545ca2f73a9ee7dd"
}
variable "kubernetes-version"{}
# variable "kubeconfig_path"{}
variable "role-arn"{}


variable "region"{}

variable "subnets"{
    type = list(string)
    default = []
}


variable "public-subnet-id" {
  default = "subnet-03afb113e58e74af5"
}
variable "private-subnet-id" {
  default = "subnet-05b4ed9daa1d37958"
}

#Security Group
variable "security-group-id" {}

variable "enabled"{
    default = true
    description = "If enable it will create a new cluster"
}

# variable "namespace"{}
variable "name"{}
# variable "region"{}
variable "vpc-id"{
    default = "vpc-xxxxxxxx"
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
  default = "subnet-xxxxxxxxxxx"
}
variable "private-subnet-id" {
  default = "subnet-yyyyyyyyyyyyy"
}

#Security Group
variable "security-group-id" {}

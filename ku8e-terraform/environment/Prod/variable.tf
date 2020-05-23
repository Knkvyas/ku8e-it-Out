variable "name"{
    default      = "eks_testing_cluster"
}
variable "region"{
    default    = "ap-southeast-1"
}
variable "vpc_id"{
    default = "vpc-xxxxxxxxx"   # paste you VPC ID here.
}
variable "kubernetes_version"{
    default = "1.14"
}
variable "kubeconfig_path"{
    default = "~/.kube/config"
}
variable "role_arn"{
    default = "eksrole"
}
variable "ssh-key"{
    default = "ku8e-flask"
}
variable "instance-type"{
    default = "t3.small"
}

variable "subnet-ids"{
    type = list(string)
    default = ["subnet-xxxxxxxxxx","subnet-yyyyyyyyyy"]    # add your subnets ID
}


#Security Group
variable "security-group-id" {
    default = "sg-xxxxxxxxxxxxxxx"    # add your security Group ID
}



########################### Autoscale Config ################################


variable "launch-config-name"{
    default  = "ecs-launch-configuration-test"
}
variable "launch-image"{
    default = "ami-024ce53b56277d5d5"
}
variable "launch-instance-type"{
    default  = "t2.small"
}
variable "associate-public-ip-address"{
    default = true
}
variable "key"{
    default = "ku8e-flask"
}

variable "max-instance-size" {
    default = 3
  description = "Maximum number of instances in the cluster"
}

variable "min-instance-size" {
    default = 2
  description = "Minimum number of instances in the cluster"
}

variable "desired-capacity" {
    default = 2
  description = "Desired number of instances in the cluster"
}

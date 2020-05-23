variable "launch-config-name"{}
variable "launch-image"{}
variable "launch-instance-type"{}
variable "security-groups"{}

variable "associate-public-ip-address"{
    type = (bool)
    default = true
}
variable "key"{}


variable "subnets"{
    type = list(string)
    default = []
}



variable "max-instance-size" {
  description = "Maximum number of instances in the cluster"
}

variable "min-instance-size" {
  description = "Minimum number of instances in the cluster"
}

variable "desired-capacity" {
  description = "Desired number of instances in the cluster"
}

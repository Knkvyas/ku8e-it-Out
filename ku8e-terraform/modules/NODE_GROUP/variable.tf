variable "cluster-name"{}
variable "node-group-name"{}
variable "node-role-arn"{}
variable "subnets"{
    type = list(string)
    default = []
}

variable "security-group-id"{}
variable "ssh"{}
variable "instance-types"{
    type = string
    default = "t3.small"
}


variable "scaling" {
  type = map(string)
  default = {
        desired-size = 1
        max-size = 2
        min-size = 1
    }
}
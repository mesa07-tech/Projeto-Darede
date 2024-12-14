variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
    type    = list(string)
}

variable "public_subnets" {
    type    = list(string)
}

variable "private_subnets" {
    type    = list(string)
}

variable "cluster_name" {
<<<<<<< HEAD
    type = string 
=======
    type = string
>>>>>>> e9cd40fd21bb0dbaa8c2b89405ec66588e9b3448
}
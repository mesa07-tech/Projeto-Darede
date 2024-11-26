variable "cluster_name" {
  type = string
}

variable "nodes_name" {
  type = string
}

variable "service_role_arn" {
  type = string
}

variable "instance_role_arn" {
  type = string
}

variable "vpc_id" {
  type        = string
}

variable "public_subnets" {
  type        = list(string)
}

variable "private_subnets" {
  type        = list(string)
}
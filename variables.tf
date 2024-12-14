variable "shared_config_files" {
  type = list(string)
}

variable "shared_credentials_files" {
  type = list(string)
}

variable "service_role_arn" {
  type = string
}

variable "instance_role_arn" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

<<<<<<< HEAD
variable "cluster_name" {
  type = string 
=======
variable "certificate_arn" {
  type = string
}

variable "config_path" {
  type = string
}

variable "cluster_name" {
  type = string
>>>>>>> e9cd40fd21bb0dbaa8c2b89405ec66588e9b3448
  
}
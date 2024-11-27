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
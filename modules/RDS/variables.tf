variable "db_username" {
  type        = string
}

variable "db_password" {
  type        = string
  sensitive   = true
}

variable "db_engine" {
  type        = string
}

variable "db_instance_class" {
  type        = string
}

variable "allocated_storage" {
  type        = number
}

variable "backup_retention_period" {
  type        = number
  default     = 7
}

variable "backup_window" {
  type        = string
  default     = "03:00-04:00"
}

variable "vpc_cidr_block" {
  type        = string
}

variable "publicly_accessible" {
  type        = bool
}

variable "vpc_id" {
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
}
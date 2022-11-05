
variable "primary_region" {
  description = "Primary region"
  type        = string
  default     = "us-east-2"
}

variable "secondary_region" {
  description = "Secondary region"
  type        = string
  default     = "us-east-1"
}

variable "global_cluster_identifier" {
  description = "Global cluster identifier"
  type        = string
  default     = "o2-global"
}

variable "engine" {
  description = "engine"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version" {
  description = "engine version"
  type        = string
  default     = "11.9"
}

variable "database_name" {
  description = "database name"
  type        = string
  default     = "o2_db"
}

variable "primary_cluster_identifier" {
  description = "primary cluster identifier"
  type        = string
  default     = "o2-primary-cluster"
}


variable "master_username" {
  description = "master username"
  type        = string
  default     = "username"
}

variable "master_password" {
  description = "master password"
  type        = string
  default     = "somepass123"
}

variable "primary_cluster_instance" {
  description = "02 primary cluster instance"
  type        = string
  default     = "o2-primary-cluster-instance"
}

variable "instance_class" {
  description = "instance_class"
  type        = string
  default     = "db.r4.large"
}


variable "secondary_cluster_identifier" {
  description = "secondary cluster identifier"
  type        = string
  default     = "o2-secondary-cluster"
}

variable "secondary_cluster_instance" {
  description = "02 secondary cluster instance"
  type        = string
  default     = "o2-secondary-cluster-instance"
}

variable "db_subnet_group_name"{
  description = "db subnet group name"
  type        = string
  default     = "default"
}
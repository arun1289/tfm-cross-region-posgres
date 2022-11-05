terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.38.0"
    }
  }
}

provider "aws" {
  region = var.primary_region
}

provider "aws" {
  alias  = "primary"
  region = var.primary_region
}

provider "aws" {
  alias  = "secondary"
  region = "us-east-1"
}

resource "aws_rds_global_cluster" "o2globalcluster" {
  global_cluster_identifier = var.global_cluster_identifier
  engine                    = var.engine
  engine_version            = var.engine_version
  database_name             = var.database_name
}

resource "aws_rds_cluster" "primary" {
  provider                  = aws.primary
  engine                    = aws_rds_global_cluster.o2globalcluster.engine
  engine_version            = aws_rds_global_cluster.o2globalcluster.engine_version
  cluster_identifier        = var.primary_cluster_identifier
  master_username           = var.master_username
  master_password           = var.master_password
  database_name             = var.database_name
  global_cluster_identifier = aws_rds_global_cluster.o2globalcluster.id
}

resource "aws_rds_cluster_instance" "primary" {
  provider             = aws.primary
  engine               = aws_rds_global_cluster.o2globalcluster.engine
  engine_version       = aws_rds_global_cluster.o2globalcluster.engine_version
  identifier           = var.primary_cluster_instance
  cluster_identifier   = aws_rds_cluster.primary.id
  instance_class       = var.instance_class
  db_subnet_group_name = var.db_subnet_group_name
  publicly_accessible = true
}

resource "aws_rds_cluster" "secondary" {
  provider                  = aws.secondary
  engine                    = aws_rds_global_cluster.o2globalcluster.engine
  engine_version            = aws_rds_global_cluster.o2globalcluster.engine_version
  cluster_identifier        = var.secondary_cluster_identifier
  global_cluster_identifier = aws_rds_global_cluster.o2globalcluster.id
  skip_final_snapshot       = true
  lifecycle {
    ignore_changes = [
      replication_source_identifier
    ]
  }
  depends_on = [
    aws_rds_cluster_instance.primary
  ]
}

resource "aws_rds_cluster_instance" "secondary" {
  provider             = aws.secondary
  engine               = aws_rds_global_cluster.o2globalcluster.engine
  engine_version       = aws_rds_global_cluster.o2globalcluster.engine_version
  identifier           = var.secondary_cluster_instance
  cluster_identifier   = aws_rds_cluster.secondary.id
  instance_class       = var.instance_class
  db_subnet_group_name = var.db_subnet_group_name
  publicly_accessible = true
}
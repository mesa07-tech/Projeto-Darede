resource "aws_security_group" "rdssg" {
  name_prefix = "rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306 
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["172.16.0.0/16"]  #caso de errado trocar por 0.0.0.0/0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "testdb" {
  allocated_storage       = var.allocated_storage
  engine                  = var.db_engine
  instance_class          = var.db_instance_class
  username                = var.db_username
  password                = var.db_password
  publicly_accessible     = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  vpc_security_group_ids = [aws_security_group.rdssg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name

}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids 
}




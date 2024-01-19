# Creates Security Group
resource "aws_security_group" "allow_app" {
  name          = "robot-${var.COMPONENT}-${var.ENV}-sg"
  description   = "robot-${var.COMPONENT}-${var.ENV}-sg"
  vpc_id        =  data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description      = "Application Port"
    from_port        = var.APP_PORT
    to_port          = var.APP_PORT
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  ingress {
    description      = "SSH PORT"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  ingress {
    description      = "Allows Prometheus"
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "robot-${var.COMPONENT}-${var.ENV}-sg"
  }
}
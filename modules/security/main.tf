resource "aws_security_group" "prod_web" {
  name        = "${var.project_name}_sg"
  vpc_id      = var.vpc_id
  description = "Allow http and https ports inbound and outbound all"
}

resource "aws_security_group_rule" "public_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.prod_web.security_group_id
}


resource "aws_security_group_rule" "public_egress" {
  description       = "Allow ALL ports"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.prod_web.id
}

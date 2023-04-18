data "aws_ami" "latest_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "prod_web" {

  count         = 1
  ami           = data.aws_ami.latest_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = var.key_pair

  vpc_security_group_ids = [
    var.sg_id
  ]

  iam_instance_profile = var.instance_profile

  root_block_device {
    volume_size = 8
    tags = {
      "Terraform" : "true"
      "Name" : "${var.project_name}_ebs_instance_${count.index + 1}"
    }
  }

  user_data = templatefile("${path.module}/../../site_files/instanceUserData.tftpl", {
    lambdaURL = var.lambdaURL
  })



  tags = {
    "Name" : "${var.project_name}_${count.index + 1}"
  }
}

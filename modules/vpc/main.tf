data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"
}

locals {
  Name_of_AZs = data.aws_availability_zones.available.names
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "172.16.0.0/24"
  availability_zone       = local.Name_of_AZs[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}_subnet_${local.Name_of_AZs[0]}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}
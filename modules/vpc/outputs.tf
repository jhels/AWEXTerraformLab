output "vpc_subnet" {
  value = aws_subnet.main.id
}

output "az_list" {
  value = local.Name_of_AZs
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "instance_ip" {
  description = "instance public IP"
  value       = aws_instance.prod_web.*.public_ip
}

output "instance_id" {
  description = "instance ID"
  value       = aws_instance.prod_web.*.id
}
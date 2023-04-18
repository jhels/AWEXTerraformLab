output "instance_profile" {
  description = "Created instance profile with new role attached"
  value       = aws_iam_instance_profile.ec2_profile.name
}
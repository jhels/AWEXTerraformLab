resource "aws_iam_role" "role" {
  name        = "${var.project_name}-role"
  description = "Terraform created role allowing EC2 to assume roles"

  assume_role_policy = file("${path.module}/assume_role_policy.json")
}

# resource "aws_iam_role_policy_attachment" "ecr-policy-attach" {
#   role       = aws_iam_role.role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
# }

resource "aws_iam_role_policy_attachment" "s3-read-only" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}_ec2_profile"
  role = aws_iam_role.role.name
}
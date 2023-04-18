module "my-vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "instance-iam-role" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "instance-security" {
  source       = "./modules/security"
  project_name = var.project_name
  vpc_id       = module.my-vpc.vpc_id
}

module "web-server-instance" {
  source           = "./modules/instance"
  sg_id            = module.instance-security.security_group_id
  project_name     = var.project_name
  subnet_id        = module.my-vpc.vpc_subnet
  key_pair         = var.key_pair
  instance_profile = module.instance-iam-role.instance_profile
  lambdaURL        = aws_lambda_function_url.test_live.function_url
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./site_files/webapilambda.py"
  output_path = "./site_files/lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "./site_files/lambda_function_payload.zip"
  function_name = "webapilambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "webapilambda.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"

}

resource "aws_lambda_function_url" "test_live" {
  function_name      = aws_lambda_function.test_lambda.function_name
  authorization_type = "NONE"

  cors {
    allow_origins = ["*"]
  }
}
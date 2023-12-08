variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "lambda_iam_role" {
  description = "The name of the IAM role for the lambda function"
  type        = string
}

variable "iam_policy_bedrock" {
  description = "The name of the IAM policy to access AWS Bedrock service"
  type        = string
}

variable "iam_policy_cw_log" {
  description = "The name of the IAM policy to access AWS CloudWatch Logs"
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the lambda function"
  type        = string
}

variable "force_image_rebuild" {
  type    = bool
  default = false
}
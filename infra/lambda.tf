resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 0
}


resource "aws_lambda_function" "lambda_llm_stream" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_iam_role.arn
  environment {
    variables = {
      AWS_LWA_INVOKE_MODE = "RESPONSE_STREAM"
    }
  }
  memory_size  = 256
  image_uri    = "${aws_ecr_repository.ecr_repository.repository_url}:latest"
  package_type = "Image"
  timeout      = 900
  publish      = true


  depends_on = [
    null_resource.docker_build_and_push,
    aws_cloudwatch_log_group.lambda_log_group
  ]
}


resource "aws_lambda_function_url" "lambda_llm_stream_url" {
  function_name      = aws_lambda_function.lambda_llm_stream.arn
  authorization_type = "NONE"
  invoke_mode        = "RESPONSE_STREAM"
  depends_on         = [
    aws_lambda_function.lambda_llm_stream
  ]
}

#resource "aws_lambda_alias" "lambda_llm_stream_alias" {
#  name             = "alias_name"
#  function_name    = aws_lambda_function.lambda_llm_stream.function_name
#  function_version = aws_lambda_function.lambda_llm_stream.version
#}

resource "aws_lambda_provisioned_concurrency_config" "lambda_llm_stream" {
  function_name                     = aws_lambda_function.lambda_llm_stream.function_name
  provisioned_concurrent_executions = 2
  qualifier                         = aws_lambda_function.lambda_llm_stream.version
}
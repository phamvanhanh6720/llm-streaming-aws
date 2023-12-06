#resource "aws_cloudwatch_log_group" "lambda_log_group" {
#  name = "/aws/lambda/${var.lambda_function_name}"
#  retention_in_days = 0
#}


resource "aws_lambda_function" "lambda_llm_stream" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_iam_role.arn
  environment {
    variables = {
      AWS_LWA_INVOKE_MODE = "RESPONSE_STREAM"
    }
  }
  memory_size  = 512
  image_uri    = var.ecr_image_uri
  package_type = "Image"
}


resource "aws_lambda_function_url" "lambda_llm_stream_url" {
  function_name      = aws_lambda_function.lambda_llm_stream.arn
  authorization_type = "NONE"
  invoke_mode        = "RESPONSE_STREAM"
  depends_on = [
    aws_lambda_function.lambda_llm_stream]
}
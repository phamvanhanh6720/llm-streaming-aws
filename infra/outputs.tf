output "lambda_function_arn" {
  value = aws_lambda_function.lambda_llm_stream.arn
}

output "lambda_function_url" {
  value = aws_lambda_function_url.lambda_llm_stream_url.function_url
}
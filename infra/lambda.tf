#resource "aws_lambda_function" "llm-stream-lambda" {
#    function_name = "llm-stream-lambda"
#    role = "${aws_iam_role.llm-stream-lambda.arn}"
#    handler = "index.handler"
#    runtime = "nodejs6.10"
#    filename = "llm-stream-lambda.zip"
#    source_code_hash = "${base64sha256(file("llm-stream-lambda.zip"))}"
#    timeout = "60"
#    memory_size = "128"
#    publish = "true"
#    environment {
#        variables = {
#        "LLM_STREAM_TABLE" = "${aws_dynamodb_table.llm-stream-table.name}"
#        }
#    }
#    depends_on = ["aws_iam_role.llm-stream-lambda"]
#}
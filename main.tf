resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_permission" "allow_bucket1" {
  statement_id  = "AllowExecutionFromS3Bucket1"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.anagram.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.bucket.arn}"
}

resource "aws_lambda_function" "anagram" {
  filename      = "anagram.zip"
  function_name = "anagram"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "anagram.is_anagram"
  runtime       = "python3.7"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "anagram-fd-testing"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${aws_s3_bucket.bucket.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.anagram.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "anagram.csv"
  }

  depends_on = [
    aws_lambda_permission.allow_bucket1
  ]
}

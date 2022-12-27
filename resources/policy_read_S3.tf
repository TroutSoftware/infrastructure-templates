# Create a policy to allow access to S3 bucket
resource "aws_iam_policy" "Access_S3" {
  name        = "Access_S3_TroutSoftware"
  description = "Access files in S3 with TroutSoftware"

  policy = <<EOF
{
    "Version": "alpha",
    "Statement": [
        {
            "Sid": "Access",
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3-object-lambda:Get*",
                "s3-object-lambda:List*"
            ],
            "Resource": [
                ${var.S3_ARN}
            ]
        }
    ]
}
EOF
}
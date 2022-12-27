# Set aws provider
provider "aws" {
  region = "us-east-1"
}

# Declare the ARN OAuth variable
variable "ARN_OAUTH" {
  type = string
}

# Declare the S3 ARN variable (file to read)
variable "S3_ARN" {
  type = string
}

# Declare the Google oauth config
variable "GOOGLE_CONFIG" {
  type = string
}

# Create a role that can be assumed by users from a Google account.
resource "aws_iam_role" "Federated_role_google_Demo" {
  name = "Federated_role_google_Demo"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Federated": "${var.ARN_OAUTH}"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
            "StringEquals": {
                "accounts.google.com:aud": "${var.GOOGLE_CONFIG}"
            }
        }
    }
    ]
}
EOF
}

# Create a policy that can be attached to the role.
resource "aws_iam_policy" "Access_S3_Demo" {
  name        = "Access_S3_Demo"
  description = "Policy to allow access to the S3 bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "${var.S3_ARN}"
    },
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "${var.S3_ARN}/*"
    }
  ]
}
EOF
}

# Attach the policy to the role
resource "aws_iam_policy_attachment" "s3_access_policy_attachment" {
  name       = "s3_access_policy_attachment"
  policy_arn = "${aws_iam_policy.Access_S3_Demo.arn}"
  roles      = ["${aws_iam_role.Federated_role_google_Demo.name}"]
}

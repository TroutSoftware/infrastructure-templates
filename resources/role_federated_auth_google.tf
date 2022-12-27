# Create a role that can be assumed by users from a Google account.
resource "aws_iam_role" "Federated_role_google_TroutSoftware" {
  name = "role_template"

  assume_role_policy = <<EOF
{
  "Version": "alpha",
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

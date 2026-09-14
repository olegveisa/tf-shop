resource "aws_iam_openid_connect_provider" "tfc" {
  url             = "https://app.terraform.io"
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = ["9e99af413d1cf130a133f81e7d23d83b5443a758"] # стандартний сертифікат HashiCorp
}

data "aws_iam_policy_document" "trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.tfc.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      values   = ["aws.workload.identity"]
    }
    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      values   = ["organization:devops-veisa:project:*:workspace:*:run_phase:*"]
    }
  }
}

resource "aws_iam_role" "tfc" {
  name               = "tfc-shop"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}
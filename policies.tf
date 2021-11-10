#Data for iam role policy to accept multiple principals and to assume a role
data "aws_iam_policy_document" "cross_account_ecr_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.principal_arns
    }

    actions = ["sts:AssumeRole"]
  }
}

#Creation of an IAM Role - cross_account_access_role
resource "aws_iam_role" "cross_account_ecr_access_role" {
  name               = "cross_account_ecr_access_role"
  assume_role_policy = data.aws_iam_policy_document.cross_account_ecr_role_policy.json
}

#attaching the IAM policy with cross_account_access_role

resource "aws_iam_role_policy_attachment" "cross_account_ecr_access_role" {

  role       = aws_iam_role.cross_account_ecr_access_role.id
  policy_arn = aws_iam_policy.cross_account_ecr_iam_policy.arn

}

#Creation of iam role policy
resource "aws_iam_policy" "cross_account_ecr_iam_policy" {
  name = "cross_account_ecr_iam_policy"
    
  policy = data.aws_iam_policy_document.cross_account_ecr_iam_policy_document.json
}

#Data for cross_account_iam_policy

data "aws_region" "current" {}

data "aws_iam_policy_document" "cross_account_ecr_iam_policy_document" {
  statement {
    actions   = [
      "ecr:DescribeImages",
      "ecr:DescribeRepositories"
    ]
    effect    = "Allow"
    resources = [
      "${aws_ecr_repository.Shared_ECR.arn}"
    ]
    sid       = "AllowReadOnlyAccess"
  }
}
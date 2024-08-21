
# aws_iam_role_policy = an inline policy
# aws_iam_policy, that is a managed policy and can be re-used

# Version of role and policies for non integration environment
# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach_power_user" {
  count      = var.int_environment ? 0 : 1
  role       = aws_iam_role.github_runner_role[0].name
  policy_arn = data.aws_iam_policy.power_user_policy.arn
}
# resource "aws_iam_policy" "ro_policy_iam" {
#   count       = var.int_environment ? 0 : 1
#   name        = "${var.repo_name}-github-runner-iam-services"
#   description = "Read-only policies for key iam permissions required by github runner"

#   policy = file("uec-github-runner-iam-services.json")
# }

resource "aws_iam_role_policy_attachment" "attach_ro_iam" {
  count      = var.int_environment ? 0 : 1
  role       = aws_iam_role.github_runner_role[0].name
  policy_arn = aws_iam_policy.ro_policy_iam.arn
}


resource "aws_iam_role" "github_runner_role" {
  count              = var.int_environment ? 0 : 1
  name               = "${var.repo_name}-github-runner"
  assume_role_policy = <<-EOF
    {
      "Version":"2012-10-17",
      "Statement":[
        {
          "Effect":"Allow",
          "Principal":{
            "Federated":"arn:aws:iam::${local.account_id}:oidc-provider/token.actions.githubusercontent.com"
          },
          "Action":"sts:AssumeRoleWithWebIdentity",
          "Condition":{
            "ForAllValues:StringLike":{
                "token.actions.githubusercontent.com:sub":"repo:${var.github_org}/${var.repo_name}:*",
                "token.actions.githubusercontent.com:aud":"sts.amazonaws.com"
              }
          }
        }
      ]
    }
    EOF
}

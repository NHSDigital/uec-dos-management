
# Version of the role (and policies for integration env only)
# Attach the pu policy to the role
resource "aws_iam_role_policy_attachment" "attach_power_user_int" {
  count      = var.int_environment ? 1 : 0
  role       = aws_iam_role.github_runner_role_int[0].name
  policy_arn = data.aws_iam_policy.power_user_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_ro_iam_int" {
  count      = var.int_environment ? 1 : 0
  role       = aws_iam_role.github_runner_role_int[0].name
  policy_arn = aws_iam_policy.ro_policy_iam.arn
}

# for int environment multiple repo trust
resource "aws_iam_role" "github_runner_role_int" {
  count              = var.int_environment ? 1 : 0
  name               = "${var.repo_name}-github-runner"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_int[0].json

}

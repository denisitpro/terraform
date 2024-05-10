## Create an IAM user
#resource "aws_iam_user" "c1_certificate_user" {
#  name = "c1-certificate-user"
#  tags = {
#    Name        = "c1-certificate-user"
#    Description = "c1 certificate user for API access enrol certificate"
#    Code        = local.c1_company_code
#    Createdby   = local.c1_author_devops
#  }
#}
#
### Create an IAM access key for the user - not print text value, only masked
##resource "aws_iam_access_key" "c1_certificate_user_key" {
##  user = aws_iam_user.c1_certificate_user.name
##}
#
## Create an IAM policy to grant certificate issuance permission in Route 53
#resource "aws_iam_policy" "c1_certificate_policy" {
#  name        = "c1-certificate-policy"
#  description = "c1 policy to allow certificate issuance in Route 53"
#
#  policy = <<-EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Sid": "CertbotRoute53",
#            "Effect": "Allow",
#            "Action": [
#                "route53:GetChange",
#                "route53:ListHostedZones",
#                "route53:ListResourceRecordSets"
#            ],
#            "Resource": "*"
#        },
#        {
#            "Sid": "CertbotRoute531",
#            "Effect": "Allow",
#            "Action": "route53:ChangeResourceRecordSets",
#            "Resource": "arn:aws:route53:::hostedzone/Z0013801VTM9ENSGOR15"
#        }
#    ]
#}
#
#
#  EOF
#}
#
## Attach the policy to the user
#resource "aws_iam_user_policy_attachment" "certificate_user_policy_attachment" {
#  user       = aws_iam_user.c1_certificate_user.name
#  policy_arn = aws_iam_policy.c1_certificate_policy.arn
#}
#
#
## Output the access key credentials
##output "certificate_user_access_key" {
##  value = aws_iam_access_key.c1_certificate_user_key.id
##  sensitive = true
##}
##
##output "certificate_user_secret_key" {
##  value = aws_iam_access_key.c1_certificate_user_key.secret
##  sensitive = true
##}

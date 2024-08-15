aws identitystore list-users --identity-store-id d-92671f71c1 --region us-west-2 --profile aws_master

aws identitystore list-users --identity-store-id d-92671f71c1 --filters AttributePath="UserName",AttributeValue="burakk@bcaa.bc.ca" --region us-west-2 --profile aws_master

aws identitystore describe-user --identity-store-id d-92671f71c1 --user-id 92671f71c1-0caf47a4-8f87-4213-95ba-d193fa9294f3 --region us-west-2 --profile aws_master

aws identitystore is-member-in-groups --identity-store-id d-92671f71c1 --member-id 92671f71c1-0caf47a4-8f87-4213-95ba-d193fa9294f3 groups-ids 92671f71c1-7c6aea23-4a0a-491e-8fef-ff21c6000864 --region us-west-2 --profile aws_master

aws identitystore list-groups --identity-store-id d-92671f71c1 --filters AttributePath="DisplayName",AttributeValue="AWS-SSO-Automation-AdminAccess@bcaa.bc.ca" --region us-west-2 --profile aws_master

aws identitystore list-groups --identity-store-id d-92671f71c1 --filters AttributePath="DisplayName",AttributeValue="*@bcaa.bc.ca" --region us-west-2 --profile aws_master

aws identitystore list-group-memberships --identity-store-id d-92671f71c1 --group-id 92671f71c1-7c6aea23-4a0a-491e-8fef-ff21c6000864 --region us-west-2 --profile aws_master

aws identitystore is-member-ingroups --identity-store-id d-92671f71c1 --member-id 92671f71c1-0caf47a4-8f87-4213-95ba-d193fa9294f3 --group-ids 92671f71c1-ac1c8b6f-6b0d-4edf-85c0-de63c722c6fc --region us-west-2 --profile aws_master

aws identitystore get-user-id --identity-store-id d-92671f71c1 --alternate-identifier burakk --region us-west-2 --profile aws_master

aws sso-admin describe-permission-set --instance-arn arn:aws:sso:::instance/ssoins-790760b98bdd6ce9 --permission-set-arn arn:aws:sso:::permissionSet/ssoins-790760b98bdd6ce9/ps-7c92a19667396d3e --region us-west-2 --profile aws_master

aws sso-admin list-permission-sets-provisioned-to-account --instance-arn arn:aws:sso:::instance/ssoins-790760b98bdd6ce9 --account-id 337558554106 --region us-west-2 --profile aws_master

aws sso-admin list-permission-sets --instance-arn arn:aws:sso:::instance/ssoins-790760b98bdd6ce9 --region us-west-2 --profile aws_master | grep arn:aws:sso | wc -l

Get-ADGroupMember -Identity "AWS-SSO-Automation-AdminAccess" -Recursive | Get-ADUser -Properties Mail | Select-Object GivenName,Mail



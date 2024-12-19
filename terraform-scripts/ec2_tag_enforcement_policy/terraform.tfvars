default_profile = "master"
region          = "us-west-2"
targets         = ["ou-47ib-kxbi6gah"] # Exceptions OU (AWS Sandbox)
ec2_tag_enforcement = [
  "aws:RequestTag/Name",
  "aws:RequestTag/Creator",
  "aws:RequestTag/Department",
  "aws:RequestTag/Description",
  "aws:RequestTag/TicketNumber",
  "aws:RequestTag/Environment"
]
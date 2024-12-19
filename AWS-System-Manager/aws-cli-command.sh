aws ssm create-document \
--name "Burak-InstallCrowdStrike" \
--content file://crowdstrike-agent-install.yaml \
--document-type "Command" \
--document-format YAML \
--region us-west-2 


aws ssm create-document \
--name "Burak-AutomateInstallCrowdStrike" \
--content file://automate-crowdstrike.yaml \
--document-type "Automation" \
--document-format YAML \
--region us-west-2
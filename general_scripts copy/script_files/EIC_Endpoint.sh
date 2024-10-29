aws ec2 create-instance-connect-endpoint \
    --subnet-id subnet-02376c9a9fef6099c \
    --security-group-id sg-09a1f0a378f00903d

#    {
#        "InstanceConnectEndpoint": {
#            "OwnerId": "155754364360",
#            "InstanceConnectEndpointId": "eice-0af1f5266d4868ccd",
#            "InstanceConnectEndpointArn": "arn:aws:ec2:us-west-2:155754364360:instance-connect-endpoint/eice-0af1f5266d4868ccd",
#            "State": "create-in-progress",
#            "StateMessage": "",
#            "NetworkInterfaceIds": [],
#            "VpcId": "vpc-0384aa0e5691eb4d9",
#            "CreatedAt": "2023-06-16T18:34:13+00:00",
#            "SubnetId": "subnet-02376c9a9fef6099c",
#            "PreserveClientIp": false,
#            "SecurityGroupIds": [
#                "sg-09a1f0a378f00903d"
#            ],
#            "Tags": []
#        },
#        "ClientToken": "4d266f07-b0f2-408d-be1d-3390b1fcffc9"


aws ec2-instance-connect ssh --instance-id i-0018154e7ed0bb0e2

# You can run the following command to test connectivity.

ssh ec2-user@i-0018154e7ed0bb0e2 \
    -i burak_test.pem \
    -o ProxyCommand='aws ec2-instance-connect open-tunnel \
    --instance-id i-0018154e7ed0bb0e2'
aws ec2 describe-instances --instance-ids i-0cbdd3c444076d39c --profile data_protection --region ca-central-1

# "MetadataOptions": {
#                         "State": "applied",
#                         "HttpTokens": "optional",
#                         "HttpPutResponseHopLimit": 2,
#                         "HttpEndpoint": "enabled",
#                         "HttpProtocolIpv6": "disabled",
#                         "InstanceMetadataTags": "disabled"
#                     },

aws ec2 modify-instance-metadata-options --instance-id i-0cbdd3c444076d39c --profile data_protection --region ca-central-1 \
    --http-tokens required --http-endpoint enabled \
    --http-put-response-hop-limit 1

#  "HttpTokens": "optional" will be "HttpTokens": "required"

# Then SSH into the EC2 instance

curl http://169.254.169.254/latest/meta

#    <?xml version="1.0" encoding="iso-8859-1"?>
#    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
#            "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
#    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
#    <head>
#    <title>401 - Unauthorized</title>
#    </head>
#    <body>
#    <h1>401 - Unauthorized</h1>
#    </body>
#    </html>

TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/

# We are able to get the response to the requests with a provided token.

# IMDSv2 is a new recommended security best practice to enable on your instances. It provides another layer of security to access your instance metadata.
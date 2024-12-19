import boto3
import time
import sys
import json
import re

def lambda_handler(event, context):
    # TODO implement
    emrClient = boto3.setup_default_session(region_name='ca-central-1')
    emrClient = boto3.client('emr')
    
    snsclient = boto3.client('sns')
    snsArn = 'arn:aws:sns:ca-central-1:607968612228:emr-cluster-list-topic'
    message = str(emrClient.list_clusters(ClusterStates=['WAITING','STARTING','RUNNING']))
    data = []
    
    # print(message)
    
    output_string = message.replace("tzinfo=tzlocal())", "tzinfo=tzlocal())'")

    output_string = output_string.replace("datetime.datetime","'datetime.datetime")
    
    pre_json = output_string.replace("'", "\"")
    
    valid_json = json.dumps(pre_json)
    
    message_json = json.loads(valid_json)
    
    last_version_json = message_json
    
    response = snsclient.publish(
        TopicArn = snsArn,
        Message =  last_version_json , 
        Subject='DnA Prod List of Active EMR clusters' ,
    )

    #return json.dumps(response)
    
    return response

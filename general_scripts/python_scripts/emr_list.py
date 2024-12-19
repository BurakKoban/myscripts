import boto3
import time
import sys
import json


def lambda_handler(event, context):
    # TODO implement
    emrClient = boto3.setup_default_session(region_name='ca-central-1')
    emrClient = boto3.client('emr')
    
    snsclient = boto3.client('sns')
    snsArn = 'arn:aws:sns:ca-central-1:607968612228:emr-cluster-list-topic'
    message = str(emrClient.list_clusters(ClusterStates=['WAITING','STARTING','RUNNING']))
    data = []
    
    # message_dict = jq(message)
    
    print(message)
    
    response = snsclient.publish(
        TopicArn = snsArn,
        Message =  message , 
        Subject='DnA Prod List of Active EMR clusters' ,
        MessageStructure = 'html' , 
        
    )
    
    return json.dumps(response)

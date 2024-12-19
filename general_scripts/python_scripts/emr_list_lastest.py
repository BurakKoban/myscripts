import boto3
import time
import sys
import json
from datetime import datetime



def lambda_handler(event, context):
    # TODO implement
    emrClient = boto3.setup_default_session(region_name='ca-central-1')
    emrClient = boto3.client('emr')
    snsclient = boto3.client('sns')
    snsArn = 'arn:aws:sns:ca-central-1:632856304542:emr-list-topic'
  
    #message = str(emrClient.list_clusters(ClusterStates=['WAITING','STARTING','RUNNING']))
    
    page_iterator = emrClient.get_paginator('list_clusters').paginate(
        ClusterStates=['WAITING','STARTING','RUNNING']
    )
    
    item_list = []
    item_str = ""
    n_item_str = ""
    for page in page_iterator:
        
        for item in page['Clusters']:
            item_list.append(item)
           
    formatted_items = []
    for item in item_list:
        creation_dt = item['Status']['Timeline']['CreationDateTime']
        formatted_dt = 'EMRCluster date-start time:' + creation_dt.strftime("%Y-%m-%d %H:%M:%S")
        formatted_items.append(f"{item['Id']}---{item['Name']}---{formatted_dt}")
    
    item_str = ",#######################,".join(formatted_items)
    item_str = f"DnA PreProd EMR Clusters:######################  {item_str}"
    response = snsclient.publish(
        TopicArn = snsArn,
        Message =  (item_str) , 
        Subject='DnA PreProd List of Active EMR Clusters' ,
        
    )
    

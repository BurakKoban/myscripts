import json
import boto3
from collections import Counter
def lambda_handler(event, context):
    client = boto3.client('lambda')
    response = client.list_functions(FunctionVersion='ALL')
    d = dict(Counter([x['FunctionName'] for x in response['Functions']]))
    print(json.dumps(d, indent=2))
    for key, value in d.items():
        if value > 5:
           print(key, '->', value) 
           a = {}
           for x in response['Functions']:
               if x['FunctionName'] == key and x['Version'] != '$LATEST':
                   #print(x['FunctionArn'],x['LastModified'])
                   a[x['FunctionArn']] = x['LastModified']
           listofTuples = sorted(a.items() , key=lambda x: x[1])
           print(a)
           print(json.dumps(listofTuples))
           if len(listofTuples) > 5:
               for elem in listofTuples[0:len(listofTuples)-5]:
                   response = client.delete_function(FunctionName=elem[0])
                   print("FunctionArn",elem[0],"Deleted response",response,sep = "->")


# If you have large number of lambdas then using paginator will help. You can use following code for reference

import json
import boto3
from collections import Counter


def lambda_handler(event, context):
    client = boto3.client("lambda")
    paginator = client.get_paginator("list_functions")
    response_iterator = paginator.paginate(
        FunctionVersion="ALL",
        PaginationConfig={
            "MaxItems": 123,
            "PageSize": 123,
        },
    )
    print(response_iterator)
    for page in response_iterator:
        d = dict(Counter([x["FunctionName"] for x in page["Functions"]]))
        print(json.dumps(d, indent=2))
        for key, value in d.items():
            if value > 5:
                print(key, "->", value)
                a = {}
                for x in response["Functions"]:
                    if x["FunctionName"] == key and x["Version"] != "$LATEST":
                        # print(x['FunctionArn'],x['LastModified'])
                        a[x["FunctionArn"]] = x["LastModified"]
                listofTuples = sorted(a.items(), key=lambda x: x[1])
                print(a)
                print(json.dumps(listofTuples))
                if len(listofTuples) > 5:
                    for elem in listofTuples[0 : len(listofTuples) - 5]:
                        response = client.delete_function(FunctionName=elem[0])
                        print(
                            "FunctionArn",
                            elem[0],
                            "Deleted response",
                            response,
                            sep="->",
                        )

# Remove Old Lambda Versions

from __future__ import absolute_import, print_function, unicode_literals
import boto3

NUM_VERSION = 5


def get_versions_function(client, function_name):
    versions = client.list_versions_by_function(FunctionName=function_name)

    while "NextMarker" in versions and versions["NextMarker"]:
        tmp = client.list_versions_by_function(
            FunctionName=function_name,
            Marker=versions["NextMarker"])
        versions['Versions'].extend(tmp['Versions'])
        versions["NextMarker"] = tmp["NextMarker"] if "NextMarker" in tmp else None

    return versions['Versions']


def get_functions(client):
    functions = client.list_functions()

    while "NextMarker" in functions and functions["NextMarker"]:
        tmp = client.list_functions(
            Marker=functions["NextMarker"])
        functions['Functions'].extend(tmp['Functions'])
        functions["NextMarker"] = tmp["NextMarker"] if "NextMarker" in tmp else None

    return functions['Functions']


def clean_old_lambda_versions(client):
    functions = get_functions(client)

    for function in functions:
        versions = get_versions_function(client, function['FunctionArn'])
        numVersions = len(versions)
        aliases = client.list_aliases(FunctionName=function['FunctionArn'])
        alias_versions = [alias['FunctionVersion'] for alias in aliases['Aliases']]

        if numVersions <= NUM_VERSION:
            print('{}: done'.format(function['FunctionName']))
        else:
            for version in versions:
                if (version['Version'] != function['Version'] 
                        and numVersions > NUM_VERSION
                        and not version['Version'] in alias_versions):

                    arn = version['FunctionArn']
                    print('delete_function(FunctionName={})'.format(arn))
                    client.delete_function(FunctionName=arn)  # uncomment me once you've checke
                    numVersions -= 1


session = boto3.session.Session(profile_name='default')
regions = ['us-west-2', 'ca-central-1', 'us-east-1']

for region in regions:
    client = session.client('lambda', region_name=region)
    clean_old_lambda_versions(client)

# Last 3 version of the lambda function

import boto3
lambda_client = boto3.client('lambda')

def lambda_handler(event, context):
    function_name = 'DeleteOlderLambdaVersion' #add your Lambda Function Name here
    versions_to_keep = 3 #Number of version to keep
    
    response = lambda_client.list_versions_by_function(
        FunctionName=function_name
    )
    versions = response['Versions']
    versions.sort(key=lambda v: v['Version'])
    total_versions = len(versions)
    versions_to_delete = total_versions - versions_to_keep
    for version in versions:
        if version['Version'] == '$LATEST': #Skip the latest version
            continue
        versions_to_delete-=1
        if versions_to_delete <= 0: #break if all version deleted
            break 
        version_number = version['Version']
        lambda_client.delete_function(
            FunctionName=function_name,
            Qualifier=version_number
        )
    return True
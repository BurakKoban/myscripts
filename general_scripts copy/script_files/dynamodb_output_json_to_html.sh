# Create an S3 bucket, a Lambda function and a Dynamodb table

# The code for the Lambda function:

import json
import boto3

client = boto3.client('dynamodb')


def lambda_handler(event, context):
  data = client.scan(
    TableName='burak-test'
    )
 
  s3 = boto3.resource('s3')
  object = s3.Object('burak-test-dynamodb-html', 'object.json')
  response = {
      'statusCode': 200,
      'body': json.dumps(data),
      'headers': {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
  }
  object.put(Body=json.dumps(response).encode())
  
  return response

  # IAM policy for the lambda function:

 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:us-west-2:155754364360:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:Get*",
                "dynamodb:Scan*"
            ],
            "Resource": "arn:aws:dynamodb:us-west-2:155754364360:table/burak-test"
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:GetRecords",
                "dynamodb:GetShardIterator",
                "dynamodb:DescribeStream",
                "dynamodb:ListStreams"
            ],
            "Resource": "arn:aws:dynamodb:us-west-2:155754364360:table/burak-test/stream/2023-06-27T18:10:13.889"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:Put*"
            ],
            "Resource": [
                "arn:aws:s3:::burak-test-dynamodb-html",
                "arn:aws:s3:::burak-test-dynamodb-html/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:us-west-2:155754364360:log-group:/aws/lambda/burak-test-dynamodb:*"
            ]
        }
    ]
}

# Enable dynamodb data streams

# Then set it up to trigger you lambda function

# HTML file to fetch the json file

<!doctype html>
<html lang="en">
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Burak dynamodb export - JSON Test</title>
</head>
<body>
Cloud Front S3 test123 for dynamodb <br>
<br>
DynamoDB items:<br>
<br>   
<div id="myData"></div>
<script>
    fetch('object.json')  
        .then(response => response.json())
        .then(data => {
            // butun olay su kisim burak hoca, parse yapmak gerekiyor
        let bodyData = JSON.parse(data.body);
        appendData(bodyData.Items);
        })
        .catch(err => console.log('error: ' + err));
        
    function appendData(data) {
        var mainContainer = document.getElementById("myData");
        for (var i = 0; i < data.length; i++) {
            var div = document.createElement("div");
            div.innerHTML = 'Name: ' + data[i].name.S + ' ' + data[i].lastname.S;
            mainContainer.appendChild(div);
        }
    }
</script>



</body>
</html>

# grid model html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Burak dynamodb items - JSON to Html Test</title>
    <style>
        .grid-container {
            display: grid;
            grid-template-columns: auto auto auto;
            padding: 20px;
            
            gap: 0px;
            width: 50vw;
            margin: auto;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding:5%;
        }
        .grid-item {
            
            padding: 20px;
            font-size: 20px;
            text-align: center;
            border-bottom: 1px dotted #9f9f9f;
            border-right:  1px dotted #9f9f9f;
            border-left: 1px dotted #9f9f9f;
        }

  
        .header {
            font-weight: 900;
            color: #fff;
            border-bottom: 1px dotted #9f9f9f;
            border-top: 1px dotted #9f9f9f;
            background-color: #46bdc6;
        }


        #title {
            text-align: center;
            font-weight: 800;
            font-size: 2rem;
            margin: 40px 0;
        }
    </style>
</head>
<body>
<div id="title">Cloud Front S3 Json to Grid Table for Dynamodb item display</div>

<div id="myData" class="grid-container">
    <div class="grid-item header">No</div>
    <div class="grid-item header">First Name</div>
    <div class="grid-item header">Last Name</div>

</div>
<script>
    fetch('object.json') 
        .then(response => response.json())
        .then(data => {
            let bodyData = JSON.parse(data.body);
            appendData(bodyData.Items);
        })
        .catch(err => console.log('error: ' + err));
    
    function appendData(data) {
        var mainContainer = document.querySelector("#myData");
        for (let i = 0; i < data.length; i++) {
            
            let div1 = document.createElement("div");
            div1.innerHTML = i+1; 
            div1.className = 'grid-item'; 
            mainContainer.appendChild(div1)
            
            let div2 = document.createElement("div");
            div2.innerHTML = data[i].name.S;
            div2.className = 'grid-item';

            mainContainer.appendChild(div2);
            let div3 = document.createElement("div");
            div3.innerHTML = data[i].lastname.S;
            div3.className = 'grid-item';
            mainContainer.appendChild(div3);
        }
    }
</script>
</body>
</html>

# An other version of HTML

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Burak dynamodb items - JSON to Html Test</title>
    <style>
        .grid-container {
            display: grid;
            grid-template-columns: auto auto auto;
            padding: 20px;
            
            gap: 0px;
            width: 50vw;
            margin: auto;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding:5%;
        }
        .grid-item {
            
            padding: 20px;
            font-size: 20px;
            text-align: center;
           
            
        }

  
        .header {
            font-weight: 900;
            color: #46bdc6;
           
            
            
        }


        #title {
            text-align: center;
            font-weight: 800;
            font-size: 2rem;
            margin: 40px 0;
        }
    </style>
</head>
<body>
<div id="title">Cloud Front S3 Json to Grid Table for Dynamodb item display</div>

<div id="myData" class="grid-container">
    <div class="grid-item header">No</div>
    <div class="grid-item header">First Name</div>
    <div class="grid-item header">Last Name</div>

</div>
<script>
    fetch('object.json') 
        .then(response => response.json())
        .then(data => {
            let bodyData = JSON.parse(data.body);
            appendData(bodyData.Items);
        })
        .catch(err => console.log('error: ' + err));
    
    function appendData(data) {
        var mainContainer = document.querySelector("#myData");
        for (let i = 0; i < data.length; i++) {
            
            let div1 = document.createElement("div");
            div1.innerHTML = i+1; 
            div1.className = 'grid-item'; 
            mainContainer.appendChild(div1)
            
            let div2 = document.createElement("div");
            div2.innerHTML = data[i].name.S;
            div2.className = 'grid-item';

            mainContainer.appendChild(div2);
            let div3 = document.createElement("div");
            div3.innerHTML = data[i].lastname.S;
            div3.className = 'grid-item';
            mainContainer.appendChild(div3);
        }
    }
</script>
</body>
</html>
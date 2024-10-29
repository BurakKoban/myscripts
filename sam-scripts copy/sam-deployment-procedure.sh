# first we need to initilaze a sam project

sam init --location /path/ -- runtime python3.9|nodejs6.10 

# Or you can initilaze it manually step by step

# 1- Create a src folder

mkdir src

# 2- Create a python file

cd src 
vi app.py

# 3- Create a templat.yaml file

cd ..
vi template.yaml

# 4- 



sam build

#Package&Deploy

aws cloudformation package
sam package

aws cloudformation deploy
sam deploy
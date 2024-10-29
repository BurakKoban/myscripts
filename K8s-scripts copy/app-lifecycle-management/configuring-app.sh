Configuring applications comprises of understanding the following concepts:

* Configuring Command and Arguments on applications

* Configuring Environment Variables

* Configuring Secrets

# Docker commands

docker run ubuntu

docker ps -a 

Dockerfile      ------------------------>       pod-definition.yaml

FROM ubuntu       ------------>                 apiVersion: v1
                                                kind: Pod
                                                metadata:
                                                  name: ubuntu-sleeper-pod
    
                                                spec:
                                                  containers:
                                                  - name: ubuntu-sleeper
                                                    image: ubuntu-sleeper
ENTRYPOINT ["sleep"]      -------------->           command: ["sleep2.0"]

CMD["5"]              ------------------>           args: ["10"]

# 

kubectl run webapp-green --image=kodekloud/webapp-color --dry-run=client -o yaml > pod-definition.yaml

kubectl run webapp-green --image=kodekloud/webapp-color -- --color green
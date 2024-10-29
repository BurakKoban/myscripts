kubectl create secret docker-registry private-reg-cred
--docker-server=myprivateregistry.com:5000 --docker-username=dock_user
--docker-password=dock_password --docker-email=dock_user@myprivateregistry.com


# To provide additional capabilities to docker container user

docker run --cap-add MAC_ADMIN ubuntu

# To drop some capabilities

docker run --cap-drop KILL ubuntu

# To run the container with all privileges enabled

docker run --privileged ubuntu

# To make it at pod level

apiVersion: v1
kind: Pod
metadata:
  name: web-pod
spec:
  securityContext:
    runAsUser: 1000

  containers:
  - name: ubuntu
    image: ubuntu
    command: ["sleep", "3600"]

# To make it at container level

apiVersion: v1
kind: Pod
metadata:
  name: web-pod
spec:
  

  containers:
  - name: ubuntu
    image: ubuntu
    command: ["sleep", "3600"]
    securityContext:
      runAsUser: 1000
      capabilities:
        add: ["MAC_ADMIN"]


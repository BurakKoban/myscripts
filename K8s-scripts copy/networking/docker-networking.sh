# To create a container without any networking

docker run --network none ubuntu

# To create a container with networking of the host

docker run --network host ubuntu

# To map the container to bepublicly reachable on the host at port 8080

docker run -p 8080:80 ubuntu

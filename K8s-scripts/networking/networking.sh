# List and modify network interfaces

ip link

# To see IP addresses assigned to the interfaces

ip addr

# To IP address of the interface

ip addr add 192.168.1.10/24 dev eth0

# To see the routes

ip route

route

# To add a route

ip route add 192.168.1.0/24 via 192.168.1.1

# To see ip forwarding is enabled or not

cat /proc/sys/net/ipv4/ip_forward

# To see the port

netstat
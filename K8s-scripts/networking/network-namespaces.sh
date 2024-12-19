# To create a network namespace

ip netns add red

ip netns add blue

# To list network namespaces

ip netns

# To see the eth interfaces in the network namespace

ip netns exec red ip link  # or

ip -n red link

# T0 see MAC addresses assigned to IP addresses

arp

# To establish connection between two network namespaces

ip link add veth-red type veth peer name veth-blue

# To attach the interfaces

ip link set veth-red netns red
ip link set veth-blue netns blue

# To assign IP addresses to the interfaces

ip -n red addr add 192.168.15.1 dev veth-red
ip -n blue addr add 192.168.15.2 dev veth-blue

# To bring up the interfaces

ip -n red link set veth-red up
ip -n blue link set veth-blue up

# To create a network switch

ip link add v-net-0 type bridge

ip link set dev v-net-0 up # to bring the switch up

# To delete the connection to the network namespace

ip -n red link del veth-red

# To connect namespaces to the network switch

ip link add veth-red type veth peer name veth-red-br

ip link set veth-red netns red
ip link set veth-red-br master v-net-0

ip -n red addr add 192.168.15.1 dev veth-red
ip -n red link set veth-red up

ip addr add 192.168.15.5 dev v-net-0





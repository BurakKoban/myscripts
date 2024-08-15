stats sum(packets) as packetsTransferred by srcAddr, dstAddr, srcPort, dstPort
    | sort packetsTransferred  desc
    |  filter isIpInSubnet(srcAddr,'172.26.128.0/17')
    | limit 25
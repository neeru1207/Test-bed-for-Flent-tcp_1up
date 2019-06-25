#
#                                    DUMBELL TOPOLOGY 
#  __________             ____________             ____________             __________
# |          |     A     |            |     B     |            |     C     |          |
# |  Client  |1---------2|  Router 1  |3---------4|  Router 2  |5---------6|  Server  |
# |__________|           |____________|           |____________|           |__________|
#                                                    
#                                                                  
#     
#              
#
#                                         Link A
#                           Network Address : 10.0.0.0/24
#                     Interface 1                        Interface 2
#             Name         : ethc_r1          	Name         : ethr1_c
#             IPv4 Address : 10.0.0.1/24         IPv4 Address : 10.0.0.2/24
#
#
#                                         Link B
#                           Network Address : 10.0.1.0/24
#                     Interface 3                        Interface 4
#             Name         : ethr1_r2          	Name         : ethr2_r1
#             IPv4 Address : 10.0.1.1/24         IPv4 Address : 10.0.1.2/24
#
#
#                                         Link C
#                           Network Address : 10.0.2.0/24
#                     Interface 5                        Interface 6
#             Name         : ethr2_s          	Name         : eths_r2
#             IPv4 Address : 10.0.2.1/24         IPv4 Address : 10.0.2.2/24
#

sudo ip netns del client
sudo ip netns del router1
sudo ip netns del router2
sudo ip netns del server

sudo ip netns add client
sudo ip netns add router1
sudo ip netns add router2
sudo ip netns add server

sudo ip link add ethc_r1 type veth peer name ethr1_c
sudo ip link add ethr2_s type veth peer name eths_r2
sudo ip link add ethr1_r2 type veth peer name ethr2_r1

sudo ip link set ethc_r1 netns client
sudo ip link set ethr1_c netns router1
sudo ip link set ethr1_r2 netns router1
sudo ip link set ethr2_r1 netns router2
sudo ip link set ethr2_s netns router2
sudo ip link set eths_r2 netns server

sudo ip netns exec router1 ip link set ethr1_c up
sudo ip netns exec router1 ip link set ethr1_r2 up

sudo ip netns exec router2 ip link set ethr2_s up
sudo ip netns exec router2 ip link set ethr2_r1 up

sudo ip netns exec client ip link set ethc_r1 up
sudo ip netns exec server ip link set eths_r2 up

sudo ip netns exec client ip address add 10.0.0.1/24 dev ethc_r1
sudo ip netns exec router1 ip address add 10.0.0.2/24 dev ethr1_c

sudo ip netns exec router1 ip address add 10.0.1.1/24 dev ethr1_r2
sudo ip netns exec router2 ip address add 10.0.1.2/24 dev ethr2_r1

sudo ip netns exec router2 ip address add 10.0.2.1/24 dev ethr2_s
sudo ip netns exec server ip address add 10.0.2.2/24 dev eths_r2

sudo ip netns exec client ip route add default via 10.0.0.2 dev ethc_r1
sudo ip netns exec server ip route add default via 10.0.2.1 dev eths_r2
sudo ip netns exec router1 ip route add default via 10.0.1.2 dev ethr1_r2
sudo ip netns exec router2 ip route add default via 10.0.1.1 dev ethr2_r1

sudo ip netns exec router1 sysctl net.ipv4.ip_forward=1
sudo ip netns exec router2 sysctl net.ipv4.ip_forward=1

sudo ip netns exec server netserver


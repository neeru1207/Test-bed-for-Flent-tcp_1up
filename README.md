# Test-bed-for-Flent-tcp_1up
A dumbbell topology test bed in linux using network namespaces for Flent's tcp_1up test.
# Architecture
<!-- language: lang-none -->
                                        DUMBELL TOPOLOGY 
      __________             ____________             ____________             __________
     |          |     A     |            |     B     |            |     C     |          |
     |  Client  |1---------2|  Router 1  |3---------4|  Router 2  |5---------6|  Server  |
     |__________|           |____________|           |____________|           |__________|
                                                    
                                                                  
     
              

                                         Link A
                           Network Address : 10.0.0.0/24
                     Interface 1                        Interface 2
             Name         : ethc_r1          	Name         : ethr1_c
             IPv4 Address : 10.0.0.1/24         IPv4 Address : 10.0.0.2/24


                                         Link B
                           Network Address : 10.0.1.0/24
                     Interface 3                        Interface 4
             Name         : ethr1_r2          	Name         : ethr2_r1
             IPv4 Address : 10.0.1.1/24         IPv4 Address : 10.0.1.2/24


                                         Link C
                           Network Address : 10.0.2.0/24
                     Interface 5                        Interface 6
             Name         : ethr2_s          	Name         : eths_r2
             IPv4 Address : 10.0.2.1/24         IPv4 Address : 10.0.2.2/24


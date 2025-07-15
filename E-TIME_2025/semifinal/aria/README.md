# ticket 1
```bash
HQ(config)#enable password etime2025
HQ(config)#enable secret 2025etime
OFFICE(config)#enable password etime2025
OFFICE(config)#enable secret 2025etime
BRANCH(config)#enable password etime2025
BRANCH(config)#enable secret 2025etime
``` 
# ticket 2
```bash
HQ(config)#banner motd ^C
Enter TEXT message.  End with the character '^'.
Halo, ini adalah router HQ^C

BRANCH(config)#ip domain-name etime.com
OFFICE(config)#ip domain-name etime.com
HQ(config)#ip domain-name etime.com
```

# ticket 3
```
CAMPUS(config)#router ospf 10
CAMPUS(config-router)#network 10.10.10.20 0.0.0.3 area 0
```

# ticket 4
```bash
DSW_Campus(config)#int fa 0/3
DSW_Campus(config-if)#switchport trunk allowed vlan 100,200

Switch(config)#hostname Acc1_Campus
Acc1_Campus(config)#enable password etime2025
Acc1_Campus(config)#int ra fa 0/1-2
Acc1_Campus(config-if-range)#channel-group 1 mode active 
Acc1_Campus(config-if-range)#channel-protocol lacp
Acc1_Campus(config-if-range)#int po1
Acc1_Campus(config-if)#sw mode tr
Acc1_Campus(config-if)#vlan 100
Acc1_Campus(config-vlan)#vlan 200
Acc1_Campus(config-vlan)#int fa 0/3
Acc1_Campus(config-if)#sw acc vlan 100
```

# ticket 5
- server http
  - enable http, and https

# ticket 6
```bash
HQ(config)#int gig0/1.10
HQ(config-subif)#ip helper-address 172.16.10.2
```

# ticket 7
- aktifkan license
```bash
license boot module c2900 technology-package uck9 
do wr
do reload
```

- telepony service
```bash
HQ(config)#telephony-service 
HQ(config-telephony)#max-ephones 5
HQ(config-telephony)#max-dn 5
HQ(config-telephony)#ip source-address 192.168.10.1  port 2000
HQ(config-telephony)#auto assign 1 to 5
HQ(config)#ephone-dn 1
HQ(config-ephone-dn)#number 1001
HQ(config-ephone-dn)#ephone-dn 2
HQ(config-ephone-dn)#number 1002
HQ(config-ephone-dn)#ephone-dn 3
HQ(config-ephone-dn)#number 1003
```

# ticket 8
```bash
HQ(config-dial-peer)#dial-peer voice 1 voip
HQ(config-dial-peer)#destination-pattern 200.
HQ(config-dial-peer)#session target ipv4:192.168.20.1

BRANCH(config)#dial-peer voice 1 voip
BRANCH(config-dial-peer)#destination-pattern 100.
BRANCH(config-dial-peer)#session target ipv4:192.168.10.1
```

# ticket 9
## Email Server
- tambahkan user baru nisa:123
- lalu tambahkan juga di pcnya
  - NISA, nias@mail.etime.pnj, mail.etime.pnj, mail.etime.pnj, nisa, 123

# ticket 10
```bash
OFFICE(config)#ip domain-name etime.com
OFFICE(config)#username tegar privilege 15 password 123
OFFICE(config)#crypto key generate rsa
OFFICE(config)#ip ssh version 2
OFFICE(config)#line vty 0 4
OFFICE(config-line)#login local
OFFICE(config-line)#transport input ssh

HQ(config)#ip domain-name etime.com
HQ(config)#username tegar privilege 15 pass 123
HQ(config)#crypto key generate rsa
HQ(config)#ip ssh version 2
HQ(config)#line vty 0 4
HQ(config-line)#login local
HQ(config-line)#transport input ssh

BRANCH(config)#ip domain-name etime.com
BRANCH(config)#username tegar privilage 15 pass 123                                    ^
BRANCH(config)#username tegar privilege 15 pass 123
BRANCH(config)#crypto key generate rsa
BRANCH(config)#ip ssh version 2
BRANCH(config)#line vty 0 4
BRANCH(config-line)#login local
BRANCH(config-line)#transport input ssh
````


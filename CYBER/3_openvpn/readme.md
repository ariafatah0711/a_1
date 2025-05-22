## Instalasi dan Konfigurasi OpenVPN pada VM Linux dengan Protokol Standar
### Instalasi OpenVPN dan Pembuatan Sertifikat Server (Easy-RSA 3.0)
#### Instalasi Paket yang Dibutuhkan
```bash
yum install epel-release
yum install openvpn easy-rsa
```

#### Membuat Directory easy-rsa pada `/etc/openvpn`, dan Meng-copy Template easy-rsa
```bash
mkdir /etc/openvpn/easy-rsa
cd /usr/share/easy-rsa/3.?.?
cp -rf * /etc/openvpn/easy-rsa/
```

#### Membuat Sertifikat untuk Server
```bash
cd /etc/openvpn/easy-rsa
./easyrsa init-pki
./easyrsa build-ca
./easyrsa gen-dh
./easyrsa gen-req vpn-harbas nopass
./easyrsa sign server vpn-harbas
```

#### Membuat Directory `keys` dan Menyalin Sertifikat yang Dibutuhkan
```bash
mkdir /etc/openvpn/keys
chmod 750 /etc/openvpn/keys/
cp -a /etc/openvpn/easy-rsa/pki/ca.crt /etc/openvpn/keys/
cp -a /etc/openvpn/easy-rsa/pki/dh.pem /etc/openvpn/keys/dh2048.pem
cp -a /etc/openvpn/easy-rsa/pki/issued/vpn-harbas.crt /etc/openvpn/keys/
cp -a /etc/openvpn/easy-rsa/pki/private/vpn-harbas.key /etc/openvpn/keys/
```

---

## Membuat Sertifikat File Client
### Membuat Certificate Client
```bash
cd /etc/openvpn/easy-rsa
./easyrsa gen-req client_window nopass
./easyrsa sign client client_window
```

### Menyalin Sertifikat Client ke Direktori `/etc/openvpn/client/`
```bash
cp -a /etc/openvpn/easy-rsa/pki/issued/client_window.crt /etc/openvpn/client/
cp -a /etc/openvpn/easy-rsa/pki/private/client_window.key /etc/openvpn/client/
```

### Konfigurasi Server OpenVPN
File: `/etc/openvpn/server/server.conf`

```ini
port 1194                     # Port server OpenVPN (default 1194)
proto udp                     # Protokol yang dipakai: UDP
dev tun                       # Gunakan interface TUN (routing IP)
comp-lzo                      # Aktifkan kompresi LZO (deprecated, hati-hati)
management 127.0.0.1 1194     # Management interface di localhost port 1194 (tanpa password, kurang aman)
keepalive 10 120              # Ping setiap 10 detik, timeout 120 detik
persist-key                   # Jangan reset key saat restart
persist-tun                   # Jangan reset tun interface saat restart
verb 3                        # Level verbose log, 3 = standar cukup detail

server 10.12.10.0 255.255.255.0           # subnet VPN yang di dapatkan client (netmask harus 255.255.255.0 misalnya)
push "route 192.168.0.0 255.255.255.0"    # Push route jaringan lokal ke klien (client dpt dhcp route ke)
push "dhcp-options DNS 192.168.0.5"       # Push DNS server ke klien (clinent dpt ip dns)
push "dhcp-options DOMAIN harbas.com"     # Push domain DNS search ke klien (opsional)

ca /etc/openvpn/keys/ca.crt               # Sertifikat CA
cert /etc/openvpn/keys/vpn-harbas.crt     # Sertifikat server
key /etc/openvpn/keys/vpn-harbas.key      # Private key server
dh /etc/openvpn/keys/dh2048.pem           # Diffie-Hellman parameter
```

### Konfigurasi Firewall
```bash
firewall-cmd --permanent --add-service=openvpn
firewall-cmd --permanent --add-port=1194/udp
firewall-cmd --reload
```

### mengaktifkan OpenVPN Server
```bash
systemctl enable --now openvpn-server@server
systemctl restart openvpn-server@server
```

### Membuat File Konfigurasi Client
File: `client1.ovpn`

```ini
client
dev tun
proto udp
remote 192.168.80.x 1194
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
verb 3
remote-cert-tls server
<ca>
--- isi dengan file.ca
</ca>
<cert>
--- isi dengan file.cert
</cert>
<key>
--- isi dengan file.key
</key>
```

### Tag	Isi file dari Easy-RSA	Keterangan
- <ca>	pki/ca.crt	Sertifikat CA (Certificate Authority)
- <cert>	pki/issued/<client_name>.crt	Sertifikat client yang di-generate
- <key>	pki/private/<client_name>.key	Private key clien

---

## Konektivitas VPN Client Dapat Berjalan di Background
### Uji Coba VPN pada Windows
* Install OpenVPN
* Tambahkan file konfigurasi
* Jalankan OpenVPN

### Uji Coba VPN pada Linux (CLI)
```bash
apt install openvpn
sudo openvpn client1.ovp
```

<!-- ## Instalasi dan Konfigurasi OpenVPN pada VM Linux dengan Protokol Standar
    - installasi openvpn, dan membuat sertifikat server menggunakan easy-rsa 3.0 ✓
        - instalasi paket yang dibutuhkan
            - yum install epel-release
            - yum install openvpn easy-rsa
        - membuat directory easy-rsa pada /etc/openvpn, dan mengcopy template easy-rsa ke /etc/openvpn
            - mkdir /etc/openvpn/easy-rsa
            - cd /usr/share/easy-rsa/3.0.3
            - cp -rf * /etc/openvpn/easy-rsa/
        - membuat certificate untuk server
            - cd /etc/openvpn/easy-rsa
            - ./easyrsa init-pki
            - ./easyrsa build-ca
            - ./easyrsa gen-dh
            - ./easyrsa gen-req vpn-harbas nopass
            - ./easyrsa sign server vpn-harbas
        - membuat directory keys untuk tempat penyimpanan ca / certificate, dan meng copy certificate yang dibutuhkan
            - mkdir /etc/openvpn/keys
            - chmod 750 /etc/openvpn/keys/
            - cp -a /etc/openvpn/easy-rsa/pki/ca.crt /etc/openvpn/keys/
            - cp -a /etc/openvpn/easy-rsa/pki/dh.pem /etc/openvpn/keys/dh2048.pem
            - cp -a /etc/openvpn/easy-rsa/pki/issued/vpn-harbas.crt /etc/openvpn/keys/
            - cp -a /etc/openvpn/easy-rsa/pki/private/vpn-harbas.key /etc/openvpn/keys/
    - installasi openvpn, dan membuat sertifikat server menggunakan easy-rsa 2.0 ☓

## Membuat Sertifikat File Client
    - Membuat certificate File Client ✓
        - membuat certificate client
            - cd /etc/openvpn/easy-rsa
            - ./easyrsa gen-req client_window nopass
            - ./easyrsa sign client client_window
        - mengcopy certificate client ke keys
            - cp -a /etc/openvpn/easy-rsa/pki/issued/client_window.crt /etc/openvpn/client/
            - cp -a /etc/openvpn/easy-rsa/pki/private/client_window.key /etc/openvpn/client/
        - membuat konfigurasi server openvpn
            - vim /etc/openvpn/server.conf
                ```INI
                port 1194
                proto udp
                dev tun
                comp-lzo
                management 127.0.0.1 1194
                keepalive 10 120
                persist-key
                persist-tun
                verb 3
                server 127.16.16.0 255.255.255.255
                push "route 192.168.0.0 255.255.255.0"
                push "dhcp-options DNS 192.168.0.5"
                push "dhcp-options DOMAIN harbas.com"
                ca /etc/openvpn/keys/ca.crt
                cert /etc/openvpn/keys/vpn-harbas.crt
                key /etc/openvpn/keys/vpn-harbas.key
                dh /etc/openvpn/keys/dh2048.pem
                ```
        - konfigurasi firewall
            - firewall-cmd --permanent --add-service=openvpn
            - firewall-cmd --permanent --add-service=1194/udp
            - firewall-cmd --reload
        - membuat certificate client
            - nano client1.ovpn
                ```
                client
                dev tun
                proto udp
                remote 192.168.80.x 1194
                resolv-retry infinite
                nobind
                persist-key
                persist-tun
                comp-lzo
                verb 3
                remote-cert-tls server
                <ca>
                --- isi dengan file.ca
                </ca>
                <cert>
                --- isi dengan file.cert
                </cert>
                <key>
                --- isi dengan file.key
                </key>
                ```

## Konektifitas VPN Client dapat Berjalan di Background
    - uji coba vpn dengan file client pada windows menggunakan openvpn ✓
        - install openvpn in windows, add file vpn and run
    - uji coba vpn dengan file client pada linux menggunakan cli openvpn ✓
        - apt install openvpn
        - sudo openvpn client1.ovpn

## Uji Konektifitas OpenVP
- melakukan konektivitas dengan konfigurasi ip 10.10.10.0 ✓
- melakukan konektivitas dengan konfigurasi ip 127.16.16.0 (yang ini belum bisa ga tau kenapa kayaknya karena subnetmasknya salah) ☓ -->
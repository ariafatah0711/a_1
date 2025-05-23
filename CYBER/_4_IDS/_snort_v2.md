# centos 7 - snort v2
## Update Sistem & Install Dependencies
```bash
yum update -y
yum groupinstall "Development Tools" -y
yum install -y epel-release
yum install -y libpcap-devel pcre-devel libdnet-devel tcpdump \
    libnghttp2 libnghttp2-devel zlib zlib-devel \
    daq daq-devel \
    lua-devel openssl-devel \
    luajit luajit-devel \
    wget flex bison libuuid-devel
```

## Install libdnet Secara Manual (kalau error di repo)
```bash
cd /usr/src/
sudo wget https://github.com/ofalk/libdnet/archive/refs/heads/master.zip -O libdnet.zip
sudo unzip libdnet.zip
cd libdnet-*
./configure && make && sudo make install
```

## Download & Compile DAQ (Data Acquisition) Library
```bash
cd /usr/src/
sudo wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz
sudo tar -xvzf daq-2.0.7.tar.gz
cd daq-2.0.7
./configure && make && sudo make install
```

## Download & Install Snort
```bash
cd /usr/src/
sudo wget https://www.snort.org/downloads/snort/snort-2.9.20.tar.gz
sudo tar -xvzf snort-2.9.20.tar.gz
cd snort-2.9.20
./configure --enable-sourcefire && make && sudo make install

snort -V
```

## Buat Folder Konfigurasi
```bash
sudo mkdir -p /etc/snort/rules
sudo mkdir /var/log/snort
sudo mkdir /usr/local/lib/snort_dynamicrules
sudo touch /etc/snort/rules/white_list.rules
sudo touch /etc/snort/rules/black_list.rules
sudo touch /etc/snort/snort.conf
```

## test snort
```bash
# test configuration
snort -T -c /etc/snort/snort.conf

# run snort
snort -A console -q -c /etc/snort/snort.conf -i eth0

# vevrify log
cat /var/log/snort/alert
```

## Edit Konfigurasi /etc/snort/snort.conf
```bash

```

# rules
## Comunity Rules (OPSIONAL)
```bash
cd /etc/snort/rules
sudo wget https://www.snort.org/downloads/community/community-rules.tar.gz
sudo tar -xvzf community-rules.tar.gz
sudo cp community-rules/* .  # salin rule-nya ke /etc/snort/rules/
```

- [sql.rules snort_v2](./rules/snort_v2/sql.rules)
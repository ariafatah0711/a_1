# snort v3
- [docs epel-linux](https://www.redhat.com/en/blog/install-epel-linux)
- [docs-snort-v3](https://docs.snort.org/start/installation)

## install epel
```bash
dnf config-manager --set-enable crb # enable the CodeReady Linux Builder repository
sudo dnf install epel-release epel-next-release -y #  install the EPEL RPM.

yum update -y # opsional
```

## setup require packages
<!-- ```bash
# Cek apakah paket-paket berikut sudah terinstall
rpm -q cmake flex gcc-c++ openssl openssl-devel \
       libdnet libdnet-devel \
       hwloc hwloc-devel \
       luajit luajit-devel \
       libpcap libpcap-devel \
       pcre pcre-devel pcre2 pcre2-devel \
       pkgconfig zlib zlib-devel xz-devel \
       autoconf automake libtool | grep "not installed"

yum install git cmake flex g++ openssl openssl-devel -y
yum install libdnet libdnet-devel.x86_64 -y
yum install hwloc hwloc-devel.x86_64 -y
yum install luajit luajit-devel.x86_64 -y
yum install libpcap libpcap-devel.x86_64 -y
yum install pcre pcre-devel.x86_64 pcre2 pcre2-devel.x86_64 -y
yum install pkgconfig zlib zlib-devel xz-devel -y

yum install autoconf automake libtool -y # for libdaq
``` -->

```bash
# Cek apakah paket-paket berikut sudah terinstall
rpm -q cmake flex gcc-c++ openssl openssl-devel \
       libdnet libdnet-devel \
       hwloc hwloc-devel \
       luajit luajit-devel \
       libpcap libpcap-devel \
       pcre pcre-devel pcre2 pcre2-devel \
       pkgconfig zlib zlib-devel xz-devel \
       autoconf automake libtool \
    | grep "not installed"

# Install dependensi utama
yum install -y git cmake flex gcc-c++ openssl openssl-devel

# Install dependensi tambahan
yum install -y libdnet libdnet-devel
yum install -y hwloc hwloc-devel
yum install -y luajit luajit-devel
yum install -y libpcap libpcap-devel
yum install -y pcre pcre-devel pcre2 pcre2-devel
yum install -y pkgconfig zlib zlib-devel xz-devel

# Install tools autotools (untuk build libdaq, dsb)
yum install -y autoconf automake libtool
```

## Installing LibDAQ
```bash
git clone https://github.com/snort3/libdaq.git
cd libdaq
./bootstrap
./configure --prefix=/usr/local/lib/daq_s3
make install

# you must then run ldconfig to configure your system's dynamic linker run-time bindings. However, if you have installed the DAQ in a nonstandard location, you'll first need to tell your system where to find the new shared libraries. One common solution is to create a file in the /etc/ld.so.conf.d/ directory that points to where those libraries are located:
cat > /etc/ld.so.conf.d/libdaq3.conf << EOF
/usr/local/lib/daq_s3/lib/
EOF

ldconfig
```

## Building Snort
```bash
cd /opt
git clone https://github.com/snort3/snort3.git
export my_path=/usr/local/snort3
export PKG_CONFIG_PATH=/usr/local/lib/daq_s3/lib/pkgconfig:$PKG_CONFIG_PATH # fix error configure libdaq
pkg-config --modversion libdaq # fix error configure libdaq

mkdir -p $my_path
cd snort3
./configure_cmake.sh --prefix=$my_path \
--with-daq-includes=/usr/local/lib/daq_s3/include/ \
--with-daq-libraries=/usr/local/lib/daq_s3/lib/
# if installed have error ur need installing more depedency

cd build
make -j $(nproc)
make install
```

## check install
```bash
$my_path/bin/snort -V
$my_path/bin/snort --daq-list
# If, however, you get No available DAQ modules (try adding directories with --daq-dir)., then you will need to specify --daq-dir as the error points out:
$my_path/bin/snort --daq-dir /usr/local/lib/daq_s3/lib/daq --daq-list
```

## make link or alias
### make link
```bash
ln -s $my_path/bin/snort /usr/local/bin/snort
```

### alias sementara
```bash
# Alias sementara (berlaku hanya di session terminal aktif)
alias snort='$my_path/bin/snort --daq-dir /usr/local/lib/daq_s3/lib/daq'
```

### alias permanent
```bash
# Tambahkan alias ke ~/.bashrc agar permanen (otomatis aktif tiap buka terminal)
echo "alias snort='$my_path/bin/snort --daq-dir /usr/local/lib/daq_s3/lib/daq'" >> ~/.bashrc
# Terapkan langsung ke session sekarang
source ~/.bashrc
```

# rules
```bash
# sudo mkdir -p /etc/snort3
# sudo mkdir -p /etc/snort3/rules
# sudo mkdir -p /etc/snort3/so_rules
# sudo mkdir -p /etc/snort3/lists
# sudo mkdir -p /var/log/snort3
# sudo mkdir -p /usr/local/lib/snort3_dynamicengine
# sudo mkdir -p /usr/local/lib/snort3_dynamicrules

# cp /opt/snort3/lua/snort.lua /etc/snort3
# cp /opt/snort3/lua/snort_defaults.lua /etc/snort3

cd /opt/snort3/lua
echo "alert icmp any any -> any any (msg:"ICMP Echo Request Detected"; itype:8; sid:1000001; rev:1;)" > local.rules
vi snort.lua
###
ips =
{
    -- use this to enable decoder and inspector alerts
    --enable_builtin_rules = true,

    -- use include for rules files; be sure to set your path
    -- note that rules files can include other rules files
    -- (see also related path vars at the top of snort_defaults.lua)
    variables = default_variables,

    rules = [[
        include local.rules
    ]]
}
###

snort -T -c /opt/snort3/lua/snort.lua -i enp0s8
snort -A cmg -c snort.lua -i enp0s8

# ping anotehr device to ip centos

cat > local.rules << EOF
alert tcp any any -> any any (
    msg:"[Snort3] Nmap TCP SYN Scan Detected";
    flags:S;
    flow:stateless;
    detection_filter:track by_src, count 5, seconds 3;
    sid:1000010; 
    rev:1;
)

alert tcp any any -> any any (
    msg:"[Snort3] Nmap TCP NULL Scan Detected";
    flags:0;
    flow:stateless;
    sid:1000011;
    rev:1;
)

alert tcp any any -> any any (
    msg:"[Snort3] Nmap TCP Xmas Scan Detected";
    flags:FU;
    flow:stateless;
    sid:1000012;
    rev:1;
)

alert udp any any -> any any (
    msg:"[Snort3] Nmap UDP Scan Detected";
    flow:stateless;
    detection_filter:track by_src, count 10, seconds 5;
    sid:1000013;
    rev:1;
)
EOF

snort -A cmg -c snort.lua -i enp0s8
```

## sql rules
```bash
yum install podman
podman run --rm -itd --network host vulnerables/web-dvwa
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --reload

cat > sql.rules << EOF
alert http any any -> any any (
    msg:"[Snort3] SQL Injection Generic Attempt";
    pcre:"/('|%27)\s*or\s*1\s*=\s*1(\s|--|#|%23)*/i";
    flow:to_server,established;
    http_uri;
    sid:1000301;
    rev:1;
)

alert http any any -> any any (
    msg:"[Snort3] SQL Keyword 'UNION SELECT' Detected";
    pcre:"/union(\s+all)?\s+select/i";
    flow:to_server,established;
    http_uri;
    sid:1000302;
    rev:1;
)
EOF

vi snort.lua
###
    rules = [[
        include local.rules
        include sql.rules
    ]]
###

snort -T -c snort.lua -i enp0s8
snort -A cmg -c snort.lua -i enp0s8
```
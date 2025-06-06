# MODUL B INFRASTRUCTURE PROGRAMMABLE & AUTOMATION
## soal
- [soal.pdf](./LKS_PROVINSI_2024_ITNSA_MB_actual_en.pdf)
- [users.csv_sample](./workfolder/users.csv)
- [workfolder_sample](./workfolder/)

## topologi
![alt text](images/readme/image.png)

## configuration
### setup repository di LIN1, LIN2, dan BASTION
- sebelum configurasi repo, pastikan sudah bisa mengakses internet.
- ubah configuration repo debian 
  ```nano /etc/apt/sources.list```
  ```bash
  deb https://ftp.debian.org/debian/ bookworm contrib main non-free non-free-firmware
  deb https://ftp.debian.org/debian/ bookworm-updates contrib main non-free non-free-firmware
  deb https://security.debian.org/debian-security/ bookworm-security contrib main non-free non-free-firmware
  ```
  > configurasi debian ini tergantung dengan versi yang digunakan, dan url repo juga tergantung repo yang aktif. (bisa cari di google)
- setelah melakukan configursi tersebut pastikan bisa melakukan ```apt update```

### installasi ansible dan package pendukung di BASTION
```bash
# bastion
apt install pipx ansible sshpass curl
ansible -v
```

### setup openssh server pada LIN1, dan LIN2
- Instalasi OpenSSH Server di LIN1 dan LIN2
  ```bash
  apt install openssh-server net-tools
  ```
  > net-tools bersifat opsional, tapi berguna untuk mengecek port SSH (port 22) aktif dengan netstat -tulnp.
- Edit Konfigurasi sshd_config
  - Edit file konfigurasi OpenSSH:
    ```bash
    nano /etc/ssh/sshd_config
    ```
  - Cari baris:
    ```bash
    #PermitRootLogin prohibit-password
    ```
  - Ubah menjadi (jangan lupa hapus # di awal baris untuk mengaktifkan konfigurasi):
    ```bash
    PermitRootLogin yes
    ```
  - Default-nya, root login dilarang (atau hanya boleh dengan public key). 
    > Mengubah ke PermitRootLogin yes memperbolehkan login sebagai root via password (pastikan root punya password).
<!-- - mengaktifkan OpenSSH Server
  ```bash
  systemctl enable --now ssh
  ```
  > --now digunakan untuk melakukan enable sekaligus start -->
- melakukan restart OpenSSH Server jika ingin mengubah konfigurasi
  ```bash
  systemctl restart ssh
  ```

### setup openssh server pada WIN
- installasi windows
  - install windows di proxmox jan lupa untuk gunakan display **VMware compatible** karena kadang tidak muncul
- tambahkan user
  ```bash
  net user user P@ssw0rd /add
  net localgroup administrators user /add # add user to group administrator (make this user to privilages admin)

  # test login
  runas /user:user powershell
  exit
  ```
- Instalasi OpenSSH Server
  ```bash
  # Masuk ke PowerShell dari cmd
  powershell

  # Install fitur OpenSSH Server
  Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

  # Mulai dan aktifkan service agar otomatis jalan saat boot
  Start-Service sshd
  Set-Service -Name sshd -StartupType 'Automatic' # opsional

  # (Opsional) Cek status service
  Get-Service sshd
  ```
- Tambahkan rule firewall agar bisa akses dari luar
  ```bash
  # versi singkat
  New-NetFirewallRule -Name sshd -Protocol TCP -LocalPort 22 -Action Allow -DisplayName ssh
  ```
- mengubah shell default menjadi powershell
  ```bash
  Set-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Force

  ## atau
  notepad "C:\ProgramData\ssh\sshd_config"

  # tambahkan ini
  DefaultShell C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
  ```

## Ansible – Automation via SSH
### configurasi ansible aria generate by Chat GPT (opsional jika ingin cuma run aja)
- clone repository ini dan masuk ke ITNSA, modul B
  ```bash
  cd /tmp

  apt install git
  git clone https://github.com/ariafatah0711/a_1
  cd a_1

  cp -rf ITNSA/B/workfolder /home/user
  ```
- jika user / directory /home/user tidak ditemukan buat terlebih dahulu dengan menggunakan ```useradd user```, dan ```passwd user``` untuk mengubah password user (opsional)
- setelah melakukan clone masuk ke directory ```/home/user/workfolder```, dan jangan lupa ubah hosts menjadi ip yang sesuai dengan server yang ingin di konfig nantinya
  ```bash
  cd /home/user/workfolder
  nano hosts
  ## dan sesuaikan ip nya

  nano linux/2-dns-server.yml
  ## ubah dan sesuaikan
  dns_servers:
    - "10.0.10.11"
    - "10.0.10.12"
  
  nano linux/3-dns-client.yml
  ## ubah dan sesuaikan
  dns_servers:
    - "10.0.10.11"
    - "10.0.10.12"

  nano windows/3-dns-server.yml
  ## ubah dan sesuaikan
  vars:
    ip_dns: "10.0.10.20"        # IP DNS server (yang akan direkam di A record)
    hostname: "win"             # Nama host DNS (hostname server)

  nano windows/3-dns-client.yml
  ## ubah dan sesuaikan
  dns_servers:
      - "10.0.10.20"
      - "10.0.10.11"
  ```

### Test koneksi SSH dengan Ansible
```bash
# linux
ansible linux -i /home/user/workfolder/hosts -m ping

# windows
ansible windows -i /home/user/workfolder/hosts -m win_ping

# atau jika ingin menggunakan semua ip di inventory
# ansible all -i /home/user/workfolder/hosts -m ping
```
Penjelasan:
- **linux** → nama group host yang didefinisikan di file hosts.
- **all** → untuk semua host yang didefinisikan di file hosts.
- **-i** → menunjukkan path ke file inventory hosts.
- **-m ping** → menjalankan module ping Ansible (bukan ICMP, tapi tes koneksi & autentikasi via SSH).

### Menjalankan Playbook Ansible
```bash
# LIN*
ansible-playbook /home/user/workfolder/linux/1-hostname.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/linux/2-dns-server.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/linux/3-dns-client.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/linux/4-web-server.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/linux/5-users.yml -i /home/user/workfolder/hosts

# WIN
# ansible-galaxy collection install community.windows # need for windows module

ansible-playbook /home/user/workfolder/windows/1-hostname.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/windows/2-sec-log.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/windows/3-dns-client.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/windows/3-dns-server.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/windows/4-web-server.yml -i /home/user/workfolder/hosts
```
> Pastikan struktur direktori dan nama file sesuai.

## test configurasi LIN1, LIN2 (opsional)
```bash
# 1-hostname.yml
hostname # melihat apakah konfigurasi hostname sudah berhasil

# 2-dns-server.yml
systemctl status named # melihat service dns sudah berjalan
cat /etc/bind/zones/db.linux.com # melihat zone db linux.com

# 3-dns-client.yml
cat /etc/resolv.conf
nslookup linux.com
nslookup lin1.linux.com
nslookup lin2.linux.com

# 4-web-server.yml
apt install curl
curl lin1.linux.com # or use ip use the 10.1.10.11
curl lin2.linux.com # or use ip use the 10.1.10.12

# 5-users.yml
cat /etc/passwd
ls /home
```

## test configurasi WIN (opsional)
```bash
# 1-hostname.yml
hostname # sebelum mengecek ini coba reboot dulu karena hostname akan berubah setelah reboot

# 2-sec-log.yml
Get-Service TermService
Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections

# 3-dns-server.yml & 3-dns-client.yml 
ipconfig /all
### pastikan ip dns nya sesuai dengann ip dns WIN, dan LIN1
DNS Servers . . . . . . . . . . . : 10.0.10.20
                                    10.0.10.11
###
nslookup windows.com
nslookup www.windows.com
nslookup win.windows.com

# 4-web-server.yml
Get-Service W3SVC # check active web server service IIS
Invoke-WebRequest -Uri http://10.0.10.20 -UseBasicParsing # atau gunakan curl tapi di windows cadang curlnya ada errornya

## cek dari ansible atau host lain jika ingin menggunakan curl
curl 10.0.10.20 # sesuaikan saja ip nya sama ip windowsnya
```
# nama_soal
## topologi
![alt text](images/readme/image.png)

## configuration
### setup repository di LIN1, LIN2, dan BASTION
- sebelum configurasi repo, pastikan sudah bisa mengakses internet.
- ubah configuration repo debian 
  ```nano /etc/apt/sources.lists```
  ```bash
  deb https://ftp.debian.org/debian/ bookworm contrib main non-free non-free-firmware
  deb https://ftp.debian.org/debian/ bookworm-updates contrib main non-free non-free-firmware
  deb https://security.debian.org/debian-security/ bookworm-security contrib main non-free non-free-firmware
  ```
  > configurasi debian ini tergantung dengan versi yang digunakan, dan url repo juga tergantung repo yang aktif. (bisa cari di google)
- setelah melakukan configursi tersebut pastikan bisa melakukan apt update

### installasi ansible dan package pendukung di BASTION
```bash
# bastion
apt install pipx ansible sshpass curl
ansible -v
```

### setup openssh server pada LIN1, dan LIN2
- Instalasi OpenSSH Server di LIN1 dan LIN2
  ```bash
  sudo apt install openssh-server net-tools
  ```
  > net-tools bersifat opsional, tapi berguna untuk mengecek port SSH (port 22) aktif dengan netstat -tulnp.
- Edit Konfigurasi sshd_config
  - Edit file konfigurasi OpenSSH:
    ```bash
    sudo nano /etc/ssh/sshd_config
    ```
  - Cari baris:
    ```bash
    #PermitRootLogin prohibit-password
    ```
  - Ubah menjadi:
    ```bash
    PermitRootLogin yes
    ```
  > Default-nya, root login dilarang (atau hanya boleh dengan public key). 
  Mengubah ke PermitRootLogin yes memperbolehkan login sebagai root via password (pastikan root punya password).
- mengaktifkan OpenSSH Server
  ```bash
  sudo systemctl enable --now ssh
  ```
  > --now digunakan untuk melakukan enable sekaligus start
- melakukan restart OpenSSH Server jika ingin mengubah konfigurasi
  ```bash
  sudo systemctl restart ssh
  ```

### setup openssh server pada WIN
- lorem
  ```bash
  comming soon
  ```

## Ansible – Automation via SSH
### configurasi ansible aria generate by Chat GPT (opsional jika ingin cuma run aja)
- clone repository ini dan masuk ke ITNSA, modul B
  ```bash
  cd /tmp
  git clone https://github.com/ariafatah/a_1
  cd a_1

  cp -rf ITNSA/B/workfolder /home/user
  ```
- jika user / directory /home/user tidak ditemukan buat terlebih dahulu dengan menggunakan ```useradd user```, dan ```passwd user``` untuk mengubah password user (opsional)
- setelah melakukan clone masuk ke directory dengan perintah ```/home/user/workfolder```, dan jangan lupa ubah hosts menjadi ip yang sesuai dengan server yang ingin di konfig nantinya
  ```bash
  cd /home/user/workfolder
  nano hosts
  ## dan sesuaikan
  ```

### Test koneksi SSH dengan Ansible
```bash
ansible all -i /home/user/workfolder/hosts -m ping
```
Penjelasan:
- **all** → nama group host yang didefinisikan di file hosts. (jika menggunakan all akan melakukan ke semua host)
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
ansible-playbook /home/user/workfolder/windows/1-hostname.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/windows/2-sec-log.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/windows/3-dns-client.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/windows/3-dns-server.yml -i /home/user/workfolder/hosts
ansible-playbook /home/user/workfolder/windows/4-web-server.yml -i /home/user/workfolder/hosts

```
> Pastikan struktur direktori dan nama file sesuai.

---
<!-- 
## linux-bastion ( ansible )
```bash
## install ansible
apt install pipx ansible sshpass curl
git clone https://github.com/ariafatah0711/a_1
cd a_1

# test connection with ansible
ansible linux -i IT_NSA/workfolder/hosts -m ping

# use workfolder
ansible-playbook ITNSA/workfolder/linux/1-hostname.yml -i IT_NSA/workfolder/hosts
ansible-playbook ITNSA/workfolder/linux/2-dns-server.yml -i IT_NSA/workfolder/hosts
ansible-playbook ITNSA/workfolder/linux/3-dns-client.yml -i IT_NSA/workfolder/hosts
ansible-playbook ITNSA/workfolder/linux/4-web-server.yml -i IT_NSA/workfolder/hosts
ansible-playbook ITNSA/workfolder/linux/5-users.yml -i IT_NSA/workfolder/hosts
```

## linux debian
```bash
# setup repo
nano /etc/apt/sources.lists
###
deb https://ftp.debian.org/debian/ bookworm contrib main non-free non-free-firmware
deb https://ftp.debian.org/debian/ bookworm-updates contrib main non-free non-free-firmware
deb https://security.debian.org/debian-security/ bookworm-security contrib main non-free non-free-firmware
###

# setup sshd
apt install openssh-server curl net-tools
nano /etc/ssh/sshd_config
##
# ubah bagian permitrootlogin menjadi yes
##

systemctl enable --now ssh
```

## windows server
```bash
# none
``` -->
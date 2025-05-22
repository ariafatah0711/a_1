# linux debian
```bash
# setup repo
nano /etc/apt/sources.lists
###
deb https://ftp.debian.org/debian/ bookworm contrib main non-free non-free-firmware
deb https://ftp.debian.org/debian/ bookworm-updates contrib main non-free non-free-firmware
deb https://security. debian. org/debian-security/ bookworm-security contrib main non-free non-free-firmware
###

# setup sshd
apt install openssh-server curl net-tools
nano /etc/ssh/sshd_config
##
# ubah bagian permitrootlogin menjadi yes
##

systemctl enable --now ssh
```

# ansible
```bash
# setup repo
nano /etc/apt/sources.lists
###
deb https://ftp.debian.org/debian/ bookworm contrib main non-free non-free-firmware
deb https://ftp.debian.org/debian/ bookworm-updates contrib main non-free non-free-firmware
deb https://security. debian. org/debian-security/ bookworm-security contrib main non-free non-free-firmware
###

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
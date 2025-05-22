# linux debian
```bash
# setup repo

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

## install ansible
apt install pipx ansible sshpass curl
git clone https://github.com/ariafatah0711/a_1
cd a_1

# test connection with ansible
ansible linux -i IT_NSA/workfolder/hosts -m ping


```
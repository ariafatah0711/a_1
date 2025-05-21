# suricata
## Installation from EPEL
```bash
yum update

useradd suricata # opsional ya
passwd suricata # 123

yum -y install epel-release
yum install -y suricata
```

## update rules
```bash
suricata-update
```

## update interface
- gunakan perintah ```vi /etc/sysconfig/suricata``` untuk mengubah configurasi interface dan user
  ```INI
  OPTIONS="-i enp0s8 --user suricata "
  ```

## mengaktifkan suricata
```bash
systemctl enable --now suricata
systemctl status suricata


```



## mengubah configurasi suricata
- configurasi file lokasi suricata berada di path ```/etc/suricata/suricata.yaml```

## reload configuration
```bash
systemctl reload suricata
```

## mengubah rules
lokasi default rules suricata berada di path ```/var/lib/suricata/rules/suricata.rules```
```INI

```


# verifikasi menggunakan dvwa
```bash
yum install -y docker
docker run -d -p 8080:80 vulnerables/web-dvwa
```
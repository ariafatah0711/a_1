# setup
## install require app
- [debian_12_netinst.iso](#)
- [windows_server_2022_evaluation](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022)
- [vmware workstation pro](https://support.broadcom.com/group/ecx/downloads)

## create vm
- install vmware workstation pro (btw harus login dulu jika ingin download)
- siapkan iso windows server dan debian 12 nya
- buat 1 vm debian dan lakukan installasi sampai bisa kebuka setelah berhasil. shutdown vm
- clone vm debian menjadi 4 dan ubah namanya menjadi seperti ini
  ![alt text](images/0_setup_vm/image-1.png)
- setelah itu install vm windows server
  ![alt text](images/0_setup_vm/image-2.png)
  > jangan lupa ubah settinganya di options > advance > firmware type nya diubah menjadi BIOS

## setup network adaptor
- buat bridge dengan wireless atau adaptor lan biar bisa konek ke jaringan lokal di **virtual network editor**
  ![alt text](images/0_setup_vm/image.png)
- setelah itu atur network menjadi seperti ini
  - FW-UTARA 
    - network adaptor 1 = bridge (harus ubah dulu di network editor dan sesuaikan ke interface yang ingin di bridge)
      ![alt text](images/0_setup_vm/image-4.png)
    - network adaptor 2 = LAN_SEGMENT ( utara.site (192.168.10.0/24) )
       ![alt text](images/0_setup_vm/image-3.png)
  - LINSRV1
    - network adaptor 1 = LAN_SEGMEN ( utara.site (192.168.10.0/24) )
  - LINSRV2
    - network adaptor 1 = LAN_SEGMEN ( utara.site (192.168.10.0/24) )
  - FW-SELATAN
    - network adaptor 1 = bridge
    - network adaptor 2 = LAN_SEGMENT ( selatan.site (172.16.20.0/24) )
  - WINSRV
    - network adaptor 1 = LAN_SEGMENT ( selatan.site (172.16.20.0/24) )
- setelah setup network adaptor jangan lupa untuk melakukan snapshoot agar mempermudah jika ingin mencoba lagi

## setup hostname
- power on LINSRV1, LINSRV1, FW-UTARA, FW-SELATAN terlebih dahulu
- setelah itu coba ping FW ping internet jika sudah berarti sudah aman
- ubah hostname di tiap vm
  ```bash
  hostnamectl set-hostname <nama>
  ```
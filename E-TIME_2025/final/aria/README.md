# Point-Point Pengerjaan
1. Setiap Server Disetting IP Secara Statik
   ![alt text](images/README/image.png)
   ![alt text](images/README/image-1.png)
   ![alt text](images/README/image-2.png)
   ![alt text](images/README/image-3.png)

2. SW L3 DS1 Menjalankan HSRP Pada VLAN 10 dengan group number 110 dan nilai priority 110 dan DS2 Menjadi Backup dengan group number 105
3. SW L3 DS2 Menjalankan HSRP Pada VLAN 20 dengan group number 120 dan nilai priority 110 dan DS2 Menjadi Backup dengan group number 105
4. Gateway yang digunakan oleh server HTTP ialah 192.168.10.1
5. Gateway yang digunakan oleh server DNS ialah 192.168.20.1
6. Setiap Router di setting untuk syncron time dan calendar ke NTP Server
7. Pada Server FTP di Tapos dibuatkan user dengan nama ali dan password 123 yang memiliki permission RWNL
8. Pada switch cipayung menjalankan spanning tree mode rapid pvst+ dengan ketentuan root bridge berada di SW_CIPAYUNG_1 baik vlan 40 dan 200
9. SW_CIPAYUNG_1 terdapat po1 mengarah SW_CIPAYUNG_2 dengan mode active
10. SW_CIPAYUNG_1 terdapat po2 mengarah SW_CIPAYUNG_3 dengan mode auto
11. SW_CIPAYUNG_2 terdapat po1 mengarah SW_CIPAYUNG_1 dengan mode passive
12. SW_CIPAYUNG_3 terdapat po1 mengarah SW_CIPAYUNG_1 dengan mode dessireble
13. Pada SW_CIMANGGIS_1 menjalankan spanning tree mode pvst dengan ketentuan root bridge berada di SW_CIMANSW_CIMANGGIS_1 GGIS_1 baik vlan 50 dan 100
14. terdapat po1 mengarah SW_CIMANGGIS_2 dengan mode active
15. SW_CIMANGGIS_1 terdapat po2 mengarah SW_CIMANGGIS_3 dengan mode auto
16. SW_CIMANGGIS_2 terdapat po1 mengarah SW_CIMANGGIS_1 dengan mode active
17. SW_CIMANGGIS_3 terdapat po1 mengarah SW_CIMANGGIS_1 dengan mode dessireble
18. Pada layanan VOIP Baik Bojongsari dan juga Tapos dapat berkomunikasi antar server VOIP
19. Pada layanan VOIP Baik Bojongsari dan juga Tapos ephone-dn berjumlah 5
20. Pada Router CIPAYUNG merupakan backbone router yang menjalankan resdistribusi routing

# debug
```bash
show ip interface brief | exclude unassigned
```
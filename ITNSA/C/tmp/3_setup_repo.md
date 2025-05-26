### Cara Setting Repository Debian Menggunakan DVD ISO

---

#### 1. **Masukkan DVD Debian atau Mount ISO**

* Jika menggunakan **DVD fisik**, masukkan ke drive DVD.
* Jika menggunakan **file ISO**, mount ke direktori, contoh:

```bash
sudo mkdir /media/debian
sudo mount -o loop /path/to/debian-dvd.iso /media/debian

# atau
sudo mount /dev/<sr0> /media/debian
```

> Ganti `/path/to/debian-dvd.iso` dengan lokasi file ISO milikmu.

---

#### 2. **Edit file `sources.list`**

Backup file lama:

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
```

Edit file:

```bash
sudo nano /etc/apt/sources.list
```

Hapus atau beri komentar (`#`) pada baris repo online. Tambahkan baris ini:

```
deb [trusted=yes] file:/media/debian/ bookworm main contrib
```

> * Ganti `bookworm` sesuai versi Debian kamu (misal: `bullseye`, `buster`, dll).
> * `trusted=yes` menghindari verifikasi GPG.

---

#### 3. **Update Repository**

```bash
sudo apt update
```

Jika sukses, Debian akan membaca paket dari ISO tersebut.

---

#### 4. **(Opsional) Tambahkan DVD Lainnya**

Jika memiliki lebih dari satu DVD ISO:

* Mount ISO DVD2:

```bash
sudo mkdir /media/debian2
sudo mount -o loop /path/to/debian-dvd2.iso /media/debian2

# atau
sudo mount /dev/<sr0> /media/debian
```

* Tambahkan ke `sources.list`:

```
deb [trusted=yes] file:/media/debian2/ bookworm main contrib
```

Atau gunakan:

```bash
sudo apt-cdrom add
```

---

### Catatan:

* Gunakan DVD ISO yang cocok dengan versi Debian.
* Beberapa paket membutuhkan DVD lainnya untuk dependensi.
* Pastikan ISO tetap ter-mount saat digunakan.

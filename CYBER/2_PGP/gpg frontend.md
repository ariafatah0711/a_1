Berikut adalah panduan lengkap menggunakan **GpgFrontend** untuk:

1. Membuat kunci
2. Mengenkripsi pesan
3. Mengekspor kunci dengan opsi *Include Secret Key*
4. Mendekripsi pesan
5. Menandatangani dan memverifikasi pesan

---

## 🔐 1. Membuat Kunci

1. **Buka GpgFrontend**.
2. Klik menu **"Key Management"** atau ikon kunci.
3. Pilih **"Generate Key Pair"**.
4. Isi informasi berikut:

   * **Name**: Nama lengkap Anda.
   * **Email**: Alamat email Anda.
   * **Passphrase**: Kata sandi untuk melindungi kunci pribadi Anda.
5. Klik **"Generate"** dan tunggu proses selesai.

> 💡 *Tip*: Gunakan passphrase yang kuat untuk melindungi kunci pribadi Anda.

---

## ✉️ 2. Mengenkripsi Pesan

1. Buka tab **"Encrypt"**.
2. Pilih file atau ketik pesan yang ingin dienkripsi.
3. Pilih penerima dengan memilih kunci publik mereka.
4. Klik **"Encrypt"**.
5. Simpan file terenkripsi yang dihasilkan.

> 🔐 *Catatan*: Hanya penerima yang memiliki kunci pribadi yang sesuai yang dapat mendekripsi pesan tersebut.

---

## 📦 3. Mengekspor Kunci dengan Opsi *Include Secret Key*

1. Buka **"Key Management"**.
2. Pilih kunci yang ingin diekspor.
3. Klik **"Export Key"**.
4. Centang opsi:

   * **"Include Secret Key"**: Untuk menyertakan kunci pribadi.
   * **"Exclude keys that do not have a private key"**: Untuk mengecualikan kunci yang tidak memiliki kunci pribadi.
5. Tentukan lokasi penyimpanan dan nama file.
6. Klik **"OK"** untuk mengekspor.

> ⚠️ *Penting*: Hanya ekspor kunci pribadi jika Anda memerlukan cadangan atau akan memindahkannya ke perangkat lain. Jaga file ini dengan aman.

---

## 🔓 4. Mendekripsi Pesan

1. Buka tab **"Decrypt"**.
2. Pilih file terenkripsi yang ingin didekripsi.
3. Klik **"Decrypt"**.
4. Masukkan passphrase jika diminta.
5. File asli akan ditampilkan atau disimpan sesuai pengaturan.

> 🔐 *Catatan*: Pastikan kunci pribadi Anda tersedia di keyring untuk dapat mendekripsi pesan.

---

## ✍️ 5. Menandatangani dan Memverifikasi Pesan

### Menandatangani Pesan:

1. Buka tab **"Sign"**.
2. Pilih file atau ketik pesan yang ingin ditandatangani.
3. Pilih kunci pribadi Anda.
4. Klik **"Sign"**.
5. Simpan file yang telah ditandatangani.

### Memverifikasi Tanda Tangan:

1. Buka tab **"Verify"**.
2. Pilih file yang ditandatangani.
3. Klik **"Verify"**.
4. GpgFrontend akan menampilkan hasil verifikasi dan informasi tentang penandatangan.

> ✅ *Catatan*: Verifikasi tanda tangan memastikan bahwa pesan berasal dari pengirim yang sah dan belum diubah.

---

Jika Anda memerlukan bantuan lebih lanjut atau memiliki pertanyaan spesifik, silakan tanyakan!
# GPG CLI Cheat Sheet

## Instalasi
```bash
sudo apt install gnupg
```

## Generate Key
```bash
gpg --full-generate-key
```

## Melihat Daftar Key
```bash
gpg --list-keys          # Melihat public keys
gpg --list-secret-keys   # Melihat private keys
```

## Menghapus Key
```bash
gpg --delete-secret-keys harbas@gmail.com
```

---

## Enkripsi & Dekripsi File

### Contoh Persiapan File
```bash
echo "pesan rahasia" > file.txt
```

### Hanya Enkripsi
```bash
gpg -e -r harbas@gmail.com file.txt
rm file.txt  # Hapus file asli setelah dienkripsi
```

### Dekripsi
```bash
gpg -d file.txt.gpg -o out
```

---

## Signing (Tanda Tangan Digital)

### Hanya Sign
```bash
gpg -s -r harbas@gmail.com file.txt
```

### Verifikasi Tanda Tangan
```bash
gpg -v file.txt.gpg
```

### Sign dan Encrypt sekaligus
```bash
gpg -se -r harbas@gmail.com file.txt
```

---

## Export dan Import Key

### Export Key
```bash
gpg --export harbas@gmail.com > pub.asc
gpg --export-secret-key harbas@gmail.com > priv.asc
```

### Import Key
```bash
gpg --import pub.asc

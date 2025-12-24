# 🏛️ Aplikasi Web Pengajuan Dokumen Warga Digital (E-Kelurahan)

[![GitHub repo size](https://img.shields.io/github/repo-size/BintangDwiImamDermawan/pbl?color=blue)](https://github.com/BintangDwiImamDermawan/pbl)
[![GitHub contributors](https://img.shields.io/github/contributors/BintangDwiImamDermawan/pbl?color=green)](https://github.com/BintangDwiImamDermawan/pbl)

Aplikasi berbasis web yang dirancang untuk memodernisasi layanan administrasi di tingkat **Kelurahan**. Dengan sistem ini, warga dapat mengajukan berbagai surat keterangan secara daring tanpa perlu mengantre di kantor kelurahan, menjadikannya lebih efektif dan efisien dari segi waktu.

---

## 🌟 Fitur Utama

* **Pengajuan Mandiri:** Warga dapat mengisi formulir dan mengunggah dokumen pendukung secara digital.
* **Beragam Jenis Dokumen:** Mendukung pembuatan berbagai surat keterangan:
    * Surat Keterangan Usaha (SKU)
    * Surat Keterangan Pindah Domisili
    * Surat Keterangan Kepemilikan Rumah
    * Surat Keterangan Kematian
    * Surat Keterangan Tidak Mampu (SKTM)
* **Verifikasi Petugas:** Sistem manajemen bagi petugas kelurahan untuk memeriksa kelengkapan data secara real-time.
* **E-Output (PDF):** Setelah dokumen diverifikasi dan disetujui, warga diberikan akses untuk mengunduh dan mencetak dokumen dalam format PDF secara mandiri.

---

## 🛠️ Alur Kerja Sistem

1.  **Input:** Warga memilih jenis surat dan mengisi data serta lampiran dokumen.
2.  **Review:** Petugas menerima notifikasi pengajuan dan melakukan pengecekan validitas data.
3.  **Approval:** Jika data sesuai, petugas menyetujui pengajuan.
4.  **Output:** Warga mendapatkan akses unduh file PDF yang sudah diproses.

---

## 👥 Anggota Tim PBL-TRPL-104-B4
Terima kasih kepada seluruh anggota tim yang telah berkontribusi dalam pengembangan projek ini:

<table align="center">
  <tr>
    <td align="center">
      <a href="https://github.com/BintangDwiImamDermawan">
        <img src="https://github.com/BintangDwiImamDermawan.png" width="100px;" alt="Bintang Dwi Imam Dermawan"/><br />
        <sub><b>Bintang Dwi Imam D.</b></sub>
      </a>
    </td>
    <td align="center">
        <a href="https://github.com/humayra19">
        <img src="https://github.com/humayra19.png" width="100px;" alt="Devika Humayra"/><br />
        <sub><b>Devika Humayra</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/fajpras">
        <img src="https://github.com/fajpras.png" width="100px;" alt="Fajpras"/><br />
        <sub><b>Fajri Pras</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/swandyxtry-glitch">
        <img src="https://github.com/swandyxtry-glitch.png" width="100px;" alt="Swandy"/><br />
        <sub><b>Swandy</b></sub>
      </a>
    </td>
        <td align="center">
      <a href="https://github.com/achel-silitonga">
        <img src="https://github.com/achel-silitonga.png" width="100px;" alt="Achel"/><br />
        <sub><b>Achel</b></sub>
      </a>
    </td>
  </tr>
</table>



## 🛠️ Teknologi yang Digunakan
* **Language:** [PHP, CSS Bootstrap, JavaScript]
* **Database:** [MySQL]

---
# 🚀 Project Dashboard

Selamat datang di repositori ini! Di bawah ini adalah statistik aktivitas terbaru dan kontributor utama.

## 📊 Status Repositori

| Detail | Status |
| :--- | :--- |
| **Last Commit** | ![GitHub last commit](https://img.shields.io/github/last-commit/BintangDwiImamDermawan/pbl?style=flat-square) |
| **Total Files** | ![GitHub repo size](https://img.shields.io/github/repo-size/BintangDwiImamDermawan/pbl?style=flat-square) |
| **Open Issues** | ![GitHub issues](https://img.shields.io/github/issues/BintangDwiImamDermawan/pbl?style=flat-square) |


---

## 🏆 Top Contributors

<a href="https://github.com/BintangDwiImamDermawan/pbl/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=BintangDwiImamDermawan/pbl" />
</a>

> Klik pada foto untuk melihat detail profil.


## ⚙️ Cara Instalasi
1. Clone repositori ini:
   ```bash
   git clone https://github.com/BintangDwiImamDermawan/pbl.git

2. Buat file koneksi didalam file
    ```mermaid
    buat file dengan nama conn.php 

    /pbl/ 
      └─config/
          └─conn.php

3. Koneksi
    ```bash
    <?php
    $db = 'pbl';
    $user = 'root';
    $host = 'localhost';
    $pass = '';
    $conn = mysqli_connect($host, $user, $pass, $db);
    ?>
   


-- 1. Buat Database
CREATE DATABASE IF NOT EXISTS `pbl`;
USE `pbl`;

-- Matikan pengecekan foreign key agar proses pembuatan lancar
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------
-- Tabel Admin
-- --------------------------------------------------------
CREATE TABLE `admin` (
  `id_admin` int NOT NULL AUTO_INCREMENT,
  `nama_admin` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id_admin`)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Tabel Warga (Harus dibuat sebelum data_diri)
-- --------------------------------------------------------
CREATE TABLE `warga` (
  `id_warga` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status_data_diri` int DEFAULT NULL,
  PRIMARY KEY (`id_warga`),
  UNIQUE KEY `email` (`email`),
  KEY `nama` (`nama`)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Tabel Petugas (Harus dibuat sebelum data_diri_petugas)
-- --------------------------------------------------------
CREATE TABLE `petugas` (
  `id_petugas` int NOT NULL AUTO_INCREMENT,
  `nama_petugas` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password_petugas` varchar(255) NOT NULL,
  PRIMARY KEY (`id_petugas`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Tabel Data Diri
-- --------------------------------------------------------
CREATE TABLE `data_diri` (
  `nik` varchar(30) NOT NULL,
  `id_warga` int UNSIGNED NOT NULL,
  `nama_lengkap` varchar(30) NOT NULL,
  `foto_profil` varchar(255) DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `agama` varchar(50) NOT NULL,
  `tempat_lahir` varchar(30) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` varchar(10) NOT NULL,
  `pekerjaan` varchar(30) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `provinsi` varchar(30) NOT NULL,
  `kabupaten` varchar(30) NOT NULL,
  `kecamatan` varchar(40) NOT NULL,
  `kelurahan` varchar(40) NOT NULL,
  PRIMARY KEY (`nik`),
  UNIQUE KEY `id_warga` (`id_warga`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `fk_data_diri_warga` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Tabel Data Diri Petugas
-- --------------------------------------------------------
CREATE TABLE `data_diri_petugas` (
  `id_data_diri` int NOT NULL AUTO_INCREMENT,
  `id_petugas` int NOT NULL,
  `nama_lengkap` varchar(30) NOT NULL,
  `nomor` varchar(20) NOT NULL,
  `foto_profil` varchar(255) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `tempat_lahir` varchar(30) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` varchar(30) NOT NULL,
  PRIMARY KEY (`id_data_diri`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `fk_petugas_diri` FOREIGN KEY (`id_petugas`) REFERENCES `petugas` (`id_petugas`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Tabel Dokumen Domisili
-- --------------------------------------------------------
CREATE TABLE `dokumen_domisili` (
  `id_surat` int NOT NULL AUTO_INCREMENT,
  `nik` varchar(30) NOT NULL,
  `nama_lengkap` varchar(30) NOT NULL,
  `agama` varchar(30) NOT NULL,
  `pekerjaan` varchar(30) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `foto_surat_pengantar` mediumblob NOT NULL,
  `foto_kk` mediumblob NOT NULL,
  `foto_pas` mediumblob,
  PRIMARY KEY (`id_surat`),
  CONSTRAINT `fk_domisili_nik` FOREIGN KEY (`nik`) REFERENCES `data_diri` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Tabel Dokumen Izin Usaha
-- --------------------------------------------------------
CREATE TABLE `dokumen_izin_usaha` (
  `id_surat` int NOT NULL AUTO_INCREMENT,
  `nik` varchar(30) NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `nama_kbli` varchar(255) NOT NULL,
  `nomor_kbli` varchar(30) NOT NULL,
  `kecamatan` varchar(30) NOT NULL,
  `desa` varchar(30) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `foto_npwp` mediumblob NOT NULL,
  `foto_pengantar` mediumblob NOT NULL,
  `foto_kk` mediumblob NOT NULL,
  `foto_ktp` mediumblob NOT NULL,
  `foto_surat_domisili` mediumblob NOT NULL,
  `foto_bukti` mediumblob NOT NULL,
  PRIMARY KEY (`id_surat`),
  CONSTRAINT `fk_usaha_nik` FOREIGN KEY (`nik`) REFERENCES `data_diri` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------
-- Tabel Dokumens (Log Status Pelayanan)
-- --------------------------------------------------------
CREATE TABLE `dokumens` (
  `id_dokumen` int NOT NULL AUTO_INCREMENT,
  `id_warga` int UNSIGNED NOT NULL,
  `id_petugas` int DEFAULT NULL,
  `id_surat` int DEFAULT NULL,
  `nama_dokumen` varchar(30) NOT NULL,
  `nama_warga` varchar(30) NOT NULL,
  `tanggal` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(30) DEFAULT NULL,
  `nama_petugas` varchar(50) DEFAULT NULL,
  `komentar` text,
  `pada` datetime DEFAULT NULL,
  PRIMARY KEY (`id_dokumen`),
  CONSTRAINT `fk_dokumens_warga` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_dokumens_petugas` FOREIGN KEY (`id_petugas`) REFERENCES `petugas` (`id_petugas`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Nyalakan kembali pengecekan foreign key
SET FOREIGN_KEY_CHECKS = 1;
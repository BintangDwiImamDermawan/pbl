SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";
SET FOREIGN_KEY_CHECKS = 0; -- Mematikan pengecekan relasi agar tidak error

-- 1. Buat Database
CREATE DATABASE IF NOT EXISTS `pbl` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pbl`;

-- --------------------------------------------------------
-- Tabel Admin
-- --------------------------------------------------------
CREATE TABLE `admin` (
  `id_admin` int NOT NULL AUTO_INCREMENT,
  `nama_admin` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabel Warga (Master)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabel Petugas (Master)
-- --------------------------------------------------------
CREATE TABLE `petugas` (
  `id_petugas` int NOT NULL AUTO_INCREMENT,
  `nama_petugas` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password_petugas` varchar(255) NOT NULL,
  PRIMARY KEY (`id_petugas`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  KEY `id_petugas` (`id_petugas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabel Dokumens (Log Antrean)
-- --------------------------------------------------------
CREATE TABLE `dokumens` (
  `id_dokumen` int NOT NULL AUTO_INCREMENT,
  `nama_dokumen` varchar(30) NOT NULL,
  `id_warga` int UNSIGNED NOT NULL,
  `nama_warga` varchar(30) NOT NULL,
  `tanggal` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_surat` int DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `id_petugas` int DEFAULT NULL,
  `nama_petugas` varchar(50) DEFAULT NULL,
  `komentar` text,
  `pada` datetime DEFAULT NULL,
  PRIMARY KEY (`id_dokumen`),
  KEY `id_petugas` (`id_petugas`),
  KEY `id_warga` (`id_warga`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  UNIQUE KEY `nik` (`nik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  UNIQUE KEY `nik` (`nik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabel Dokumen Rumah
-- --------------------------------------------------------
CREATE TABLE `dokumen_rumah` (
  `id_surat` int NOT NULL AUTO_INCREMENT,
  `nik` varchar(30) NOT NULL,
  `nama_lengkap` varchar(50) NOT NULL,
  `kecamatan` varchar(50) NOT NULL,
  `desa` varchar(50) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `foto_sertifikat` mediumblob NOT NULL,
  `foto_akta_mendirikan` mediumblob NOT NULL,
  `foto_kk` mediumblob NOT NULL,
  `foto_ktp` mediumblob NOT NULL,
  `foto_BPPBB` mediumblob NOT NULL,
  `foto_surat_tidak_sengketa` mediumblob NOT NULL,
  PRIMARY KEY (`id_surat`),
  UNIQUE KEY `nik` (`nik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabel Dokumen SKK (Kematian)
-- --------------------------------------------------------
CREATE TABLE `dokumen_skk` (
  `id_surat` int NOT NULL AUTO_INCREMENT,
  `nama_lengkap` varchar(30) NOT NULL,
  `nik` varchar(30) NOT NULL,
  `jenis_kelamin` varchar(30) NOT NULL,
  `pekerjaan` varchar(30) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `penyebab` varchar(50) NOT NULL,
  `tanggal_kematian` date NOT NULL,
  `foto_surat_RS` mediumblob NOT NULL,
  `foto_ktp_pelapor` mediumblob NOT NULL,
  `foto_surat_pengantar` mediumblob NOT NULL,
  `foto_akte_nikah` mediumblob,
  PRIMARY KEY (`id_surat`),
  UNIQUE KEY `nik` (`nik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabel Dokumen SKTM
-- --------------------------------------------------------
CREATE TABLE `dokumen_sktm` (
  `id_surat` int NOT NULL AUTO_INCREMENT,
  `nik` varchar(30) NOT NULL,
  `nama_lengkap` varchar(50) NOT NULL,
  `agama` varchar(30) NOT NULL,
  `pekerjaan` varchar(40) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `foto_persetujuan` mediumblob NOT NULL,
  `foto_rumah` mediumblob NOT NULL,
  `foto_kk` mediumblob NOT NULL,
  `foto_slip_gaji` mediumblob NOT NULL,
  `foto_tagihan` mediumblob NOT NULL,
  PRIMARY KEY (`id_surat`),
  UNIQUE KEY `nik` (`nik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Menambahkan Constraint (Foreign Key)
-- --------------------------------------------------------

ALTER TABLE `data_diri`
  ADD CONSTRAINT `data_diri_ibfk_1` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `data_diri_petugas`
  ADD CONSTRAINT `data_diri_petugas_ibfk_1` FOREIGN KEY (`id_petugas`) REFERENCES `petugas` (`id_petugas`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dokumens`
  ADD CONSTRAINT `dokumens_ibfk_10` FOREIGN KEY (`id_warga`) REFERENCES `warga` (`id_warga`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dokumens_ibfk_9` FOREIGN KEY (`id_petugas`) REFERENCES `petugas` (`id_petugas`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `dokumen_domisili`
  ADD CONSTRAINT `dokumen_domisili_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `data_diri` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dokumen_izin_usaha`
  ADD CONSTRAINT `dokumen_izin_usaha_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `data_diri` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dokumen_rumah`
  ADD CONSTRAINT `dokumen_rumah_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `data_diri` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dokumen_sktm`
  ADD CONSTRAINT `dokumen_sktm_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `data_diri` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE;

SET FOREIGN_KEY_CHECKS = 1; -- Hidupkan kembali pengecekan
COMMIT;
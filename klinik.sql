-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 06, 2021 at 05:37 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `klinik`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cari_tindakan` (IN `p_tindakan_nama` VARCHAR(50))  begin
SELECT * FROM klinik.tindakan
where tindakan.tindakan_nama like CONCAT('%',p_tindakan_nama, '%');
SELECT p_tindakan_nama;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_coba` (IN `p_nama` VARCHAR(50))  begin
declare hitung int;
SET hitung =(
SELECT COUNT(*) 
FROM klinik.pasien 
WHERE pasien.pasien_nama
like p_nama 
    );
	if hitung > 0 THEN 
	begin
		select hitung;
        /*select p_nama;
        select * from pasien;*/
	end;
	else
		INSERT INTO `klinik`.`tindakan` (`tindakan_nama`) VALUES (p_nama);
		select * from pasien;
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_admin` (`p_nama` VARCHAR(45))  begin
declare hitung int;
SET hitung =(
SELECT COUNT(*) 
FROM klinik.admin
WHERE admin.nama
like p_nama 
    );
	if hitung > 0 THEN 
	begin
    select p_nama;
		select hitung;
    select * from admin;
	end;
	else
	INSERT INTO `klinik`.`admin` (`nama`) VALUES (p_nama);
	select*from admin;
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_dokter` (`p_nama` VARCHAR(45))  BEGIN
INSERT INTO `klinik`.`dokter` (`nama`) VALUES (p_nama);
select*from dokter;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_kasir` (`p_nama` VARCHAR(45))  BEGIN
INSERT INTO `klinik`.`kasir` (`nama`) VALUES (p_nama);
select*from kasir;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_kasirr` (`p_nama` VARCHAR(45))  BEGIN
INSERT INTO `klinik`.`kasir` (`nama`) VALUES (p_nama);
select*from kasir;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_obat` (`p_nama` VARCHAR(45))  BEGIN
INSERT INTO klinik.obat (obat_nama) VALUES (p_nama);
select * from obat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_pasien` (`p_nama` VARCHAR(45))  BEGIN
INSERT INTO `klinik`.`pasien` (`pasien_nama`) VALUES (p_nama);
select*from pasien;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_visit` (`p_dokter_id` INT, `p_kasir_id` INT, `p_pasien_id` INT)  BEGIN
INSERT INTO `klinik`.`visit` (`dokter_id`, `kasir_id`, `pasien_id`) VALUES (p_dokter_id  , p_kasir_id  , p_pasien_id);
select * from visit;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_new_pasien` (IN `p_nama` VARCHAR(50))  begin
declare hitung int;
SET hitung =(
SELECT COUNT(*) 
FROM klinik.pasien 
WHERE pasien.pasien_nama
like p_nama 
    );
	if hitung > 0 THEN 
	begin
		select p_nama;
		select hitung;
        select * from pasien;
	end;
	else
		INSERT INTO `klinik`.`tindakan` (`tindakan_nama`) VALUES (p_nama);
		select * from pasien;
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_new_tindakan` (IN `p_tindakan_nama` VARCHAR(50))  begin
declare hitung int;
SET hitung =(
SELECT COUNT(*) 
FROM klinik.tindakan 
WHERE tindakan.tindakan_nama
like p_tindakan_nama 
    );
	if hitung > 0 THEN 
	begin
    select p_tindakan_nama;
		select hitung;
        select * from tindakan;
	end;
	else
		INSERT INTO `klinik`.`tindakan` (`tindakan_nama`) VALUES (p_tindakan_nama);
		select * from tindakan;
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `total_procedure_db` ()  SELECT COUNT(*) ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE="PROCEDURE" 
AND ROUTINE_SCHEMA="k2"$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cari_pasien` (`p_nama` VARCHAR(50)) RETURNS VARCHAR(50) CHARSET utf8mb4 BEGIN
	DECLARE pesan varchar(50);
	set pesan =p_nama;
	if exists(
    select * from pasien where pasien.pasien_nama=p_nama
    )then
		begin
			set pesan='sukses';
		end;
	else 
		begin
			set pesan=CONCAT('pasien: ',p_nama, ' tidak ditemukan');
		end;
	END if; 
	RETURN pesan;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `alergi`
--

CREATE TABLE `alergi` (
  `id` int(11) NOT NULL,
  `pasien_id` int(11) DEFAULT NULL,
  `alergi_nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `antrean_admin`
--

CREATE TABLE `antrean_admin` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status_antrean` enum('buka','tutup') DEFAULT NULL,
  `antrean_sekarang` int(11) DEFAULT NULL,
  `antrean_terakhir` int(11) NOT NULL,
  `batas_antrean` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `antrean_admin`
--

INSERT INTO `antrean_admin` (`id`, `user_id`, `status_antrean`, `antrean_sekarang`, `antrean_terakhir`, `batas_antrean`) VALUES
(1, 1, 'buka', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `apoteker`
--

CREATE TABLE `apoteker` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `tlp` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `apoteker`
--

INSERT INTO `apoteker` (`id`, `user_id`, `nama`, `alamat`, `tlp`) VALUES
(1, 6, 'apoteker', 'jl apoteker', '0811122233456');

-- --------------------------------------------------------

--
-- Table structure for table `daftar_akun`
--

CREATE TABLE `daftar_akun` (
  `id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `dftr_akun_has_penjurnalan`
--

CREATE TABLE `dftr_akun_has_penjurnalan` (
  `penjurnalan_id` int(11) DEFAULT NULL,
  `daftar_akun_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `dokter`
--

CREATE TABLE `dokter` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `dr_nama` varchar(50) DEFAULT NULL,
  `spesialis` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='	' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kasir`
--

CREATE TABLE `kasir` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `tlp` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `komentar`
--

CREATE TABLE `komentar` (
  `id` int(11) NOT NULL,
  `user_klinik_id` int(11) DEFAULT NULL,
  `order_obat_id` int(11) DEFAULT NULL,
  `komentar` varchar(5000) DEFAULT NULL,
  `tgl_komentar` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `nota_penjualan`
--

CREATE TABLE `nota_penjualan` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT 'user id dari kasir yg menjualkan',
  `visit_id` int(11) DEFAULT NULL,
  `resep_apoteker_id` int(11) DEFAULT NULL,
  `tgl_transaksi` timestamp NULL DEFAULT NULL,
  `total_harga` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nota_penjualan`
--

INSERT INTO `nota_penjualan` (`id`, `user_id`, `visit_id`, `resep_apoteker_id`, `tgl_transaksi`, `total_harga`) VALUES
(1, 7, 1, 1, '2021-09-30 17:00:00', '5000'),
(2, 7, 1, 1, '2021-10-01 17:00:00', '5000'),
(3, 7, 1, 1, '2021-10-01 17:00:00', '5000');

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `id` int(11) NOT NULL,
  `order_obat_id` int(11) DEFAULT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `kadaluarsa` timestamp NULL DEFAULT NULL,
  `harga_jual` varchar(45) DEFAULT NULL,
  `harga_beli` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id`, `order_obat_id`, `nama`, `stok`, `kadaluarsa`, `harga_jual`, `harga_beli`) VALUES
(7, 0, 'obat 1', 10, '2021-10-01 08:05:48', '1000', NULL),
(8, 0, 'obat 2', 10, '2021-10-01 08:05:48', '2000', NULL),
(9, 0, 'obat 1', 10, '2021-09-02 08:05:48', '3000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_obat`
--

CREATE TABLE `order_obat` (
  `id` int(11) NOT NULL,
  `user_klinik_id` int(11) DEFAULT NULL,
  `tgl_transaksi` timestamp NULL DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `no_rekam_medis` varchar(45) DEFAULT NULL,
  `NIK` varchar(45) DEFAULT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `tgl_lahir` datetime DEFAULT NULL,
  `kelamin` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `golongan_darah` varchar(5) DEFAULT NULL,
  `alamat` varchar(1000) DEFAULT NULL,
  `agama` varchar(50) DEFAULT NULL,
  `status_kawin` enum('Belum kawin','Kawin','Cerai hidup','Cerai mati') DEFAULT NULL,
  `pekerjaan` varchar(50) DEFAULT NULL,
  `kewarganegaraan` varchar(45) DEFAULT NULL,
  `tlp` varchar(15) DEFAULT NULL,
  `hp` varchar(15) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id`, `user_id`, `no_rekam_medis`, `NIK`, `nama`, `tempat_lahir`, `tgl_lahir`, `kelamin`, `golongan_darah`, `alamat`, `agama`, `status_kawin`, `pekerjaan`, `kewarganegaraan`, `tlp`, `hp`, `created`) VALUES
(6, 3, NULL, NULL, 'pasien 1', NULL, '2021-09-10 06:17:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 4, NULL, NULL, 'pasien 2', NULL, '2021-09-10 06:17:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 5, '003', '315151654888352', 'pasien 3', NULL, '2021-09-01 06:13:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `penjurnalan`
--

CREATE TABLE `penjurnalan` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tgl` timestamp NULL DEFAULT NULL,
  `debit` int(11) DEFAULT NULL,
  `kredit` int(11) DEFAULT NULL,
  `saldo_awal` int(11) DEFAULT NULL,
  `saldo_akhir` int(11) DEFAULT NULL,
  `UTB_total_kredit` int(11) DEFAULT NULL,
  `UTB_total_debit` int(11) DEFAULT NULL,
  `ATB_debit` int(11) DEFAULT NULL,
  `ATB_kredit` int(11) DEFAULT NULL,
  `BS_debit` int(11) DEFAULT NULL,
  `BS_kredit` int(11) DEFAULT NULL,
  `PCTB_debit` int(11) DEFAULT NULL,
  `PTCB_kredit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `penyakit`
--

CREATE TABLE `penyakit` (
  `id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `resep_apoteker`
--

CREATE TABLE `resep_apoteker` (
  `id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `nama_pembeli` varchar(50) DEFAULT 'pembeli_non_visit',
  `user_id_apoteker` int(11) DEFAULT NULL,
  `tgl_penulisan_resep` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `resep_apoteker`
--

INSERT INTO `resep_apoteker` (`id`, `visit_id`, `nama_pembeli`, `user_id_apoteker`, `tgl_penulisan_resep`) VALUES
(1, NULL, 'pembeli 1', 6, '2021-09-30 17:00:00'),
(2, 1, 'pembeli_non_visit', 6, '2021-09-30 17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `resep_has_obat`
--

CREATE TABLE `resep_has_obat` (
  `id` int(11) NOT NULL,
  `obat_id` int(11) DEFAULT NULL,
  `dosis` varchar(45) DEFAULT NULL,
  `jumlah` varchar(45) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `resep_has_obat`
--

INSERT INTO `resep_has_obat` (`id`, `obat_id`, `dosis`, `jumlah`, `visit_id`) VALUES
(44, 7, '3x1', '30', 1),
(45, 8, '3x1', '30', 2),
(46, 7, '3x1', '10', 1),
(47, 8, '1x1', '20', 1);

-- --------------------------------------------------------

--
-- Table structure for table `rsp_aptkr_has_obat`
--

CREATE TABLE `rsp_aptkr_has_obat` (
  `resep_apoteker_id` int(11) NOT NULL,
  `obat_id` int(11) NOT NULL,
  `jumlah` varchar(45) DEFAULT NULL,
  `dosis` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rsp_aptkr_has_obat`
--

INSERT INTO `rsp_aptkr_has_obat` (`resep_apoteker_id`, `obat_id`, `jumlah`, `dosis`) VALUES
(1, 7, '30', '3x1'),
(1, 8, '30', '3x1'),
(1, 9, '30', '3x1'),
(2, 7, '30', '3x1'),
(2, 8, '30', '3x1'),
(2, 9, '30', '3x1');

-- --------------------------------------------------------

--
-- Table structure for table `tindakan`
--

CREATE TABLE `tindakan` (
  `id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `mt_sisi` enum('kanan','kiri','') DEFAULT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tindakan`
--

INSERT INTO `tindakan` (`id`, `visit_id`, `nama`, `mt_sisi`, `harga`) VALUES
(1, 1, NULL, 'kanan', 1000),
(2, 1, NULL, 'kiri', 2000);

-- --------------------------------------------------------

--
-- Table structure for table `user_klinik`
--

CREATE TABLE `user_klinik` (
  `id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `sandi` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_klinik`
--

INSERT INTO `user_klinik` (`id`, `username`, `sandi`) VALUES
(1, 'admin_antrean', 'admin_antrean'),
(2, 'dokter1', 'dokter1'),
(3, 'pasien1', 'pasien1'),
(4, 'pasien2', 'pasien2'),
(5, 'pasien3', 'pasien3'),
(6, 'apoteker', NULL),
(7, 'kasir_visit', NULL),
(8, 'kasir_obat', NULL),
(9, 'pemilik', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `visit`
--

CREATE TABLE `visit` (
  `id` int(11) NOT NULL,
  `nomor_antrean` int(11) DEFAULT NULL,
  `status_antrean` enum('belum','sudah','batal') DEFAULT 'belum',
  `perusahaan` varchar(500) DEFAULT NULL,
  `tgl_visit` timestamp NULL DEFAULT current_timestamp(),
  `keluhan` varchar(1000) DEFAULT NULL,
  `vod` varchar(100) DEFAULT NULL,
  `vos` varchar(100) DEFAULT NULL,
  `tod` varchar(100) DEFAULT NULL,
  `tos` varchar(100) DEFAULT NULL,
  `palpebra` varchar(100) DEFAULT NULL,
  `konjungtiva` varchar(100) DEFAULT NULL,
  `kornea` varchar(100) DEFAULT NULL,
  `bmd` varchar(100) DEFAULT NULL,
  `lensa` varchar(100) DEFAULT NULL,
  `fundus_od` varchar(100) DEFAULT NULL,
  `diagnosa` varchar(1000) DEFAULT NULL,
  `terapi` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `visit`
--

INSERT INTO `visit` (`id`, `nomor_antrean`, `status_antrean`, `perusahaan`, `tgl_visit`, `keluhan`, `vod`, `vos`, `tod`, `tos`, `palpebra`, `konjungtiva`, `kornea`, `bmd`, `lensa`, `fundus_od`, `diagnosa`, `terapi`) VALUES
(1, 1, 'belum', NULL, '2021-10-01 05:13:31', '1 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 2, 'belum', NULL, '2021-10-01 05:13:44', '2 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 3, 'belum', NULL, '2021-10-01 05:13:54', '3 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 'belum', NULL, '2021-10-02 05:14:40', '1 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, 'belum', NULL, '2021-10-03 05:15:17', '1 3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `visit_has_user`
--

CREATE TABLE `visit_has_user` (
  `id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `visit_has_user`
--

INSERT INTO `visit_has_user` (`id`, `visit_id`, `user_id`) VALUES
(1, 1, 3),
(2, 2, 4),
(3, 3, 5),
(4, 4, 3),
(5, 5, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alergi`
--
ALTER TABLE `alergi`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `pasien_id` (`pasien_id`) USING BTREE;

--
-- Indexes for table `antrean_admin`
--
ALTER TABLE `antrean_admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_antrean_admin_user1_idx` (`user_id`);

--
-- Indexes for table `apoteker`
--
ALTER TABLE `apoteker`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_apoteker_user1_idx` (`user_id`);

--
-- Indexes for table `daftar_akun`
--
ALTER TABLE `daftar_akun`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dftr_akun_has_penjurnalan`
--
ALTER TABLE `dftr_akun_has_penjurnalan`
  ADD KEY `fk_dftr_akun_has_penjurnalan_penjurnalan1_idx` (`penjurnalan_id`),
  ADD KEY `fk_dftr_akun_has_penjurnalan_daftar_akun1_idx` (`daftar_akun_id`);

--
-- Indexes for table `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_dokter_user1_idx` (`user_id`);

--
-- Indexes for table `kasir`
--
ALTER TABLE `kasir`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id_UNIQUE` (`id`) USING BTREE,
  ADD KEY `fk_kasir_user1_idx` (`user_id`);

--
-- Indexes for table `komentar`
--
ALTER TABLE `komentar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_komentar_user_klinik1_idx` (`user_klinik_id`),
  ADD KEY `fk_komentar_order_obat1_idx` (`order_obat_id`);

--
-- Indexes for table `nota_penjualan`
--
ALTER TABLE `nota_penjualan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_nota_penjualan_visit1_idx` (`visit_id`),
  ADD KEY `fk_nota_penjualan_user1_idx` (`user_id`),
  ADD KEY `fk_nota_penjualan_resep_apoteker1_idx` (`resep_apoteker_id`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id_UNIQUE` (`id`) USING BTREE,
  ADD KEY `fk_obat_order_obat1_idx` (`order_obat_id`);

--
-- Indexes for table `order_obat`
--
ALTER TABLE `order_obat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_obat_user_klinik1_idx` (`user_klinik_id`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id_UNIQUE` (`id`) USING BTREE,
  ADD KEY `fk_pasien_user1_idx` (`user_id`);

--
-- Indexes for table `penjurnalan`
--
ALTER TABLE `penjurnalan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_penjurnalan_user1_idx` (`user_id`);

--
-- Indexes for table `penyakit`
--
ALTER TABLE `penyakit`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `visit_id` (`visit_id`) USING BTREE;

--
-- Indexes for table `resep_apoteker`
--
ALTER TABLE `resep_apoteker`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_resep_apoteker_user1_idx` (`user_id_apoteker`),
  ADD KEY `fk_resep_apoteker_visit1_idx` (`visit_id`);

--
-- Indexes for table `resep_has_obat`
--
ALTER TABLE `resep_has_obat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_resep_has_obat_obat1_idx` (`obat_id`),
  ADD KEY `fk_resep_has_obat_visit1_idx` (`visit_id`);

--
-- Indexes for table `rsp_aptkr_has_obat`
--
ALTER TABLE `rsp_aptkr_has_obat`
  ADD PRIMARY KEY (`resep_apoteker_id`,`obat_id`),
  ADD KEY `fk_resep_apoteker_has_obat_obat1_idx` (`obat_id`),
  ADD KEY `fk_resep_apoteker_has_obat_resep_apoteker1_idx` (`resep_apoteker_id`);

--
-- Indexes for table `tindakan`
--
ALTER TABLE `tindakan`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_tindakan_visit1_idx` (`visit_id`);

--
-- Indexes for table `user_klinik`
--
ALTER TABLE `user_klinik`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `iduser_UNIQUE` (`id`);

--
-- Indexes for table `visit`
--
ALTER TABLE `visit`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE;

--
-- Indexes for table `visit_has_user`
--
ALTER TABLE `visit_has_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_visit_has_user_visit1_idx` (`visit_id`),
  ADD KEY `fk_visit_has_user_user1_idx` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `antrean_admin`
--
ALTER TABLE `antrean_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `apoteker`
--
ALTER TABLE `apoteker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kasir`
--
ALTER TABLE `kasir`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nota_penjualan`
--
ALTER TABLE `nota_penjualan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `resep_apoteker`
--
ALTER TABLE `resep_apoteker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `resep_has_obat`
--
ALTER TABLE `resep_has_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `tindakan`
--
ALTER TABLE `tindakan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_klinik`
--
ALTER TABLE `user_klinik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `visit`
--
ALTER TABLE `visit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `visit_has_user`
--
ALTER TABLE `visit_has_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alergi`
--
ALTER TABLE `alergi`
  ADD CONSTRAINT `alergi_ibfk_1` FOREIGN KEY (`pasien_id`) REFERENCES `pasien` (`id`);

--
-- Constraints for table `antrean_admin`
--
ALTER TABLE `antrean_admin`
  ADD CONSTRAINT `fk_antrean_admin_user1` FOREIGN KEY (`user_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `apoteker`
--
ALTER TABLE `apoteker`
  ADD CONSTRAINT `fk_apoteker_user1` FOREIGN KEY (`user_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `dftr_akun_has_penjurnalan`
--
ALTER TABLE `dftr_akun_has_penjurnalan`
  ADD CONSTRAINT `fk_dftr_akun_has_penjurnalan_daftar_akun1` FOREIGN KEY (`daftar_akun_id`) REFERENCES `daftar_akun` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_dftr_akun_has_penjurnalan_penjurnalan1` FOREIGN KEY (`penjurnalan_id`) REFERENCES `penjurnalan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `dokter`
--
ALTER TABLE `dokter`
  ADD CONSTRAINT `fk_dokter_user1` FOREIGN KEY (`user_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `kasir`
--
ALTER TABLE `kasir`
  ADD CONSTRAINT `fk_kasir_user1` FOREIGN KEY (`user_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `komentar`
--
ALTER TABLE `komentar`
  ADD CONSTRAINT `fk_komentar_order_obat1` FOREIGN KEY (`order_obat_id`) REFERENCES `order_obat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_komentar_user_klinik1` FOREIGN KEY (`user_klinik_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `nota_penjualan`
--
ALTER TABLE `nota_penjualan`
  ADD CONSTRAINT `fk_nota_penjualan_resep_apoteker1` FOREIGN KEY (`resep_apoteker_id`) REFERENCES `resep_apoteker` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_nota_penjualan_user1` FOREIGN KEY (`user_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_nota_penjualan_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `obat`
--
ALTER TABLE `obat`
  ADD CONSTRAINT `fk_obat_order_obat1` FOREIGN KEY (`order_obat_id`) REFERENCES `order_obat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `order_obat`
--
ALTER TABLE `order_obat`
  ADD CONSTRAINT `fk_order_obat_user_klinik1` FOREIGN KEY (`user_klinik_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pasien`
--
ALTER TABLE `pasien`
  ADD CONSTRAINT `fk_pasien_user1` FOREIGN KEY (`user_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `penjurnalan`
--
ALTER TABLE `penjurnalan`
  ADD CONSTRAINT `fk_penjurnalan_user1` FOREIGN KEY (`user_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `penyakit`
--
ALTER TABLE `penyakit`
  ADD CONSTRAINT `penyakit_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`);

--
-- Constraints for table `resep_apoteker`
--
ALTER TABLE `resep_apoteker`
  ADD CONSTRAINT `fk_resep_apoteker_user1` FOREIGN KEY (`user_id_apoteker`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_resep_apoteker_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `resep_has_obat`
--
ALTER TABLE `resep_has_obat`
  ADD CONSTRAINT `fk_resep_has_obat_obat1` FOREIGN KEY (`obat_id`) REFERENCES `obat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_resep_has_obat_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rsp_aptkr_has_obat`
--
ALTER TABLE `rsp_aptkr_has_obat`
  ADD CONSTRAINT `fk_resep_apoteker_has_obat_obat1` FOREIGN KEY (`obat_id`) REFERENCES `obat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_resep_apoteker_has_obat_resep_apoteker1` FOREIGN KEY (`resep_apoteker_id`) REFERENCES `resep_apoteker` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tindakan`
--
ALTER TABLE `tindakan`
  ADD CONSTRAINT `fk_tindakan_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `visit_has_user`
--
ALTER TABLE `visit_has_user`
  ADD CONSTRAINT `fk_visit_has_user_user1` FOREIGN KEY (`user_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_visit_has_user_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

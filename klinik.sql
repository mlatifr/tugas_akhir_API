-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 25, 2021 at 06:48 AM
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
  `user_klinik_id` int(11) DEFAULT NULL,
  `status_antrean` enum('buka','tutup') DEFAULT NULL,
  `antrean_sekarang` int(11) DEFAULT NULL,
  `antrean_terakhir` int(11) NOT NULL,
  `batas_antrean` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `antrean_admin`
--

INSERT INTO `antrean_admin` (`id`, `user_klinik_id`, `status_antrean`, `antrean_sekarang`, `antrean_terakhir`, `batas_antrean`) VALUES
(1, 1, 'buka', 1, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `daftar_akun`
--

CREATE TABLE `daftar_akun` (
  `id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `daftar_akun`
--

INSERT INTO `daftar_akun` (`id`, `nama`) VALUES
(1, 'jasa medis'),
(2, 'obat'),
(3, 'tindakan'),
(4, 'kas'),
(5, 'piutang jasa medis'),
(6, 'piutang obat'),
(7, 'hutang obat'),
(8, 'hutang barang habis pakai'),
(9, 'admin'),
(10, 'barang habis pakai');

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
  `jasa_medis` int(11) DEFAULT NULL,
  `biaya_admin` int(11) DEFAULT NULL,
  `total_harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nota_penjualan`
--

INSERT INTO `nota_penjualan` (`id`, `user_id`, `visit_id`, `resep_apoteker_id`, `tgl_transaksi`, `jasa_medis`, `biaya_admin`, `total_harga`) VALUES
(1, 7, 1, 1, '2021-09-30 17:00:00', 200000, 40000, 5000),
(2, 7, 1, 1, '2021-10-01 17:00:00', 200000, 40000, 5000),
(3, 7, 1, 1, '2021-10-01 17:00:00', 200000, 40000, 5000),
(4, 7, 1, 1, '2021-09-30 17:00:00', 200000, 40000, 5000),
(5, 7, 1, 1, '2021-09-30 17:00:00', 200000, 40000, 5000),
(6, 7, 1, 1, '2021-09-30 17:00:00', 200000, 40000, 5000),
(7, 7, NULL, 1, '2021-09-30 17:00:00', NULL, NULL, 5000),
(8, 7, NULL, 1, '2021-09-30 17:00:00', NULL, NULL, 5000),
(9, 7, NULL, 1, '2021-09-30 17:00:00', NULL, NULL, 5000),
(10, 7, NULL, 1, '2021-09-30 17:00:00', NULL, NULL, 5000),
(11, 7, NULL, 1, '2021-09-30 17:00:00', NULL, NULL, 5000),
(12, 7, NULL, 1, '2021-09-30 17:00:00', NULL, NULL, 5000),
(13, 7, 2, 1, '2021-09-30 17:00:00', NULL, NULL, 5000),
(14, 7, 2, 1, '2021-09-30 17:00:00', 200000, 40000, 5000),
(15, 7, 2, 1, '2021-09-30 17:00:00', 200000, 40000, 5000);

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `id` int(11) NOT NULL,
  `order_obat_id` int(11) DEFAULT NULL,
  `jumlah_order` int(11) DEFAULT NULL,
  `jumlah_diterima` int(11) DEFAULT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `kadaluarsa` timestamp NULL DEFAULT NULL,
  `harga_jual` varchar(45) DEFAULT NULL,
  `harga_beli` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id`, `order_obat_id`, `jumlah_order`, `jumlah_diterima`, `nama`, `stok`, `kadaluarsa`, `harga_jual`, `harga_beli`) VALUES
(7, 1, 15, 15, 'obat 1', 10, '2021-10-01 08:05:48', '1000', NULL),
(8, 1, 13, 13, 'obat 2', 10, '2021-10-01 08:05:48', '2000', NULL),
(9, 1, 12, 12, 'obat 1', 10, '2021-09-02 08:05:48', '3000', NULL),
(30, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(31, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(32, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(33, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(34, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(35, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(36, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(37, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(38, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(39, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(40, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(41, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(42, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(43, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(44, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(45, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(46, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(47, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(48, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(49, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(50, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(51, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(52, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(53, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(54, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(55, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(56, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(57, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(58, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(59, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(60, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(61, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(62, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(63, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(64, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(65, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(66, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(67, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(68, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(69, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(70, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(71, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(72, 2, 17, NULL, 'obat order satu', NULL, NULL, NULL, '30000'),
(73, 2, 17, NULL, 'obat order dua', NULL, NULL, NULL, '30000'),
(74, 2, 27, NULL, 'obat order tiga', NULL, NULL, NULL, '30000'),
(75, 4, 17, NULL, 'bimbingan ke 4', NULL, NULL, NULL, '40000'),
(76, 4, 17, NULL, 'bimbingan ke 4.1', NULL, NULL, NULL, '410000'),
(77, 4, 27, NULL, 'bimbingan ke 4.2', NULL, NULL, NULL, '420000');

-- --------------------------------------------------------

--
-- Table structure for table `order_obat`
--

CREATE TABLE `order_obat` (
  `id` int(11) NOT NULL,
  `user_klinik_id` int(11) DEFAULT NULL,
  `tgl_order` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_obat`
--

INSERT INTO `order_obat` (`id`, `user_klinik_id`, `tgl_order`) VALUES
(1, 9, '2021-09-30 18:00:00'),
(2, 9, '2021-10-04 17:00:00'),
(3, 9, '2021-10-04 17:00:00'),
(4, 9, '2021-10-04 17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id` int(11) NOT NULL,
  `user_klinik_id` int(11) DEFAULT NULL,
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

INSERT INTO `pasien` (`id`, `user_klinik_id`, `no_rekam_medis`, `NIK`, `nama`, `tempat_lahir`, `tgl_lahir`, `kelamin`, `golongan_darah`, `alamat`, `agama`, `status_kawin`, `pekerjaan`, `kewarganegaraan`, `tlp`, `hp`, `created`) VALUES
(6, 3, NULL, NULL, 'pasien 1', NULL, '2021-09-10 06:17:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 4, NULL, NULL, 'pasien 2', NULL, '2021-09-10 06:17:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 5, '003', '315151654888352', 'pasien 3', NULL, '2021-09-01 06:13:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `penjurnalan`
--

CREATE TABLE `penjurnalan` (
  `id` int(11) NOT NULL,
  `user_klinik_id` int(11) DEFAULT NULL,
  `tgl_penjurnalan` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `penjurnalan`
--

INSERT INTO `penjurnalan` (`id`, `user_klinik_id`, `tgl_penjurnalan`) VALUES
(1, 10, '2021-10-01 02:19:17'),
(2, 10, '2021-09-30 17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `penjurnalan_has_akun`
--

CREATE TABLE `penjurnalan_has_akun` (
  `id` int(11) NOT NULL,
  `penjurnalan_id` int(11) DEFAULT NULL,
  `daftar_akun_id` int(11) DEFAULT NULL,
  `tgl_catat` timestamp NULL DEFAULT NULL,
  `debet` int(11) DEFAULT NULL,
  `kredit` int(11) DEFAULT NULL,
  `ket_transaksi` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `penjurnalan_has_akun`
--

INSERT INTO `penjurnalan_has_akun` (`id`, `penjurnalan_id`, `daftar_akun_id`, `tgl_catat`, `debet`, `kredit`, `ket_transaksi`) VALUES
(1, 1, 6, '2021-09-30 17:00:00', 40000, NULL, ''),
(2, 1, 6, '2021-09-30 17:00:00', 40000, NULL, 'piutang obat'),
(3, 1, 6, '2021-09-30 17:00:00', 40000, NULL, 'piutang obat'),
(4, 1, 1, '2021-09-30 17:00:00', 1000000, NULL, 'pendapatan jasa medis'),
(5, 1, 4, '2021-09-30 17:00:00', NULL, 1000000, 'pendapatan jasa medis'),
(6, 1, 2, '2021-09-30 17:00:00', NULL, 40000, 'piutang obat'),
(7, 1, 6, '2021-09-30 17:00:00', 40000, NULL, 'piutang obat'),
(8, 1, 2, '2021-09-30 17:00:00', 1000000, NULL, 'pendapatan jasa medis'),
(9, 1, 7, '2021-09-30 17:00:00', NULL, 1000000, 'pendapatan jasa medis'),
(10, 1, 5, '2021-09-30 17:00:00', NULL, 40000, 'piutang obat'),
(11, 1, 7, '2021-09-30 17:00:00', 40000, NULL, 'piutang obat'),
(12, 1, 4, '2021-09-30 17:00:00', 1000000, 0, 'pendapatan jasa medis'),
(13, 1, 1, '2021-09-30 17:00:00', NULL, 1000000, 'pendapatan jasa medis'),
(14, 1, 4, '2021-09-30 17:00:00', NULL, 40000, 'piutang obat'),
(15, 1, 10, '2021-09-30 17:00:00', 40000, 0, 'piutang obat');

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
(2, 1, 'pembeli_non_visit', 6, '2021-10-01 17:00:00'),
(3, 1, 'pembeli_non_visit', 6, '2021-10-02 17:00:00'),
(4, 1, 'pembeli_non_visit', 6, '2021-10-03 17:00:00'),
(5, 2, 'pembeli_non_visit', 6, '2021-10-04 17:00:00'),
(6, NULL, 'budi', 6, '2021-10-05 17:00:00'),
(7, NULL, 'budi', 6, '2021-10-06 17:00:00'),
(8, NULL, 'budi', 6, '2021-10-07 17:00:00'),
(9, NULL, 'budi', 6, '2021-10-08 17:00:00'),
(10, NULL, 'budi', 6, '2021-10-09 17:00:00'),
(11, NULL, 'budi', 6, '2021-10-10 17:00:00'),
(12, NULL, 'budi', 6, '2021-10-11 17:00:00'),
(13, 2, 'pembeli_non_visit', 6, '2021-10-12 17:00:00'),
(14, 2, 'pembeli_non_visit', 6, '2021-10-13 17:00:00'),
(15, 2, 'pembeli_non_visit', 6, '2021-10-14 17:00:00');

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
(47, 8, '1x1', '20', 1),
(48, 7, '3x1', '10', 1),
(49, 8, '1x1', '20', 1),
(50, 7, '3x1', '10', 1),
(51, 8, '1x1', '20', 1);

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
(2, 9, '30', '3x1'),
(4, 7, '30', '3x1'),
(4, 8, '30', '3x1'),
(4, 9, '30', '3x1'),
(5, 7, '30', '3x1'),
(5, 9, '30', '3x1');

-- --------------------------------------------------------

--
-- Table structure for table `saldo_akun`
--

CREATE TABLE `saldo_akun` (
  `id` int(11) NOT NULL,
  `daftar_akun_id` int(11) DEFAULT NULL,
  `tgl_catat` timestamp NULL DEFAULT NULL,
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
(2, 1, NULL, 'kiri', 2000),
(3, 1, 'b', 'kanan', 0),
(4, 1, 'f', 'kiri', 0),
(5, 1, 'b', 'kanan', 0),
(6, 1, 'f', 'kiri', 0);

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
(6, 'apoteker', 'apoteker'),
(7, 'kasir_visit', 'kasir_visit'),
(8, 'kasir_obat', 'kasir_obat'),
(9, 'pemilik', 'pemilik'),
(10, 'akuntan', 'akuntan'),
(11, 'pasien4', 'pasien4'),
(12, 'pasien5', 'pasien5');

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
(1, 1, 'belum', NULL, '2021-10-25 04:05:20', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 2, 'belum', NULL, '2021-10-25 04:05:53', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 3, 'belum', NULL, '2021-10-25 04:06:09', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 4, 'batal', NULL, '2021-10-25 04:11:13', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 5, 'belum', NULL, '2021-10-25 04:28:31', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `visit_has_user`
--

CREATE TABLE `visit_has_user` (
  `id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `user_klinik_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `visit_has_user`
--

INSERT INTO `visit_has_user` (`id`, `visit_id`, `user_klinik_id`) VALUES
(1, 1, 3),
(2, 2, 4),
(3, 3, 5),
(4, 4, 11),
(5, 5, 12);

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
  ADD KEY `fk_antrean_admin_user_klinik1_idx` (`user_klinik_id`);

--
-- Indexes for table `daftar_akun`
--
ALTER TABLE `daftar_akun`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `fk_pasien_user_klinik1_idx` (`user_klinik_id`);

--
-- Indexes for table `penjurnalan`
--
ALTER TABLE `penjurnalan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_penjurnalan_user_klinik1_idx` (`user_klinik_id`);

--
-- Indexes for table `penjurnalan_has_akun`
--
ALTER TABLE `penjurnalan_has_akun`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_penjurnalan_has_akun_penjurnalan1_idx` (`penjurnalan_id`),
  ADD KEY `fk_penjurnalan_has_akun_daftar_akun1_idx` (`daftar_akun_id`);

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
-- Indexes for table `saldo_akun`
--
ALTER TABLE `saldo_akun`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_saldo_akun_daftar_akun1_idx` (`daftar_akun_id`);

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
  ADD KEY `fk_visit_has_user_user_klinik1_idx` (`user_klinik_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `antrean_admin`
--
ALTER TABLE `antrean_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `daftar_akun`
--
ALTER TABLE `daftar_akun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nota_penjualan`
--
ALTER TABLE `nota_penjualan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `order_obat`
--
ALTER TABLE `order_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `penjurnalan`
--
ALTER TABLE `penjurnalan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `penjurnalan_has_akun`
--
ALTER TABLE `penjurnalan_has_akun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `resep_apoteker`
--
ALTER TABLE `resep_apoteker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `resep_has_obat`
--
ALTER TABLE `resep_has_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `tindakan`
--
ALTER TABLE `tindakan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_klinik`
--
ALTER TABLE `user_klinik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  ADD CONSTRAINT `fk_antrean_admin_user_klinik1` FOREIGN KEY (`user_klinik_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_pasien_user_klinik1` FOREIGN KEY (`user_klinik_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `penjurnalan`
--
ALTER TABLE `penjurnalan`
  ADD CONSTRAINT `fk_penjurnalan_user_klinik1` FOREIGN KEY (`user_klinik_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `penjurnalan_has_akun`
--
ALTER TABLE `penjurnalan_has_akun`
  ADD CONSTRAINT `fk_penjurnalan_has_akun_daftar_akun1` FOREIGN KEY (`daftar_akun_id`) REFERENCES `daftar_akun` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_penjurnalan_has_akun_penjurnalan1` FOREIGN KEY (`penjurnalan_id`) REFERENCES `penjurnalan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Constraints for table `saldo_akun`
--
ALTER TABLE `saldo_akun`
  ADD CONSTRAINT `fk_saldo_akun_daftar_akun1` FOREIGN KEY (`daftar_akun_id`) REFERENCES `daftar_akun` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tindakan`
--
ALTER TABLE `tindakan`
  ADD CONSTRAINT `fk_tindakan_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `visit_has_user`
--
ALTER TABLE `visit_has_user`
  ADD CONSTRAINT `fk_visit_has_user_user_klinik1` FOREIGN KEY (`user_klinik_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_visit_has_user_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

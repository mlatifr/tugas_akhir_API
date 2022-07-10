-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 10, 2022 at 03:29 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cari_tindakan` (IN `p_tindakan_nama` VARCHAR(50))   begin
SELECT * FROM klinik.tindakan
where tindakan.tindakan_nama like CONCAT('%',p_tindakan_nama, '%');
SELECT p_tindakan_nama;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_coba` (IN `p_nama` VARCHAR(50))   begin
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_admin` (`p_nama` VARCHAR(45))   begin
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_dokter` (`p_nama` VARCHAR(45))   BEGIN
INSERT INTO `klinik`.`dokter` (`nama`) VALUES (p_nama);
select*from dokter;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_kasir` (`p_nama` VARCHAR(45))   BEGIN
INSERT INTO `klinik`.`kasir` (`nama`) VALUES (p_nama);
select*from kasir;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_kasirr` (`p_nama` VARCHAR(45))   BEGIN
INSERT INTO `klinik`.`kasir` (`nama`) VALUES (p_nama);
select*from kasir;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_obat` (`p_nama` VARCHAR(45))   BEGIN
INSERT INTO klinik.obat (obat_nama) VALUES (p_nama);
select * from obat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_pasien` (`p_nama` VARCHAR(45))   BEGIN
INSERT INTO `klinik`.`pasien` (`pasien_nama`) VALUES (p_nama);
select*from pasien;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_visit` (`p_dokter_id` INT, `p_kasir_id` INT, `p_pasien_id` INT)   BEGIN
INSERT INTO `klinik`.`visit` (`dokter_id`, `kasir_id`, `pasien_id`) VALUES (p_dokter_id  , p_kasir_id  , p_pasien_id);
select * from visit;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_new_pasien` (IN `p_nama` VARCHAR(50))   begin
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_new_tindakan` (IN `p_tindakan_nama` VARCHAR(50))   begin
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `total_procedure_db` ()   SELECT COUNT(*) ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE="PROCEDURE" 
AND ROUTINE_SCHEMA="k2"$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cari_pasien` (`p_nama` VARCHAR(50)) RETURNS VARCHAR(50) CHARSET utf8mb4  BEGIN
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
(1, 1, 'buka', 0, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `daftar_akun`
--

CREATE TABLE `daftar_akun` (
  `id` int(11) NOT NULL,
  `no` int(11) DEFAULT NULL,
  `nama` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `daftar_akun`
--

INSERT INTO `daftar_akun` (`id`, `no`, `nama`) VALUES
(1, 100, '-----aset'),
(2, 102, 'kas'),
(3, 103, 'obat'),
(4, 104, 'piutang obat'),
(5, 108, 'piutang jasa medis'),
(6, 109, 'piutang admin'),
(7, 110, 'piutang tindakan'),
(8, 200, '-------kewajiban'),
(9, 205, 'hutang gaji'),
(10, 206, 'hutang obat'),
(11, 300, '------ekuitas pemilik'),
(12, 301, 'prive'),
(13, 400, '--------pendapatan'),
(14, 401, 'tindakan'),
(15, 402, 'admin'),
(16, 404, 'jasa medis'),
(17, 500, '--------biaya'),
(18, 502, 'biaya gaji'),
(19, 503, 'biaya listrik'),
(20, 504, 'biaya air'),
(21, 505, 'biaya internet'),
(22, 506, 'biaya belanja snack'),
(23, 507, 'biaya belanja snack'),
(24, 507, 'biayamahal binggo'),
(25, 507, 'biayamahal binggo'),
(26, 508, '508'),
(27, 508, '508'),
(28, 509, '509'),
(29, 111, 'coba di android'),
(30, 112, 'coba di windows');

-- --------------------------------------------------------

--
-- Table structure for table `info_pegawai`
--

CREATE TABLE `info_pegawai` (
  `id` int(11) NOT NULL,
  `user_klinik_id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `unit_kerja` varchar(100) NOT NULL,
  `tlp` varchar(20) DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `info_pegawai`
--

INSERT INTO `info_pegawai` (`id`, `user_klinik_id`, `nama`, `status`, `unit_kerja`, `tlp`, `alamat`) VALUES
(1, 1, 'M. Latif Robbani', 'non-aktif', 'perawat', '081217240058', 'TextEditingController#b2803(TextEditingValue(text: ┤nolll├, selection: TextSelection.invalid, composing: TextRange(start: -1, end: -1)))'),
(2, 2, '22', 'aktif', 'perawat', '081213213514', 'alamat 2'),
(3, 20, 'nama', 'aktif', 'perawat', '08121321311', 'alamat'),
(4, 21, 'nama', 'aktif', 'perawat', '08121321342', 'alamat'),
(5, 22, 'nama', 'aktif', 'perawat', '08121223123', 'alamat'),
(6, 23, 'nama', 'aktif', 'perawat', '08121377777', 'alamat'),
(7, 1, '11', 'aktif', 'perawat', '08121326566', 'alamat'),
(8, 7, '77', 'aktif', 'perawat', '08121321309090', 'kasir visit'),
(9, 24, 'nama', 'aktif', 'perawat', 'tlp ', 'alamat'),
(10, 25, '123', 'aktif', 'perawat', '123', '123'),
(11, 26, '123', 'aktif', 'perawat', '123', '123'),
(12, 27, '321', 'aktif', 'perawat', '321', '321'),
(13, 28, '11', 'aktif', 'perawat', '11', '11'),
(14, 29, '222', 'aktif', 'perawat', '222', '222'),
(15, 30, '333', 'aktif', 'perawat', '333', '333'),
(16, 31, '111', 'aktif', 'perawat', '111', '111'),
(17, 32, 'latifkun', 'aktif', 'perawat', '08122131313', 'sidoarjo'),
(18, 33, 'mlatifr', 'aktif', 'perawat', 'mlatifr', 'mlatifr');

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
(1, 13, 4, NULL, '2021-10-31 17:00:00', 8, 5, 1971013),
(2, 13, 5, NULL, '2021-10-31 17:00:00', 0, 0, 15000),
(3, 13, 10, NULL, '2021-11-09 17:00:00', 10000, 5000, 57000),
(4, 13, 12, NULL, '2021-11-10 17:00:00', 1, 0, 1),
(5, 13, 12, NULL, '2021-11-10 17:00:00', 4000, 1000, 33000),
(6, 13, 1, NULL, '2021-11-11 17:00:00', 10000, 4000, 37000),
(7, 13, 2, NULL, '2021-11-13 17:00:00', 111, 444, 42555);

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
  `harga_beli` varchar(45) DEFAULT NULL,
  `status_order` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id`, `order_obat_id`, `jumlah_order`, `jumlah_diterima`, `nama`, `stok`, `kadaluarsa`, `harga_jual`, `harga_beli`, `status_order`) VALUES
(1, 1, 1, NULL, 'Allegran Refresh', 10, '2021-11-01 01:57:19', '9000', '8800', ''),
(2, 1, 2, NULL, 'Blink Contacts', 5, '2021-11-02 01:57:25', '6000', '5500', ''),
(3, 1, 3, NULL, 'Calcium Pyruvat', 5, '2021-11-03 01:57:28', '5500', '5450', ''),
(4, 1, 4, NULL, 'FOCUSON', 5, '2021-11-04 01:57:32', '13000', '12200', ''),
(5, NULL, 5, 5, 'Masker', 5, '2021-11-05 01:57:36', '5000', NULL, ''),
(6, NULL, 3, 3, 'Kassa Steril / Kapas', 3, '2021-11-06 01:57:40', '10000', NULL, ''),
(7, 1, 1, NULL, 'Allegran Refresh', 20, '2021-11-02 01:57:19', '9000', '8800', ''),
(8, 8, 88, 88, 'delapan delapan', 887, '2022-07-08 07:22:46', '888', '888', 'pemesanan'),
(16, 17, 1313, NULL, 'Allegran Refresh', NULL, NULL, NULL, '1300', ''),
(17, 18, 220, NULL, 'Blink Contacts', NULL, NULL, NULL, '2200', ''),
(18, 19, 22, 11, 'Blink Contacts', 11, '2022-07-07 17:00:00', '2200', '2200', 'diterima'),
(19, 19, 22, 11, 'Blink Contacts', 11, '2022-07-08 17:00:00', '2200', '2200', 'diterima'),
(20, 9, 99, 99, '99', 99, '2022-07-08 07:50:37', '99', '99', 'pemesanan');

--
-- Triggers `obat`
--
DELIMITER $$
CREATE TRIGGER `after_insert` AFTER INSERT ON `obat` FOR EACH ROW INSERT INTO obat_history (`obat_id`, `order_obat_id`, `jumlah_order`, `jumlah_diterima`, `nama`, `stok`, `kadaluarsa`, `harga_jual`, `harga_beli`, `status_order`, `tanggal`) VALUES  (new.id,new.order_obat_id, new.jumlah_order, new.jumlah_diterima, new.nama, new.stok, new.kadaluarsa, new.harga_jual, new.harga_beli, new.status_order, NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_obat` AFTER UPDATE ON `obat` FOR EACH ROW INSERT INTO obat_history (`obat_id`, `order_obat_id`, `jumlah_order`, `jumlah_diterima`, `nama`, `stok`, `kadaluarsa`, `harga_jual`, `harga_beli`, `status_order`, `tanggal`) VALUES  (new.id,new.order_obat_id, new.jumlah_order, new.jumlah_diterima, new.nama, new.stok, new.kadaluarsa, new.harga_jual, new.harga_beli,'penjualan', NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `obat_history`
--

CREATE TABLE `obat_history` (
  `id` int(11) NOT NULL,
  `obat_id` int(11) NOT NULL,
  `order_obat_id` int(11) DEFAULT NULL,
  `jumlah_order` int(11) DEFAULT NULL,
  `jumlah_diterima` int(11) DEFAULT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `kadaluarsa` timestamp NULL DEFAULT NULL,
  `harga_jual` varchar(45) DEFAULT NULL,
  `harga_beli` varchar(45) DEFAULT NULL,
  `status_order` varchar(45) NOT NULL,
  `tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `obat_history`
--

INSERT INTO `obat_history` (`id`, `obat_id`, `order_obat_id`, `jumlah_order`, `jumlah_diterima`, `nama`, `stok`, `kadaluarsa`, `harga_jual`, `harga_beli`, `status_order`, `tanggal`) VALUES
(8, 8, 8, 88, 88, '888', 888, '2022-07-08 07:22:46', '888', '888', 'pemesanan', '2022-07-08 14:27:34'),
(20, 20, 9, 99, 99, '99', 99, '2022-07-08 07:50:37', '99', '99', 'pemesanan', '2022-07-08 14:51:04'),
(21, 8, 8, 88, 88, 'delapan delapan', 888, '2022-07-08 07:22:46', '888', '888', 'pemesanan', '2022-07-08 14:52:03'),
(22, 8, 8, 88, 88, 'delapan delapan', 887, '2022-07-08 07:22:46', '888', '888', 'penjualan', '2022-07-08 14:54:24');

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
(1, 9, '2021-10-31 03:05:51'),
(2, 9, '2021-10-30 17:00:00'),
(3, 9, '0000-00-00 00:00:00'),
(4, 9, '0000-00-00 00:00:00'),
(5, 9, '0000-00-00 00:00:00'),
(6, 9, '0000-00-00 00:00:00'),
(7, 9, '0000-00-00 00:00:00'),
(8, 9, '2022-07-06 17:00:00'),
(9, 9, '2022-07-06 17:00:00'),
(10, 9, '2022-07-06 17:00:00'),
(11, 9, '2022-07-06 17:00:00'),
(12, 9, '2022-07-06 17:00:00'),
(13, 9, '0000-00-00 00:00:00'),
(14, 9, '2022-07-07 17:00:00'),
(15, 9, '2022-07-07 17:00:00'),
(16, 9, '2022-07-07 17:00:00'),
(17, 9, '2022-07-07 17:00:00'),
(18, 9, '2022-07-07 17:00:00'),
(19, 9, '2022-07-07 17:00:00');

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
  `kelamin` varchar(45) DEFAULT NULL,
  `golongan_darah` varchar(5) DEFAULT NULL,
  `alamat` varchar(1000) DEFAULT NULL,
  `agama` varchar(50) DEFAULT NULL,
  `status_kawin` varchar(45) DEFAULT NULL,
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
(1, 14, '14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 15, '15', '1231231231231312', 'nama lengkap', 'tempat lahir mlatifr', '2021-11-14 00:00:00', 'Laki-laki', 'B', 'alamat mlatifr', '', 'belum kawin', 'Pelajar/ Mahasiswa', 'kewarganegaraan indonesia', 'TextEditingCont', NULL, NULL),
(3, 16, '16', '1231231231231312', 'nama lengkap', 'tempat lahir mlatifr', '2021-11-14 00:00:00', 'Laki-laki', 'B', 'alamat mlatifr', '', 'belum kawin', 'Pelajar/ Mahasiswa', 'kewarganegaraan indonesia', 'TextEditingCont', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `penjurnalan`
--

CREATE TABLE `penjurnalan` (
  `id` int(11) NOT NULL,
  `user_klinik_id` int(11) NOT NULL,
  `daftar_akun_id` int(11) NOT NULL,
  `tgl_catat` timestamp NULL DEFAULT NULL,
  `debet` int(11) DEFAULT NULL,
  `kredit` int(11) DEFAULT NULL,
  `ket_transaksi` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `penjurnalan`
--

INSERT INTO `penjurnalan` (`id`, `user_klinik_id`, `daftar_akun_id`, `tgl_catat`, `debet`, `kredit`, `ket_transaksi`) VALUES
(7, 15, 4, '2022-06-16 02:53:06', 1000000, 0, 'pendapatan jasa medis'),
(8, 15, 2, '2022-06-16 02:53:06', 0, 1000000, 'pendapatan jasa medis'),
(9, 15, 9, '2022-06-22 02:25:17', 0, 550000, 'pendapatan jasa medis'),
(10, 15, 3, '2022-06-22 17:00:00', 3400000, 0, 'pendapatan jasa medis'),
(11, 15, 4, '2022-06-01 02:57:50', 1000000, 0, 'pendapatan jasa medis'),
(12, 10, 6, '2022-06-02 17:00:00', 0, 100, 'piutang admin kredit 100'),
(13, 10, 6, '2022-06-02 17:00:00', 0, 555, 'lima'),
(14, 10, 9, '0000-00-00 00:00:00', 100, 0, '100 gaji debet'),
(15, 10, 9, '0000-00-00 00:00:00', 213, 0, '213'),
(16, 10, 9, '0000-00-00 00:00:00', 0, 321, '321'),
(17, 10, 9, '0000-00-00 00:00:00', 0, 456, '456'),
(18, 10, 4, '0000-00-00 00:00:00', 0, 987, '987'),
(19, 10, 4, '0000-00-00 00:00:00', 0, 852, '852'),
(20, 15, 4, '0000-00-00 00:00:00', 1000000, 0, 'pendapatan jasa medis'),
(21, 15, 4, '0000-00-00 00:00:00', 1000000, 0, 'pendapatan jasa medis'),
(22, 15, 4, '2022-06-11 17:00:00', 1000000, 0, 'pendapatan jasa medis'),
(23, 15, 4, '2022-06-11 17:00:00', 1000000, 0, 'pendapatan jasa medis'),
(24, 15, 4, '2022-06-11 17:00:00', 1000000, 0, 'pendapatan jasa medis'),
(25, 15, 4, '2021-09-30 17:00:00', 1000000, 0, 'pendapatan jasa medis'),
(26, 10, 6, '2022-06-28 17:00:00', 145, 0, '145 db admin'),
(27, 10, 2, '2022-06-30 17:00:00', 5500, 0, 'kas debet 5500'),
(28, 10, 12, '2022-06-30 17:00:00', 0, 5500, 'prive debet 5500'),
(29, 15, 4, '2021-09-30 17:00:00', 1000000, 0, 'pendapatan jasa medis');

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
  `nama_pembeli` varchar(50) DEFAULT NULL,
  `user_id_apoteker` int(11) DEFAULT NULL,
  `tgl_penulisan_resep` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `resep_apoteker`
--

INSERT INTO `resep_apoteker` (`id`, `visit_id`, `nama_pembeli`, `user_id_apoteker`, `tgl_penulisan_resep`) VALUES
(1, 1, NULL, 6, '2021-11-11 17:00:00'),
(2, 1, NULL, 6, '2021-11-11 17:00:00'),
(3, 2, NULL, 6, '2021-11-13 17:00:00'),
(4, 2, NULL, 6, '2021-11-13 17:00:00'),
(5, 3, NULL, 6, '2021-11-15 17:00:00'),
(6, 3, NULL, 6, '2021-11-15 17:00:00'),
(7, 7, NULL, 6, '2022-07-09 17:00:00');

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
(1, 1, '', '1', 3),
(2, 2, '', '1', 3),
(3, 3, '', '1', 3),
(4, 4, '', '1', 3),
(5, 6, '', '1', 3),
(6, 5, '', '1', 3),
(7, 1, '1', '', 3),
(8, 2, '1', '', 3),
(9, 4, '2x1', '2', 5),
(10, 2, '1x1', '2', 5),
(11, 1, '2x2', '2', 6),
(24, 20, '3x1', '1', 1),
(25, 7, '3x1', '10', 1),
(26, 7, '3x1', '10', 1),
(27, 7, '3x1', '10', 1),
(28, 2, '1x1', '2', 5),
(29, 4, '2x1', '2', 5),
(30, 1, '2x2', '2', 6),
(31, 20, '9x9', '9', 7);

-- --------------------------------------------------------

--
-- Table structure for table `rsp_aptkr_has_obat`
--

CREATE TABLE `rsp_aptkr_has_obat` (
  `id` int(11) NOT NULL,
  `resep_apoteker_id` int(11) DEFAULT NULL,
  `obat_id` int(11) DEFAULT NULL,
  `jumlah` varchar(45) DEFAULT NULL,
  `dosis` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rsp_aptkr_has_obat`
--

INSERT INTO `rsp_aptkr_has_obat` (`id`, `resep_apoteker_id`, `obat_id`, `jumlah`, `dosis`) VALUES
(1, 1, 1, '1', '1x1'),
(2, 1, 2, '2', '2x1'),
(3, 3, 4, '3', '3x1'),
(5, 5, 4, '3', '3x1'),
(6, 7, 20, '9', '99');

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
  `nama` varchar(45) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tindakan`
--

INSERT INTO `tindakan` (`id`, `nama`, `harga`) VALUES
(1, 'tindakan 1', 1000),
(2, 'tindakan 2', 2000),
(3, 'Pteredium', 30000),
(4, 'tindakan 4', 4000),
(5, 'tindakan 5', 5000),
(6, 'tindakan 6', 6000),
(7, 'tindakan 7', 5000);

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
(12, 'pasien5', 'pasien5'),
(13, 'kasir', 'kasir'),
(15, 'mlatifr', 'sandi'),
(16, 'mlatifr', 'sandi'),
(17, 'admin_order', 'admin_order'),
(24, 'coba', 'coba'),
(25, '123', '123'),
(26, '123', '123'),
(27, '321', '321'),
(28, '11', '11'),
(29, '222', '222'),
(30, '333', '333'),
(31, '111', '111'),
(32, 'latif', 'latif'),
(33, 'mlatifr', 'mlatifr');

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
(1, 1, 'belum', NULL, '2021-11-12 05:38:58', 'visit 12 11 2021', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 2, 'belum', NULL, '2021-11-13 23:42:25', 'keluhanku', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, 'belum', NULL, '2021-11-16 09:51:14', 'timbelen', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 2, 'belum', NULL, '2021-11-16 09:56:07', 'operasi pasien 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, 'belum', NULL, '2022-07-09 22:56:54', 'berobat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 2, 'belum', NULL, '2022-07-09 22:59:53', 'berobat2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 1, 'belum', NULL, '2022-07-10 01:08:57', 'berobat pasien 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `visit_has_tindakan`
--

CREATE TABLE `visit_has_tindakan` (
  `id` int(11) NOT NULL,
  `tindakan_id` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `mt_sisi` enum('kanan','kiri','') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `visit_has_tindakan`
--

INSERT INTO `visit_has_tindakan` (`id`, `tindakan_id`, `visit_id`, `mt_sisi`) VALUES
(10, 1, 1, 'kiri'),
(11, 1, 1, 'kanan'),
(14, 1, 2, 'kiri'),
(15, 2, 2, 'kiri'),
(16, 1, 3, 'kiri'),
(17, 2, 3, 'kiri'),
(20, 1, 5, 'kiri'),
(21, 1, 5, 'kanan'),
(22, 2, 6, 'kiri'),
(23, 2, 6, 'kanan');

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
(2, 2, 15),
(3, 3, 3),
(4, 4, 4),
(5, 5, 33),
(6, 6, 33),
(7, 7, 3);

--
-- Indexes for dumped tables
--

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
-- Indexes for table `info_pegawai`
--
ALTER TABLE `info_pegawai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_info_pegawai_user_klinik1_idx` (`user_klinik_id`);

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
-- Indexes for table `obat_history`
--
ALTER TABLE `obat_history`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id_UNIQUE` (`id`) USING BTREE,
  ADD KEY `fk_obat_history_obat1_idx` (`obat_id`);

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
  ADD KEY `fk_penjurnalan_user_klinik1_idx` (`user_klinik_id`),
  ADD KEY `fk_penjurnalan_daftar_akun1_idx` (`daftar_akun_id`);

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
  ADD PRIMARY KEY (`id`),
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
  ADD PRIMARY KEY (`id`) USING BTREE;

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
-- Indexes for table `visit_has_tindakan`
--
ALTER TABLE `visit_has_tindakan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_table1_tindakan1_idx` (`tindakan_id`),
  ADD KEY `fk_table1_visit1_idx` (`visit_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `info_pegawai`
--
ALTER TABLE `info_pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nota_penjualan`
--
ALTER TABLE `nota_penjualan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `obat_history`
--
ALTER TABLE `obat_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `order_obat`
--
ALTER TABLE `order_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `penjurnalan`
--
ALTER TABLE `penjurnalan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `resep_apoteker`
--
ALTER TABLE `resep_apoteker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `resep_has_obat`
--
ALTER TABLE `resep_has_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `rsp_aptkr_has_obat`
--
ALTER TABLE `rsp_aptkr_has_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tindakan`
--
ALTER TABLE `tindakan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_klinik`
--
ALTER TABLE `user_klinik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `visit`
--
ALTER TABLE `visit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `visit_has_tindakan`
--
ALTER TABLE `visit_has_tindakan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `visit_has_user`
--
ALTER TABLE `visit_has_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `antrean_admin`
--
ALTER TABLE `antrean_admin`
  ADD CONSTRAINT `fk_antrean_admin_user_klinik1` FOREIGN KEY (`user_klinik_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `info_pegawai`
--
ALTER TABLE `info_pegawai`
  ADD CONSTRAINT `fk_info_pegawai_user_klinik1` FOREIGN KEY (`user_klinik_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Constraints for table `obat_history`
--
ALTER TABLE `obat_history`
  ADD CONSTRAINT `fk_obat_history_obat1` FOREIGN KEY (`obat_id`) REFERENCES `obat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_penjurnalan_daftar_akun1` FOREIGN KEY (`daftar_akun_id`) REFERENCES `daftar_akun` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_penjurnalan_user_klinik1` FOREIGN KEY (`user_klinik_id`) REFERENCES `user_klinik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Constraints for table `visit_has_tindakan`
--
ALTER TABLE `visit_has_tindakan`
  ADD CONSTRAINT `fk_table1_tindakan1` FOREIGN KEY (`tindakan_id`) REFERENCES `tindakan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_table1_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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

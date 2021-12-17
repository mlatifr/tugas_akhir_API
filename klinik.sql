-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 17, 2021 at 02:55 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

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
(1, 1, 'buka', 1, 3, 5);

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
-- Table structure for table `history_stok`
--

CREATE TABLE `history_stok` (
  `id` int(11) NOT NULL,
  `tgl_transaksi` timestamp NULL DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `obat_id` int(11) DEFAULT NULL,
  `jumlah_order` int(11) DEFAULT NULL,
  `jumlah_diterima` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `history_stok`
--

INSERT INTO `history_stok` (`id`, `tgl_transaksi`, `stok`, `obat_id`, `jumlah_order`, `jumlah_diterima`) VALUES
(1, '2021-12-02 06:31:48', 5, 3, NULL, NULL),
(2, '2021-12-02 06:31:52', 5, 4, NULL, NULL),
(3, '2021-12-02 06:31:57', 100, 2, NULL, NULL),
(4, '2021-12-02 06:32:03', 100, 1, NULL, NULL),
(5, '2021-12-02 06:32:07', 500, 2, NULL, NULL),
(6, '2021-12-03 00:17:45', 50, 1, NULL, NULL),
(7, '2021-12-03 00:17:49', 50, 2, NULL, NULL),
(8, '2021-12-03 00:17:56', 50, 3, NULL, NULL),
(9, '2021-12-03 00:18:00', 50, 4, NULL, NULL),
(10, '2021-12-03 00:30:40', 500, 1, NULL, NULL),
(11, '2021-12-03 00:30:40', 500, 2, NULL, NULL),
(12, '2021-12-03 00:31:10', 485, 2, NULL, NULL),
(13, '2021-12-03 00:31:10', 470, 1, NULL, NULL),
(14, '2021-12-03 00:31:32', 440, 1, NULL, NULL),
(15, '2021-12-03 00:31:32', 470, 2, NULL, NULL),
(16, '2021-12-03 00:31:50', 455, 2, NULL, NULL),
(17, '2021-12-03 00:31:50', 410, 1, NULL, NULL),
(18, '2021-12-03 07:52:29', 440, 2, NULL, NULL),
(19, '2021-12-03 07:52:29', 380, 1, NULL, NULL),
(20, '2021-12-03 12:07:24', 500, 3, NULL, NULL),
(21, '2021-12-03 12:07:24', 500, 4, NULL, NULL),
(22, '2021-12-03 17:33:21', 350, 1, NULL, NULL),
(23, '2021-12-03 17:33:21', 425, 2, NULL, NULL),
(24, '2021-12-03 19:34:10', 320, 1, NULL, NULL),
(25, '2021-12-03 19:34:22', 410, 2, NULL, NULL),
(26, '2021-12-03 19:34:31', 485, 3, NULL, NULL),
(27, '2021-12-05 21:36:32', 310, 1, NULL, NULL),
(28, '2021-12-05 21:37:17', 455, 3, NULL, NULL),
(29, '2021-12-05 21:37:17', 385, 2, NULL, NULL),
(30, '2021-12-06 04:26:09', 370, 7, NULL, NULL),
(31, '2021-12-09 22:48:33', NULL, 8, NULL, NULL),
(32, '2021-12-09 22:48:33', NULL, 9, NULL, NULL),
(33, '2021-12-10 04:50:49', NULL, 8, NULL, NULL),
(34, '2021-12-10 04:50:49', NULL, 9, NULL, NULL),
(35, '2021-12-10 04:51:15', 5, 9, NULL, NULL),
(36, '2021-12-10 04:51:15', 10, 8, NULL, NULL),
(37, '2021-12-10 04:51:41', 10, 8, NULL, NULL),
(38, '2021-12-10 04:51:41', 5, 9, NULL, NULL),
(39, '2021-12-10 04:52:49', 100, 8, NULL, NULL),
(40, '2021-12-10 04:52:49', 500, 9, NULL, NULL),
(41, '2021-12-10 04:52:53', 500, 9, NULL, NULL),
(42, '2021-12-10 04:52:53', 100, 8, NULL, NULL),
(43, '2021-12-10 04:53:00', 500, 9, NULL, NULL),
(44, '2021-12-10 04:53:00', 100, 8, NULL, NULL),
(45, '2021-12-10 04:53:22', 100, 8, NULL, NULL),
(46, '2021-12-10 04:53:22', 500, 9, NULL, NULL),
(47, '2021-12-10 04:53:26', 100, 8, NULL, NULL),
(48, '2021-12-10 04:53:26', 500, 9, NULL, NULL),
(49, '2021-12-10 04:53:38', 100, 8, NULL, NULL),
(50, '2021-12-10 04:53:38', 500, 9, NULL, NULL),
(51, '2021-12-10 04:55:29', 10, 8, NULL, NULL),
(52, '2021-12-10 04:55:29', 50, 9, NULL, NULL),
(53, '2021-12-10 04:55:41', 10, 8, NULL, NULL),
(54, '2021-12-10 04:55:41', 50, 9, NULL, NULL),
(55, '2021-12-10 04:56:59', 100, 8, NULL, NULL),
(56, '2021-12-10 04:57:02', 500, 9, NULL, NULL),
(57, '2021-12-10 04:57:31', 100, 8, NULL, NULL),
(58, '2021-12-10 04:57:34', 500, 9, NULL, NULL),
(59, '2021-12-12 00:10:38', 500, 9, NULL, NULL),
(60, '2021-12-12 00:10:38', 100, 8, NULL, NULL),
(61, '2021-12-12 08:39:58', NULL, 10, 20, NULL),
(62, '2021-12-12 08:40:03', NULL, 11, 20, NULL),
(63, '2021-12-13 06:33:05', 295, 1, NULL, NULL),
(64, '2021-12-13 06:33:05', 370, 2, NULL, NULL),
(65, '2021-12-13 07:47:32', NULL, 12, 100, NULL),
(66, '2021-12-13 07:51:50', NULL, 13, 100, NULL),
(67, '2021-12-15 12:27:45', NULL, 14, 15, NULL),
(68, '2021-12-15 12:27:45', NULL, 15, 10, NULL),
(69, '2021-12-15 12:31:23', NULL, 16, 15, NULL),
(70, '2021-12-15 12:31:23', NULL, 17, 10, NULL),
(71, '2021-12-15 12:33:18', NULL, 18, 15, NULL),
(72, '2021-12-15 12:33:18', NULL, 19, 10, NULL),
(73, '2021-12-16 00:08:19', NULL, 20, 8, NULL),
(74, '2021-12-16 00:08:19', NULL, 21, 8, NULL),
(75, '2021-12-16 00:10:58', NULL, 22, 8, NULL),
(76, '2021-12-17 12:14:32', NULL, 22, NULL, NULL),
(77, '2021-12-17 13:13:46', NULL, 11, NULL, NULL),
(78, '2021-12-17 13:14:51', 10, 11, NULL, NULL),
(79, '2021-12-17 13:14:57', 10, 11, NULL, NULL),
(80, '2021-12-17 13:15:02', NULL, 11, NULL, NULL),
(81, '2021-12-17 13:15:17', NULL, 11, NULL, NULL),
(82, '2021-12-17 13:15:59', NULL, 11, NULL, NULL),
(83, '2021-12-17 13:16:52', 10, 11, NULL, NULL),
(84, '2021-12-17 13:18:11', NULL, 21, NULL, NULL),
(85, '2021-12-17 13:22:05', NULL, 20, NULL, NULL),
(86, '2021-12-17 13:23:07', 4, 20, NULL, NULL),
(87, '2021-12-17 13:31:33', NULL, 19, NULL, NULL),
(88, '2021-12-17 13:31:55', 2, 19, NULL, NULL),
(89, '2021-12-17 13:32:56', 2, 19, NULL, NULL),
(90, '2021-12-17 13:35:21', NULL, 18, NULL, NULL),
(91, '2021-12-17 13:36:36', NULL, 17, NULL, NULL),
(92, '2021-12-17 13:37:48', 5, 17, NULL, NULL),
(93, '2021-12-17 13:41:34', NULL, 16, NULL, NULL),
(94, '2021-12-17 13:42:38', 8, 16, NULL, NULL),
(95, '2021-12-17 13:43:44', 8, 16, NULL, NULL),
(96, '2021-12-17 13:43:44', 7, 23, 15, NULL),
(97, '2021-12-17 13:44:44', NULL, 15, NULL, NULL),
(98, '2021-12-17 13:44:45', 3, 24, 10, NULL),
(99, '2021-12-17 13:44:45', 2, 25, 10, NULL),
(100, '2021-12-17 13:48:09', 265, 1, NULL, NULL),
(101, '2021-12-17 13:48:09', 355, 2, NULL, NULL),
(102, '2021-12-17 13:48:09', 440, 3, NULL, NULL),
(103, '2021-12-17 13:48:09', 485, 4, NULL, NULL),
(104, '2021-12-17 13:48:09', 370, 7, NULL, NULL),
(105, '2021-12-17 13:48:09', 10, 8, NULL, NULL),
(106, '2021-12-17 13:48:09', 5, 9, NULL, NULL),
(107, '2021-12-17 13:48:09', NULL, 10, NULL, NULL),
(108, '2021-12-17 13:48:09', 10, 11, NULL, NULL),
(109, '2021-12-17 13:48:09', NULL, 12, NULL, NULL),
(110, '2021-12-17 13:48:09', NULL, 13, NULL, NULL),
(111, '2021-12-17 13:48:09', NULL, 14, NULL, NULL),
(112, '2021-12-17 13:48:09', 5, 15, NULL, NULL),
(113, '2021-12-17 13:48:09', 8, 16, NULL, NULL),
(114, '2021-12-17 13:48:09', 5, 17, NULL, NULL),
(115, '2021-12-17 13:48:09', 5, 18, NULL, NULL),
(116, '2021-12-17 13:48:09', 2, 19, NULL, NULL),
(117, '2021-12-17 13:48:09', 4, 20, NULL, NULL),
(118, '2021-12-17 13:48:09', 4, 21, NULL, NULL),
(119, '2021-12-17 13:48:09', 1, 22, NULL, NULL),
(120, '2021-12-17 13:48:09', 7, 23, NULL, NULL),
(121, '2021-12-17 13:48:09', 3, 24, NULL, NULL),
(122, '2021-12-17 13:48:09', 2, 25, NULL, NULL),
(123, '2021-12-17 13:50:46', 355, 2, NULL, NULL),
(124, '2021-12-17 13:50:46', 1, 26, 2, NULL),
(125, '2021-12-17 13:53:34', 440, 3, NULL, NULL),
(126, '2021-12-17 13:53:34', 2, 27, 3, NULL);

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
(1, 13, 1, NULL, '2021-11-23 17:00:00', 400, 100, 10300),
(2, 13, 2, NULL, '2021-11-23 17:00:00', 400, 100, 14400),
(3, 13, 3, NULL, '2021-11-23 17:00:00', 400, 100, 20100),
(4, 13, 4, NULL, '2021-11-24 17:00:00', 400, 100, 10000),
(5, 13, 5, NULL, '2021-11-24 17:00:00', 400, 100, 17000),
(6, 13, 6, NULL, '2021-11-24 17:00:00', 400, 100, 25000),
(7, 13, 10, NULL, '2021-11-26 17:00:00', 400, 100, 100000),
(8, 13, 5, NULL, '2021-11-24 17:00:00', 400, 100, 16000),
(9, 13, 11, NULL, '2021-12-01 17:00:00', 400, 100, 121000),
(10, 13, 13, NULL, '2021-12-02 17:00:00', 400, 100, 360000),
(11, 13, 16, NULL, '2021-12-03 17:00:00', 400, 100, 157000),
(12, 13, 17, NULL, '2021-12-03 17:00:00', 400, 100, 219000),
(13, 13, 18, NULL, '2021-12-03 17:00:00', 400, 100, 236000),
(14, 13, 19, NULL, '2021-12-05 17:00:00', 400, 100, 167000),
(15, 13, 20, NULL, '2021-12-05 17:00:00', 400, 100, 500000),
(16, 13, 25, NULL, '2021-12-12 17:00:00', 10000, 5000, 387000);

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
  `status_order` varchar(45) DEFAULT NULL COMMENT 'mengetahui obat sudah datang atau belum'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id`, `order_obat_id`, `jumlah_order`, `jumlah_diterima`, `nama`, `stok`, `kadaluarsa`, `harga_jual`, `harga_beli`, `status_order`) VALUES
(1, 1, 1, NULL, 'Allegran Refresh', 265, NULL, '9000', '8800', 'pemesanan'),
(2, 1, 2, 1, 'Blink Contacts', 1, '2021-11-30 17:00:00', '6000', '5500', 'diterima'),
(3, 1, 3, 1, 'Calcium Pyruvat', 1, '2021-12-16 17:00:00', '5500', '5450', 'diterima'),
(4, 1, 4, NULL, 'FOCUSON', 485, NULL, '13000', '12200', 'pemesanan'),
(7, 1, 2, NULL, 'Blink Contacts', 370, NULL, '6000', '5500', 'pemesanan'),
(8, 11, 10, 10, 'obat baru', 10, '2022-02-01 17:00:00', '115000', '100000', 'pemesanan'),
(9, 11, 5, 5, 'Allegran Refresh', 5, '2022-02-01 17:00:00', '57500', '50000', 'pemesanan'),
(10, 12, 20, NULL, 'obat baru', NULL, NULL, '37450', '35000', 'pemesanan'),
(11, 13, 20, 10, 'obat baru', 10, '2021-12-16 17:00:00', '37450', '35000', 'pemesanan'),
(12, 14, 100, NULL, 'vitacimin', NULL, NULL, '275000', '250000', 'pemesanan'),
(13, 15, 100, NULL, 'Allegran Refresh', NULL, NULL, '220000', '200000', 'pemesanan'),
(14, 16, 15, NULL, 'Blink Contacts', NULL, NULL, '10000', '10000', 'pemesanan'),
(15, 16, 10, 5, 'vitacimin', 5, '2021-11-30 17:00:00', '12500', '12500', 'pemesanan'),
(16, 17, 15, 8, 'Blink Contacts', 8, '2021-12-16 17:00:00', '10000', '10000', 'pemesanan'),
(17, 17, 10, 5, 'vitacimin', 5, '2021-12-16 17:00:00', '12500', '12500', 'pemesanan'),
(18, 18, 15, 5, 'Blink Contacts', 5, '2021-12-16 17:00:00', '10000', '10000', 'pemesanan'),
(19, 18, 10, 2, 'vitacimin', 2, '2021-12-16 17:00:00', '12500', '12500', 'pemesanan'),
(20, 19, 8, 4, 'dexaharsen', 4, '2021-12-30 17:00:00', '3300', '3000', 'pemesanan'),
(21, 19, 8, 4, 'talion', 4, '2021-11-30 17:00:00', '36300', '33000', 'pemesanan'),
(22, 20, 8, 1, 'vitacimin', 1, '2021-12-16 17:00:00', '10500', '10000', 'pemesanan'),
(23, 17, 15, 7, 'Blink Contacts', 7, '2021-12-18 17:00:00', '10000', '10000', 'pemesanan'),
(24, 16, 10, 3, 'vitacimin', 3, '2021-12-02 17:00:00', '12500', '12500', 'pemesanan'),
(25, 16, 10, 2, 'vitacimin', 2, '2021-12-01 17:00:00', '12500', '12500', 'pemesanan'),
(26, 1, 2, 1, 'Blink Contacts', 1, '2021-12-01 17:00:00', '6000', '5500', 'diterima'),
(27, 1, 3, 2, 'Calcium Pyruvat', 2, '2021-12-16 17:00:00', '5500', '5450', 'diterima');

--
-- Triggers `obat`
--
DELIMITER $$
CREATE TRIGGER `after_insert_obat` AFTER INSERT ON `obat` FOR EACH ROW INSERT INTO `history_stok` 
(`id`, `tgl_transaksi`, `stok`, `obat_id`,`jumlah_order`)
VALUES (null, current_timestamp(), new.stok, new.id,new.jumlah_order)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_obat` AFTER UPDATE ON `obat` FOR EACH ROW INSERT INTO `history_stok` (`id`, `tgl_transaksi`, `stok`, `obat_id`)
VALUES (null, current_timestamp(), old.stok, old.id)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_obat`
--

CREATE TABLE `order_obat` (
  `id` int(11) NOT NULL,
  `user_klinik_id` int(11) DEFAULT NULL,
  `tgl_order` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_obat`
--

INSERT INTO `order_obat` (`id`, `user_klinik_id`, `tgl_order`) VALUES
(1, 9, '2021-10-31 03:05:51'),
(2, 9, '2021-10-30 17:00:00'),
(3, 9, '2021-12-07 17:00:00'),
(4, 9, '2021-12-07 17:00:00'),
(5, 9, '2021-12-07 17:00:00'),
(6, 9, '2021-12-09 17:00:00'),
(7, 9, '2021-12-09 17:00:00'),
(8, 9, '2021-12-09 17:00:00'),
(9, 9, '2021-12-09 17:00:00'),
(10, 9, '2021-12-09 17:00:00'),
(11, 9, '2021-12-09 17:00:00'),
(12, 9, '2021-12-11 17:00:00'),
(13, 9, '2021-12-11 17:00:00'),
(14, 9, '2021-12-12 17:00:00'),
(15, 9, '2021-12-12 17:00:00'),
(16, 9, '2021-12-14 17:00:00'),
(17, 9, '2021-12-14 17:00:00'),
(18, 9, '2021-12-14 17:00:00'),
(19, 9, '2021-12-15 17:00:00'),
(20, 9, '2021-12-15 17:00:00');

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
(1, 10, NULL),
(2, 10, NULL),
(3, 10, NULL),
(4, 10, NULL),
(5, 10, NULL),
(6, 10, NULL),
(7, 10, NULL),
(8, 10, NULL),
(9, 10, NULL),
(10, 10, NULL),
(11, 10, NULL),
(12, 10, NULL),
(13, 10, NULL),
(14, 10, NULL),
(15, 10, NULL),
(16, 10, NULL),
(17, 10, NULL),
(18, 10, NULL),
(19, 10, NULL),
(20, 10, NULL),
(21, 6, NULL),
(22, 9, NULL),
(23, 9, NULL),
(24, 9, NULL),
(25, 9, NULL),
(26, 9, NULL),
(27, 9, NULL),
(28, 9, NULL),
(29, 18, NULL),
(30, 9, NULL);

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
(1, 4, NULL, 6, '2021-11-30 17:00:00'),
(2, 5, NULL, 6, '2021-11-30 17:00:00'),
(3, 4, NULL, 6, '2021-11-30 17:00:00'),
(4, 4, NULL, 6, '2021-11-30 17:00:00'),
(5, 4, NULL, 6, '2021-11-30 17:00:00'),
(6, 5, NULL, 6, '2021-11-30 17:00:00'),
(7, 4, NULL, 6, '2021-11-30 17:00:00'),
(8, 5, NULL, 6, '2021-11-30 17:00:00'),
(9, 11, NULL, 6, '2021-12-01 17:00:00'),
(10, 12, NULL, 6, '2021-12-01 17:00:00'),
(11, 12, NULL, 6, '2021-12-01 17:00:00'),
(12, 11, NULL, 6, '2021-12-01 17:00:00'),
(13, 13, NULL, 6, '2021-12-02 17:00:00'),
(14, 13, NULL, 6, '2021-12-02 17:00:00'),
(15, 14, NULL, 6, '2021-12-02 17:00:00'),
(16, 15, NULL, 6, '2021-12-02 17:00:00'),
(17, 16, NULL, 6, '2021-12-03 17:00:00'),
(18, 17, NULL, 6, '2021-12-03 17:00:00'),
(19, 18, NULL, 6, '2021-12-03 17:00:00'),
(20, 19, NULL, 6, '2021-12-05 17:00:00'),
(21, 20, NULL, 6, '2021-12-05 17:00:00'),
(22, 21, NULL, 6, '2021-12-05 17:00:00'),
(23, 19, NULL, 6, '2021-12-05 17:00:00'),
(24, 19, NULL, 6, '2021-12-06 17:00:00'),
(25, 23, NULL, 6, '2021-12-11 17:00:00'),
(26, 23, NULL, 6, '2021-12-11 17:00:00'),
(27, 25, NULL, 6, '2021-12-12 17:00:00'),
(28, 25, NULL, 6, '2021-12-12 17:00:00'),
(29, 25, NULL, 6, '2021-12-12 17:00:00'),
(30, 25, NULL, 6, '2021-12-12 17:00:00'),
(31, 27, NULL, 6, '2021-12-16 17:00:00');

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
(1, 1, '1x1', '1', 1),
(2, 2, '2x2', '2', 2),
(3, 3, '3x1', '3', 3),
(4, 1, '1x1', '1', 4),
(5, 2, '2x1', '2', 5),
(6, 3, '3x1', '3', 6),
(7, 1, '1x1', '1', 7),
(8, 4, '5x1', '5', 10),
(9, 2, '2x1', '2', 11),
(10, 3, '3x1', '15', 12),
(11, 1, '2x1', '30', 13),
(12, 2, '3x1', '15', 13),
(13, 3, '1x1', '15', 14),
(14, 4, '1x1', '15', 14),
(15, 1, '3x1', '15', 15),
(16, 3, '3x1', '30', 15),
(17, 1, '1x1', '10', 16),
(18, 2, '2x1', '25', 17),
(19, 3, '3x1', '30', 18),
(20, 1, '3x1', '15', 19),
(21, 2, '3x1', '15', 20),
(22, 3, '3x1', '15', 20),
(23, 1, '3x1', '30', 23),
(24, 1, '3x1', '30', 25),
(25, 2, '1x1', '15', 25),
(26, 3, '2x1', '30', 25),
(27, 1, '1x1', '10', 27),
(28, 2, '3x1', '30', 27);

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
(4, 1, 1, '1', '1x1'),
(8, 1, 1, '1', '1x1'),
(9, 3, 1, '3', '3x3'),
(10, 3, 2, '3', '3x3'),
(11, 3, 3, '3', '3x3'),
(12, 3, 4, '3', '3x3'),
(13, 3, 3, '3', '3x3'),
(14, 3, 1, '3', '3x3'),
(15, 4, 1, '1', '1x1'),
(16, 4, 2, '2', '1x1'),
(17, 4, 4, '4', '1x1'),
(18, 4, 3, '3', '1x1'),
(19, 4, 1, '4', '1x1'),
(20, 9, 2, '20', '2x1'),
(21, 10, 3, '15', '3X1'),
(22, 14, 1, '30', '2x1'),
(23, 14, 2, '15', '3x1'),
(24, 15, 3, '15', '1x1'),
(25, 15, 4, '15', '1x1'),
(26, 16, 1, '15', '3x1'),
(27, 16, 3, '30', '3x1'),
(28, 17, 1, '10', '1x1'),
(29, 18, 2, '25', '2x1'),
(30, 19, 3, '30', '3x1'),
(31, 20, 1, '15', '3x1'),
(32, 21, 2, '15', '3x1'),
(33, 21, 3, '15', '3x1'),
(34, 26, 1, '30', '3x1'),
(35, 27, 1, '30', '3x1'),
(36, 27, 2, '15', '1x1'),
(37, 30, 1, '30', '3x1');

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
(3, 'tindakan 3', 3000),
(4, 'tindakan 4', 4000),
(5, 'tindakan 5', 5000),
(6, 'tindakan 6', 6000);

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
(17, 'mlatifr', 'mlatifr'),
(18, 'admin_order', 'admin_order');

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
(1, 1, 'belum', NULL, '2021-11-23 23:31:50', 'keluhan mlatifr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 2, 'belum', NULL, '2021-11-23 23:32:16', 'keluhan pasien1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 3, 'belum', NULL, '2021-11-23 23:32:36', 'kaleuhan pasien2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 'belum', NULL, '2021-11-24 22:38:37', 'nov 25 keluhan mlatifr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 2, 'belum', NULL, '2021-11-24 22:38:59', 'nov 25 pasien1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 3, 'belum', NULL, '2021-11-24 22:39:21', 'nov 25 pasien 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 1, 'belum', NULL, '2021-11-26 09:14:43', 'pasien1 26 nov', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 2, 'belum', NULL, '2021-11-26 09:15:04', 'pasien2 26 nov', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 3, 'belum', NULL, '2021-11-26 09:15:26', 'mlatifr 26 nov', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 1, 'belum', NULL, '2021-11-26 21:07:58', 'mlatifr 27 nov', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 1, 'belum', NULL, '2021-12-01 22:23:42', 'keluhan pasien 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 2, 'belum', NULL, '2021-12-01 22:24:00', 'keluhan pasien 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 1, 'belum', NULL, '2021-12-03 00:25:10', 'p1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 2, 'belum', NULL, '2021-12-03 00:25:26', 'p2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 3, 'belum', NULL, '2021-12-03 00:25:48', 'p3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 1, 'belum', NULL, '2021-12-03 19:24:57', 'kl', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 2, 'belum', NULL, '2021-12-03 19:27:25', 'kl', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 3, 'belum', NULL, '2021-12-03 19:28:35', 'asd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 1, 'sudah', NULL, '2021-12-05 21:32:36', 'pasien1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 2, 'sudah', NULL, '2021-12-05 21:32:52', 'pasien2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 3, 'belum', NULL, '2021-12-05 21:33:05', 'pasien3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 4, 'belum', NULL, '2021-12-05 21:33:22', 'pasien4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 1, 'sudah', NULL, '2021-12-12 00:49:47', 'pasien1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 2, 'sudah', NULL, '2021-12-12 00:50:08', 'pasien2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 1, 'sudah', NULL, '2021-12-13 06:28:32', 'pasien1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 2, 'belum', NULL, '2021-12-13 07:04:45', 'pasien2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 3, 'belum', NULL, '2021-12-17 06:51:05', 'keluh 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
(1, 1, 1, 'kiri'),
(2, 2, 2, 'kiri'),
(3, 3, 3, 'kanan'),
(4, 1, 4, 'kiri'),
(5, 2, 5, 'kiri'),
(6, 2, 5, 'kanan'),
(7, 3, 6, 'kiri'),
(8, 3, 6, 'kanan'),
(9, 1, 7, 'kiri'),
(10, 6, 10, 'kiri'),
(11, 6, 10, 'kanan'),
(12, 1, 11, 'kiri'),
(13, 2, 12, 'kanan'),
(14, 1, 14, 'kiri'),
(15, 1, 14, 'kanan'),
(16, 1, 16, 'kiri'),
(17, 1, 16, 'kanan'),
(18, 2, 17, 'kiri'),
(19, 2, 17, 'kanan'),
(20, 3, 18, 'kiri'),
(21, 3, 18, 'kanan'),
(24, 2, 20, 'kiri'),
(25, 2, 20, 'kanan'),
(28, 1, 19, 'kiri'),
(29, 2, 19, 'kiri'),
(30, 3, 19, 'kiri'),
(31, 4, 19, 'kiri'),
(32, 5, 19, 'kiri'),
(33, 6, 19, 'kiri'),
(34, 2, 21, 'kiri'),
(37, 1, 23, 'kiri'),
(38, 2, 23, 'kanan'),
(77, 1, 25, 'kiri'),
(78, 2, 25, 'kiri'),
(79, 3, 25, 'kiri');

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
(1, 1, 17),
(2, 2, 3),
(3, 3, 4),
(4, 4, 17),
(5, 5, 3),
(6, 6, 4),
(7, 7, 3),
(8, 8, 4),
(9, 9, 17),
(10, 10, 17),
(11, 11, 3),
(12, 12, 4),
(13, 13, 3),
(14, 14, 4),
(15, 15, 5),
(16, 16, 3),
(17, 17, 4),
(18, 18, 5),
(19, 19, 3),
(20, 20, 4),
(21, 21, 5),
(22, 22, 11),
(23, 23, 3),
(24, 24, 4),
(25, 25, 3),
(26, 26, 4),
(27, 27, 3);

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
-- Indexes for table `history_stok`
--
ALTER TABLE `history_stok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_history_stok_obat1_idx` (`obat_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `history_stok`
--
ALTER TABLE `history_stok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nota_penjualan`
--
ALTER TABLE `nota_penjualan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `order_obat`
--
ALTER TABLE `order_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `penjurnalan`
--
ALTER TABLE `penjurnalan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `penjurnalan_has_akun`
--
ALTER TABLE `penjurnalan_has_akun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resep_apoteker`
--
ALTER TABLE `resep_apoteker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `resep_has_obat`
--
ALTER TABLE `resep_has_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `rsp_aptkr_has_obat`
--
ALTER TABLE `rsp_aptkr_has_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `tindakan`
--
ALTER TABLE `tindakan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_klinik`
--
ALTER TABLE `user_klinik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `visit`
--
ALTER TABLE `visit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `visit_has_tindakan`
--
ALTER TABLE `visit_has_tindakan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `visit_has_user`
--
ALTER TABLE `visit_has_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

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
-- Constraints for table `history_stok`
--
ALTER TABLE `history_stok`
  ADD CONSTRAINT `fk_history_stok_obat1` FOREIGN KEY (`obat_id`) REFERENCES `obat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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

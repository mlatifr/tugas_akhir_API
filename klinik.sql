-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 14, 2021 at 04:03 AM
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
-- Table structure for table `antrean`
--

CREATE TABLE `antrean` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status_antrean` enum('buka','tutup') DEFAULT NULL,
  `antrean_sekarang` int(11) DEFAULT NULL,
  `antrean_terakhir` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `antrean`
--

INSERT INTO `antrean` (`id`, `user_id`, `status_antrean`, `antrean_sekarang`, `antrean_terakhir`) VALUES
(1, 1, 'buka', 2, 4);

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
-- Table structure for table `kartu_stok_obat`
--

CREATE TABLE `kartu_stok_obat` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tgl_beli` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `kategori` enum('bebas','keras','obat_wajib_apotek','narkotika','psikotropika','herbal') DEFAULT NULL,
  `beli_jual_saldo` enum('beli','jual','saldo') DEFAULT NULL,
  `jmlh` int(11) DEFAULT NULL,
  `hrg_unit` int(11) DEFAULT NULL,
  `total_hrg` int(11) DEFAULT NULL,
  `saldo_akhir` int(11) DEFAULT NULL,
  `harga_beli` int(11) DEFAULT NULL,
  `harga_jual` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

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
  `user_id` int(11) DEFAULT NULL,
  `kartu_stok_obat_id` int(11) DEFAULT NULL,
  `komentar` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mata`
--

CREATE TABLE `mata` (
  `id` int(11) NOT NULL,
  `mt_sisi` enum('kanan','kiri','') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `id` int(11) NOT NULL,
  `ob_nama` varchar(45) DEFAULT NULL,
  `kartu_stok_obat_id` int(11) NOT NULL,
  `resep_id` int(11) DEFAULT NULL,
  `kadaluarsa` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

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
(7, 4, NULL, NULL, 'pasien 2', NULL, '2021-09-10 06:17:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
-- Table structure for table `resep`
--

CREATE TABLE `resep` (
  `id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `dosis` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tindakan`
--

CREATE TABLE `tindakan` (
  `id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tindakan_has_mata`
--

CREATE TABLE `tindakan_has_mata` (
  `tindakan_id` int(11) DEFAULT NULL,
  `mata_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `sandi` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `sandi`) VALUES
(1, 'admin_antrean', 'admin_antrean'),
(2, 'dokter1', 'dokter1'),
(3, 'pasien1', 'pasien1'),
(4, 'pasien2', 'pasien2'),
(5, 'pasien3', 'pasien3');

-- --------------------------------------------------------

--
-- Table structure for table `visit`
--

CREATE TABLE `visit` (
  `id` int(11) NOT NULL,
  `nomor_antrean` int(11) DEFAULT NULL,
  `penjurnalan_id` int(11) DEFAULT NULL,
  `perusahaan` varchar(500) DEFAULT NULL,
  `tgl_visit` timestamp NULL DEFAULT current_timestamp(),
  `tensi_sistole` varchar(3) DEFAULT NULL,
  `tensi_diastole` varchar(3) DEFAULT NULL,
  `berat_badan` varchar(3) DEFAULT NULL,
  `anamnesis` varchar(5000) DEFAULT NULL,
  `keluhan` varchar(5000) DEFAULT NULL,
  `hasil_periksa` varchar(5000) DEFAULT NULL,
  `status_antrean` enum('belum','sudah','batal') DEFAULT 'belum'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `visit`
--

INSERT INTO `visit` (`id`, `nomor_antrean`, `penjurnalan_id`, `perusahaan`, `tgl_visit`, `tensi_sistole`, `tensi_diastole`, `berat_badan`, `anamnesis`, `keluhan`, `hasil_periksa`, `status_antrean`) VALUES
(1, 1, NULL, NULL, '2021-09-08 02:01:00', NULL, NULL, NULL, NULL, 'pasien 1 keluhan 1', NULL, 'sudah'),
(2, 2, NULL, NULL, '2021-09-08 02:02:57', NULL, NULL, NULL, NULL, 'pasien 2 keluhan 1', NULL, 'belum'),
(3, 3, NULL, NULL, '2021-09-08 02:12:14', NULL, NULL, NULL, NULL, 'pasien 3 keluhan 1', NULL, 'belum'),
(4, 4, NULL, NULL, '2021-09-10 04:39:05', NULL, NULL, NULL, NULL, 'pasien 1 keluhan 2', NULL, 'belum'),
(5, 4, NULL, NULL, '2021-09-13 06:26:14', NULL, NULL, NULL, NULL, 'pasien 1 keluhan 3', NULL, 'belum');

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
(1, 1, 2),
(2, 1, 3),
(9, 2, 2),
(10, 2, 4),
(11, 3, 2),
(12, 3, 5),
(13, 5, 3);

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
-- Indexes for table `antrean`
--
ALTER TABLE `antrean`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_antrean_user1_idx` (`user_id`);

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
-- Indexes for table `kartu_stok_obat`
--
ALTER TABLE `kartu_stok_obat`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id_UNIQUE` (`id`) USING BTREE,
  ADD KEY `fk_kartu_stok_obat_user1_idx` (`user_id`);

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
  ADD KEY `fk_komentar_kartu_stok_obat1_idx` (`kartu_stok_obat_id`),
  ADD KEY `fk_komentar_user1_idx` (`user_id`);

--
-- Indexes for table `mata`
--
ALTER TABLE `mata`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id_UNIQUE` (`id`) USING BTREE;

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id_UNIQUE` (`id`) USING BTREE,
  ADD KEY `fk_obat_kartu_stok_obat1_idx` (`kartu_stok_obat_id`),
  ADD KEY `fk_obat_resep1_idx` (`resep_id`);

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
-- Indexes for table `resep`
--
ALTER TABLE `resep`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id_UNIQUE` (`id`) USING BTREE,
  ADD KEY `fk_resep_visit1_idx` (`visit_id`) USING BTREE;

--
-- Indexes for table `tindakan`
--
ALTER TABLE `tindakan`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_tindakan_visit1_idx` (`visit_id`);

--
-- Indexes for table `tindakan_has_mata`
--
ALTER TABLE `tindakan_has_mata`
  ADD KEY `fk_tindakan_has_mata_tindakan1_idx` (`tindakan_id`),
  ADD KEY `fk_tindakan_has_mata_mata1` (`mata_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `iduser_UNIQUE` (`id`);

--
-- Indexes for table `visit`
--
ALTER TABLE `visit`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE,
  ADD KEY `fk_visit_penjurnalan1_idx` (`penjurnalan_id`);

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
-- AUTO_INCREMENT for table `antrean`
--
ALTER TABLE `antrean`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kartu_stok_obat`
--
ALTER TABLE `kartu_stok_obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `mata`
--
ALTER TABLE `mata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `resep`
--
ALTER TABLE `resep`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tindakan`
--
ALTER TABLE `tindakan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `visit`
--
ALTER TABLE `visit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `visit_has_user`
--
ALTER TABLE `visit_has_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alergi`
--
ALTER TABLE `alergi`
  ADD CONSTRAINT `alergi_ibfk_1` FOREIGN KEY (`pasien_id`) REFERENCES `pasien` (`id`);

--
-- Constraints for table `antrean`
--
ALTER TABLE `antrean`
  ADD CONSTRAINT `fk_antrean_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_dokter_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `kartu_stok_obat`
--
ALTER TABLE `kartu_stok_obat`
  ADD CONSTRAINT `fk_kartu_stok_obat_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `kasir`
--
ALTER TABLE `kasir`
  ADD CONSTRAINT `fk_kasir_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `komentar`
--
ALTER TABLE `komentar`
  ADD CONSTRAINT `fk_komentar_kartu_stok_obat1` FOREIGN KEY (`kartu_stok_obat_id`) REFERENCES `kartu_stok_obat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_komentar_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `obat`
--
ALTER TABLE `obat`
  ADD CONSTRAINT `fk_obat_kartu_stok_obat1` FOREIGN KEY (`kartu_stok_obat_id`) REFERENCES `kartu_stok_obat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_obat_resep1` FOREIGN KEY (`resep_id`) REFERENCES `resep` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pasien`
--
ALTER TABLE `pasien`
  ADD CONSTRAINT `fk_pasien_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `penjurnalan`
--
ALTER TABLE `penjurnalan`
  ADD CONSTRAINT `fk_penjurnalan_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `penyakit`
--
ALTER TABLE `penyakit`
  ADD CONSTRAINT `penyakit_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`);

--
-- Constraints for table `resep`
--
ALTER TABLE `resep`
  ADD CONSTRAINT `fk_resep_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tindakan`
--
ALTER TABLE `tindakan`
  ADD CONSTRAINT `fk_tindakan_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tindakan_has_mata`
--
ALTER TABLE `tindakan_has_mata`
  ADD CONSTRAINT `fk_tindakan_has_mata_mata1` FOREIGN KEY (`mata_id`) REFERENCES `mata` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tindakan_has_mata_tindakan1` FOREIGN KEY (`tindakan_id`) REFERENCES `tindakan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `visit`
--
ALTER TABLE `visit`
  ADD CONSTRAINT `fk_visit_penjurnalan1` FOREIGN KEY (`penjurnalan_id`) REFERENCES `penjurnalan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `visit_has_user`
--
ALTER TABLE `visit_has_user`
  ADD CONSTRAINT `fk_visit_has_user_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_visit_has_user_visit1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

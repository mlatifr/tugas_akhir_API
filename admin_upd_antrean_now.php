<?php
error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$antrean_sekarang = '';
$batas_antrean = '';
$antrean_terakhir = '';
extract($_POST);
if ($antrean_terakhir != null) {
    $sql = "UPDATE `antrean_admin` SET `antrean_sekarang` = '0', `batas_antrean` = '0',`antrean_terakhir` = '0'  WHERE `antrean_admin`.`id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->execute();
}
if ($antrean_sekarang != null && $batas_antrean != null) {
    $sql = "UPDATE `antrean_admin` SET `antrean_sekarang` = ?, `batas_antrean` = ? WHERE `antrean_admin`.`id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $antrean_sekarang, $batas_antrean);
    $stmt->execute();
}
if ($antrean_sekarang && $batas_antrean == null) {
    $sql = "UPDATE `antrean_admin` SET `antrean_sekarang` = ? WHERE `antrean_admin`.`user_klinik_id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $antrean_sekarang);
    $stmt->execute();
}
if ($batas_antrean && $antrean_sekarang == null) {
    $sql = "UPDATE `antrean_admin` SET `batas_antrean` = ? WHERE `antrean_admin`.`user_klinik_id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $batas_antrean);
    $stmt->execute();
}
require 'pasien_view_antrean_sekarang.php';

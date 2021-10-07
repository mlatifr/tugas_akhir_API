
<?php
error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$antrean_sekarang = '';
$batas_antrean = '';
extract($_POST);
if ($antrean_sekarang != null && $batas_antrean != null) {
    $sql = "UPDATE `antrean_admin` SET `antrean_sekarang` = ?, `batas_antrean` = ? WHERE `antrean_admin`.`id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $antrean_sekarang, $batas_antrean);
    $stmt->execute();
    if ($stmt->affected_rows > 0) {
        $arr = ["result" => "success", "antrean_sekarang" => $antrean_sekarang, "batas_antrean" => $batas_antrean];
    } else {
        $arr = ["result" => "fail $antrean_sekarang && $batas_antrean", "Error" => $con->error, "sql" => $stmt];
    }
}
if ($antrean_sekarang && $batas_antrean == null) {
    $sql = "UPDATE `antrean_admin` SET `antrean_sekarang` = ? WHERE `antrean_admin`.`user_klinik_id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $antrean_sekarang);
    $stmt->execute();
    if ($stmt->affected_rows > 0) {
        $arr = ["result" => "success", "antrean_sekarang" => $antrean_sekarang];
    } else {
        $arr = ["result" => "fail", "Error" => $con->error];
    }
}
if ($batas_antrean && $antrean_sekarang == null) {
    $sql = "UPDATE `antrean_admin` SET `batas_antrean` = ? WHERE `antrean_admin`.`user_klinik_id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $batas_antrean);
    $stmt->execute();
    if ($stmt->affected_rows > 0) {
        $arr = ["result" => "success", "batas_antrean" => $batas_antrean];
    } else {
        $arr = ["result" => "fail", "Error" => $con->error];
    }
}

echo json_encode($arr);
$stmt->close();
$con->close();

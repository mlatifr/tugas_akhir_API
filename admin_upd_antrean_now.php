
<?php
error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
extract($_POST);
// echo $antrean_sekarang . "\n" . $batas_antrean;
if ($antrean_sekarang && $batas_antrean) {
    $sql = "UPDATE `antrean_admin` SET `antrean_sekarang` = ? , `batas_antrean` = ? WHERE `antrean_admin`.`user_id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $antrean_sekarang, $batas_antrean);
}
if ($batas_antrean) {
    $sql = "UPDATE `antrean_admin` SET `batas_antrean` = ? WHERE `antrean_admin`.`user_id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $batas_antrean);
}
if ($antrean_sekarang) {
    $sql = "UPDATE `antrean_admin` SET `antrean_sekarang` = ? WHERE `antrean_admin`.`user_id` = 1";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $antrean_sekarang);
}
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "id" => $con->insert_id];
} else {
    $arr = ["result" => "fail", "Error" => $con->error];
}
echo json_encode($arr);

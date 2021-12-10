<?php require 'connect.php';
?>
<?php
$jumlah_diterima = '';
$stok = '';
$kadaluarsa = '';
$status_order = '';
$obat_id = '';
extract($_POST);
$sql = "UPDATE `obat` 
        SET 
        `jumlah_diterima` = ?, 
        `stok` = ?, 
        `kadaluarsa` = ?, 
        `status_order` = ? 
        WHERE `obat`.`id` = ?";
$stmt = $con->prepare($sql);
$stmt->bind_param("sssss",$jumlah_diterima,$stok,$kadaluarsa,$status_order,$obat_id);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "data" => 'update success'];
};
echo json_encode($arr);
$stmt->close();
$con->close();
?>
<?php require 'connect.php';
?>
<?php
extract($_POST);
$sql = "INSERT INTO `tindakan` ( `nama`, `harga`) 
    VALUES ( '" . $nama . "', '" . $harga . "')";
$stmt = $con->prepare($sql);
$stmt->execute();
require 'dokter_v_list_tindakan.php';
?>
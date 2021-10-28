<?php require 'connect.php';
?>
<?php
$nama = '';
$harga = '';
extract($_POST);
$sql = "INSERT INTO `tindakan` ( `nama`, `harga`) 
    VALUES (?, ?)";
$stmt = $con->prepare($sql);
$stmt->bind_param("ss", $nama, $harga);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    echo ($nama . ' harga: ' . $harga);
    require 'dokter_v_list_tindakan.php';
};
?>
<?php require 'connect.php';
?>
<?php

$order_obat_id= '';
$jumlah_order= '';
$jumlah_diterima= '';
$nama= '';
$stok= '';
$kadaluarsa= '';
$harga_jual= '';
$harga_beli= '';
$status_order= '';
$jumlah_diterima = '';
$stok = '';
$kadaluarsa = '';
$status_order = '';
$obat_id = '';
extract($_POST);
$sql = "INSERT INTO `obat` 
(
`order_obat_id`, 
`jumlah_order`, 
`jumlah_diterima`, 
`nama`, 
`stok`, 
`kadaluarsa`, 
`harga_jual`, 
`harga_beli`, 
`status_order`
) 
VALUES 
(
?, 
?, 
?, 
?, 
?, 
?, 
?, 
?, 
?)";
$stmt = $con->prepare($sql);
$stmt->bind_param("sssssssss",
$order_obat_id,
$jumlah_order,
$jumlah_diterima,
$nama,
$stok,
$kadaluarsa,
$harga_jual,
$harga_beli,
$status_order);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "data" => 'insert success'];
}else{
    $arr = ["result" => "error", "data" => $con->errno];
};
echo json_encode($arr);
$stmt->close();
$con->close();
?>
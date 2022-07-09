<?php require 'connect.php';
?>
<?php
$arr = [];
$order_obat_id = '';
$jumlah_order = '';
$nama = '';
$harga_beli = '';
$obat_id = '';
extract($_POST);
$sql =
    "INSERT INTO `obat` 
        (`order_obat_id`, `jumlah_order`, `nama`, `harga_beli`,`harga_jual`,`status_order`)
        VALUES 
        ('" . $order_obat_id . "','" .  $jumlah_order . "','" . $nama . "', '" . $harga_beli . "', '" . $harga_jual . "', '" . $status_order . "')";
$stmt = $con->prepare($sql);
$stmt->execute();
$obat_array = $con->insert_id;
echo $obat_id;
if ($stmt->affected_rows > 0) {
    require 'connect.php';
} else {
    $arr = ["result" => "fail pemilik_input_order_item.php", "sql" => "$sql", "Error" => $con->error,];
    echo json_encode($arr);
    $con->close();
};

?>
<?php require 'connect.php';
?>
<?php
$arr = [];
extract($_POST);
foreach ($obat_array as $row => $value) {
    $order_obat_id = mysqli_real_escape_string($con, $value['order_obat_id']);
    $jumlah_order = mysqli_real_escape_string($con, $value['jumlah_order']);
    $nama = mysqli_real_escape_string($con, $value['nama']);
    $harga_beli = mysqli_real_escape_string($con, $value['harga_beli']);
    $obat_id = mysqli_real_escape_string($con, $value['obat_id']);
    // $obat_id['obat_id'];
    $sql =
        "INSERT INTO `obat` 
        (`order_obat_id`, `jumlah_order`, `nama`, `harga_beli`)
        VALUES 
        ('" . $order_obat_id . "','" .  $jumlah_order . "','" . $nama . "', '" . $harga_beli . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
    $obat_array[$row]['obat_id'] = $con->insert_id;
    echo $obat_id;
    if ($stmt->affected_rows > 0) {
        // $obat_id = 'oini id obat';
        $arr = ["result" => "success", "data" => $obat_array];
    } else {
        $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
    }
};
echo json_encode($arr);
$con->close();
?>
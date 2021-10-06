<?php require 'connect.php';
?>
<?php
extract($_POST);
$last_id;
$sql =
    "INSERT INTO `nota_penjualan` 
        (`user_id`, `visit_id`, `resep_apoteker_id`, `tgl_transaksi`, `total_harga`) 
        VALUES 
        (?,?,?,?,?)";
$stmt = $con->prepare($sql);
$stmt->bind_param("sssss", $user_id, $visit_id, $resep_apoteker_id, $tgl_transaksi, $total_harga);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $last_id = $con->insert_id;
    $arr = ["result" => "success", "nota_jual_id" => $last_id];
} else {
    $arr = ["result" => "fail", "nota_jual_id" => $last_id, "Error" => $con->error];
}
echo json_encode($arr);
$con->close();
?>
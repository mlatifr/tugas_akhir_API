<?php require 'connect.php';
?>
<?php
$arr = [];
$last_id;
extract($_POST);
$sql =
    "INSERT INTO `order_obat` (`user_klinik_id`, `tgl_order`) 
        VALUES ('" . $user_klinik_id  . "','" . $tgl_order . "')";
$stmt = $con->prepare($sql);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $last_id = $con->insert_id;
    $arr = ["result" => "success", "sql" => "$sql",  "id_order_obat_tgl" => $last_id];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
}
echo json_encode($arr);
$con->close();
?>
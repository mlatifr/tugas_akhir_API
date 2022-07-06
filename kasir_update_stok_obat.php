<?php require 'connect.php';
?>
<?php
$arr = [];
$obat_id;
$stok_obat_baru;
extract($_POST);
// echo($obat_id.'|'.$stok_baru);
    $sql = "UPDATE `obat` SET `stok` = ?  WHERE `obat`.`id` = ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $stok_obat_baru, $obat_id);
    $stmt->execute();
    if ($stmt->affected_rows > 0) {
        $arr = ["result" => "success", "data" => $obat_array];
    } else {
        $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
    }

echo json_encode($arr);
$con->close();
?>
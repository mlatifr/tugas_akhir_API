<?php require 'connect.php';
?>
<?php
$arr2 = [];
$stok_baru;
$stok_lama;
$terjual;
extract($_POST);
foreach ($obat_array as $row => $value) {
    $obat_id = mysqli_real_escape_string($con, $value['obat_id']);
    // $stok_baru = mysqli_real_escape_string($con, $value['stok_baru']);
    // $stok_lama = mysqli_real_escape_string($con, $value['stok_lama']);
    $terjual = mysqli_real_escape_string($con, $value['terjual']);

    // $stok_baru = $stok_lama - $terjual;
    $sql2 = "UPDATE `obat` SET `stok` = ? WHERE `obat`.`id` = ?";
    $stmt2 = $con->prepare($sql2);
    $stmt2->bind_param("ss", $terjual, $obat_id);
    $stmt2->execute();
    if ($stmt2->affected_rows > 0) {
        $arr2 = ["result" => "success", "data" => $obat_array];
    } else {
        $arr2 = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
    }
};
echo json_encode($arr2);
$con->close();
?>
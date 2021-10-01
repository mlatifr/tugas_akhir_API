<?php require 'connect.php';
?>
<?php
$arr = [];
extract($_POST);
foreach ($obat_array as $row => $value) {
    $resep_id = mysqli_real_escape_string($con, $value['resep_id']);
    $obat_id = mysqli_real_escape_string($con, $value['obat_id']);
    $jumlah = mysqli_real_escape_string($con, $value['jumlah']);
    $dosis = mysqli_real_escape_string($con, $value['dosis']);
    $sql = "INSERT INTO `rsp_aptkr_has_obat` (`resep_apoteker_id`, `obat_id`, `jumlah`, `dosis`)
            VALUES ('" . $resep_id . "','" .  $obat_id . "',  '" . $jumlah . "', '" . $dosis . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
    if ($stmt->affected_rows > 0) {
        $arr = ["result" => "success", "data" => $obat_array];
    } else {
        $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
    }
};
echo json_encode($arr);
$con->close();
?>
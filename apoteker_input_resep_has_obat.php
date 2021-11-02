<?php require 'connect.php';
?>
<?php
$arr = [];
$resep_apoteker_id = '';
$obat_id = '';
$jumlah = '';
$dosis = '';
extract($_POST);
$sql = "INSERT INTO `rsp_aptkr_has_obat` (`resep_apoteker_id`, `obat_id`, `jumlah`, `dosis`)
            VALUES ('" . $resep_apoteker_id . "','" .  $obat_id . "',  '" . $jumlah . "',  '" . $dosis . "')";
$stmt = $con->prepare($sql);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    require 'apoteker_v_keranjang_resep_obat.php';
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'sql' => $sql];
    echo json_encode($arr);
    $con->close();
}
?>
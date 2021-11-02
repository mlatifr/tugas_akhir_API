<?php require 'connect.php';
?>
<?php
$arr = [];
$visit_id = '';
$user_id_apoteker = '';
$tgl_penulisan_resep = '';
extract($_POST);
$sql =
    "INSERT INTO `resep_apoteker` (`visit_id`,  `user_id_apoteker`, `tgl_penulisan_resep`)
VALUES ('" . $visit_id . "','" .  $user_id_apoteker . "',  '" . $tgl_penulisan_resep . "')";
$stmt = $con->prepare($sql);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "id_resep_apoteker" => $con->insert_id];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
}
echo json_encode($arr);
$con->close();
?>
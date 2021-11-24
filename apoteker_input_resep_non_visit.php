<?php require 'connect.php';
?>
<?php
$arr = [];
$last_id;
$visit_id = null;
$nama_pembeli = null;
extract($_POST);
// pelayanan resep dari pembeli non-visit 
if ($nama_pembeli && $visit_id == null) {
    $sql =
        "INSERT INTO `resep_apoteker` (`nama_pembeli`, `user_id_apoteker`, `tgl_penulisan_resep`)
        VALUES ('" .  $nama_pembeli . "',  '" . $user_id_apoteker . "', '" . $tgl_penulisan_resep . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
    if ($stmt->affected_rows > 0) {
        $last_id = $con->insert_id;
        $arr = ["result" => "success",  "resep_id" => $last_id];
    } else {
        $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
    }
};
//pelayanan resep dari pasien yg visit
if ($visit_id) {
    $sql =
        "INSERT INTO `resep_apoteker` ( `visit_id`, `user_id_apoteker`, `tgl_penulisan_resep`)
        VALUES ('" . $visit_id  . "','" . $user_id_apoteker . "','" . $tgl_penulisan_resep . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
    if ($stmt->affected_rows > 0) {
        $last_id = $con->insert_id;
        $arr = ["result" => "success",  "resep_id" => $last_id];
    } else {
        $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
    }
}
echo json_encode($arr);
$con->close();
?>
<?php require 'connect.php';
?>
<?php
$arr = [];
$last_id;
extract($_POST);
// $visit_id = mysqli_real_escape_string($con, $value['visit_id']);
// $nama_pembeli = mysqli_real_escape_string($con, $value['nama_pembeli']);
// $user_id_apoteker = mysqli_real_escape_string($con, $value['user_id_apoteker']);
// $tgl_penulisan_resep = mysqli_real_escape_string($con, $value['tgl_penulisan_resep']);
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
// pelayanan resep dari pembeli non-visit
elseif ($nama_pembeli) {
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

echo json_encode($arr);

$con->close();

?>
<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
extract($_POST);
foreach ($obat_array as $row => $value) {

    $visit_id = mysqli_real_escape_string($con, $value['visit_id']);
    $nama_pembeli = mysqli_real_escape_string($con, $value['nama_pembeli']);
    $user_id_apoteker = mysqli_real_escape_string($con, $value['user_id_apoteker']);
    $tgl_penulisan_resep = mysqli_real_escape_string($con, $value['tgl_penulisan_resep']);
    $obat_id = mysqli_real_escape_string($con, $value['obat_id']);
    $jumlah = mysqli_real_escape_string($con, $value['jumlah']);
    $dosis = mysqli_real_escape_string($con, $value['dosis']);
    //pelayanan resep dari pasien yg visit
    if ($visit_id) {
        $sql = "INSERT INTO `resep_apoteker` ( `visit_id`, `nama_pembeli`, `user_id_apoteker`, `tgl_penulisan_resep`)
        VALUES ('" . $visit_id . "','" .  $nama_pembeli . "',  '" . $user_id_apoteker . "', '" . $tgl_penulisan_resep . "')";
        $stmt = $con->prepare($sql);
        $stmt->execute();
        if ($stmt->affected_rows > 0) {
            echo 'sql 1 success' . "\n";
            $last_id = $con->insert_id;
            // INSERT INTO `rsp_aptkr_has_obat` (`resep_apoteker_id`, `obat_id`, `jumlah`, `dosis`) VALUES ('1', '7', '30', '3x1')
            $sql2 = "INSERT INTO `rsp_aptkr_has_obat` (`resep_apoteker_id`, `obat_id`, `jumlah`, `dosis`)
            VALUES ('" . $last_id . "','" .  $obat_id . "',  '" . $jumlah . "', '" . $dosis . "')";
            $stmt2 = $con->prepare($sql2);
            $stmt2->execute();
            if ($stmt2->affected_rows > 0) {
                echo 'sql 2 success' . "\n id input: $last_id \n ";
                $arr = ["result" => "success", "data" => $obat_array];
            } else {
                $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
            }
        } else {
            $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
        }
    }
    // pelayanan resep dari pembeli non-visit
    elseif ($nama_pembeli) {
        $sql = "INSERT INTO `resep_apoteker` (`nama_pembeli`, `user_id_apoteker`, `obat_id`, `dosis`, `jumlah`)
        VALUES ('" .  $nama_pembeli . "',  '" . $user_id_apoteker . "', '" . $obat_id . "', '" . $dosis . "', '" . $jumlah . "')";
    }
};

echo json_encode($arr);

$con->close();

?>
<?php require 'connect.php';
?>
<?php
$user_klinik_id = '';
$data = [];
extract($_POST);
$sql =
    "INSERT INTO `user_klinik` ( `username`, `sandi`) 
VALUES (?,?)";
$stmt = $con->prepare($sql);
$stmt->bind_param("ss", $username, $sandi);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    echo "sql 1 success \n";
    $user_klinik_id = "$con->insert_id";
    // echo $user_klinik_id;
    $sql2 =
        "INSERT INTO `pasien` 
    (`user_klinik_id`, `no_rekam_medis`, `NIK`, `nama`, `tempat_lahir`, `tgl_lahir`, `kelamin`, `golongan_darah`, `alamat`, `agama`, `status_kawin`, `pekerjaan`, `kewarganegaraan`, `tlp`, `hp`, `created`)
    VALUES 
    (?,?,?,?,?,?,?,?,?,?,?,?,?,?, NULL, NULL)";
    $stmt2 = $con->prepare($sql2);
    $stmt2->bind_param("ssssssssssssss", $user_klinik_id, $user_klinik_id, $NIK, $nama, $tempat_lahir, $tgl_lahir, $kelamin, $golongan_darah, $alamat, $agama, $status_kawin, $pekerjaan, $kewarganegaraan, $tlp);
    $stmt2->execute();
    if ($stmt2->affected_rows > 0) {
        // $no_antrean = $no_antrean + 1;
        echo "sql 2 success \n";
        $arr = [
            "result" => "success",
            "data" => $username,
        ];
    }
} else {
    $arr = ["result" => "fail", "visit_id" => $visit_id, "Error" => $con->error];
}
echo json_encode($arr);

$con->close();

?>
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
    // echo "sql 1 success \n";
    $user_klinik_id = "$con->insert_id";
    // echo $user_klinik_id;
    $sql2 =
        "INSERT INTO `info_pegawai` (`user_klinik_id`, `nama`, `tlp`, `alamat`) VALUES (?,?,?,?)";
    $stmt2 = $con->prepare($sql2);
    $stmt2->bind_param("ssss", $user_klinik_id, $nama, $tlp, $alamat);
    $stmt2->execute();
    if ($stmt2->affected_rows > 0) {
        // $no_antrean = $no_antrean + 1;
        // echo "sql 2 success \n";
        $data = ['username' => $username, 'nama' => $nama, 'tlp' => $tlp, 'alamat' => $alamat,];
        $arr = [
            "result" => "success",
            "data" => $data,
        ];
    }
} else {
    $arr = ["result" => "fail", "visit_id" => $visit_id, "Error" => $con->error];
}
echo json_encode($arr);

$con->close();

?>
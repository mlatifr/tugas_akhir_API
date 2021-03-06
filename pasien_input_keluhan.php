<?php require 'connect.php';
?>
<?php
$visit_id;
extract($_POST);
$sql = "INSERT INTO `visit` (`keluhan`,`nomor_antrean`) VALUES (?,?)";
$stmt = $con->prepare($sql);
$stmt->bind_param("ss", $keluhan, $no_antrean);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    // echo "sql 1 success \n";
    $visit_id = $con->insert_id;
    $sql2 = "INSERT INTO `visit_has_user` (`visit_id`, `user_klinik_id`) VALUES (?,?)";
    $stmt2 = $con->prepare($sql2);
    $stmt2->bind_param("ss", $visit_id, $user_klinik_id);
    $stmt2->execute();
    if ($stmt2->affected_rows > 0) {
        // $no_antrean = $no_antrean + 1;
        // echo "sql 2 success \n";
        $sql3 = "UPDATE antrean_admin SET antrean_terakhir = ? WHERE antrean_admin.id=1";
        $stmt3 = $con->prepare($sql3);
        $stmt3->bind_param("s", $no_antrean);
        $stmt3->execute();
        $arr = [
            "result" => "success",
            "visit_id" => $visit_id,
            "user_klinik_id" => $user_klinik_id,
            "keluhan" => $keluhan,
            'no_antrean' => $no_antrean,
            'tgl_visit' => date('Y-m-d H:i:s')
        ];
    }
} else {
    $arr = ["result" => "fail", "visit_id" => $visit_id, "Error" => $con->error];
}
echo json_encode($arr);

$con->close();

?>
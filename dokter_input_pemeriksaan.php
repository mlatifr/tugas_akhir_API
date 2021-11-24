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
    $visit_id = $con->insert_id;
    // echo $visit_id . ' ' . $user_id;
    // $arr = ["result" => "success", "visit_id" => $visit_id];
    $sql2 = "INSERT INTO `visit_has_user` (`visit_id`, `user_id`) VALUES (?,?)";
    $stmt2 = $con->prepare($sql2);
    $stmt2->bind_param("ss", $visit_id, $user_id);
    $stmt2->execute();
    if ($stmt2->affected_rows > 0) {
        $sql3 = "UPDATE antrean SET `antrean_terakhir` = ? WHERE antrean.id=1";
        $stmt3 = $con->prepare($sql3);
        $stmt3->bind_param("s", $no_antrean);
        $stmt3->execute();
        $arr = [
            "result" => "success", "visit_id" => $visit_id,
            "user_id" => $user_id, "keluhan" => $keluhan,
            'no_antrean' => $no_antrean
        ];
    }
} else {
    $arr = ["result" => "fail", "visit_id" => $visit_id, "Error" => $con->error];
}
echo json_encode($arr);

$con->close();

?>
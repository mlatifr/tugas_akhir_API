<?php require 'connect.php';
?>
<?php
extract($_POST);
foreach ($tindakan_array as $row => $value) {
    echo ($row);
    $tindakan_id = mysqli_real_escape_string($con, $value["tindakan_id"]);
    $visit_id = mysqli_real_escape_string($con, $value["visit_id"]);
    $mt_sisi = mysqli_real_escape_string($con, $value["mt_sisi"]);
    $sql = "INSERT INTO `visit_has_tindakan` (`tindakan_id`,`visit_id`,`mt_sisi`) 
    VALUES ('" . $tindakan_id . "','" .  $visit_id . "','" .  $mt_sisi . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
};
$arr = [];
$data = [];
if ($stmt->affected_rows > 0) {
    // $arr = ["result" => "success", 'jumlah array' => count($tindakan_array), "data" => $tindakan_array];
    $arr = ["data" => $tindakan_array];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, '_post' => $tindakan_array];
}
echo json_encode($arr);
$con->close();
?>
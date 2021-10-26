<?php require 'connect.php';
?>
<?php
extract($_POST);
foreach ($tindakan_array as $row => $value) {
    $tindakan_id = mysqli_real_escape_string($con, $value["tindakan_id"]);
    $visit_id = mysqli_real_escape_string($con, $value["visit_id"]);
    $sql = "INSERT INTO `visit_has_tindakan` (`tindakan_id`,`visit_id`) 
    VALUES ('" . $tindakan_id . "','" .  $visit_id . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
};
$arr = [];
$data = [];
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "data" => $tindakan_array];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($tindakan_array)];
}
echo json_encode($arr);
$con->close();
?>
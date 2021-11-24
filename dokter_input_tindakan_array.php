<?php require 'connect.php';
?>
<?php
$tindakan_id = '';
$visit_id = '';
$mt_sisi = '';
extract($_POST);
$sql = "INSERT INTO `visit_has_tindakan` (`tindakan_id`,`visit_id`,`mt_sisi`) 
    VALUES ('" . $tindakan_id . "','" .  $visit_id . "','" .  $mt_sisi . "')";
$stmt = $con->prepare($sql);
$stmt->execute();

$arr = [];
$data = [];
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "succes"];
    // $arr = ["result" => "success", 'jumlah array' => count($tindakan_array), "data" => $tindakan_array];
    // $arr = ["data" => $tindakan_array];
} else {
    $arr = ["result" => "fail", "Error" => $con->error];
}
echo json_encode($arr);
$con->close();
?>
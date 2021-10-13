<?php require 'connect.php';
?>
<?php
// $visit_id;
extract($_POST);
$sql = "INSERT INTO `penjurnalan` (`user_klinik_id`, `tgl_penjurnalan`)VALUES (?,?)";
$stmt = $con->prepare($sql);
$stmt->bind_param("ss", $user_klinik, $tgl_penjurnalan);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $penjurnalan_id = $con->insert_id;
    $arr = ["result" => "success", "penjurnalan_id" => $con->insert_id];
} else {
    $arr = ["result" => "fail", "penjurnalan_id" => $penjurnalan_id, "Error" => $con->error];
}
echo json_encode($arr);

$con->close();

?>
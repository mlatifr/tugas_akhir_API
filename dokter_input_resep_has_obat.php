<?php require 'connect.php';
?>
<?php
// $visit_id;
extract($_POST);
// echo  $obat_id . ' ' . $dosis . ' ' . $jumlah . ' ' . $visit_id;
$sql = "INSERT INTO `resep_has_obat` (`obat_id`, `dosis`, `jumlah`, `visit_id`) VALUES (?,?,?,?)";
$stmt = $con->prepare($sql);
$stmt->bind_param("ssss", $obat_id, $dosis, $jumlah, $visit_id);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $visit_id = $con->insert_id;
    // echo $visit_id . ' ' . $user_id;
    $arr = ["result" => "success", "resep_has_obat_id" => $con->insert_id];
} else {
    $arr = ["result" => "fail", "visit_id" => $visit_id, "Error" => $con->error];
}
echo json_encode($arr);

$con->close();

?>
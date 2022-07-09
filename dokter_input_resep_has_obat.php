<?php require 'connect.php';
?>
<?php
// $visit_id;
extract($_POST);
echo  $obat_id . ' ' . $dosis . ' ' . $jumlah . ' ' . $visit_id;
$sql = '';
// $sql = "INSERT INTO `resep_has_obat` (`obat_id`, `dosis`, `jumlah`, `visit_id`) VALUES (`$obat_id`, `$dosis`, `$jumlah`, `$visit_id`)";
// $sql = "INSERT INTO `resep_has_obat` (`id`, `obat_id`, `dosis`, `jumlah`, `visit_id`) VALUES (NULL, '20', '3x1', '1', '1')";
$sql = "INSERT INTO `resep_has_obat` (`id`, `obat_id`, `dosis`, `jumlah`, `visit_id`) VALUES (NULL, $obat_id, '$dosis', $jumlah, $visit_id)";
echo '<br>' . $sql;
$stmt = $con->prepare($sql);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $visit_id = $con->insert_id;
    // echo $visit_id . ' ' . $user_id;
    $arr = ["result" => "success", "resep_has_obat_id" => $con->insert_id];
} else {
    $arr = ["result" => "fail error", "sql" => $sql, "Error" => $con->error];
}
echo json_encode($arr);

$con->close();

?>
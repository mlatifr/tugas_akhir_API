<?php require 'connect.php';
?>
<?php
extract($_POST);
foreach ($obat_array as $row => $value) {
    $obat_id = mysqli_real_escape_string($con, $value['obat_id']);
    $dosis = mysqli_real_escape_string($con, $value['dosis']);
    $jumlah = mysqli_real_escape_string($con, $value['jumlah']);
    $visit_id = mysqli_real_escape_string($con, $value['visit_id']);
    $sql = "INSERT INTO `resep_has_obat` ( `obat_id`, `dosis`, `jumlah`, `visit_id`) 
    VALUES ('" . $obat_id . "','" . $dosis . "','" . $jumlah . "','" . $visit_id . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
};
$arr = [];
if ($stmt->affected_rows > 0) {

    $arr = ["result" => "success", "data" => $obat_array];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
}
echo json_encode($arr);

$con->close();

?>
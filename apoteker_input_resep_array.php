<?php require 'connect.php';
?>
<?php
extract($_POST);
foreach ($obat_array as $row => $value) {
    $visit_id = mysqli_real_escape_string($con, $value['visit_id']);
    $nama_pembeli = mysqli_real_escape_string($con, $value['nama_pembeli']);
    $user_id_apoteker = mysqli_real_escape_string($con, $value['user_id_apoteker']);
    $obat_id = mysqli_real_escape_string($con, $value['obat_id']);
    $dosis = mysqli_real_escape_string($con, $value['dosis']);
    $jumlah = mysqli_real_escape_string($con, $value['jumlah']);
    $sql = "INSERT INTO `resep_apoteker` ( `visit_id`, `nama_pembeli`, `user_id_apoteker`, `obat_id`, `dosis`, `jumlah`)
        VALUES ('" . $visit_id . "','" .  $nama_pembeli . "',  '" . $user_id_apoteker . "', '" . $obat_id . "', '" . $dosis . "', '" . $jumlah . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
};
$arr = [];
$data = [];
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "data" => $obat_array];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
}
echo json_encode($arr);

$con->close();

?>
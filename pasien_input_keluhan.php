<?php require 'connect.php';
?>
<?php

extract($_POST);
$sql = "INSERT INTO `visit` (`pasien_id`,`keluhan`) VALUES (?,?)";
$stmt = $con->prepare($sql);
$stmt->bind_param("ss", $pasien_id, $keluhan);

// $sql = "INSERT INTO `visit` 
// (`id`, `dokter_id`, `pasien_id`, `antrean_id`, `kasir_id`, `penjurnalan_id`, `perusahaan`, `tgl_visit`, `tensi_sistole`, `tensi_diastole`, `berat_badan`, `anamnesis`, `keluhan`, `hasil_periksa`) 
// VALUES (NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'keluhan 2', NULL)";
// $stmt = $con->prepare($sql);

$stmt->execute();
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "visit_id" => $con->insert_id, "pasien_id" => $pasien_id];
} else {
    $arr = ["result" => "fail", "Error" => $con->error];
}
echo json_encode($arr);

$con->close();

?>
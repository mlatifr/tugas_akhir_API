<?php require 'connect.php';
?>
<?php

$obat_array = array(
    'tindakan0' => array('1', 'operasi_mata1', 'kiri', '1000000'),
    'tindakan1' => array('1', 'operasi_mata2', 'kanan', '2000000'),
    'tindakan2' => array('1', 'operasi_mata3', 'kiri', '3000000'),
    'tindakan3' => array('1', 'operasi_mata4', 'kanan', '4000000'),
    'tindakan4' => array('1', 'operasi_mata5', 'kiri', '5000000'),
);
foreach ($obat_array as $row => $value) {
    $visit_id = mysqli_real_escape_string($con, $value[0]);
    $nama_tindakan = mysqli_real_escape_string($con, $value[1]);
    $mt_sisi = mysqli_real_escape_string($con, $value[2]);
    $harga = mysqli_real_escape_string($con, $value[3]);
    $sql = "INSERT INTO `tindakan` (`visit_id`, `nama_tindakan`, `mt_sisi`, `harga`) 
    VALUES ('" .  $visit_id . "',  '" . $nama_tindakan . "', '" . $mt_sisi . "', '" . $harga . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
};
$arr = [];
$data = [];
if ($stmt->affected_rows > 0) {
    foreach ($obat_array as $row => $value) {
        $data += [
            "visit_id$row" => $value[0], "nama$row" => $value[1],
            "mt_sisi$row" => $value[2], "harga$row" => $value[3],
        ];
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
}
echo json_encode($arr);

$con->close();

?>
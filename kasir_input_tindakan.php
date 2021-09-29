<?php require 'connect.php';
?>
<?php

$obat_array = array(
    'obat0' => array('1', 'operasi_mata1', 'kiri', '1000000'),
    'obat1' => array('1', 'operasi_mata2', 'kanan', '2000000'),
    'obat2' => array('1', 'operasi_mata3', 'kiri', '3000000'),
    'obat3' => array('1', 'operasi_mata4', 'kanan', '4000000'),
    'obat4' => array('1', 'operasi_mata5', 'kiri', '5000000'),
);
foreach ($obat_array as $row => $value) {
    $visit_id = mysqli_real_escape_string($con, $value[0]);
    $nama = mysqli_real_escape_string($con, $value[1]);
    $mt_sisi = mysqli_real_escape_string($con, $value[2]);
    $harga = mysqli_real_escape_string($con, $value[3]);
    $sql = "INSERT INTO `tindakan` (`visit_id`, `nama`, `mt_sisi`, `harga`) 
    VALUES ('" .  $visit_id . "',  '" . $nama . "', '" . $mt_sisi . "', '" . $harga . "')";
    // mysqli_query($con, $sql);
    $stmt = $con->prepare($sql);
    $stmt->execute();
};
$arr = [];
$data = [];
if ($stmt->affected_rows > 0) {
    foreach ($obat_array as $row => $value) {
        // array_push($arr,  $value[0], $value[1], $value[2],);
        // array_push($data,  $value[0], $value[1], $value[2],);
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
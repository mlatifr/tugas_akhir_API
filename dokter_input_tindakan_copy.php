<?php require 'connect.php';
?>
<?php
extract($_POST);
// echo ("jumlah array : " . count($tindakan_array) . "\n ");
// foreach ($tindakan_array as $row) {
//     echo ($row . "\n ");
// }
// echo print_r($tindakan_array, true);
// echo count($tindakan_array);
echo json_encode($tindakan_array);
echo ("\n");
// $tindakan_array = array(
//     'tindakan0' => array('1', 'operasi_mata1', 'kiri', '1000000'),
//     'tindakan1' => array('1', 'operasi_mata2', 'kanan', '2000000'),
//     'tindakan2' => array('1', 'operasi_mata3', 'kiri', '3000000'),
//     'tindakan3' => array('1', 'operasi_mata4', 'kanan', '4000000'),
//     'tindakan4' => array('1', 'operasi_mata5', 'kiri', '5000000'),
// );
foreach ($tindakan_array as $row => $value) {
    // echo ($value["visit_id"] . "\n" .
    //     $value["nama_tindakan"] . "\n" .
    //     $value["mt_sisi"] . "\n" .
    //     $value["harga"] . "\n");
    $visit_id = mysqli_real_escape_string($con, $value["visit_id"]);
    $nama_tindakan = mysqli_real_escape_string($con, $value["nama_tindakan"]);
    $mt_sisi = mysqli_real_escape_string($con, $value["mt_sisi"]);
    $harga = mysqli_real_escape_string($con, $value["harga"]);
    $sql = "INSERT INTO `tindakan` (`visit_id`, `nama_tindakan`, `mt_sisi`, `harga`) 
    VALUES ('" .  $visit_id . "',  '" . $nama_tindakan . "', '" . $mt_sisi . "', '" . $harga . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
};
$arr = [];
$data = [];
if ($stmt->affected_rows > 0) {
    foreach ($tindakan_array as $row => $value) {
        $data += [
            "visit_id$row" => $value[0], "nama_tindakan$row" => $value[1],
            "mt_sisi$row" => $value[2], "harga$row" => $value[3],
        ];
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($tindakan_array)];
}
echo json_encode($arr);

$con->close();

?>
<?php require 'connect.php';
?>
<?php

$obat_array = array(
    'obat0' => array('4', '7', '000'),
    'obat1' => array('4', '7', '111'),
    'obat2' => array('4', '7', '222'),
    'obat3' => array('4', '7', '333'),
    'obat4' => array('4', '7', '444'),
);
foreach ($obat_array as $row => $value) {
    $resep_id = mysqli_real_escape_string($con, $value[0]);
    $obat_id = mysqli_real_escape_string($con, $value[1]);
    $dosis = mysqli_real_escape_string($con, $value[2]);
    $sql = "INSERT INTO resep_has_obat(`resep_id`, `obat_id`,`dosis`) VALUES ('" . $resep_id . "', '" . $obat_id . "', '" . $dosis . "')";
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
        $data += ["resep_id_$row" => $value[0], "obat_id_$row" => $value[1], "dosis_$row" => $value[2],];
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
}
echo json_encode($arr);

$con->close();

?>
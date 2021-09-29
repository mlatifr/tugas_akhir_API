<?php require 'connect.php';
?>
<?php

$obat_array = array(
    'obat0' => array('1', '4', '7', '000', '7'),
    'obat1' => array('1', '4', '7', '111', '7'),
    'obat2' => array('1', '4', '7', '222', '7'),
    'obat3' => array('1', '4', '7', '333', '7'),
    'obat4' => array('1', '4', '7', '444', '1000'),
);
foreach ($obat_array as $row => $value) {
    $user_id_apoteker = mysqli_real_escape_string($con, $value[0]);
    $resep_id = mysqli_real_escape_string($con, $value[1]);
    $obat_id = mysqli_real_escape_string($con, $value[2]);
    $dosis = mysqli_real_escape_string($con, $value[3]);
    $jumlah = mysqli_real_escape_string($con, $value[4]);
    $sql = "INSERT INTO resep_apoteker(`user_id_apoteker`,`resep_id`, `obat_id`,`dosis`,`jumlah`) 
    VALUES ('" . $user_id_apoteker . "','" . $resep_id . "', '" . $obat_id . "', '" . $dosis . "', '" . $jumlah . "')";
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
            "________$row ________" => $row,
            "user_id_apoteker_$row" => $value[0],
            "resep_id_$row" => $value[1],
            "obat_id_$row" => $value[2],
            "dosis_$row" => $value[3],
            "jumlah_$row" => $value[4],
        ];
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
}
echo json_encode($arr);

$con->close();

?>
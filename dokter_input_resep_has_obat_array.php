<?php require 'connect.php';
?>
<?php

$obat_array = array(
    'obat1' => array('4', '7', '000'),
    'obat2' => array('4', '7', '111'),
    // '2' => array('4', '7', '222'),
    // '3' => array('4', '7', '333'),
    // '4' => array('4', '7', '444'),
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
$arr = ["result" => "success"];
if ($stmt->affected_rows > 0) {
    foreach ($obat_array as $row => $value) {
        // array_push($arr,  $value[0], $value[1], $value[2],);
        $arr += ["resep_id$row" => $value[0], "obat_id$row" => $value[1], "dosis$row" => $value[2]];
        // $arr += ['obat_id' => $value[1]];
        // $arr += ['dosis' => $value[2]];
    }
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($obat_array)];
}
echo json_encode($arr);

$con->close();

?>
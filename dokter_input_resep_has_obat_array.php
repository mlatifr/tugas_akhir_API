<?php require 'connect.php';
?>
<?php

$obat_array = array(
    '0' => array('4', '7', '000'),
    '1' => array('4', '7', '111'),
    '2' => array('4', '7', '222'),
    '3' => array('4', '7', '333'),
);
foreach ($obat_array as $row => $value) {
    $resep_id = mysqli_real_escape_string($con, $value[0]);
    $obat_id = mysqli_real_escape_string($con, $value[1]);
    $dosis = mysqli_real_escape_string($con, $value[2]);
    $sql = "INSERT INTO resep_has_obat(`resep_id`, `obat_id`,`dosis`) VALUES ('" . $resep_id . "', '" . $obat_id . "', '" . $dosis . "')";
    mysqli_query($con, $sql);
};
// $visit_id;
// extract($_POST);

// $jumlah_data = 5;
// $angka_obat = 0;
// for ($i = 0; $i <= $jumlah_data; $i++) {
//     $angka_obat++;
//     $obat = 'obat' . $angka_obat;
//     $dosis = $i . 'x1';
//     // echo ("INSERT INTO `resep_has_obat` (`resep_id`, `obat_id`,`dosis`) VALUES (4,7,$dosis)");
//     $sql = "INSERT INTO `resep_has_obat` (`resep_id`, `obat_id`,`dosis`) VALUES (4,7,$dosis)";
//     $stmt = $con->prepare($sql);
//     $stmt->execute();
// }
// echo $resep_id . ' ' . $obat_id . ' ' . $dosis;
// $sql = "INSERT INTO `resep_has_obat` (`resep_id`, `obat_id`,`dosis`) VALUES (?,?,?)";
// $stmt = $con->prepare($sql);
// $stmt->bind_param("sss", $resep_id, $obat_id, $dosis);
// $stmt->execute();
// if ($stmt->affected_rows > 0) {
//     $visit_id = $con->insert_id;
//     // echo $visit_id . ' ' . $user_id;
//     $arr = ["result" => "success", "resep_has_obat_id" => $con->insert_id];
// } else {
//     $arr = ["result" => "fail", "visit_id" => $visit_id, "Error" => $con->error];
// }
// echo json_encode($arr);

$con->close();

?>
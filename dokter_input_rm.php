<?php require 'connect.php';
?>
<?php
// $idPasien = "%{$_POST['idPasien']}%";
// echo $idPasien;

extract($_POST);
// echo $_POST;
$sql =
    "UPDATE `visit` 
    SET 
    `keluhan` = ?, 
    `vod` = ?, `vos` = ?, `tod` = ?, `tos` = ?, 
    `palpebra` = ?, `konjungtiva` = ?, `kornea` = ?, `bmd` = ?, `lensa` = ?, 
    `fundus_od` = ?, 
    `diagnosa` = ?, 
    `terapi` = ? 
    WHERE `visit`.`id` = ?";
$stmt = $con->prepare($sql);
$stmt->bind_param(
    "ssssssssssssss",
    $keluhan,
    $vod,
    $vos,
    $tod,
    $tos,
    $palpebra,
    $konjungtiva,
    $kornea,
    $bmd,
    $lensa,
    $fundus_od,
    $diagnosa,
    $terapi,
    $idVisit
);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "id_visit" => $idVisit];
} else {
    $arr = ["result" => "fail", "Error" => $con->error];
}
echo json_encode($arr);
$stmt->close();
$con->close();

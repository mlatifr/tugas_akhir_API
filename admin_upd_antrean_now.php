
<?php
error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
extract($_POST);
echo $antrean_sekarang;
$sql = "UPDATE `antrean` SET `antrean_sekarang` = ? WHERE `antrean`.`user_id` = 1";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $antrean_sekarang);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "id" => $con->insert_id];
} else {
    $arr = ["result" => "fail", "Error" => $con->error];
}
echo json_encode($arr);

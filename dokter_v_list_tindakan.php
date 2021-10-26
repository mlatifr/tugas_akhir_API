<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$mt_sisi = "%{$_POST['mt_sisi']}%";
$sql =
    "SELECT id,nama,mt_sisi FROM `tindakan` WHERE mt_sisi LIKE ?";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $mt_sisi);
$stmt->execute();
$result = $stmt->get_result();
$data = [];
if ($result->num_rows > 0) {
    while ($r = mysqli_fetch_assoc($result)) {
        array_push($data, $r);
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "error", "message" => "sql error: $sql"];
}
echo json_encode($arr);
$stmt->close();
$con->close();

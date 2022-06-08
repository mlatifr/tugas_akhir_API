<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$sql =
    "SELECT
    *
    FROM
        `info_pegawai` ip
    INNER JOIN user_klinik uk ON
        ip.user_klinik_id = uk.id
    ";
$stmt = $con->prepare($sql);
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

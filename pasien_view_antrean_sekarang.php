<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$sql = "SELECT * from antrean_admin where user_klinik_id=1";
$stmt = $con->prepare($sql);
$stmt->execute();
$result = $stmt->get_result();
$data = [];
if ($result->num_rows > 0) {
    $r = mysqli_fetch_assoc($result);
    // while ($r = mysqli_fetch_assoc($result)) {
    //     array_push($data, $r);
    // }
    $arr =
        [
            "result" => "success",
            "status_antrean" => $r['status_antrean'],
            "antrean_sekarang" => $r['antrean_sekarang'],
            "antrean_terakhir" => $r['antrean_terakhir'],
            "batas_antrean" => $r['batas_antrean']
        ];
} else {
    $arr = ["result" => "error", "message" => "sql error: $sql"];
}
echo json_encode($arr);
$stmt->close();
$con->close();

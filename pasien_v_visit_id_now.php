<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$user_id = "{$_POST['user_id']}";
$tgl_visit = "%{$_POST['tgl_visit']}%";
$sql =
    "SELECT vst.id as visit_id 
    FROM `visit` vst
    INNER JOIN visit_has_user vhu ON vst.id=vhu.visit_id
    WHERE tgl_visit LIKE ?
    AND vhu.user_klinik_id = ?";
$stmt = $con->prepare($sql);
$stmt->bind_param("ss", $tgl_visit,$user_id);
$stmt->execute();
$result = $stmt->get_result();
$data = [];
if ($result->num_rows > 0) {
    $r = mysqli_fetch_assoc($result);
    // while ($r = mysqli_fetch_assoc($result)) {
    //     array_push($data, $r);
    //     echo($r['visit_id']);
    // }
    $arr = ["result" => "success", "visit_id" => $r['visit_id']];
} else {
    $arr = ["result" => "error", "message" => "sql error: $sql"];
}
echo json_encode($arr);
$stmt->close();
$con->close();

<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
extract($_POST);
// $user_id = "%{$_POST['user_id']}%";
// $visit_id = "%{$_POST['visit_id']}%";
// echo $user_id . ' ' . $tgl_visit;
// echo ' ' . $tgl_visit;
$sql =
    "SELECT *
    FROM `visit_has_tindakan` WHERE visit_id = ? 
    ORDER BY tindakan_id
    ";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $visit_id);
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

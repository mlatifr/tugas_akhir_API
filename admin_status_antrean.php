<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php

// $user_id = "%{$_POST['user_id']}%";
extract($_POST);
// echo ' ' . $vhu_id;
// echo gettype($vhu_id);

$sql = "UPDATE `visit` SET `status_antrean` = ? WHERE `visit`.`id` = ? ";
$stmt = $con->prepare($sql);
$stmt->bind_param("ss", $status, $visit_id);
$stmt->execute();
$result = $con->affected_rows;
if ($result > 0) {
    $arr = ["result" => "success", 'id_visit' => $visit_id, 'status' => $status, "Affected rows: " => $con->affected_rows];
} else {
    $arr = ["result" => "error", "message" => "sql error: $sql"];
}
echo json_encode($arr);
$stmt->close();
$con->close();

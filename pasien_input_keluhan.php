<?php require 'connect.php';
?>
<?php
$visit_id;
extract($_POST);
$sql = "INSERT INTO `visit` (`keluhan`) VALUES (?)";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $keluhan);
$stmt->execute();
if ($stmt->affected_rows > 0) {
    $visit_id = $con->insert_id;
    // echo $visit_id . ' ' . $user_id;
    // $arr = ["result" => "success", "visit_id" => $visit_id];
    $sql2 = "INSERT INTO `visit_has_user` (`visit_id`, `user_id`) VALUES (?,?)";
    $stmt2 = $con->prepare($sql2);
    $stmt2->bind_param("ss", $visit_id, $user_id);
    $stmt2->execute();
    if ($stmt2->affected_rows > 0) {
        $arr = ["result" => "success", "visit_id" => $visit_id, "user_id" => $user_id, "keluhan" => $keluhan];
    }
} else {
    $arr = ["result" => "fail", "visit_id" => $visit_id, "Error" => $con->error];
}
echo json_encode($arr);

$con->close();

?>
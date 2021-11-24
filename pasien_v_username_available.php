<?php require 'connect.php';
?>
<?php
$username = "{$_POST['username']}";
// echo $username;
$sql =
    "SELECT  * FROM `user_klinik` where username = ? ";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
    $arr = ["result" => "username unavailable", "data" => 'username unavailable'];
} else {
    $arr = ["result" => "success", "data" => 'username available'];
}
echo json_encode($arr);
$stmt->close();
$con->close();

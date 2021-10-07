<?php require 'connect.php';
?>
<?php
extract($_POST);
echo $id . '_' . $sandi;
$sql = "SELECT * FROM user_klinik where username=? and sandi=?";
$stmt = $con->prepare($sql);
$stmt->bind_param("ss", $id, $sandi);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
	$r = mysqli_fetch_assoc($result);
	$arr = ["result" => "success", "id" => $r['id']];
} else {
	$arr = ["result" => "error", "message" => "sql error: $sql"];
}
echo json_encode($arr);
// echo('____________');
// echo ($user_name);
// echo ($user_password);
$stmt->close();
$con->close();

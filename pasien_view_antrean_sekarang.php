<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php

// $user_id = "%{$_POST['user_id']}%";
// $tgl_visit = "%{$_POST['tgl_visit']}%";
// echo $user_id . ' ' . $tgl_visit;
$sql = "SELECT * from antrean where user_id=1";
$stmt = $con->prepare($sql);
// $stmt->bind_param("ss", $user_id, $tgl_visit);
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

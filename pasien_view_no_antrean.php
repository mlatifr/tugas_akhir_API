<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php

$namaPasien = "%{$_POST['namaPasien']}%";
$sql = "SELECT *from antrean where nama like ? ";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $namaPasien);
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

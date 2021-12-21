<?php
error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$sql=''; 
$tindakan_nama='';

$tindakan_nama="%{$_POST['tindakan_nama']}%";
if(isset($_POST['tindakan_nama']) ){
    $sql =
        "SELECT * FROM `tindakan` WHERE tindakan.nama LIKE ?;";
    }
else{
$sql =  "SELECT * FROM `tindakan` ";
}
$stmt = $con->prepare($sql);
if(isset($_POST['tindakan_nama']) ){
    $stmt->bind_param("s", $tindakan_nama);
}
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

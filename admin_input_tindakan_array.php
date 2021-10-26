<?php require 'connect.php';
?>
<?php
extract($_POST);
foreach ($tindakan_array as $row => $value) {
    $nama = mysqli_real_escape_string($con, $value["nama"]);
    $mt_sisi = mysqli_real_escape_string($con, $value["mt_sisi"]);
    $harga = mysqli_real_escape_string($con, $value["harga"]);
    $sql = "INSERT INTO `tindakan` ( `nama`, `mt_sisi`, `harga`) 
    VALUES ( '" . $nama . "', '" . $mt_sisi . "', '" . $harga . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();
};
$arr = [];
$data = [];
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "data" => $tindakan_array];
} else {
    $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($tindakan_array)];
}
echo json_encode($arr);
$con->close();
?>
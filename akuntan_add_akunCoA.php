<?php require 'connect.php';
?>
<?php
// $idPasien = "%{$_POST['idPasien']}%";
// echo $idPasien;

extract($_POST);
// echo $_POST;
$sql =
    "INSERT INTO `daftar_akun` (`no`, `nama`) VALUES (?,?)";
$stmt = $con->prepare($sql);
$stmt->bind_param(
    "ss",
    $no,
    $nama
);
$stmt->execute();
$data = ['no' => $no, 'nama' => $nama];
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "fail", "Error" => $con->error];
}
echo json_encode($arr);
$stmt->close();
$con->close();

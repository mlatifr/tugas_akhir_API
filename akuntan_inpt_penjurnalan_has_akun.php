<?php require 'connect.php';
?>
<?php
$arr = [];
extract($_POST);
$id = ($_POST['id']);
$daftar_akun_id = $_POST['daftar_akun_id'];
$tgl_catat = $_POST['tgl_catat'];
$debet = $_POST['debet'];
$kredit = $_POST['kredit'];
$ket_transaksi = $_POST['ket_transaksi'];
$sql =
    "INSERT INTO `penjurnalan_has_akun` 
        (`penjurnalan_id`, `daftar_akun_id`, `tgl_catat`, `debet`, `kredit`, `ket_transaksi`)  
        VALUES 
        ('" . $id . "','" . $daftar_akun_id . "','" . $tgl_catat . "','" . $debet . "','" . $kredit . "','" . $ket_transaksi . "')";
$stmt = $con->prepare($sql);
// echo ('stmt nya adalah:' . $sql);
$stmt->execute();

if ($stmt->affected_rows > 0) {
    $arr = ["result" => "success", "penjurnalan_has_akun_id" => $con->insert_id];
} else {
    $arr = ["result" => "fail", "Error" => $con->error,];
};
echo json_encode($arr);

$con->close();

?>
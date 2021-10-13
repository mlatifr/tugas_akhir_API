<?php require 'connect.php';
?>
<?php
$arr = [];
extract($_POST);
foreach ($transaksi_array as $row => $value) {
    $penjurnalan_id = mysqli_real_escape_string($con, $value['penjurnalan_id']);
    $daftar_akun_id = mysqli_real_escape_string($con, $value['daftar_akun_id']);
    $tgl_catat = mysqli_real_escape_string($con, $value['tgl_catat']);
    $debet = mysqli_real_escape_string($con, $value['debet']);
    $kredit = mysqli_real_escape_string($con, $value['kredit']);
    $ket_transaksi = mysqli_real_escape_string($con, $value['ket_transaksi']);
    $sql =
        "INSERT INTO `penjurnalan_has_akun` 
        (`penjurnalan_id`, `daftar_akun_id`, `tgl_catat`, `debet`, `kredit`, `ket_transaksi`)  
        VALUES 
        ('" . $penjurnalan_id . "','" . $daftar_akun_id . "','" . $tgl_catat . "','" . $debet . "','" . $kredit . "','" . $ket_transaksi . "')";
    $stmt = $con->prepare($sql);
    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        $arr = ["result" => "success", "data" => $transaksi_array];
    } else {
        $arr = ["result" => "fail", "Error" => $con->error, 'jumlah_array' => count($transaksi_array)];
    }
};
echo json_encode($arr);

$con->close();

?>
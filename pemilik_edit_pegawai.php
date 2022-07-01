<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
extract($_POST);
$id_pegawai = isset($_POST['id_pegawai']) ? $_POST['id_pegawai'] : '';
$nama = isset($_POST['nama']) ? $_POST['nama'] : '';
$status =  isset($_POST['status']) ? $_POST['status'] : '';
$unit_kerja =  isset($_POST['unit_kerja']) ? $_POST['unit_kerja'] : '';
$tlp = isset($_POST['tlp']) ? $_POST['tlp'] : '';
$alamat = isset($_POST['alamat']) ? $_POST['alamat'] : '';
if (isset($_POST['id_pegawai']) && isset($_POST['status']) && empty(($_POST['nama']))) {
    $sql =
        "UPDATE
            `info_pegawai`
        SET 
            status = '$status',
        WHERE
            info_pegawai.id = $id_pegawai
        ";
}
//update data pegawai
if (isset($_POST['nama']) && isset($_POST['tlp']) && isset($_POST['alamat']) && isset($_POST['unit_kerja'])) {
    $sql =
        "UPDATE
        `info_pegawai`
    SET
        nama = '$nama', 
        unit_kerja = '$unit_kerja',
        tlp = '$tlp',
        alamat = '$alamat'
    WHERE
        info_pegawai.id = $id_pegawai
    ";
}
// if ($con->query($sql) === TRUE) {
//     $arr = ["result" => "success yes", "data" => $sql];
// } else {
//     $arr = ["result" => "error", "message" => "sql error: $sql"];
// }
// echo json_encode($arr);
echo ($sql);
$con->close();

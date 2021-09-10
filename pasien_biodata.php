<?php require 'connect.php';
?>
<?php
$namaPasien = "%{$_POST['namaPasien']}%";
echo $namaPasien;
$sql =
    "SELECT 
NIK,nama,tempat_lahir,tgl_lahir,kelamin,golongan_darah,alamat,agama,
status_kawin,pekerjaan,kewarganegaraan,tlp,hp 
FROM pasien where nama like ? ";
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

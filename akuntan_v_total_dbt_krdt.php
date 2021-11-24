<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
// extract($_POST);
if (isset($_POST['debet'])) {
    $penjurnalan_id = "{$_POST['penjurnalan_id']}";
    $tgl_catat = "%{$_POST['tgl_catat']}%";
    $sql =
        "SELECT pha.id, pha.penjurnalan_id, pha.daftar_akun_id, da.nama, pha.tgl_catat, SUM(pha.debet) as debet
        FROM penjurnalan_has_akun pha
        INNER JOIN daftar_akun da ON pha.daftar_akun_id=da.id
        WHERE 
        penjurnalan_id =  ?
        AND tgl_catat LIKE ?
        AND debet > 0 
        GROUP BY daftar_akun_id";
}
if (isset($_POST['kredit'])) {
    $penjurnalan_id = "{$_POST['penjurnalan_id']}";
    $tgl_catat = "%{$_POST['tgl_catat']}%";
    $sql =
        "SELECT pha.id, pha.penjurnalan_id, pha.daftar_akun_id, da.nama, pha.tgl_catat, SUM(pha.kredit) as kredit
        FROM penjurnalan_has_akun pha
        INNER JOIN daftar_akun da ON pha.daftar_akun_id=da.id
        WHERE 
        penjurnalan_id =  ?
        AND tgl_catat LIKE ?
        AND kredit > 0 
        GROUP BY daftar_akun_id";
}
$stmt = $con->prepare($sql);
$stmt->bind_param(
    "ss",
    $penjurnalan_id,
    $tgl_catat
);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
    while ($r = mysqli_fetch_assoc($result)) {
        array_push($data, $r);
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "error", "message" => "sql error: $sql"];
}
echo json_encode($arr);
$con->close();
?>
<?php
error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$arr = [];
$data = [];
$tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
$sql = "SELECT
        da.id as noAkun,
        da.nama,
        pj.tgl_catat,
        pj.debet,
        pj.kredit
        FROM
        `penjurnalan` pj
        INNER JOIN daftar_akun da ON
        pj.daftar_akun_id = da.id
        WHERE
        pj.tgl_catat LIKE ?
        ORDER BY
        `pj`.`tgl_catat` ASC
        ";
// echo ('sql nya:' . $tgl_transaksi);
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $tgl_transaksi);
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

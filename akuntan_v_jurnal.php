<?php
error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$arr = [];
$data = [];
$tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
$sql = "SELECT
        pj.id,
        da.nama,
        pj.tgl_penjurnalan,
        pha.debet,
        pha.kredit
        FROM
        `penjurnalan` pj
        INNER JOIN penjurnalan_has_akun pha ON
        pj.id = pha.penjurnalan_id
        INNER JOIN daftar_akun da ON
        pha.daftar_akun_id = da.id
        WHERE
        pj.tgl_penjurnalan LIKE ?
        ORDER BY
        `pj`.`tgl_penjurnalan` ASC";
        echo('sql nya:'.$tgl_transaksi);
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

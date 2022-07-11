<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
extract($_POST);
if (isset($_POST['tgl_transaksi'])) {
    // $tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
    $sql =
        "SELECT
        oh.tanggal,
        oh.nama,
        oh.stok,
        oh.terjual,
        oh.harga_jual,
        oh.harga_beli,
        oh.status_order
    FROM
        obat_history oh
    WHERE
        oh.tanggal LIKE '%$tgl_transaksi%'";
}
// echo 'sql' . $sql;
$stmt = $con->prepare($sql);
// $stmt->bind_param("s", $tgl_transaksi);
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
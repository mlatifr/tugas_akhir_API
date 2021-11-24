<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_transaksi'])) {
    $tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
    $sql =
        "SELECT DATE_FORMAT(np.tgl_transaksi,'%Y-%m') AS periode_transaksi, SUM(np.jasa_medis) as jasa_medis, vst.perusahaan
        FROM nota_penjualan np
        INNER JOIN visit vst ON vst.id=np.visit_id
        WHERE np.tgl_transaksi LIKE ?
        && vst.perusahaan IS NOT NULL";
}
if (isset($_POST['tgl_transaksi_detail'])) {
    $tgl_transaksi = "%{$_POST['tgl_transaksi_detail']}%";
    $sql =
        "SELECT DATE_FORMAT(np.tgl_transaksi,'%Y-%m') AS periode_transaksi, (np.jasa_medis) as jasa_medis, vst.perusahaan
        FROM nota_penjualan np
        INNER JOIN visit vst ON vst.id=np.visit_id
        WHERE np.tgl_transaksi LIKE ?
        && vst.perusahaan IS NOT NULL";
}
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $tgl_transaksi);
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
<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_transaksi'])) {
    $tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
    $sql =
        "SELECT 
        np.tgl_transaksi,
        psn.nama,
        np.total_harga
        FROM nota_penjualan np
        INNER JOIN visit_has_user vhu ON np.visit_id=vhu.visit_id
        INNER JOIN pasien psn ON vhu.user_klinik_id=psn.user_klinik_id
        WHERE tgl_transaksi LIKE ?";
}
// if (isset($_POST['tgl_transaksi_detail'])) {
//     $tgl_transaksi = "%{$_POST['tgl_transaksi_detail']}%";
//     $sql =
//         "SELECT 
//         ob.id, 
//         ob.nama, 
//         ob.jumlah_order, 
//         ob.harga_beli,
//         (ob.jumlah_order * ob.harga_beli)AS total,
//         oo.tgl_order,
//         ob.jumlah_diterima
//         FROM obat ob 
//         INNER JOIN order_obat oo on ob.order_obat_id=oo.id
//         WHERE oo.tgl_order LIKE ?
//         && ob.jumlah_diterima IS NULL";
// }
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
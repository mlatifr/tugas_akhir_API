<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_transaksi'])) {
    $tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
    $sql =
        "SELECT 
            uk.username as nama_pasien,
            DATE_FORMAT(np.tgl_transaksi,'%Y-%m-%d') AS tgl_transaksi,
            np.biaya_admin as total_admin
        FROM nota_penjualan np
        INNER JOIN visit_has_user vhs ON np.visit_id=vhs.visit_id
        INNER JOIN user_klinik uk ON uk.id=vhs.user_klinik_id
        WHERE np.tgl_transaksi LIKE ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_transaksi);
}
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
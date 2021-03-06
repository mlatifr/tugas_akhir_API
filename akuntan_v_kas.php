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
        SUM(np.total_harga) AS total_harga
        FROM nota_penjualan np
        WHERE np.tgl_transaksi LIKE ?";
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
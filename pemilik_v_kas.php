<?php require 'connect.php';
?>
<?php
$tahun = "%{$_POST['tahun']}%";
$sql = 
        "SELECT
        (MONTHNAME(np.tgl_transaksi)) AS bulan,
        SUM(np.total_harga)  AS kas
        FROM
        nota_penjualan np
        WHERE
        YEAR(np.tgl_transaksi) LIKE ?
        GROUP BY
        MONTHNAME(np.tgl_transaksi)
        ORDER BY np.tgl_transaksi
        ";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $tahun);
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

<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_transaksi'])) {    
    $tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
    $sql="SELECT
    obat.nama,
    history_stok.stok,
    obat.harga_beli,
    (history_stok.stok*obat.harga_beli)AS total_harga
    FROM
    `history_stok`
    RIGHT JOIN obat ON history_stok.obat_id = obat.id
    WHERE history_stok.stok IS NOT NULL
    AND history_stok.tgl_transaksi LIKE '$tgl_transaksi'";
    // echo($sql);
}else {
    $sql =
    "SELECT 
    `nama`,
    `stok`,
    `harga_beli`
FROM `obat` ";
}    
$stmt = $con->prepare($sql);
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
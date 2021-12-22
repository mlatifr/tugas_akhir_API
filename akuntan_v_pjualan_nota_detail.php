<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_nota'])) {
    $tgl_nota = "%{$_POST['tgl_nota']}%";
    $sql =
        "SELECT 
        np.id as no_nota,
        np.tgl_transaksi,
        np.total_harga,
        us.username as nama_kasir
        FROM nota_penjualan np
        INNER JOIN resep_apoteker ra ON np.visit_id=ra.visit_id
        INNER JOIN user_klinik us ON us.id=np.user_id  
        WHERE np.tgl_transaksi LIKE ?
        ORDER BY `np`.`tgl_transaksi`  ASC;
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_nota);
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
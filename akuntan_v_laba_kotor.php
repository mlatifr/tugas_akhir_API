<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_laba_kotor'])) {
    $tgl_laba_kotor = "%{$_POST['tgl_laba_kotor']}%";
    $sql =
        "SELECT 
        np.tgl_transaksi as tgl_transaksi,
        SUM((raho.jumlah*obt.harga_jual)-(raho.jumlah*obt.harga_beli)) as laba_kotor
        FROM rsp_aptkr_has_obat raho
        INNER JOIN obat obt ON obt.id=raho.obat_id
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id 
        INNER JOIN nota_penjualan np ON np.visit_id=ra.visit_id 
        WHERE np.tgl_transaksi LIKE ?
        GROUP BY np.tgl_transaksi
        ORDER BY `np`.`tgl_transaksi` ASC";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_laba_kotor);
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
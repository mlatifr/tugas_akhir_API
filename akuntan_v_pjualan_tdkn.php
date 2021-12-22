<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_visit_detail'])) {
    $tgl_visit_detail = "%{$_POST['tgl_visit_detail']}%";
    $sql =
        "SELECT 
        tindakan.nama as namaTindakan,
        tindakan.harga as harga,
        nota_penjualan.tgl_transaksi as tglTransaksi
        FROM tindakan 
        INNER JOIN visit_has_tindakan 
        ON visit_has_tindakan.tindakan_id=tindakan.id
        INNER JOIN nota_penjualan 
        ON nota_penjualan.visit_id=visit_has_tindakan.visit_id
        WHERE nota_penjualan.tgl_transaksi LIKE ?
        GROUP BY nota_penjualan.tgl_transaksi
        ORDER BY `nota_penjualan`.`tgl_transaksi` ASC; 
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_visit_detail);
} elseif (isset($_POST['tgl_visit'])) {
    $tgl_visit = "%{$_POST['tgl_visit']}%";
    $sql =
        "SELECT sum(harga) as total_tdk, vst.tgl_visit as tgl_tdkan
        FROM tindakan tdk
        INNER JOIN visit_has_tindakan vht ON tdk.id=vht.visit_id
        INNER JOIN visit vst ON vst.id=vht.visit_id
        WHERE vst.tgl_visit LIKE ?
        &&  vst.perusahaan IS NULL";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_visit);
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
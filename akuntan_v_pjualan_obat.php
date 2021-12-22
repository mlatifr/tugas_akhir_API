<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_resep_detail'])) {
    $tgl_resep_detail = "%{$_POST['tgl_resep_detail']}%";
    $sql =
        "SELECT 
            ra.id as resep_id,
            obt.nama as nama_obat,raho.jumlah, 
            (raho.jumlah*obt.harga_jual) as total_harga, 
            ra.tgl_penulisan_resep as tgl_resep
        FROM rsp_aptkr_has_obat raho
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id         
        INNER JOIN visit vst ON ra.visit_id=vst.id
        INNER JOIN obat obt ON obt.id=raho.obat_id
        WHERE ra.tgl_penulisan_resep LIKE ? 
        &&  vst.perusahaan IS NULL";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_resep_detail);
}
// kalau pembeli obat merupakan pasien yg visit
elseif (isset($_POST['tgl_resep_nota'])) {
    $tgl_resep_nota = "%{$_POST['tgl_resep_nota']}%";
    $sql =
        "SELECT 
        nota_penjualan.id as nota_id,
        nota_penjualan.user_id as user_kasir,
        nota_penjualan.visit_id as visit_id
        FROM `nota_penjualan` 
        WHERE tgl_transaksi LIKE ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_resep_nota);
} elseif (isset($_POST['tgl_penjualan'])) {
    $tgl_penjualan = "%{$_POST['tgl_penjualan']}%";
    $sql =
        "SELECT 
        np.tgl_transaksi as tgl_transaksi,
        ra.id as resep_id,
        obt.id as obat_id,
        obt.nama,
        raho.jumlah,
        obt.harga_jual as harga,
        (raho.jumlah*obt.harga_jual) as total_harga
        FROM rsp_aptkr_has_obat raho
        INNER JOIN obat obt ON obt.id=raho.obat_id
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id 
        INNER JOIN nota_penjualan np ON np.visit_id=ra.visit_id 
        WHERE np.tgl_transaksi LIKE ?
        GROUP BY np.tgl_transaksi
        ORDER BY `np`.`tgl_transaksi` ASC;
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_penjualan);
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
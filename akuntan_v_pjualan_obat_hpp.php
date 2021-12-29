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
            (raho.jumlah*obt.harga_beli) as total_harga, 
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
elseif (isset($_POST['tgl_resep_visit'])) {
    $tgl_resep_visit = "%{$_POST['tgl_resep_visit']}%";
    $sql =
        "SELECT 
        SUM(raho.jumlah*obt.harga_beli) as total_harga, 
        ra.tgl_penulisan_resep as tgl_resep
        FROM rsp_aptkr_has_obat raho
        INNER JOIN obat obt ON obt.id=raho.obat_id
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id 
        INNER JOIN visit vst ON ra.visit_id=vst.id
        WHERE ra.tgl_penulisan_resep LIKE ?
        &&  vst.perusahaan IS NULL";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_resep_visit);
} elseif (isset($_POST['tgl_hpp_obat'])) {
    $tgl_hpp_obat = "%{$_POST['tgl_hpp_obat']}%";
    $sql =
        "SELECT 
        np.tgl_transaksi as tgl_transaksi,
        raho.jumlah,
        obt.harga_beli as harga,
        (raho.jumlah*obt.harga_beli) as total_harga
        FROM rsp_aptkr_has_obat raho
        INNER JOIN obat obt ON obt.id=raho.obat_id
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id 
        INNER JOIN nota_penjualan np ON np.visit_id=ra.visit_id 
        WHERE np.tgl_transaksi LIKE ?
        GROUP BY np.tgl_transaksi
        ORDER BY `np`.`tgl_transaksi` ASC;
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_hpp_obat);
}elseif (isset($_POST['tgl_total_hpp_obat'])) {
    $tgl_total_hpp_obat = "%{$_POST['tgl_total_hpp_obat']}%";
    $sql =
        "SELECT 
        SUM(raho.jumlah * obat.harga_beli) as hpp_total
        FROM nota_penjualan np
        INNER JOIN resep_apoteker ra ON np.tgl_transaksi
        INNER JOIN rsp_aptkr_has_obat raho ON raho.resep_apoteker_id=ra.id
        INNER JOIN obat ON raho.obat_id=obat.id
        WHERE np.tgl_transaksi LIKE ?
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_total_hpp_obat);
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
<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_list_nota_hpp'])) {
    $tgl_list_nota_hpp = "%{$_POST['tgl_list_nota_hpp']}%";
    $sql =
        "SELECT 
        np.id as no_nota,
        (raho.jumlah*obt.harga_beli)as total
        FROM rsp_aptkr_has_obat raho
        INNER JOIN obat obt ON obt.id=raho.obat_id
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id 
        INNER JOIN nota_penjualan np ON np.visit_id=ra.visit_id 
        WHERE np.tgl_transaksi LIKE ?
        ORDER BY np.id ASC";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_list_nota_hpp);
}
// kalau pembeli obat merupakan pasien yg visit
elseif (isset($_POST['tgl_list'])) {
    //list nota untuk hpp
    $tgl_list = "%{$_POST['tgl_list']}%";
    $sql =
        "SELECT 
        SUM(raho.jumlah*obt.harga_beli) as total_harga, 
        ra.tgl_penulisan_resep as tgl_resep
        FROM rsp_aptkr_has_obat raho
        INNER JOIN obat obt ON obt.id=raho.obat_id
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id 
        INNER JOIN visit vst ON ra.visit_id=vst.id
        INNER JOIN nota_penjualan np ON np.resep_apoteker_id=ra.id
        WHERE ra.tgl_penulisan_resep LIKE ?
        -- &&  vst.perusahaan IS NULL
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_list);
} elseif (isset($_POST['tgl_hpp_nota_obat'])) {
    $tgl_hpp_nota_obat = "%{$_POST['tgl_hpp_nota_obat']}%";
    $sql =
        "SELECT 
        np.id as no_nota,
        (raho.jumlah*obt.harga_beli)as total
        FROM rsp_aptkr_has_obat raho
        INNER JOIN obat obt ON obt.id=raho.obat_id
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id 
        INNER JOIN nota_penjualan np ON np.visit_id=ra.visit_id 
        WHERE np.tgl_transaksi LIKE ?
        ORDER BY np.id ASC;
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_hpp_nota_obat);
}elseif (isset($_POST['tgl_total_hpp_obat'])) {
    $tgl_total_hpp_obat = "%{$_POST['tgl_total_hpp_obat']}%";
    $sql =
        "SELECT 
        SUM(raho.jumlah*obat.harga_beli) as total_harga, 
        ra.tgl_penulisan_resep as tgl_resep
        FROM nota_penjualan np
        INNER JOIN resep_apoteker ra ON np.resep_apoteker_id=ra.id
        INNER JOIN rsp_aptkr_has_obat raho ON raho.resep_apoteker_id=ra.id
        INNER JOIN obat ON raho.obat_id=obat.id
        WHERE np.tgl_transaksi LIKE ?
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_total_hpp_obat);
}elseif (isset($_POST['nota_id'])) {
    $nota_id = "%{$_POST['nota_id']}%";
    $sql =
        "SELECT 
		obat.nama,
        raho.jumlah,
        obat.harga_beli,
        (raho.jumlah*obat.harga_beli) as total_harga
        FROM nota_penjualan np
        INNER JOIN resep_apoteker ra ON np.resep_apoteker_id=ra.id
        INNER JOIN rsp_aptkr_has_obat raho ON raho.resep_apoteker_id=ra.id
        INNER JOIN obat ON raho.obat_id=obat.id
        WHERE np.id LIKE ?
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $nota_id);
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
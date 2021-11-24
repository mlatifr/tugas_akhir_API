<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_resep_detail']) && isset($_POST['perusahaan'])) {
    $tgl_resep_detail = "%{$_POST['tgl_resep_detail']}%";
    $perusahaan = "%{$_POST['perusahaan']}%";
    $sql =
        "SELECT 
            vst.perusahaan,
            ra.id as resep_id,
            obt.nama as nama_obat,raho.jumlah, 
            (raho.jumlah*obt.harga_jual) as total_harga, 
            ra.tgl_penulisan_resep as tgl_resep
        FROM rsp_aptkr_has_obat raho
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id         
        INNER JOIN visit vst ON ra.visit_id=vst.id
        INNER JOIN obat obt ON obt.id=raho.obat_id
        WHERE ra.tgl_penulisan_resep LIKE ? 
        &&  vst.perusahaan LIKE ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $tgl_resep_detail, $perusahaan);
} elseif (isset($_POST['tgl_resep']) && isset($_POST['perusahaan'])) {
    $tgl_resep = "%{$_POST['tgl_resep']}%";
    $perusahaan = "%{$_POST['perusahaan']}%";
    $sql =
        "SELECT 
            vst.perusahaan,
            SUM(raho.jumlah*obt.harga_jual) as total_harga, 
            ra.tgl_penulisan_resep as tgl_resep
        FROM rsp_aptkr_has_obat raho
        INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id 
        INNER JOIN visit vst ON ra.visit_id=vst.id
        INNER JOIN obat obt ON obt.id=raho.obat_id
        WHERE ra.tgl_penulisan_resep LIKE ?
        &&  vst.perusahaan LIKE ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $tgl_resep, $perusahaan);
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
$stmt->close();
$con->close();
?>
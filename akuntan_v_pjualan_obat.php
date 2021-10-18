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
} elseif (isset($_POST['tgl_resep'])) {
    $tgl_resep = "%{$_POST['tgl_resep']}%";
    $sql =
        "SELECT 
        SUM(raho.jumlah*obt.harga_jual) as total_harga, 
         ra.tgl_penulisan_resep as tgl_resep
     FROM rsp_aptkr_has_obat raho
     INNER JOIN resep_apoteker ra ON ra.id=raho.resep_apoteker_id 
     INNER JOIN visit vst ON ra.visit_id=vst.id
     INNER JOIN obat obt ON obt.id=raho.obat_id
     WHERE ra.tgl_penulisan_resep LIKE ?
     &&  vst.perusahaan IS NULL";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_resep);
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
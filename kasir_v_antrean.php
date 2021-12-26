<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$tgl_visit = "%{$_POST['tgl_visit']}%";
$tgl_penulisan_resep = "%{$_POST['tgl_penulisan_resep']}%";
$resep_id_non_visit = "{$_POST['resep_id_non_visit']}";
if (isset($_POST['tgl_visit'])) {
    $sql =
    "SELECT 
    vst.id as visit_id, 
    vhu.id as vhu_id, 
    vhu.user_klinik_id as pasien_id, 
    `tgl_visit`, 
    user_klinik.username as username, 
    pasien.nama as nama, 
    `nomor_antrean`, 
    `status_antrean`, 
    `keluhan` ,
    np.total_harga
FROM `visit`vst 
    INNER JOIN visit_has_user vhu on vst.id=vhu.visit_id 
    INNER JOIN user_klinik on vhu.user_klinik_id=user_klinik.id 
    INNER JOIN pasien on user_klinik.id=pasien.user_klinik_id 
    LEFT JOIN nota_penjualan np ON np.visit_id=vst.id
WHERE tgl_visit LIKE ?
    AND user_klinik.username NOT LIKE '%dokter%' 
    AND np.total_harga IS NULL
ORDER BY `vst`.`nomor_antrean` ASC";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $tgl_visit);
}
elseif (isset($_POST['tgl_penulisan_resep'])) {
    $sql =
    "SELECT 
    ra.id AS resep_apoteker_id,
    ra.tgl_penulisan_resep,
    ra.nama_pembeli
    FROM resep_apoteker ra 
    INNER JOIN rsp_aptkr_has_obat raho
    ON ra.id=raho.resep_apoteker_id  
    INNER JOIN nota_penjualan np ON np.id=ra.id
    WHERE ra.tgl_penulisan_resep LIKE ?
    AND np.id IS NULL
    GROUP BY ra.id  
    ORDER BY `ra`.`tgl_penulisan_resep`  ASC";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $tgl_penulisan_resep);
}
elseif (isset($_POST['resep_id_non_visit'])) {
    $sql =
    "SELECT 
    ra.id as resep_id,
    ra.tgl_penulisan_resep,
    ra.nama_pembeli,
    obat.nama,
    raho.jumlah,
    obat.harga_jual
    FROM resep_apoteker ra 
    INNER JOIN rsp_aptkr_has_obat raho ON ra.id = raho.resep_apoteker_id
    INNER JOIN obat ON raho.obat_id=obat.id  
    INNER JOIN nota_penjualan np ON np.id=ra.id
    WHERE ra.id=?
    AND np.id IS NULL";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $resep_id_non_visit);
}

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

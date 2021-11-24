<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
$stmt = '';
// extract($_POST);
// $nama_pembeli = "{$_POST['nama_pembeli']}";
// $user_id = "%{$_POST['user_id']}%";
// $visit_id = "%{$_POST['visit_id']}%";
// echo $user_id . ' ' . $tgl_visit;
// echo ' ' . $tgl_visit;
if (isset($_POST['visit_id']) && isset($_POST['tgl_resep'])) {
    $visit_id = "{$_POST['visit_id']}";
    $tgl_resep = "%{$_POST['tgl_resep']}%";
    $sql =
        "SELECT 
        ra.id as resep_id,
        ra.visit_id as visit_id,
        ra.nama_pembeli,
        ra.user_id_apoteker,
        ra.tgl_penulisan_resep as tgl_resep,
        raho.obat_id as obat_id,
        jumlah,
        dosis,
        obt.nama,
        obt.stok,
        obt.kadaluarsa,
        obt.harga_jual
    FROM resep_apoteker ra
    INNER JOIN rsp_aptkr_has_obat raho ON ra.id=raho.resep_apoteker_id
    INNER JOIN obat obt ON raho.obat_id=obt.id
    where visit_id = ? AND ra.tgl_penulisan_resep LIKE ?
    ORDER BY `obt`.`nama` ASC";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $visit_id, $tgl_resep);
} elseif (isset($_POST['nama_pembeli']) && isset($_POST['tgl_resep'])) {
    $tgl_resep = "%{$_POST['tgl_resep']}%";
    $nama_pembeli = "%{$_POST['nama_pembeli']}%";
    $sql = "SELECT 
                ra.id as resep_id,
                ra.nama_pembeli,
                ra.user_id_apoteker,
                ra.tgl_penulisan_resep as tgl_resep,
                raho.obat_id as obat_id,
                jumlah,
                dosis,
                obt.nama,
                obt.stok,
                obt.kadaluarsa,
                obt.harga_jual
            FROM resep_apoteker ra
            INNER JOIN rsp_aptkr_has_obat raho ON ra.id=raho.resep_apoteker_id
            INNER JOIN obat obt ON raho.obat_id=obt.id
            WHERE nama_pembeli like ? AND ra.tgl_penulisan_resep LIKE ?
            ORDER BY `obt`.`nama` ASC";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $nama_pembeli, $tgl_resep);
} elseif (isset($_POST['tgl_resep'])) {
    $tgl_resep = "%{$_POST['tgl_resep']}%";
    $sql = "SELECT 
                ra.id as resep_id,
                ra.nama_pembeli,
                ra.user_id_apoteker,
                ra.tgl_penulisan_resep as tgl_resep,
                raho.obat_id as obat_id,
                jumlah,
                dosis,
                obt.nama,
                obt.stok,
                obt.kadaluarsa,
                obt.harga_jual
            FROM resep_apoteker ra
            INNER JOIN rsp_aptkr_has_obat raho ON ra.id=raho.resep_apoteker_id
            INNER JOIN obat obt ON raho.obat_id=obt.id
            WHERE ra.tgl_penulisan_resep LIKE ?
            ORDER BY `obt`.`nama` ASC";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_resep);
} elseif (isset($_POST['nama_pembeli'])) {
    $nama_pembeli = "%{$_POST['nama_pembeli']}%";
    $sql = "SELECT 
                ra.id as resep_id,
                ra.nama_pembeli,
                ra.user_id_apoteker,
                ra.tgl_penulisan_resep as tgl_resep,
                raho.obat_id as obat_id,
                jumlah,
                dosis,
                obt.nama,
                obt.stok,
                obt.kadaluarsa,
                obt.harga_jual
            FROM resep_apoteker ra
            INNER JOIN rsp_aptkr_has_obat raho ON ra.id=raho.resep_apoteker_id
            INNER JOIN obat obt ON raho.obat_id=obt.id
            WHERE nama_pembeli like ? 
            ORDER BY `obt`.`nama` ASC";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $nama_pembeli);
} elseif (isset($_POST['visit_id'])) {
    $visit_id = "{$_POST['visit_id']}";
    $sql = "SELECT 
                ra.id as resep_id,
                ra.nama_pembeli,
                ra.user_id_apoteker,
                ra.tgl_penulisan_resep as tgl_resep,
                raho.obat_id as obat_id,
                jumlah,
                dosis,
                obt.nama,
                obt.stok,   
                obt.kadaluarsa,
                obt.harga_jual
            FROM resep_apoteker ra
            INNER JOIN rsp_aptkr_has_obat raho ON ra.id=raho.resep_apoteker_id
            INNER JOIN obat obt ON raho.obat_id=obt.id
            WHERE visit_id = ?
            ORDER BY `obt`.`nama` ASC";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $visit_id);
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

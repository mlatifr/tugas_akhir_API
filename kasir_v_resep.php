<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
extract($_POST);
$nama_pembeli = "{$_POST['nama_pembeli']}";
// $user_id = "%{$_POST['user_id']}%";
// $visit_id = "%{$_POST['visit_id']}%";
// echo $user_id . ' ' . $tgl_visit;
// echo ' ' . $tgl_visit;
if ($visit_id) {
    $sql = "SELECT 
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
            where visit_id = ?
            ORDER BY `obt`.`nama` ASC";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $visit_id);
} elseif ($nama_pembeli) {
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
};
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

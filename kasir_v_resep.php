<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php
extract($_POST);
$nama_pembeli = "%{$_POST['nama_pembeli']}%";
// $user_id = "%{$_POST['user_id']}%";
// $visit_id = "%{$_POST['visit_id']}%";
// echo $user_id . ' ' . $tgl_visit;
// echo ' ' . $tgl_visit;
if ($visit_id != null) {
    $sql = "SELECT 
                resep_apoteker.visit_id,
                -- user_id_apoteker as usr_id_aptkr,
                nama_pembeli,
                obat_id,
                -- dosis,
                jumlah,
                -- resep.id as resep_id,
                -- visit_id,
                -- obat.id as id_obat,
                nama as nama_obat,
                -- stok,
                kadaluarsa,
                harga_jual
                -- harga_beli
            FROM resep_apoteker 
            INNER JOIN obat ON resep_apoteker.obat_id=obat.id 
            WHERE visit_id = ? 
            ORDER BY `obat`.`nama` ASC";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $visit_id);
} elseif ($nama_pembeli != null) {
    $sql = "SELECT 
                -- resep_apoteker.visit_id,
                -- user_id_apoteker as usr_id_aptkr,
                nama_pembeli,
                obat_id,
                -- dosis,
                jumlah,
                -- resep.id as resep_id,
                -- visit_id,
                -- obat.id as id_obat,
                nama as nama_obat,
                -- stok,
                kadaluarsa,
                harga_jual
                -- harga_beli
            FROM resep_apoteker 
            INNER JOIN obat ON resep_apoteker.obat_id=obat.id 
            WHERE nama_pembeli like ? 
            ORDER BY `obat`.`nama` ASC";
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

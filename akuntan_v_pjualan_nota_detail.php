<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['nota_id'])) {
    $nota_id = "{$_POST['nota_id']}";
    $sql =
        "SELECT 
		obat.nama,
        raho.jumlah as jumlah_terjual,
        obat.harga_jual,
    	(obat.harga_jual*raho.jumlah) as total_harga
        FROM nota_penjualan np
        INNER JOIN resep_apoteker ra ON np.visit_id=ra.visit_id
        INNER JOIN rsp_aptkr_has_obat raho ON ra.id=raho.resep_apoteker_id
        INNER JOIN obat ON obat.id=raho.obat_id
        WHERE np.id=?
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
<?php require 'connect.php';
?>
<?php
// $resep_apoteker_id = "{$_POST['resep_apoteker_id']}";
$sql =
    "SELECT obt.nama, raho.jumlah, raho.dosis, obt.stok
    FROM rsp_aptkr_has_obat raho 
    INNER JOIN obat obt on raho.obat_id=obt.id 
    WHERE resep_apoteker_id = ?    
";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $resep_apoteker_id);
$stmt->execute();
$result = $stmt->get_result();
$data = [];
if ($result->num_rows > 0) {
    while ($r = mysqli_fetch_assoc($result)) {
        array_push($data, $r);
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "error", "data" => 'tidak ditemukan', "message" => "sql error: $sql"];
}
echo json_encode($arr);
$stmt->close();
$con->close();

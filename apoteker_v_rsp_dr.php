<?php require 'connect.php';
?>
<?php
$visit_id = "{$_POST['visit_id']}";
$sql =
    "SELECT 
        rho.id resep_dokter_id,
        rho.obat_id as obat_id,
        obt.nama,
        rho.dosis,
        rho.jumlah
    FROM resep_has_obat rho
    INNER JOIN obat obt ON obt.id=rho.obat_id
    where visit_id = ?";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $visit_id);
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

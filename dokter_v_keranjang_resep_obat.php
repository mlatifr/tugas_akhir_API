<?php require 'connect.php';
?>
<?php
$visit_id = "{$_POST['visit_id']}";
$sql =
    "SELECT obt.id,obt.nama,rho.jumlah,rho.dosis 
    FROM resep_has_obat rho
    INNER JOIN obat obt ON rho.obat_id=obt.id
    WHERE visit_id = ?
";
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
    $arr = ["result" => "error", "data" => 'tidak ditemukan', "message" => "sql error: $sql"];
}
echo json_encode($arr);
$stmt->close();
$con->close();

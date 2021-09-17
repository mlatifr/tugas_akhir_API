<?php require 'connect.php';
?>
<?php
$visit_id = "%{$_POST['visit_id']}%";
$sql = "SELECT 
visit.id as visit_id,
obat.nama as obat, 
resep_has_obat.dosis as dosis 
FROM `resep` 
JOIN resep_has_obat
ON resep_has_obat.resep_id=resep.id
JOIN obat 
ON resep_has_obat.obat_id=obat.id
JOIN visit 
ON resep.visit_id=visit.id
WHERE visit.id like ?
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

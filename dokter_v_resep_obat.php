<?php require 'connect.php';
?>
<?php
// $tgl_visit = "%{$_POST['tgl_visit']}%";
$sql = "SELECT * FROM `resep` 
JOIN obat 
ON resep.id=obat.resep_id
JOIN visit 
ON resep.visit_id=visit.id
";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $tgl_visit);
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

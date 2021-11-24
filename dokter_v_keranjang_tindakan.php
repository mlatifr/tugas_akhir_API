<?php require 'connect.php';
?>
<?php
$visit_id = "{$_POST['visit_id']}";
$sql =
    "SELECT * FROM visit_has_tindakan vht
    INNER JOIN tindakan tdkn on vht.tindakan_id=tdkn.id
    WHERE visit_id = ?
    ORDER BY tdkn.nama
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

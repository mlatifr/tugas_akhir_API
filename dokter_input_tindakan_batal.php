<?php require 'connect.php';
?>
<?php
// $tindakan_id = "{$_POST['tindakan_id']}";
// $visit_id = "{$_POST['tindakan_id']}";
// $mt_sisi = "%{$_POST['mt_sisi']}%";
extract($_POST);
$sql = "DELETE 
FROM `visit_has_tindakan` 
WHERE tindakan_id=?
AND visit_id =?
AND mt_sisi LIKE ?";
$stmt = $con->prepare($sql);
$stmt->bind_param("sss", $tindakan_id, $visit_id, $mt_sisi);
$stmt->execute();
$arr = [];
$data = [];
if ($stmt->affected_rows > 0) {
    $arr = ["result" => "succes", 'batal input' => 'berhasil'];
    // $arr = ["result" => "success", 'jumlah array' => count($tindakan_array), "data" => $tindakan_array];
    // $arr = ["data" => $tindakan_array];
} else {
    $arr = ["result" => "fail", 'sql' => $sql, "Error" => $con->error];
}
echo json_encode($arr);
$con->close();
?>
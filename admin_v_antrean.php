<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php

// $user_id = "%{$_POST['user_id']}%";
$tgl_visit = "%{$_POST['tgl_visit']}%";
// echo $user_id . ' ' . $tgl_visit;
// echo ' ' . $tgl_visit;
$sql = "SELECT 
vst.id as visit_id,
vhu.id as vhu_id,
vhu.user_id as pasien_id,
`tgl_visit`,user_klinik.username as username,
`nomor_antrean`,
`status_antrean`,
`keluhan`
FROM `visit`vst 
INNER JOIN visit_has_user vhu on vst.id=vhu.visit_id 
INNER JOIN user_klinik on vhu.user_id=user_klinik.id 
where tgl_visit like ? AND user_klinik.username NOT LIKE '%dokter%' ";
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

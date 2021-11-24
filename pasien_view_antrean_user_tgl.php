<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php

$user_klinik_id = "%{$_POST['user_klinik_id']}%";
$tgl_visit = "%{$_POST['tgl_visit']}%";
// echo $user_id . ' ' . $tgl_visit;
$sql = "SELECT user_klinik.id as id_user, visit.nomor_antrean as no_antre , visit.tgl_visit
from visit
join visit_has_user on visit.id=visit_has_user.visit_id
join user_klinik on visit_has_user.user_klinik_id=user_klinik.id
 where user_klinik.id like ? and visit.tgl_visit like ? ";
$stmt = $con->prepare($sql);
$stmt->bind_param("ss", $user_klinik_id, $tgl_visit);
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

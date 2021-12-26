<?php

error_reporting(E_ALL | E_PARSE);
require 'connect.php';
?>
<?php

// $user_id = "%{$_POST['user_id']}%";
$tgl_visit = "%{$_POST['tgl_visit']}%";
// echo $user_id . ' ' . $tgl_visit;
// echo ' ' . $tgl_visit;
$sql =
    "SELECT 
		vst.id AS visit_id,
        vhu.id AS vhu_id,
        vhu.user_klinik_id AS pasien_id,
        `tgl_visit`,
        user_klinik.username AS username,
        `nomor_antrean`,
        `status_antrean`,
        `keluhan`
    FROM `visit` vst 
    INNER JOIN visit_has_user vhu ON vst.id=vhu.visit_id 
    INNER JOIN user_klinik ON vhu.user_klinik_id=user_klinik.id 
    LEFT JOIN resep_apoteker ra ON ra.visit_id=vst.id 
	WHERE tgl_visit LIKE ?
    AND user_klinik.username NOT LIKE '%dokter%'
    AND ra.id IS NULL
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

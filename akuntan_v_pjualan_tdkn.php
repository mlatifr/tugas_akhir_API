<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_visit_detail'])) {
    $tgl_visit_detail = "%{$_POST['tgl_visit_detail']}%";
    $sql =
        "SELECT 
        vst.tgl_visit as tgl,
        tdk.nama as tindakan,
        tdk.harga as harga,
        vhu.id,
        vhu.user_klinik_id,
        psn.nama as nama_pasien
        FROM visit_has_tindakan vht
        INNER JOIN visit vst ON vht.visit_id=vst.id
        INNER JOIN tindakan tdk ON vht.tindakan_id=tdk.id
        INNER JOIN visit_has_user vhu ON vst.id=vhu.visit_id
        INNER JOIN user_klinik uk ON uk.id=vhu.user_klinik_id
        INNER JOIN pasien psn ON vhu.user_klinik_id=psn.user_klinik_id
        WHERE vst.tgl_visit LIKE ? 
        &&  vst.perusahaan IS NULL
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_visit_detail);
} elseif (isset($_POST['tgl_visit'])) {
    $tgl_visit = "%{$_POST['tgl_visit']}%";
    $sql =
        "SELECT sum(harga) as total_tdk, vst.tgl_visit as tgl_tdkan
        FROM tindakan tdk
        INNER JOIN visit_has_tindakan vht ON tdk.id=vht.visit_id
        INNER JOIN visit vst ON vst.id=vht.visit_id
        WHERE vst.tgl_visit LIKE ?
        &&  vst.perusahaan IS NULL";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_visit);
}
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
    while ($r = mysqli_fetch_assoc($result)) {
        array_push($data, $r);
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "error", "message" => "sql error: $sql"];
}
echo json_encode($arr);
$con->close();
?>
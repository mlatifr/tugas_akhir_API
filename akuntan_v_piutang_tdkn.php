<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_visit_detail']) && isset($_POST['perusahaan'])) {
    $tgl_visit_detail = "%{$_POST['tgl_visit_detail']}%";
    $perusahaan = "%{$_POST['perusahaan']}%";
    $sql =
        "SELECT *
        FROM tindakan tdk
        INNER JOIN visit vst ON vst.id=tdk.visit_id
        WHERE vst.tgl_visit LIKE ?
        &&  vst.perusahaan LIKE ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $tgl_visit_detail, $perusahaan);
} elseif (isset($_POST['tgl_visit']) && isset($_POST['perusahaan'])) {
    $tgl_visit = "%{$_POST['tgl_visit']}%";
    $perusahaan = "%{$_POST['perusahaan']}%";
    $sql =
        "SELECT 
        vst.perusahaan,SUM(harga) as total_tdk, vst.tgl_visit as tgl_tdkan
        FROM tindakan tdk
        INNER JOIN visit vst ON vst.id=tdk.visit_id
        WHERE vst.tgl_visit LIKE ?
        &&  vst.perusahaan LIKE ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("ss", $tgl_visit, $perusahaan);
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
$stmt->close();
$con->close();
?>
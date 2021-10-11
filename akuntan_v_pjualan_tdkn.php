<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_visit_detail'])) {
    $tgl_visit_detail = "%{$_POST['tgl_visit_detail']}%";
    $sql =
        "SELECT *
        FROM tindakan tdk
        INNER JOIN visit vst ON vst.id=tdk.visit_id
        WHERE vst.tgl_visit LIKE ? ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_visit_detail);
} elseif (isset($_POST['tgl_visit'])) {
    $tgl_visit = "%{$_POST['tgl_visit']}%";
    $sql =
        "SELECT SUM(harga) as total_tdk, vst.tgl_visit as tgl_tdkan
        FROM tindakan tdk
        INNER JOIN visit vst ON vst.id=tdk.visit_id
        WHERE vst.tgl_visit LIKE ?";
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
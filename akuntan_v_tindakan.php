<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
extract($_POST);
if (isset($_POST['tgl_transaksi'])) {
    // $tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
    $sql =
        "SELECT
            vst.tgl_visit,
            uk.username,
            vht.id AS visit_has_tindakan_id,
            tdkn.nama,
            tdkn.harga,
            vht.mt_sisi
        FROM
            visit_has_tindakan vht
        INNER JOIN tindakan tdkn ON
            tdkn.id = vht.tindakan_id
        INNER JOIN visit vst ON
            vst.id = vht.visit_id
        INNER JOIN visit_has_user vhu ON
            vst.id = vhu.visit_id
        INNER JOIN user_klinik uk ON
            vhu.user_klinik_id = uk.id
        WHERE
            vst.tgl_visit LIKE '%$tgl_transaksi%'";
}
// echo 'sql' . $sql;
$stmt = $con->prepare($sql);
// $stmt->bind_param("s", $tgl_transaksi);
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
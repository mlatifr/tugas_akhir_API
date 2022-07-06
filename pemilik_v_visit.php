<?php require 'connect.php';
?>
<?php
$tahun = "%{$_POST['tahun']}%";
$sql = 
        "SELECT
        MONTHNAME(vst.tgl_visit) AS bulan,
        COUNT(vst.tgl_visit) AS visit
        FROM
            visit vst
        INNER JOIN visit_has_user vhu ON
            vst.id = vhu.visit_id
        INNER JOIN pasien psn ON
            psn.user_klinik_id = vhu.user_klinik_id
        WHERE
            YEAR(vst.tgl_visit) LIKE ?
        GROUP BY
            MONTH(vst.tgl_visit)
        ORDER BY
            vst.tgl_visit
        ";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $tahun);
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

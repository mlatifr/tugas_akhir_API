<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
extract($_POST);
if (isset($_POST['tgl_transaksi'])) {
    $sql =
        "SELECT
            pnjr.tgl_catat,
            da.no,
            da.nama,
            SUM(pnjr.debet) AS debet,
            SUM(pnjr.kredit) AS kredit
        FROM
            `penjurnalan` pnjr
        JOIN daftar_akun da ON
            da.id = pnjr.daftar_akun_id
        WHERE
            pnjr.tgl_catat LIKE '%$tgl_transaksi%'
        GROUP BY
            da.nama
        ORDER BY
            da.no ASC";
}
// echo $sql;
$stmt = $con->prepare($sql);
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
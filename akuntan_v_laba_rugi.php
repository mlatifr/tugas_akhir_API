<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
extract($_POST);
if (isset($_POST['tgl_transaksi'])) {
    $sql =
        "SELECT DISTINCT
            /*pendapatan*/
            (
            SELECT
                (
                    SUM(pnjr.debet) - SUM(pnjr.kredit)
                ) AS pendapatan
            FROM
                `penjurnalan` pnjr
            JOIN daftar_akun da ON
                da.id = pnjr.daftar_akun_id
            WHERE
                da.no < 500 AND pnjr.tgl_catat LIKE '%$tgl_transaksi%'
        ) AS pendapatan,
        /*biaya*/
        (
            SELECT
                SUM((pnjr.kredit) -(pnjr.debet)) AS biaya
            FROM
                `penjurnalan` pnjr
            JOIN daftar_akun da ON
                da.id = pnjr.daftar_akun_id
            WHERE
                da.no >= 500 AND pnjr.tgl_catat LIKE '%$tgl_transaksi%'
        ) AS biaya,
        /*laba*/
        (
            (
            SELECT
                (
                    SUM(pnjr.debet) - SUM(pnjr.kredit)
                ) AS pendapatan
            FROM
                `penjurnalan` pnjr
            JOIN daftar_akun da ON
                da.id = pnjr.daftar_akun_id
            WHERE
                da.no < 500 AND pnjr.tgl_catat LIKE '%$tgl_transaksi%'
        ) -(
            SELECT
                SUM((pnjr.kredit) -(pnjr.debet)) AS biaya
            FROM
                `penjurnalan` pnjr
            JOIN daftar_akun da ON
                da.id = pnjr.daftar_akun_id
            WHERE
                da.no >= 500 AND pnjr.tgl_catat LIKE '%$tgl_transaksi%'
        )
        ) AS laba
        FROM
            `penjurnalan` pnjr
       ";
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
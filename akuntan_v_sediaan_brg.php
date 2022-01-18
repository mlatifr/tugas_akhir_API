<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_transaksi'])) {    
    $tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
    $sql=
    "SELECT
    obat.nama,
    SUM(history_stok.stok) AS stok,
    obat.harga_beli,
    (
    SELECT
        SUM(
            history_stok.stok * obt1.harga_beli
        ) AS stok
    FROM
        `history_stok`
    INNER JOIN obat obt1 ON
        obt1.id = history_stok.obat_id
    WHERE
        obt1.nama LIKE obat.nama
    ) AS total_harga
    FROM
        `history_stok`
    RIGHT JOIN obat ON history_stok.obat_id = obat.id
    WHERE
        history_stok.stok IS NOT NULL AND history_stok.tgl_transaksi LIKE '%2022-01-18 %'
    GROUP BY
        obat.nama
    ";
    // "SELECT
    // obat.nama,
    // history_stok.stok,
    // obat.harga_beli,
    // (history_stok.stok*obat.harga_beli)AS total_harga
    // FROM
    // `history_stok`
    // RIGHT JOIN obat ON history_stok.obat_id = obat.id
    // WHERE history_stok.stok IS NOT NULL
    // AND history_stok.tgl_transaksi LIKE '$tgl_transaksi'";
    // // echo($sql);
}else {
    $sql =
    "SELECT
    obt.nama AS nama,
    SUM(obt.stok) AS stok,
    (
    SELECT
        SUM(obt1.stok * obt1.harga_beli)
    FROM
        obat obt1
    WHERE
        obt.nama = obt1.nama
    ) AS total_harga
    FROM
        obat AS obt
    WHERE
        (obt.stok) > 0
    GROUP BY
        obt.nama
    ORDER BY
        obt.nama ASC";
}    
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
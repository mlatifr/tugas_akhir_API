<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['no_nota'])) {
    $no_nota = "{$_POST['no_nota']}";
    $sql =
        "SELECT 
        vht.mt_sisi,
        tdk.nama,
        tdk.harga
        FROM nota_penjualan np
        INNER JOIN visit ON np.visit_id=visit.id
        INNER JOIN visit_has_tindakan vht on vht.visit_id=visit.id
        INNER JOIN tindakan tdk ON tdk.id=vht.tindakan_id
        WHERE np.id = ?
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $no_nota);
} elseif (isset($_POST['tgl_list_nota'])) {
    $tgl_list_nota = "%{$_POST['tgl_list_nota']}%";
    $sql =
        "SELECT 
        np.id as nota_id,
         SUM(tdk.harga) as total_harga
        FROM nota_penjualan np
        INNER JOIN visit vst ON np.visit_id=vst.id
        INNER JOIN visit_has_tindakan vht ON vht.visit_id=vst.id
        INNER JOIN tindakan tdk ON tdk.id=vht.tindakan_id
        WHERE np.tgl_transaksi LIKE ?
        GROUP BY np.id";
        // "SELECT 
        // np.id as nota_id,
        //     (SELECT 
        //     SUM(tdk.harga) as harga
        //     FROM nota_penjualan np
        //     INNER JOIN visit vst ON np.visit_id=vst.id
        //     INNER JOIN visit_has_tindakan vht ON vht.visit_id=vst.id
        //     INNER JOIN tindakan tdk ON tdk.id=vht.tindakan_id
        //     WHERE np.tgl_transaksi LIKE ?)as total_harga
        // FROM nota_penjualan np
        // INNER JOIN visit vst ON np.visit_id=vst.id
        // INNER JOIN visit_has_tindakan vht ON vht.visit_id=vst.id
        // INNER JOIN tindakan tdk ON tdk.id=vht.tindakan_id
        // WHERE np.tgl_transaksi LIKE ?
        // GROUP BY np.id
        // ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_list_nota);
} elseif (isset($_POST['tgl_transaksi'])) {
    $tgl_transaksi = "%{$_POST['tgl_transaksi']}%";
    $sql =
        "SELECT 
        np.tgl_transaksi,
        SUM(tdk.harga) as harga
        FROM nota_penjualan np
        INNER JOIN visit vst ON np.visit_id=vst.id
        INNER JOIN visit_has_tindakan vht ON vht.visit_id=vst.id
        INNER JOIN tindakan tdk ON tdk.id=vht.tindakan_id
        WHERE np.tgl_transaksi LIKE ?
        ";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_transaksi);
} elseif (isset($_POST['tgl_total_tindakan'])) {
    $tgl_total_tindakan = "%{$_POST['tgl_total_tindakan']}%";
    $sql =
        "SELECT 
        SUM(tdk.harga) as total_tindakan
        FROM nota_penjualan np
        INNER JOIN visit vst ON np.visit_id=vst.id
        INNER JOIN visit_has_tindakan vht ON vht.visit_id=vst.id
        INNER JOIN tindakan tdk ON tdk.id=vht.tindakan_id
        WHERE np.tgl_transaksi LIKE ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_total_tindakan);
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
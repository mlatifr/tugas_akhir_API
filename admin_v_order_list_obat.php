<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['order_id'])) {
    $order_id = "{$_POST['order_id']}"; 
    //    echo $tgl_order.'|tanggal order DB';
    $sql =
        "SELECT 
        oobt.tgl_order,
        obt.id as id_obat,
        obt.order_obat_id as order_id,
        obt.jumlah_order,
        obt.jumlah_diterima,
        obt.nama,
        obt.stok,
        obt.kadaluarsa,
        obt.harga_jual,
        obt.harga_beli,
        obt.status_order
        FROM order_obat oobt
        INNER JOIN obat obt ON oobt.id=obt.order_obat_id
        WHERE obt.status_order like '%pemesanan%'  
        AND oobt.id = ?
        ";
        // echo $sql;
}
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $order_id);
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
<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
    $sql =
        "SELECT 
        oobt.tgl_order,
        obt.id,
        obt.jumlah_order,
        obt.jumlah_diterima,
        obt.nama,
        obt.stok,
        obt.status_order
        FROM order_obat oobt
        INNER JOIN obat obt ON oobt.id=obt.order_obat_id
        WHERE obt.status_order like '%pemesanan%'
        GROUP BY oobt.tgl_order
        -- AND oobt.tgl_order LIKE ?
        ";

$stmt = $con->prepare($sql);
// $stmt->bind_param("s", $tgl_order);
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
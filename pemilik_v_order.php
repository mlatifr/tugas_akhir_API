<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
if (isset($_POST['tgl_order'])) {
    $tgl_order = "%{$_POST['tgl_order']}%";
    $sql =
        "SELECT oo.id as order_obat_id, obt.id, obt.nama, obt.jumlah_order, oo.tgl_order
        FROM order_obat oo
        INNER JOIN obat obt ON oo.id=obt.order_obat_id
        WHERE oo.tgl_order LIKE ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $tgl_order);
}
if (isset($_POST['order_obat_id'])) {
    $order_obat_id = "%{$_POST['order_obat_id']}%";
    $sql =
        "SELECT oo.id as order_obat_id, obt.id, obt.nama, obt.jumlah_order, oo.tgl_order
        FROM order_obat oo
        INNER JOIN obat obt ON oo.id=obt.order_obat_id
        WHERE oo.id = ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("s", $_POST['order_obat_id']);
} else {
    $format_tgl_now = date('Y-m-d');
    $tgl_now = "'%$format_tgl_now%'";
    // echo $tgl_now;
    $sql =
        "SELECT oo.id as order_obat_id, obt.id, obt.nama, obt.jumlah_order, oo.tgl_order
            FROM order_obat oo
            INNER JOIN obat obt ON oo.id=obt.order_obat_id
            WHERE oo.tgl_order LIKE $tgl_now ";
    $stmt = $con->prepare($sql);
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
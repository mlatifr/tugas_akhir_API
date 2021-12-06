<?php require 'connect.php';
?>
<?php
$arr = [];
$data = [];
    $sql =
        "SELECT 
        `nama`,
        `stok`,
        `harga_beli`
        FROM `obat` ";
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
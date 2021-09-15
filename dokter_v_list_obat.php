<?php require 'connect.php';
?>
<?php
$nama_obat = "%{$_POST['nama_obat']}%";
$sql = "SELECT 
kso.id, nama, sum(kso.jmlh) as stok
FROM obat 
join kartu_stok_obat kso
on obat.kartu_stok_obat_id=kso.id
where nama like ?
GROUP BY nama ";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $nama_obat);
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

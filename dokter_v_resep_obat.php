<?php require 'connect.php';
?>
<?php
$user_id = "{$_POST['user_id']}";
$sql =
    "SELECT 
        p.nama as pasien, 
        v.tgl_visit, 
        obt.nama as obat, 
        rho.dosis, 
        rho. jumlah
    FROM pasien p
    INNER JOIN user_klinik uk ON p.user_id=uk.id
    INNER JOIN visit_has_user vhu 
    INNER JOIN visit v ON vhu.visit_id=v.id 
    INNER JOIN resep_has_obat rho ON v.id=rho.visit_id
    INNER JOIN obat obt on rho.obat_id=obt.id
    WHERE uk.id = ?
    ORDER BY v.tgl_visit DESC
";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $user_id);
$stmt->execute();
$result = $stmt->get_result();
$data = [];
if ($result->num_rows > 0) {
    while ($r = mysqli_fetch_assoc($result)) {
        array_push($data, $r);
    }
    $arr = ["result" => "success", "data" => $data];
} else {
    $arr = ["result" => "error", "data" => 'tidak ditemukan', "message" => "sql error: $sql"];
}
echo json_encode($arr);
$stmt->close();
$con->close();

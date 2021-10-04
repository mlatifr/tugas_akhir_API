<?php require 'connect.php';
?>
<?php
$user_id = "{$_POST['user_id']}";
$sql =
    "SELECT 
        p.nama as pasien, 
        v.tgl_visit, 
        obt.nama as obat
    FROM pasien p
    INNER JOIN user_klinik uk ON p.user_id=uk.id
    INNER JOIN visit_has_user vhu 
    INNER JOIN visit v ON vhu.visit_id=v.id 
    INNER JOIN resep_apoteker ra ON v.id=ra.visit_id
    INNER JOIN rsp_aptkr_has_obat raho ON raho.resep_apoteker_id=ra.id 
    INNER JOIN obat obt on raho.obat_id=obt.id
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

<?php require 'connect.php';
?>
<?php
$idPasien = "%{$_POST['idPasien']}%";
// echo $idPasien;
$sql =
    "SELECT 
        user_klinik.username,
        visit.tgl_visit as tgl,
        keluhan,
        vod,vos,tod,tos,
        palpebra,konjungtiva,kornea,bmd,lensa,
        fundus_od as f_od,
        diagnosa, terapi
    FROM `visit` 
    join visit_has_user on visit.id=visit_has_user.visit_id
    join user_klinik on visit_has_user.user_klinik_id=user_klinik.id
    where user_klinik.id like ? 
    ORDER BY `visit`.`tgl_visit` DESC";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $idPasien);
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

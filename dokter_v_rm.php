<?php require 'connect.php';
?>
<?php
$userPasien = "%{$_POST['userPasien']}%";
echo $userPasien;
$sql =
    "SELECT visit.tgl_visit as tgl,user.username, anamnesis, keluhan, hasil_periksa FROM `visit` 
    join visit_has_user on visit.id=visit_has_user.visit_id
    join user on visit_has_user.user_id=user.id
    where user.id like ? 
    ORDER BY `visit`.`tgl_visit` DESC";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $userPasien);
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

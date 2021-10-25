<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
header("Access-Control-Allow-Credentials=true");
header("Access-Control-Allow-Headers=Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale");
header("Access-Control-Allow-Methods=POST, OPTIONS");
$arr = null;
$con = new mysqli("localhost", "root", "", "klinik");
if ($con->connect_error) {
    $arr = ["result" => "error", "message" => "unable to connect"];
    echo json_encode($arr);
    die();
}
?>
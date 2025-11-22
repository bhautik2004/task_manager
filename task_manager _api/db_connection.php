<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$host = "localhost";
$db_name = "task_manager";
$username = "root";
$password = "";

$conn = mysqli_connect($host, $username, $password, $db_name);

if (!$conn) {
    die(json_encode(array("error" => "Connection failed: " . mysqli_connect_error())));
}
?>

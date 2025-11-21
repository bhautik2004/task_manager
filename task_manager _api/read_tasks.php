<?php
include_once 'db_connection.php';

$query = "SELECT * FROM tasks ORDER BY created_at DESC";
$stmt = $conn->prepare($query);
$stmt->execute();

$tasks_arr = array();
$tasks_arr["data"] = array();

while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    array_push($tasks_arr["data"], $row);
}

echo json_encode($tasks_arr);

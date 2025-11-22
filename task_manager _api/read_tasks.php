<?php
include_once 'db_connection.php';

$query = "SELECT * FROM tasks ORDER BY created_at DESC";
$stmt = mysqli_prepare($conn, $query);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

$tasks_arr = array();
$tasks_arr["data"] = array();

while ($row = mysqli_fetch_assoc($result)) {
    array_push($tasks_arr["data"], $row);
}

echo json_encode($tasks_arr);

mysqli_stmt_close($stmt);

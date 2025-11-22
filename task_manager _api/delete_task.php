<?php
include_once 'db_connection.php';

$data = json_decode(file_get_contents("php://input"));
$id = $data->id;

$query = "DELETE FROM tasks WHERE id = ?";
$stmt = mysqli_prepare($conn, $query);

mysqli_stmt_bind_param($stmt, "i", $id);

if(mysqli_stmt_execute($stmt)) {
    echo json_encode(array("message" => "Task deleted successfully."));
} else {
    echo json_encode(array("message" => "Unable to delete task."));
}

mysqli_stmt_close($stmt);
?>

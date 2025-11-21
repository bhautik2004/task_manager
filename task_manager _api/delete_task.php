<?php
include_once 'db_connection.php';

$data = json_decode(file_get_contents("php://input"));
$id = $data->id;

$query = "DELETE FROM tasks WHERE id = ?";
$stmt = $conn->prepare($query);

if($stmt->execute([$id])) {
    echo json_encode(array("message" => "Task deleted successfully."));
} else {
    echo json_encode(array("message" => "Unable to delete task."));
}
?>

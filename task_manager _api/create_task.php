<?php
include_once 'db_connection.php';

$data = json_decode(file_get_contents("php://input"));

$query = "INSERT INTO tasks (title, description, priority, due_date, is_completed) VALUES (?, ?, ?, ?, ?)";
$stmt = $conn->prepare($query);

$title = $data->title;
$description = $data->description ?? '';
$priority = $data->priority ?? 'medium';
$due_date = $data->due_date ?? null;
$is_completed = $data->is_completed ? 1 : 0;

if($stmt->execute([$title, $description, $priority, $due_date, $is_completed])) {
    echo json_encode(array("message" => "Task created successfully."));
} else {
    echo json_encode(array("message" => "Unable to create task."));
}
?>

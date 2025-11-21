<?php
include_once '../config/database.php';
include_once '../models/Task.php';

$database = new Database();
$db = $database->getConnection();

$task = new Task($db);

$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        $stmt = $task->read();
        $num = $stmt->rowCount();
        
        $tasks_arr = array();
        $tasks_arr["data"] = array();
        
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            array_push($tasks_arr["data"], $row);
        }
        
        echo json_encode($tasks_arr);
        break;
        
    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        
        $task->title = $data->title;
        $task->description = $data->description;
        $task->category_id = $data->category_id;
        $task->priority = $data->priority;
        $task->due_date = $data->due_date;
        
        if($task->create()) {
            echo json_encode(array("message" => "Task created successfully."));
        } else {
            echo json_encode(array("message" => "Unable to create task."));
        }
        break;
        
    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));
        
        $task->id = $data->id;
        $task->title = $data->title;
        $task->description = $data->description;
        $task->category_id = $data->category_id;
        $task->priority = $data->priority;
        $task->due_date = $data->due_date;
        $task->is_completed = $data->is_completed;
        
        if($task->update()) {
            echo json_encode(array("message" => "Task updated successfully."));
        } else {
            echo json_encode(array("message" => "Unable to update task."));
        }
        break;
        
    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));
        $task->id = $data->id;
        
        if($task->delete()) {
            echo json_encode(array("message" => "Task deleted successfully."));
        } else {
            echo json_encode(array("message" => "Unable to delete task."));
        }
        break;
        
    default:
        http_response_code(405);
        echo json_encode(array("message" => "Method not allowed."));
        break;
}
?>
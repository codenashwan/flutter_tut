<?php include('include/config.php');
header('Content-Type: application/json');
if(isset($_GET['user_id'])){
    $user_id = $_GET['user_id'];

 $query  = mysqli_query($db , "SELECT * FROM `post` WHERE `user_id` =  '$user_id'");
 $json =[];
 while($row = mysqli_fetch_assoc($query)){
     $json[] = $row;
 }
 echo json_encode($json);
}
?> 
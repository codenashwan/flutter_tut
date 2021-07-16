<?php include('include/config.php');
header('Content-Type: application/json');
 $query  = mysqli_query($db , "SELECT * FROM `user` ");
 $json =[];
 while($row = mysqli_fetch_assoc($query)){
     $json[] = $row;
 }
 echo json_encode($json);
?> 
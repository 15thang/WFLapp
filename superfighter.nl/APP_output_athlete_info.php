<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$athlete_id = $_GET['athlete_id'];

$json_array = array();
$query = "SELECT * FROM `athletes` WHERE athlete_id = '$athlete_id'";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $json_array[] = $row;
}

echo json_encode($json_array, JSON_PRETTY_PRINT);
?>
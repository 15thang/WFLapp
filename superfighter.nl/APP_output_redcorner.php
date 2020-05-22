<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$event_id = $_GET['event_id'];

$json_array = array();
$query = "SELECT * FROM `athletes` WHERE athlete_id IN (SELECT redcorner FROM `eventcompetition` WHERE event_id = '$event_id')";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $json_array[] = $row;
}

echo json_encode($json_array, JSON_PRETTY_PRINT);
?>
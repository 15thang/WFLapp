<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$today = date("Y-m-d");

$json_array = array();
$query = "SELECT * FROM `events` WHERE NOT event_name = 'event_0' AND event_date < '$today'";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $json_array[] = $row;
}

echo json_encode($json_array, JSON_PRETTY_PRINT);
?>
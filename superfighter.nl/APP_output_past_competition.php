<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$json_array = array();
$query = "SELECT * FROM `competition` WHERE NOT event7 = 0 ORDER BY `competition`.`competition_id` DESC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $json_array[] = $row;
}

echo json_encode($json_array, JSON_PRETTY_PRINT);
?>
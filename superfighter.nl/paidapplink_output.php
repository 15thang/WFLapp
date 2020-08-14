<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

//dit bestand werkt nog alleen voor android

$json_array = array();
$only1a = 0;
$only1b = 0;
$query = "SELECT * FROM `appstorelink` WHERE store = 'android' ORDER BY `id` DESC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {

    $json_array[] = $row;

}

echo json_encode($json_array, JSON_PRETTY_PRINT);
?>
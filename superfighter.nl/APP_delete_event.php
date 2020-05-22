<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$event_id = $_GET['event_id'];

$vraag = "DELETE FROM events WHERE event_id = '$event_id'";
$resultaat = mysqli_query($db, $vraag);

header('location: APP_events.php');

echo $event_id;
?>
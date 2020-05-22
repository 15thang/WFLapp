<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$athlete_id = $_GET['athlete_id'];

$vraag = "DELETE FROM athletes WHERE athlete_id = '$athlete_id'";
$resultaat = mysqli_query($db, $vraag);

header('location: APP_website2.php');
?>
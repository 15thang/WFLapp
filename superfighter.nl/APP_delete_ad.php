<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$ad_id = $_GET['ad_id'];

$vraag = "DELETE FROM `ads` WHERE ad_id = '$ad_id'";
$resultaat = mysqli_query($db, $vraag);

header('location: APP_advertentie.php');
?>
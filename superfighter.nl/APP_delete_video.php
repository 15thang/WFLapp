<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$video_id = $_GET['video_id'];

$vraag = "DELETE FROM `videos` WHERE video_id = '$video_id'";
$resultaat = mysqli_query($db, $vraag);

header('location: APP_videos.php');
?>
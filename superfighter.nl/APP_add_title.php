<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$athlete_id = $_GET['athlete_id'];
$title = $_GET['title'];

$query = "INSERT INTO athletetitles (athlete_id, title) 
      	  VALUES('$athlete_id', '$title')";
mysqli_query($db, $query);

header("Location: http://superfighter.nl/APP_athlete_info.php?athlete_id=".$athlete_id);
?>
<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$blue_id = $_GET['blue_id'];
$event_id = $_GET['event_id'];
$comp_id = $_GET['comp_id'];

$vraag = "SELECT match_id FROM matches WHERE match_id IN 
         (SELECT match_id FROM `eventcompetition` WHERE event_id = '$event_id' AND bluecorner = '$blue_id' AND competition_id = '$comp_id')";
$resultaat = mysqli_query($db, $vraag);
while ($row = $resultaat->fetch_assoc()) {
    $match_id = $row['match_id'];
}
$vraag = "DELETE FROM matches WHERE match_id = '$match_id'";
$resultaat = mysqli_query($db, $vraag);
$vraag = "DELETE FROM eventcompetition WHERE match_id = '$match_id'";
$resultaat = mysqli_query($db, $vraag);

header('location: APP_event_info.php?event_id='.$event_id.'&events7=');
?>

<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$red_id = $_GET['red_id'];
$event_id = $_GET['event_id'];
$comp_id = $_GET['comp_id'];

$vraag = "SELECT match_id FROM matches WHERE match_id IN 
         (SELECT match_id FROM `eventcompetition` WHERE event_id = '$event_id' AND redcorner = '$red_id' AND competition_id = '$comp_id')";
$resultaat = mysqli_query($db, $vraag);
while ($row = $resultaat->fetch_assoc()) {
    $match_id = $row['match_id'];
}
$vraag = "DELETE FROM matches WHERE match_id = '$match_id'";
$resultaat = mysqli_query($db, $vraag);
$vraag = "DELETE FROM eventcompetition WHERE match_id = '$match_id'";
$resultaat = mysqli_query($db, $vraag);

header('location: APP_event_info.php?event_id='.$event_id.'&events7=');
?>
<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$blue_id = $_GET['blue_id'];
$red_id = $_GET['red_id'];
$athlete_id = $_GET['athlete_id'];
$event_id = $_GET['event_id'];
$comp_id = $_GET['comp_id'];
$redyellowcard = $_GET['redyellowcard'];
$points = $_GET['points'];
$tkoko = $_GET['ko'];

if ($blue_id == 0) {
    $corner = "red";
} else if ($red_id == 0) {
    $corner = "blue";
}
//get match_id
$query = "SELECT * FROM `eventcompetition` WHERE event_id = '$event_id' AND competition_id = '$comp_id' AND bluecorner = '$athlete_id' OR event_id = $event_id AND competition_id = $comp_id AND redcorner = $athlete_id";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    $match_id = $row['match_id'];
}

$vraag = "UPDATE matches SET redyellowcard = '$redyellowcard', points = '$points',
          ko = '$tkoko', corner = '$corner'
          WHERE match_id = '$match_id' AND athlete_id = '$athlete_id'";

$resultaat = mysqli_query($db, $vraag);

$eventArray[] = array();
$query = "SELECT * FROM competition WHERE competition_id = '$comp_id'";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    //events
    $event0 = $row['event0'];//fake event, remains hidden
    $event1 = $row['event1'];
    $event2 = $row['event2'];
    $event3 = $row['event3'];
    $event4 = $row['event4'];
    $event5 = $row['event5'];
    $event6 = $row['event6'];
    $event7 = $row['event7'];
    $event8 = $row['event8'];
    $event9 = $row['event9'];

    $eventArray[] = $event1;
    $eventArray[] = $event2;
    $eventArray[] = $event3;
    $eventArray[] = $event4;
    $eventArray[] = $event5;
    $eventArray[] = $event6;
    $eventArray[] = $event7;
    $eventArray[] = $event8;
    $eventArray[] = $event9;
}
$total_points = 0;
foreach ($eventArray as $eventid) {
    $query = "SELECT * FROM matches WHERE event_id = '$eventid' AND athlete_id = '$athlete_id'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        $total_points += $row['points'];
    }
}

$query = "UPDATE athletecompetition SET points = '$total_points' WHERE athlete_id = '$athlete_id' AND competition_id = '$comp_id'";
mysqli_query($db, $query);
header('location: APP_athlete_total_stats.php?comp_id='.$comp_id.'&athlete_id='.$athlete_id);
?>
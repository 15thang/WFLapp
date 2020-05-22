<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$event_id = $_GET['event_id'];
$selected_comp = $_GET['competition_id'];
$red_cornerID = $_GET['redcorner_id'];
$blue_cornerID = $_GET['bluecorner_id'];
$events7 = $_GET['events7'];

//fetch match id
$query = "SELECT match_id FROM `eventcompetition` WHERE event_id = '$event_id' AND competition_id = '$selected_comp' AND redcorner = '$red_cornerID' AND bluecorner = '$blue_cornerID'";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    $match_id = $row['match_id'];
}

//fetch blue athlete data
$query = "SELECT * FROM `athletes` WHERE athlete_id = '$blue_cornerID'";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    $athlete_name1 = $row['athlete_firstname'].' '.$row['athlete_lastname'];
    $athlete_nickname1 = $row['athlete_nickname'];
    $athlete_grade1 = $row['athlete_grade'];
    $athlete_weightclass1 = $row['athlete_weightclass'];
    $athlete_picture1 = $row['athlete_picture'];
}
//fetch red athlete data
$query = "SELECT * FROM `athletes` WHERE athlete_id = '$red_cornerID'";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    $athlete_name2 = $row['athlete_firstname'].' '.$row['athlete_lastname'];
    $athlete_nickname2 = $row['athlete_nickname'];
    $athlete_grade2 = $row['athlete_grade'];
    $athlete_weightclass2 = $row['athlete_weightclass'];
    $athlete_picture2 = $row['athlete_picture'];
}

//put the match in database 'matches'
//blue
$vraag = "INSERT INTO matches (match_id, event_id, redyellowcard, points, ko, corner, athlete_id, athlete_name, athlete_nickname, athlete_grade, athlete_weightclass, athlete_picture)
                VALUES ('$match_id', '$event_id', 'No cards', '0', 'No KO', 'blue', '$blue_cornerID', '$athlete_name1', '$athlete_nickname1', '$athlete_grade1', '$athlete_weightclass1', '$athlete_picture1')";
$resultaat = mysqli_query($db, $vraag);
//red
$vraag = "INSERT INTO matches (match_id, event_id, redyellowcard, points, ko, corner, athlete_id, athlete_name, athlete_nickname, athlete_grade, athlete_weightclass, athlete_picture)
                VALUES ('$match_id', '$event_id', 'No cards', '0', 'No KO', 'red', '$red_cornerID', '$athlete_name2', '$athlete_nickname2', '$athlete_grade2', '$athlete_weightclass2', '$athlete_picture2')";
$resultaat = mysqli_query($db, $vraag);

header("location: APP_event_info.php?event_id=".$event_id."&events7=".$events7)

?>
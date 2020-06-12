<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$athlete_id = $_GET['athlete_id'];

//pak alle match_id's waar atleet in zit en nog geen scores heeft
$match_id[] = array();
$query = "SELECT * FROM `matches` WHERE athlete_id = '$athlete_id' AND points = 0";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    if (!$row['athlete_grade'] == 0 && !$row['athlete_weightclass'] == 0 && $row['redyellowcard'] == 'No cards' && $row['ko'] == 'No KO') {
        $match_id[] = $row['match_id'];
    }
}

$past_match[] = array();
foreach ($match_id as $matchid) {
    $query = "SELECT * FROM `matches` WHERE match_id = '$matchid'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        if (!$row['points'] == 0 || !$row['redyellowcard'] == 'No cards' || !$row['ko'] == 'No KO') {
            $past_match[] = $row['match_id'];
        }
    }
}
$opponent = 'moetnog';
$comma = false;
$nodouble[] = array();
echo "[ { ";
echo '"match_event": "match_event", ';
echo '"match_event_name": "match_event_name", ';
echo '"match_date": "match_date", ';
echo '"match_blok": "match_blok", ';
echo '"match_opponent": "match_opponent", ';
echo '"match_event_picture": "event_picture", ';
echo '"match_description": "event_description", ';
echo '"match_event_place": "event_place", ';
echo '"match_event_link": "event_link", ';
echo '"match_event_max_comp": "event_max_comp"';
echo ' }, ';
foreach ($match_id as $matchid) {
    $query = "SELECT events.event_name, events.event_date, events.event_description, events.event_place, events.event_link,
              matches.match_id, matches.event_id, matches.blok, matches.athlete_name, events.event_picture 
              FROM `matches` INNER JOIN events ON matches.event_id = events.event_id 
              WHERE match_id = '$matchid' AND NOT athlete_id = '$athlete_id'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        $eventid = $row['event_id'];
        if (!in_array($row['match_id'], $past_match) && !in_array($row['match_id'], $nodouble)) {
            //no duplicates
            $nodouble[] = $row['match_id'];
            if ($comma == true) {
                echo ', ';
            }
            echo '{ ';
            echo '"match_event": "'.$row['event_id'].'", ';
            echo '"match_event_name": "'.$row['event_name'].'", ';
            echo '"match_date": "'.$row['event_date'].'", ';
            echo '"match_blok": "'.$row['blok'].'", ';
            echo '"match_opponent": "'.$row['athlete_name'].'", ';
            echo '"match_event_picture": "'.$row['event_picture'].'", ';
            echo '"match_description": "'.$row['event_description'].'", ';
            echo '"match_event_place": "'.$row['event_place'].'", ';
            echo '"match_event_link": "'.$row['event_link'].'", ';
            $query = "SELECT count( DISTINCT competition_id) AS event_max_comp FROM `eventcompetition` WHERE event_id = '$eventid'";
            $result = mysqli_query($db, $query);
            while ($row = mysqli_fetch_assoc($result)) {
                echo '"match_event_max_comp": "'.$row['event_max_comp'].'"';
            }
            echo ' }';
            $comma = true;
        }
    }
}
echo " ]";
?>
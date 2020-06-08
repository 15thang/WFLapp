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
            echo '<br>' . $row['match_id'] . ' heeft wel punten!!!!<br><br>';
            $past_match[] = $row['match_id'];
        }
    }
}
$opponent = 'moetnog';
$comma = false;
$nodouble[] = array();
echo "[ ";
foreach ($match_id as $matchid) {
    $query = "SELECT * FROM `matches` WHERE match_id = '$matchid' AND NOT athlete_id = '$athlete_id'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        if (!in_array($row['match_id'], $past_match) && !in_array($row['match_id'], $nodouble)) {
            //no duplicates
            $nodouble[] = $row['match_id'];
            if ($comma == true) {
                echo ', ';
            }
            echo '{ ';
            echo '"match_event": "'.$row['event_id'].'", ';
            echo '"match_date": "'.$row['match_date'].'", ';
            echo '"match_blok": "'.$row['blok'].'", ';
            echo '"match_opponent": "'.$row['athlete_name'].'"';
            echo ' }';
            $comma = true;
        }
    }
}
echo " ]";
?>
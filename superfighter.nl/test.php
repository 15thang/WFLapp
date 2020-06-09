<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$athlete_id = $_GET['athlete_id'];

$match_id[] = array();
$query = "SELECT * FROM `matches` WHERE athlete_id = '$athlete_id'";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    if ($row['ko'] == '1TKO') {
        $tko += 1;
    } else if ($row['ko'] == '1KO') {
        $ko += 1;
    }
    if (!$row['athlete_grade'] == 0 && !$row['athlete_weightclass'] == 0) {
        $match_id[] = $row['match_id'];
    }
}

$yellowcards = 0;
$redcards = 0;
foreach ($match_id as $matchid) {
    //atleet
    $query = "SELECT * FROM matches WHERE match_id = '$matchid' AND athlete_id = '$athlete_id'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        $totalscore1 = $row['points'];
        if ($row['redyellowcard'] == '1yellowcard') {
            $yellowcards++;
            $totalscore1 -= 1;
            $loss1 = 0;
        } else if ($row['redyellowcard'] == '1redcard') {
            $redcards++;
            $loss1 = 1;
        } else if ($row['redyellowcard'] == '2yellowcard') {
            $yellowcards += 2;
            $loss1 = 1;
        } else {
            $loss1 = 0;
        }
    }
    //tegenstander
    $query = "SELECT * FROM matches WHERE match_id = '$matchid' AND NOT athlete_id = '$athlete_id'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        $totalscore2 = $row['points'];
        if ($row['redyellowcard'] == '1yellowcard') {
            $totalscore2 -= 1;
            $loss2 = 0;
        } else if ($row['redyellowcard'] == '1redcard' || $row['redyellowcard'] == '2yellowcard') {
            $loss2 = 1;
        } else {
            $loss2 = 0;
        }
    }

    if ($loss1 == 1) {
        $losses += 1;
    } else if ($loss1 == 0 && $totalscore1 > $totalscore2) {
        $wins += 1;
    } else if ($loss1 == 0 && $totalscore1 == $totalscore2 && !$totalscore1 == 0) {
        $draws += 1;
    } else if ($loss1 == 0 && $totalscore1 < $totalscore2) {
        $losses += 1;
    } else {
        $notplayed += 1;
    }
}

if ($ko == null) {
    $ko = 0;
}
if ($tko == null) {
    $tko = 0;
}
if ($wins == null) {
    $wins = 0;
}
if ($losses == null) {
    $losses = 0;
}
if ($draws == null) {
    $draws = 0;
}

$query = "UPDATE athletes SET athlete_wins = '$wins', athlete_losses = '$losses', athlete_draws = '$draws', athlete_ko = '$ko', 
          athlete_tko = '$tko', athlete_yellowcards = '$yellowcards', athlete_redcards = '$redcards' WHERE athlete_id = '$athlete_id'";
mysqli_query($db, $query);
header('location: test.php?athlete_id='.$athlete_id += 1);

?>
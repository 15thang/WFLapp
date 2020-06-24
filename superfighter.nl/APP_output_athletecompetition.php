<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$comp_id = $_GET['competition_id'];

$athleteArray[] = array();
$query = "SELECT a.athlete_id, SUM(m.points)
FROM `athletes` AS a
INNER JOIN `athletecompetition` AS ac ON ac.athlete_id = a.athlete_id
INNER JOIN `matches` AS m ON m.athlete_id = ac.athlete_id
WHERE competition_id = '$comp_id'
GROUP BY a.athlete_id  
ORDER BY SUM(m.points)  DESC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $athleteArray[] = $row['athlete_id'];
}

$comma = false;
echo "[ ";
echo '{ ';
echo '"athlete_id": "athlete_id", ';
echo '"athlete_firstname": "athlete_firstname", ';
echo '"athlete_lastname": "athlete_lastname", ';
echo '"athlete_wins": "totalwins", ';
echo '"athlete_losses": "totallosses", ';
echo '"athlete_draws": "totaldraws", ';
echo '"athlete_ko": "totalko", ';
echo '"athlete_tko": "totaltko", ';
echo '"athlete_yellowcards": "totalyellow", ';
echo '"athlete_redcards": "totalred", ';
echo '"athlete_total_points": "totalpoints" ';
echo ' }, ';

foreach ($athleteArray as $athlete_id) {
    $totalWins = 0;
    $totalLosses = 0;
    $totalDraws = 0;
    $totalKO = 0;
    $totalTKO = 0;
    $totalYellowcard = 0;
    $totalRedcard = 0;
    $points = 0;

    $match_id[] = array();
    $query = "SELECT m.* FROM `matches` AS m
INNER JOIN `eventcompetition` AS ec ON ec.`match_id` = m.`match_id`
WHERE competition_id = '$comp_id'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        if (!$row['athlete_grade'] == 0 && !$row['athlete_weightclass'] == 0 && !in_array($row['match_id'], $match_id)) {
            $match_id[] = $row['match_id'];
        }
    }
    foreach ($match_id as $matchid) {
        //atleet
        $query = "SELECT * FROM matches WHERE match_id = '$matchid' AND athlete_id = '$athlete_id'";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            $totalscore1 = $row['points'];

            if ($row['redyellowcard'] == '1yellowcard') {
                $totalscore1 -= 1;
                $loss2 = 0;
                $totalYellowcard += 1;
                $points += $row['points'];
            } else if ($row['redyellowcard'] == '1redcard') {
                $loss1 = 1;
                $totalRedcard += 1;
            } else if ($row['redyellowcard'] == '2yellowcard') {
                $loss1 = 1;
                $totalYellowcard += 2;
            } else {
                $loss1 = 0;
                $points += $row['points'];
            }
            //method
            if ($row['ko'] == '1TKO') {
                $method = 'TKO';
                $totalTKO += 1;
            } else if ($row['ko'] == '1KO') {
                $method = 'KO';
                $totalKO += 1;
            } else {
                $method = 'DEC';
            }
        }
        //tegenstander
        $query = "SELECT * FROM matches WHERE match_id = '$matchid' AND NOT athlete_id = '$athlete_id'";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            $opponent = $row['athlete_id'];

            $totalscore2 = $row['points'];
            if ($row['redyellowcard'] == '1yellowcard') {
                $totalscore2 -= 1;
                $loss2 = 0;
            } else if ($row['redyellowcard'] == '1redcard') {
                $loss2 = 1;
            } else if ($row['redyellowcard'] == '2yellowcard') {
                $loss2 = 1;
            } else {
                $loss2 = 0;
            }
            //method
            if ($row['ko'] == '1TKO') {
                $method2 = 'TKO';
            } else if ($row['ko'] == '1KO') {
                $method2 = 'KO';
            } else {
                $method2 = 'DEC';
            }
        }
        $query = "SELECT * FROM athletes WHERE athlete_id = '$opponent'";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            $opponent = $row['athlete_firstname'].' '.$row['athlete_lastname'];
        }

        $done = true;
        //result
        if ($loss1 == 1) {
            $totalLosses += 1;
        } else if ($loss1 == 0 && $totalscore1 > $totalscore2) {
            $totalWins += 1;
        } else if ($loss1 == 0 && $totalscore1 == $totalscore2 && !$totalscore1 == 0) {
            $totalDraws  += 1;
        } else if ($loss1 == 0 && $totalscore1 < $totalscore2) {
            $totalLosses += 1;
        }
    }
    $query = "SELECT * FROM `athletes` WHERE athlete_id = '$athlete_id'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        $stats[] = array();
        //echo $athlete_id . ' VS ' . $opponent . ' STATS: Date: ' . $date . ', Result: ' . $outcome . ', Method: ' . $method . ', Round: ' . $round . '<br><br>';
        if ($comma == true) {
            echo ', ';
        }
        echo '{ ';
        echo '"athlete_id": "'.$athlete_id.'", ';
        echo '"athlete_firstname": "'.$row['athlete_firstname'].'", ';
        echo '"athlete_lastname": "'.$row['athlete_lastname'].'", ';
        echo '"athlete_wins": "'.$totalWins.'", ';
        echo '"athlete_losses": "'.$totalLosses.'", ';
        echo '"athlete_draws": "'.$totalDraws.'", ';
        echo '"athlete_ko": "'.$totalKO.'", ';
        echo '"athlete_tko": "'.$totalTKO.'", ';
        echo '"athlete_yellowcards": "'.$totalYellowcard.'", ';
        echo '"athlete_redcards": "'.$totalRedcard.'", ';
        echo '"athlete_total_points": "'.$points.'" ';
        echo ' }';
        $comma = true;
    }
}

echo ' ]';

?>

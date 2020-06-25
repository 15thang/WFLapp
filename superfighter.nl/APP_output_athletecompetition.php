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

$arr = 	array(
    array('athlete_id' => 'athlete_id',
        'athlete_firstname' => 'athlete_firstname',
        'athlete_lastname' => 'athlete_lastname',
        'athlete_matches_done' => 'totalMatchesDone',
        'athlete_matches' => 'totalMatches',
        'athlete_wins' => 'totalWins',
        'athlete_losses' => 'totalLosses',
        'athlete_draws' => 'totalDraws',
        'athlete_ko' => 'totalKO',
        'athlete_tko' => 'totalTKO',
        'athlete_yellowcards' => 'totalYellowcard',
        'athlete_redcards' => 'totalRedcard',
        'athlete_total_points' => 'points',
        'athlete_ranking_score' => 1000
    ),
);
$x = 0;

foreach ($athleteArray as $athlete_id) {
    $totalWins = 0;
    $totalLosses = 0;
    $totalDraws = 0;
    $totalKO = 0;
    $totalTKO = 0;
    $totalYellowcard = 0;
    $totalRedcard = 0;
    $points = 0;
    $totalscore = 0;
    $totalMatchesDone = 0;
    $totalMatches = 0;

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
        $done1 = false;
        $done2 = false;
        //kijk of de match al geweest is
        $query = "SELECT * FROM matches WHERE match_id = '$matchid' AND athlete_id = '$athlete_id'";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            $totalMatches++;
            if ($row['points'] == 0 && $row['redyellowcard'] == 'No cards' && $row['ko'] == 'No KO') {
                $done1 = true;
            }
        }
        $query = "SELECT * FROM matches WHERE match_id = '$matchid' AND NOT athlete_id = '$athlete_id'";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            if ($row['points'] == 0 && $row['redyellowcard'] == 'No cards' && $row['ko'] == 'No KO') {
                $done2 = true;
            }
        }
        if ($done1 == false || $done2 == false) {
            //atleet
            $query = "SELECT * FROM matches WHERE match_id = '$matchid' AND athlete_id = '$athlete_id'";
            $results = mysqli_query($db, $query);
            while ($row = $results->fetch_assoc()) {
                $totalscore1 = $row['points'];
                $totalMatchesDone++;

                if ($row['redyellowcard'] == '1yellowcard') {
                    $totalscore1 -= 1;
                    $loss2 = 0;
                    $totalYellowcard += 1;
                    $points += $row['points'];
                    $totalscore += $row['points'] - 1;
                } else if ($row['redyellowcard'] == '1redcard') {
                    $loss1 = 1;
                    $totalRedcard += 1;
                    $totalscore -= 2;
                } else if ($row['redyellowcard'] == '2yellowcard') {
                    $loss1 = 1;
                    $totalYellowcard += 2;
                    $totalscore -= 2;
                } else {
                    $loss1 = 0;
                    $points += $row['points'];
                    $totalscore += $row['points'];
                }
                //method
                if ($row['ko'] == '1TKO') {
                    $method = 'TKO';
                    $totalTKO += 1;
                    $totalscore += 1;
                } else if ($row['ko'] == '1KO') {
                    $method = 'KO';
                    $totalKO += 1;
                    $totalscore += 2;
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
                $opponent = $row['athlete_firstname'] . ' ' . $row['athlete_lastname'];
            }

            //result
            if ($loss1 == 1) {
                $totalLosses += 1;
            } else if ($loss1 == 0 && $totalscore1 > $totalscore2) {
                $totalWins += 1;
            } else if ($loss1 == 0 && $totalscore1 == $totalscore2 && !$totalscore1 == 0) {
                $totalDraws += 1;
            } else if ($loss1 == 0 && $totalscore1 < $totalscore2) {
                $totalLosses += 1;
            }
        }
    }
    $query = "SELECT * FROM `athletes` WHERE athlete_id = '$athlete_id'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        $stats[] = array();
        $kaas = 'kaasman';
        $x++;
        $arr[$x] = array('athlete_id' => $row['athlete_id'],
            'athlete_firstname' => $row['athlete_firstname'],
            'athlete_lastname' => $row['athlete_lastname'],
            'athlete_matches_done' => $totalMatchesDone,
            'athlete_matches' => $totalMatches,
            'athlete_wins' => $totalWins,
            'athlete_losses' => $totalLosses,
            'athlete_draws' => $totalDraws,
            'athlete_ko' => $totalKO,
            'athlete_tko' => $totalTKO,
            'athlete_yellowcards' => $totalYellowcard,
            'athlete_redcards' => $totalRedcard,
            'athlete_total_points' => $points,
            'athlete_ranking_score' => $totalscore
        );
    }
}

array_multisort($arr);

function val_sort($array,$key) {

    //Loop through and get the values of our specified key
    foreach($array as $k=>$v) {
        $b[] = strtolower($v[$key]);
    }

    arsort($b);

    foreach($b as $k=>$v) {
        $c[] = $array[$k];
    }

    return $c;
}

$sorted = val_sort($arr, 'athlete_ranking_score');
echo json_encode($sorted, JSON_PRETTY_PRINT);
?>

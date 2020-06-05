<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$athlete_id = $_GET['athlete_id'];

$match_id[] = array();
$query = "SELECT * FROM `matches` WHERE athlete_id = '$athlete_id'";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    if (!$row['athlete_grade'] == 0 && !$row['athlete_weightclass'] == 0) {
        $match_id[] = $row['match_id'];
    }
}

$comma = false;
echo "[ ";
echo '{ ';
echo '"match_date": "date", ';
echo '"match_result": "result", ';
echo '"match_opponent": "opponent", ';
echo '"match_method": "method", ';
echo '"match_round": "round" ';
echo ' }, ';
foreach ($match_id as $matchid) {
    //atleet
    $query = "SELECT * FROM matches WHERE match_id = '$matchid' AND athlete_id = '$athlete_id'";
    $results = mysqli_query($db, $query);
    while ($row = $results->fetch_assoc()) {
        $totalscore1 = $row['points'];
        if ($row['redyellowcard'] == '1yellowcard') {
            $totalscore1 -= 1;
            $loss1 = 0;
        } else if ($row['redyellowcard'] == '1redcard' || $row['redyellowcard'] == '2yellowcard') {
            $loss1 = 1;
        } else {
            $loss1 = 0;
        }
        //method
        if ($row['ko'] == '1TKO') {
            $method = 'TKO';
        } else if ($row['ko'] == '1KO') {
            $method = 'KO';
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
        } else if ($row['redyellowcard'] == '1redcard' || $row['redyellowcard'] == '2yellowcard') {
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
        $outcome = 'Loss';
    } else if ($loss1 == 0 && $totalscore1 > $totalscore2) {
        $outcome = 'Win';
    } else if ($loss1 == 0 && $totalscore1 == $totalscore2 && !$totalscore1 == 0) {
        $outcome = 'Draw';
    } else if ($loss1 == 0 && $totalscore1 < $totalscore2) {
        $outcome = 'Loss';
    } else {
        $outcome = 'Nope';
        $done = false;
    }

    //moet nog aan gewerkt worden
    $date = 'N/A';
    $round = 'N/A';

    $stats[] = array();
    if ($done == true) {
        if ($outcome == 'Win') {
            //echo $athlete_id . ' VS ' . $opponent . ' STATS: Date: ' . $date . ', Result: ' . $outcome . ', Method: ' . $method . ', Round: ' . $round . '<br><br>';
            if ($comma == true) {
                echo ', ';
            }
            echo '{ ';
            echo '"match_date": "'.$date.'", ';
            echo '"match_result": "'.$outcome.'", ';
            echo '"match_opponent": "'.$opponent.'", ';
            echo '"match_method": "'.$method.'", ';
            echo '"match_round": "'.$round.'" ';
            echo ' }';
            $comma = true;
        } else {
            $method = $method2;
            //echo $athlete_id . ' VS ' . $opponent . ' STATS: Date: N/A, Result: ' . $outcome . ', Method: ' . $method . ', Round: N/A<br><br>';
            if ($comma == true) {
                echo ', ';
            }
            echo '{ ';
            echo '"match_date": "'.$date.'", ';
            echo '"match_result": "'.$outcome.'", ';
            echo '"match_opponent": "'.$opponent.'", ';
            echo '"match_method": "'.$method.'", ';
            echo '"match_round": "'.$round.'" ';
            echo ' }';
            $comma = true;
        }
    } else if (!$opponent == null){
        //echo $athlete_id . ' VS ' . $opponent . ' Nog niks gevochten<br><br>';
    }
}
echo ' ]';

?>
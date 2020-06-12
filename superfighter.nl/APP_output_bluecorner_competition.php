<?php
$db       = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$event_id = $_GET['event_id'];
$comp_id = $_GET['competition_id'];
$redArray = array();
$blueArray = array();
$query = "SELECT ath.athlete_picture2 AS redcorner_picture, ath.athlete_id AS redcorner_id, 
ath.athlete_firstname AS redcorner_firstname, ath.athlete_lastname AS redcorner_lastname, 
ath.athlete_nickname AS redcorner_nickname, ath.athlete_day_of_birth AS redcorner_day_of_birth,
ath.athlete_nationality AS redcorner_nationality, ath.athlete_description AS redcorner_description, 
ath.athlete_weightclass AS redcorner_weightclass, ath.athlete_grade AS redcorner_grade, comp.competition_name AS redcorner_comp
    FROM `athletes` AS ath
	INNER JOIN `eventcompetition` AS ec
    ON ath.athlete_id = ec.redcorner
    INNER JOIN `competition` AS comp
    ON ec.competition_id = comp.competition_id
    WHERE ath.athlete_id IN (SELECT redcorner FROM `eventcompetition` WHERE event_id = '$event_id' AND competition_id = '$comp_id')
    AND comp.competition_id IN (SELECT competition_id FROM `eventcompetition` WHERE event_id = '$event_id') ORDER BY ec.competition_id ASC";
$result     = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $redArray[] = $row;
}

$query = "SELECT ath.athlete_picture2 AS bluecorner_picture, ath.athlete_id AS bluecorner_id, 
ath.athlete_firstname AS bluecorner_firstname, ath.athlete_lastname AS bluecorner_lastname, 
ath.athlete_nickname AS bluecorner_nickname, ath.athlete_day_of_birth AS bluecorner_day_of_birth,
ath.athlete_nationality AS bluecorner_nationality, ath.athlete_description AS bluecorner_description, 
ath.athlete_weightclass AS bluecorner_weightclass, ath.athlete_grade AS bluecorner_grade, 
comp.competition_name AS bluecorner_comp_name, comp.competition_id AS bluecorner_comp_id
    FROM `athletes` AS ath
	INNER JOIN `eventcompetition` AS ec
    ON ath.athlete_id = ec.bluecorner
    INNER JOIN `competition` AS comp
    ON ec.competition_id = comp.competition_id
    WHERE ath.athlete_id IN (SELECT bluecorner FROM `eventcompetition` WHERE event_id = '$event_id' AND competition_id = '$comp_id')
    AND comp.competition_id IN (SELECT competition_id FROM `eventcompetition` WHERE event_id = '$event_id') ORDER BY ec.competition_id ASC";
$result      = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $blueArray[] = $row;
}

$redblueArray = array_merge($redArray,$blueArray);
$noDuplicates = array();
$noDuplicateComps = array();
$firstsecond = 1;
$more = false;
echo "[ ";
for ($i = 0; $i <= 15; $i++) {
    foreach($redblueArray as $data) {
        if ($firstsecond == 1 && !$data['redcorner_id'] == "" && !in_array($data['redcorner_id'], $noDuplicates)) {
            if ($more == true) {
                echo ', ';
            }
            echo '{ ';
            echo '"redcorner_picture": "'.$data['redcorner_picture'].'", ';
            echo '"redcorner_id": "'.$data['redcorner_id'].'", ';
            echo '"redcorner_firstname": "'.$data['redcorner_firstname'].'", ';
            echo '"redcorner_lastname": "'.$data['redcorner_lastname'].'", ';
            echo '"redcorner_nickname": "'.$data['redcorner_nickname'].'", ';
            echo '"redcorner_day_of_birth": "'.$data['redcorner_day_of_birth'].'", ';
            echo '"redcorner_nationality": "'.$data['redcorner_nationality'].'", ';
            echo '"redcorner_description": "'.$data['redcorner_description'].'", ';
            echo '"redcorner_weightclass": "'.$data['redcorner_weightclass'].'", ';
            echo '"redcorner_grade": "'.$data['redcorner_grade'].'", ';
            echo '"redcorner_comp": "'.$data['redcorner_comp'].'", ';
            array_push($noDuplicates, $data['redcorner_id']);
            $firstsecond = 2;
        }

        if ($firstsecond == 2 && !$data['bluecorner_id'] == "" && !in_array($data['bluecorner_id'], $noDuplicates)) {
            echo '"bluecorner_picture": "'.$data['bluecorner_picture'].'", ';
            echo '"bluecorner_id": "'.$data['bluecorner_id'].'", ';
            echo '"bluecorner_firstname": "'.$data['bluecorner_firstname'].'", ';
            echo '"bluecorner_lastname": "'.$data['bluecorner_lastname'].'", ';
            echo '"bluecorner_nickname": "'.$data['bluecorner_nickname'].'", ';
            echo '"bluecorner_day_of_birth": "'.$data['bluecorner_day_of_birth'].'", ';
            echo '"bluecorner_nationality": "'.$data['bluecorner_nationality'].'", ';
            echo '"bluecorner_description": "'.$data['bluecorner_description'].'", ';
            if (!in_array($data['bluecorner_comp_id'], $noDuplicateComps)) {
                echo '"bluecorner_comp_name": "'.$data['bluecorner_comp_name'].'", ';
                echo '"bluecorner_comp_id": "'.$data['bluecorner_comp_id'].'", ';
                array_push($noDuplicateComps, $data['bluecorner_comp_id']);
            } else {
                foreach($noDuplicateComps as $compid) {
                    $query = "SELECT DISTINCT ec.competition_id, c.competition_name FROM `eventcompetition` AS ec
                          INNER JOIN `competition` AS c ON ec.competition_id = c.competition_id
                          WHERE event_id = '$event_id' AND NOT c.competition_id = '$compid'";
                    $result = mysqli_query($db, $query);
                    while ($row = mysqli_fetch_assoc($result)) {
                        if (!in_array($row['competition_name'], $noDuplicateComps)) {
                            echo '"bluecorner_comp_name": "' . $row['competition_name'] . '", ';
                            echo '"bluecorner_comp_id": "' . $row['competition_id'] . '", ';
                            array_push($noDuplicateComps, $data['bluecorner_comp_id']);
                        } else {
                            echo '"bluecorner_comp_name": "0", ';
                            echo '"bluecorner_comp_id": "0", ';
                        }
                    }
                }
            }
            echo '"bluecorner_grade": "'.$data['bluecorner_grade'].'" }';
            array_push($noDuplicates, $data['bluecorner_id']);
            $firstsecond = 1;
            $more = true;
        }
    }
}

echo " ]";
?>

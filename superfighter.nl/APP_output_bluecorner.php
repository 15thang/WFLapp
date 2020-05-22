<?php
$db       = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$event_id = $_GET['event_id'];
$redArray = array();
$blueArray = array();
$query      = "SELECT athlete_picture AS redcorner_picture, athlete_id AS redcorner_id, athlete_firstname AS redcorner_firstname,
athlete_lastname AS redcorner_lastname, athlete_nickname AS redcorner_nickname, athlete_day_of_birth AS redcorner_day_of_birth,
athlete_nationality AS redcorner_nationality, athlete_description AS redcorner_description, athlete_weightclass AS redcorner_weightclass, athlete_grade AS redcorner_grade
 FROM `athletes` WHERE athlete_id IN (SELECT redcorner FROM `eventcompetition` WHERE event_id = '$event_id')";
$result     = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $redArray[] = $row;
}
$query       = "SELECT athlete_picture AS bluecorner_picture, athlete_id AS bluecorner_id, athlete_firstname AS bluecorner_firstname,
athlete_lastname AS bluecorner_lastname, athlete_nickname AS bluecorner_nickname, athlete_day_of_birth AS bluecorner_day_of_birth,
athlete_nationality AS bluecorner_nationality, athlete_description AS bluecorner_description, athlete_weightclass AS bluecorner_weightclass, athlete_grade AS bluecorner_grade
 FROM `athletes` WHERE athlete_id IN (SELECT bluecorner FROM `eventcompetition` WHERE event_id = '$event_id')";
$result      = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $blueArray[] = $row;
}

$redblueArray = array_merge($redArray,$blueArray);
$noDuplicates = array();
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
            echo '"bluecorner_grade": "'.$data['bluecorner_grade'].'" }';
            array_push($noDuplicates, $data['bluecorner_id']);
            $firstsecond = 1;
            $more = true;
        }
    }
}

echo " ]";
?>

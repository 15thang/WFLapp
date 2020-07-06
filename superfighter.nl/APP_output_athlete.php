<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$more = false;

$athlete_Array[] = array();
$query = "SELECT DISTINCT athlete_id FROM `athletetitles`";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $athlete_Array[] = $row['athlete_id'];
}

$arr[] = array();
$x=0;
$query = "SELECT * FROM `athletes` WHERE NOT athlete_grade = 5 ORDER BY athlete_grade ASC, athlete_weight DESC, athlete_weightclass, athlete_lastname ASC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $x++;
    $arr[$x] = array('athlete_picture' => $row['athlete_picture'],
        'athlete_picture2' => $row['athlete_picture2'],
        'athlete_id' => $row['athlete_id'],
        'athlete_firstname' => $row['athlete_firstname'],
        'athlete_nickname' => $row['athlete_nickname'],
        'athlete_day_of_birth' => $row['athlete_day_of_birth'],
        'athlete_nationality' => $row['athlete_nationality'],
        'athlete_description' => $row['athlete_description'],
        'athlete_weightclass' => $row['athlete_weightclass'],
        'athlete_grade' => $row['athlete_grade'],
        'athlete_wins' => $row['athlete_wins'],
        'athlete_losses' => $row['athlete_losses'],
        'athlete_draws' => $row['athlete_draws'],
        'athlete_ko' => $row['athlete_ko'],
        'athlete_tko' => $row['athlete_tko'],
        'athlete_yellowcards' => $row['athlete_yellowcards'],
        'athlete_redcards' => $row['athlete_redcards'],
        'athlete_star' => $athlete_yellowstar,
        'athlete_stars' => $athlete_stars,
    );
}

$keys = array_keys($arr);
for($i = 0; $i < count($arr); $i++) {
    foreach($arr[$keys[$i]] as $key => $value) {
        $query = "SELECT count(athlete_id) AS athlete_stars FROM `athletetitles` WHERE athlete_id= '$value'";
        $result = mysqli_query($db, $query);
        while ($row = mysqli_fetch_assoc($result)) {
            echo 'hoihoi'.$row['athlete_id'];
            $athlete_stars = $row['athlete_stars'];
            if ($athlete_stars == 0) {
                $athlete_stars = "";
                $athlete_yellowstar = "";
            } else {
                $athlete_yellowstar = '1';
            }
            echo $athlete_stars;
            $arr[$keys[$i]]['athlete_star'] = $athlete_yellowstar;
            $arr[$keys[$i]]['athlete_stars'] = $athlete_stars;
            /*$arr[$keys[$i]] = array('athlete_yellowstar' => $athlete_yellowstar,
                'athlete_stars' => $athlete_stars,
                );*/
        }
    }
}
$keyss = array_keys($arr);
for($is = 0; $is < count($arr); $is++) {
    echo $keyss[$is] . "{<br>";
    foreach($arr[$keyss[$is]] as $key => $value) {
        echo $key . " : " . $value . "<br>";
    }
    echo "}<br>";
}



/*$athlete_id = $row['athlete_id'];
    $athlete_yellowstar = "";
    $athlete_stars = "";
    if ($more == true) {
        echo ', ';
    }
    echo '{ ';
    echo '"athlete_picture": "'.$row['athlete_picture'].'", ';
    echo '"athlete_picture2": "'.$row['athlete_picture2'].'", ';
    echo '"athlete_id": "'.$row['athlete_id'].'", ';
    echo '"athlete_firstname": "'.$row['athlete_firstname'].'", ';
    echo '"athlete_lastname": "'.$row['athlete_lastname'].'", ';
    echo '"athlete_nickname": "'.$row['athlete_nickname'].'", ';
    echo '"athlete_day_of_birth": "'.$row['athlete_day_of_birth'].'", ';
    echo '"athlete_nationality": "'.$row['athlete_nationality'].'", ';
    echo '"athlete_description": "'.$row['athlete_description'].'", ';
    echo '"athlete_weightclass": "'.$row['athlete_weightclass'].'", ';
    echo '"athlete_grade": "'.$row['athlete_grade'].'", ';
    echo '"athlete_wins": "'.$row['athlete_wins'].'", ';
    echo '"athlete_losses": "'.$row['athlete_losses'].'", ';
    echo '"athlete_draws": "'.$row['athlete_draws'].'", ';
    echo '"athlete_ko": "'.$row['athlete_ko'].'", ';
    echo '"athlete_tko": "'.$row['athlete_tko'].'", ';
    echo '"athlete_yellowcards": "'.$row['athlete_yellowcards'].'", ';
    echo '"athlete_redcards": "'.$row['athlete_redcards'].'", ';
    if ($athlete_yellowstar == "") {
        $query = "SELECT count(athlete_id) AS athlete_stars FROM `athletetitles` WHERE athlete_id= '$athlete_id'";
        $result = mysqli_query($db, $query);
        while ($row = mysqli_fetch_assoc($result)) {
            $athlete_yellowstar = '1';
            $athlete_stars = $row['athlete_stars'];
        }
    }
    echo '"athlete_star": "'.$athlete_yellowstar.'", ';
    echo '"athlete_stars": "'.$athlete_stars.'"';
    echo ' }';
    $more = true;*/
?>

<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$athlete_id1 = $_GET['athlete_id'];
$more = false;
$title = false;

$athlete_Array[] = array();
$query = "SELECT DISTINCT athlete_id FROM `athletetitles`";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $athlete_Array[] = $row['athlete_id'];
}

$arr[] = array();
$x=0;
$query = "SELECT * FROM `athletes` WHERE athlete_id = '$athlete_id1'";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $x++;
    $arr[$x] = array('athlete_picture' => $row['athlete_picture'],
        'athlete_picture2' => $row['athlete_picture2'],
        'athlete_id' => $row['athlete_id'],
        'athlete_firstname' => $row['athlete_firstname'],
        'athlete_lastname' => $row['athlete_lastname'],
        'athlete_nickname' => $row['athlete_nickname'],
        'athlete_title' => $row['title'],
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
        'athlete_star' => '',
        'athlete_stars' => '',
        'athlete_last_title' => '',
        'title_id' => '',
    );

    if (!$row['title'] == "") {
        $title = true;
    }
}

$noDuplicates[] = array();
$noDuplicateTitle[] = array();
$titleArray[] = array();
$y = 0;
$more = false;
$keys = array_keys($arr);
for($i = 0; $i < count($arr); $i++) {
    foreach($arr[$keys[$i]] as $key => $value) {
        if ($title) {
            $query = "SELECT a.*, t.title AS title_athlete, t.title_id FROM `athletes` AS a
                      INNER JOIN `athletetitles` AS t 
                      ON a.athlete_id = t.athlete_id
                      WHERE a.athlete_id = '$athlete_id1'";
            $result = mysqli_query($db, $query);
            while ($row = mysqli_fetch_assoc($result)) {
                if (!in_array($row['title_id'], $noDuplicateTitle)) {
                    $y++;
                    $arr2[$y] = array('athlete_last_title' => $row['title_athlete'],
                        'title_id' => $row['title_id'],
                    );
                    $noDuplicateTitle[] = $row['title_id'];
                    //echo json_encode($arr2, JSON_PRETTY_PRINT);
                }
            }
            $query = "SELECT count(athlete_id) AS athlete_stars, athlete_id FROM `athletetitles` WHERE athlete_id= '$athlete_id1'";
            $result = mysqli_query($db, $query);
            while ($row = mysqli_fetch_assoc($result)) {
                if ($row['athlete_id'] == $value && !in_array($i, $noDuplicates)) {
                    if ($more) {
                        echo ', ';
                    }
                    $athlete_id = $row['athlete_id'];
                    $athlete_stars = $row['athlete_stars'];

                    $athlete_yellowstar = 0;
                    if (!$row['athlete_stars'] == 0) {
                        $athlete_yellowstar = 1;
                    } else {
                        $athlete_yellowstar = "";
                        $athlete_stars = "";
                    }

                    /*$replacements = array('athlete_stars' => $athlete_stars,
                        'athlete_star' => $athlete_yellowstar);

                    $array = array_replace($arr[$i], $replacements);*/
                    $noDuplicates[] = $i;

                    //echo json_encode($array, JSON_PRETTY_PRINT);
                    $more = true;
                }
            }
        } else {
            $query = "SELECT count(athlete_id) AS athlete_stars, athlete_id FROM `athletetitles` WHERE athlete_id= '$athlete_id1'";
            $result = mysqli_query($db, $query);
            while ($row = mysqli_fetch_assoc($result)) {
                if ($row['athlete_id'] == $value && !in_array($i, $noDuplicates)) {
                    if ($more) {
                        echo ', ';
                    }
                    $athlete_id = $row['athlete_id'];
                    $athlete_stars = $row['athlete_stars'];

                    $athlete_yellowstar = 0;
                    if (!$row['athlete_stars'] == 0) {
                        $athlete_yellowstar = 1;
                    } else {
                        $athlete_yellowstar = "";
                        $athlete_stars = "";
                    }

                    $replacements = array('athlete_stars' => $athlete_stars,
                        'athlete_star' => $athlete_yellowstar,
                        'athlete_last_title' => "");

                    $array = array_replace($arr[$i], $replacements);
                    $noDuplicates[] = $i;

                    //echo json_encode($array, JSON_PRETTY_PRINT);
                    $more = true;
                }
            }
        }
    }
}

rsort($noDuplicateTitle);

$z = 0;
foreach ($noDuplicateTitle as $data) {
    $query = "SELECT a.*, t.title AS title_athlete, t.title_id FROM `athletes` AS a
                      INNER JOIN `athletetitles` AS t 
                      ON a.athlete_id = t.athlete_id
                      WHERE t.title_id = '$data' ORDER BY t.title_id ASC";
    $result = mysqli_query($db, $query);
    while ($row = mysqli_fetch_assoc($result)) {
        $z++;
        $arr2[$z] = array('athlete_picture' => $row['athlete_picture'],
            'athlete_picture2' => $row['athlete_picture2'],
            'athlete_id' => $row['athlete_id'],
            'athlete_firstname' => $row['athlete_firstname'],
            'athlete_lastname' => $row['athlete_lastname'],
            'athlete_nickname' => $row['athlete_nickname'],
            'athlete_title' => $row['title'],
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
            'athlete_last_title' => $row['title_athlete'],
            'title_id' => $row['title_id'],
        );
    }
}

$more = false;
echo '[ ';
if ($title) {
    //$json_string = json_encode($arr2, JSON_PRETTY_PRINT);
    foreach ($arr2 as $row) {
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
        echo '"athlete_title": "'.$row['athlete_title'].'", ';
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
        echo '"athlete_star": "'.$row['athlete_star'].'", ';
        echo '"athlete_stars": "'.$row['athlete_stars'].'", ';
        echo '"athlete_last_title": "'.$row['athlete_last_title'].'"';
        echo ' }';
        $more = true;
    }
} else {
    //$json_string = json_encode($arr, JSON_PRETTY_PRINT);
    foreach ($arr as $row) {
        if (!$row['athlete_id'] == "") {
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
            echo '"athlete_title": "'.$row['athlete_title'].'", ';
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
            echo '"athlete_star": "'.$row['athlete_star'].'", ';
            echo '"athlete_stars": "'.$row['athlete_stars'].'", ';
            echo '"athlete_last_title": "'.$row['athlete_last_title'].'"';
            echo ' }';
            $more = true;
        }
    }
}
echo ' ]';

?>


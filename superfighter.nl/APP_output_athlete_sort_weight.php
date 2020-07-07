<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$weight = $_GET['weight'];
$more = false;

$athlete_Array[] = array();
$query = "SELECT DISTINCT athlete_id FROM `athletetitles`";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $athlete_Array[] = $row['athlete_id'];
}

$arr[] = array();
$x=0;
$query = "SELECT * FROM `athletes` WHERE athlete_weightclass = '$weight' AND NOT athlete_grade = 5 ORDER BY athlete_grade ASC,athlete_weight DESC, athlete_weightclass, athlete_lastname ASC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $x++;
    $arr[$x] = array('athlete_picture' => $row['athlete_picture'],
        'athlete_picture2' => $row['athlete_picture2'],
        'athlete_id' => $row['athlete_id'],
        'athlete_firstname' => $row['athlete_firstname'],
        'athlete_lastname' => $row['athlete_lastname'],
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
        'athlete_star' => '',
        'athlete_stars' => '',
        'athlete_last_title' => '',
    );
}
echo '[ ';
$noDuplicates[] = array();
$more = false;
$keys = array_keys($arr);
for($i = 0; $i < count($arr); $i++) {
    foreach($arr[$keys[$i]] as $key => $value) {
        $query = "SELECT count(athlete_id) AS athlete_stars, athlete_id FROM `athletetitles` WHERE athlete_id= '$value'";
        $result = mysqli_query($db, $query);
        while ($row = mysqli_fetch_assoc($result)) {
            if ($row['athlete_id'] == $value && !in_array($i, $noDuplicates)) {
                if ($more) {
                    echo ', ';
                }
                $athlete_id = $row['athlete_id'];
                $athlete_stars = $row['athlete_stars'];
                $last_title = "";

                $athlete_yellowstar = 0;
                if (!$row['athlete_stars'] == 0) {
                    $athlete_yellowstar = 1;
                } else {
                    $athlete_yellowstar = "";
                    $athlete_stars = "";
                }

                $replacements = array('athlete_stars' => $athlete_stars,
                    'athlete_star' => $athlete_yellowstar,
                    'athlete_last_title' => $last_title);

                $array = array_replace($arr[$i], $replacements);
                $noDuplicates[] = $i;

                echo json_encode($array, JSON_PRETTY_PRINT);
                $more = true;
            }
        }
    }
}
echo ' ]';
?>


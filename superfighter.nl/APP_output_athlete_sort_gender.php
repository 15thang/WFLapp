<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$grade = $_GET['grade'];
$gender = $_GET['gender'];

if ($gender == 1) {
    $gender1 = 'Male';
} else if ($gender == 2) {
    $gender1 = 'Female';
}

$json_array = array();
$query = "SELECT * FROM `athletes` WHERE athlete_gender = '$gender1' ORDER BY athlete_grade ASC,athlete_weight DESC, athlete_weightclass, athlete_lastname ASC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    if ($grade == 4) {
        if ($row['athlete_grade'] != 5){
            $json_array[] = $row;
        }
    }
    if ($grade == 5) {
        if ($row['athlete_grade'] == 5){
            $json_array[] = $row;
        }
    }
}
echo json_encode($json_array, JSON_PRETTY_PRINT);
?>
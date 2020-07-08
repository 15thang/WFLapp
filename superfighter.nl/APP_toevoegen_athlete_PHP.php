<?php
ob_start();
$db                   = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$athlete_firstname    = (str_replace("'", "", $_GET['athlete_name']));
$athlete_lastname     = (str_replace("'", "", $_GET['athlete_lastname']));
$athlete_nickname     = (str_replace("'", "", $_GET['athlete_nickname']));
$athlete_gender       = ($_GET['athlete_gender']);
$athlete_weight       = ($_GET['athlete_weight']);
$athlete_weightclass  = ($_GET['athlete_weightclass']);
$athlete_grade        = ($_GET['athlete_grade']);
$athlete_nationality  = ($_GET['athlete_nationality']);
$athlete_day_of_birth = date('Y-m-d', strtotime($_GET['athlete_day_of_birth']));
$athlete_description  = (str_replace("'", "", $_GET['athlete_description']));
$va_number            = ($_GET['athlete_va_number']);
$date_added           = date("Y-m-d");
//contact gegevens
$athlete_email        = (str_replace("'", "", $_GET['athlete_email']));
$athlete_phone1       = ($_GET['athlete_phone1']);
$athlete_phone2       = ($_GET['athlete_phone2']);
$athlete_adress       = ($_GET['athlete_adress']);
$athlete_postal_code  = (str_replace("'", "", $_GET['athlete_postal_code']));
$athlete_city         = (str_replace("'", "", $_GET['athlete_city']));
//social media
$athlete_facebook     = (str_replace("'", "", $_GET['athlete_facebook']));
$athlete_twitter      = (str_replace("'", "", $_GET['athlete_twitter']));
$athlete_instagram    = (str_replace("'", "", $_GET['athlete_instagram']));
$athlete_linkedin     = (str_replace("'", "", $_GET['athlete_linkedin']));
$athlete_youtube      = (str_replace("'", "", $_GET['athlete_youtube']));
//gym/trainer
$gymname              = ($_GET['athlete_gym']);
$trainer              = ($_GET['athlete_trainer']);
$trainer_phone        = ($_GET['athlete_trainer_phone']);
$trainer_email        = ($_GET['athlete_trainer_email']);

$dst = 'pics/athlete_avatar.png';
$dst2 = 'pics/athlete_event.png';

$query = "INSERT INTO athletes (athlete_firstname, athlete_lastname, athlete_nickname, athlete_gender, athlete_gym, athlete_trainer, athlete_picture, athlete_picture2, athlete_weight, athlete_weightclass, athlete_grade, 
                            athlete_nationality, va_number, date_added,
                            athlete_day_of_birth, athlete_description, athlete_email, athlete_phone1, athlete_phone2,
                            athlete_adress, athlete_postal_code, athlete_city, athlete_facebook, athlete_twitter, athlete_instagram, athlete_linkedin, athlete_youtube) 
            VALUES('$athlete_firstname', '$athlete_lastname', '$athlete_nickname', '$athlete_gender', '$gymname', '$trainer', '$dst', '$dst2', '$athlete_weight', '$athlete_weightclass', '$athlete_grade', 
                   '$athlete_nationality', '$va_number', '$date_added',
                   '$athlete_day_of_birth', '$athlete_description', '$athlete_email', '$athlete_phone1', '$athlete_phone2', 
                   '$athlete_adress', '$athlete_postal_code', '$athlete_city', '$athlete_facebook', '$athlete_twitter', '$athlete_instagram', '$athlete_linkedin', '$athlete_youtube')";
mysqli_query($db, $query);

$gymarray = array();
$query    = "SELECT * FROM `gym`";
$results  = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    $gymarray[] = $row;
}
print_r($gymarray);
if (in_array("trainer@train.com", $gymarray)) {
    echo 'Trainer bestaat al, geen nieuwe trainer nodig.';
} else if (!in_array("trainer@train.com", $gymarray)) {
    $query = "INSERT INTO gym (gym_name, coach_name, coach_email, coach_phone)
        VALUES('$gymname', '$trainer', '$trainer_email', '$trainer_phone')";
    mysqli_query($db, $query);
} else {
    echo 'er is iets mis gegaan';
}
header("location: http://superfighter.nl/APP_atleet_toegevoegd.php?naam='.$athlete_firstname.'_'.$athlete_lastname.'");
ob_flush();
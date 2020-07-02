<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$today = date("Y-m-d");

$event = array();
$only1 = true;
$query = "SELECT * FROM `events` WHERE NOT event_name = 'event_0' AND event_date >= '$today' ORDER BY event_date ASC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    if ($only1) {
        $event1_id = $row['event_id'];
        $event1_name = $row['event_name'];
        $event1_description = $row['event_description'];
        $event1_date = $row['event_date'];
        $event1_year = substr($event1_date, 0, -6);
        $event1_month = substr($event1_date, 5, -3);
        $event1_day = substr($event1_date, 8);
        $event1_ticketlink = $row['event_link'];
        $query = "SELECT * FROM `videos` WHERE video_type = 'Live' AND video_event = '$event1_id' ORDER BY video_id DESC";
        $result = mysqli_query($db, $query);
        while ($row = mysqli_fetch_assoc($result)) {
            $event1_live_link = $row['video_link'];
        }
        $only1 = false;
    }
}
$only2 = true;
$query = "SELECT * FROM `events` WHERE NOT event_name = 'event_0' AND event_date >= '$today' AND NOT event_id = '$event1_id' ORDER BY event_date ASC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    if ($only2) {
        $event2_id = $row['event_id'];
        $event2_name = $row['event_name'];
        $event2_description = $row['event_description'];
        $event2_date = $row['event_date'];
        $event2_ticketlink = $row['event_link'];
        $only2 = false;
    }
}
echo "[ ";
$more = false;
$query = "SELECT a.* FROM `athletes` AS a
WHERE a.athlete_id IN 
(SELECT athlete_id FROM `athletecompetition` WHERE `competition_id` IN 
(SELECT competition_id FROM `eventcompetition` WHERE event_id = '$event1_id'))";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    if ($more == true) {
        echo ', ';
    }
    echo '{ ';
    //Eerst volgende evenement boven aan de homepage
    echo '"event1_id": "'.$event1_id.'", ';
    echo '"event1_name": "'.$event1_name.'", ';
    echo '"event1_description": "'.$event1_description.'", ';
    echo '"event1_date": "'.$event1_date.'", ';
    echo '"event1_year": "'.$event1_year.'", ';
    echo '"event1_month": "'.$event1_month.'", ';
    echo '"event1_day": "'.$event1_day.'", ';
    echo '"event1_ticketlink": "'.$event1_ticketlink.'", ';
    echo '"event1_live_link": "'.$event1_live_link.'", ';

    //Evenement dat na eerst volgende evenement komt
    echo '"event2_id": "'.$event2_id.'", ';
    echo '"event2_name": "'.$event2_name.'", ';
    echo '"event2_description": "'.$event2_description.'", ';
    echo '"event2_date": "'.$event2_date.'", ';
    echo '"event2_ticketlink": "'.$event2_ticketlink.'", ';

    //Atleten uit eerst volgende evenement
    echo '"athlete_id": "'.$row['athlete_id'].'", ';
    echo '"athlete_firstname": "'.$row['athlete_firstname'].'", ';
    echo '"athlete_lastname": "'.$row['athlete_lastname'].'", ';
    echo '"athlete_nickname": "'.$row['athlete_nickname'].'", ';
    echo '"athlete_picture": "'.$row['athlete_picture'].'", ';
    echo '"athlete_weightclass": "'.$row['athlete_weightclass'].'", ';
    echo '"athlete_grade": "'.$row['athlete_grade'].'", ';
    echo '"athlete_wins": "'.$row['athlete_wins'].'", ';
    echo '"athlete_losses": "'.$row['athlete_losses'].'", ';
    echo '"athlete_draws": "'.$row['athlete_draws'].'"';

    echo ' }';
    $more = true;
}

?>
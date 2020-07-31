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
        $event1_picture = $row['event_picture'];
        $event1_description = $row['event_description'];
        $event1_date = $row['event_date'];
        $event1_year = substr($event1_date, 0, -6);
        $event1_month = substr($event1_date, 5, -3);
        $event1_day = substr($event1_date, 8);
        $event_time = str_replace(":00.0000","",$row['event_time']);
        $event1_hour = substr($event_time, 0, -3);
        $event1_minute = substr($event_time, 3);
        $event1_ticketlink = $row['event_link'];
        $event1_place = $row['event_place'];
        $query = "SELECT * FROM `videos` WHERE video_type = 'Live' AND video_event = '$event1_id' ORDER BY video_id DESC";
        $result = mysqli_query($db, $query);
        while ($row = mysqli_fetch_assoc($result)) {
            $event1_live_link = $row['video_link'];
            $event1_live_link =  str_replace("https://www.youtube.com/embed/","",$event1_live_link);
        }
        $query = "SELECT count( DISTINCT competition_id) AS event_max_comp FROM `eventcompetition` WHERE event_id = '$event1_id'";
        $result = mysqli_query($db, $query);
        while ($row = mysqli_fetch_assoc($result)) {
            $event1_max_comp = $row['event_max_comp'];
        }
        $only1 = false;
    }
}

$athleteArray[] = array();
$offset = 0;
echo "[ ";
$more = false;
$query = "SELECT a.* FROM `athletes` AS a
WHERE a.athlete_id IN 
(SELECT athlete_id FROM `athletecompetition` WHERE `competition_id` IN 
(SELECT competition_id FROM `eventcompetition` WHERE event_id = '$event1_id'))";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $athleteArray[] = $row;
}

array_shift($athleteArray);
foreach ($athleteArray as $row) {
    $only1Event = true;
    if ($more == true) {
        echo ', ';
    }

    echo '{ ';

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
    echo '"athlete_draws": "'.$row['athlete_draws'].'", ';
    echo '"total_yellowcards": "'.$row['athlete_yellowcards'].'", ';
    echo '"total_redcards": "'.$row['athlete_redcards'].'", ';

    //Eerst volgende evenement boven aan de homepage
    echo '"event1_id": "'.$event1_id.'", ';
    echo '"event1_name": "'.$event1_name.'", ';
    echo '"event1_picture": "'.$event1_picture.'", ';
    echo '"event1_description": "'.$event1_description.'", ';
    echo '"event1_date": "'.$event1_date.'", ';
    echo '"event1_year": "'.$event1_year.'", ';
    echo '"event1_month": "'.$event1_month.'", ';
    echo '"event1_day": "'.$event1_day.'", ';
    echo '"event1_hour": "'.$event1_hour.'", ';
    echo '"event1_minute": "'.$event1_minute.'", ';
    echo '"event1_ticketlink": "'.$event1_ticketlink.'", ';
    echo '"event1_live_link": "'.$event1_live_link.'", ';
    echo '"event1_place": "'.$event1_place.'", ';
    echo '"event1_max_comp": "'.$event1_max_comp.'", ';

    //get all upcoming events
    $query = "SELECT * FROM `events` WHERE NOT event_name = 'event_0' AND event_date >= '$today' 
    AND NOT event_id = '$event1_id' ORDER BY event_date ASC LIMIT " . intval($offset) . ", 1";
    $result = mysqli_query($db, $query);
    while ($row = mysqli_fetch_assoc($result)) {
        //Evenement dat na eerst volgende evenement komt
        $event2_id = $row['event_id'];
        echo '"event2_id": "'.$row['event_id'].'", ';
        echo '"event2_name": "'.$row['event_name'].'", ';
        echo '"event2_picture": "'.$row['event_picture'].'", ';
        echo '"event2_description": "'.$row['event_description'].'", ';
        echo '"event2_date": "'.$row['event_date'].'", ';
        echo '"event2_ticketlink": "'.$row['event_link'].'", ';
        echo '"event2_place": "'.$row['event_place'].'", ';
        $query = "SELECT count( DISTINCT competition_id) AS event_max_comp FROM `eventcompetition` WHERE event_id = '$event2_id'";
        $result = mysqli_query($db, $query);
        while ($row = mysqli_fetch_assoc($result)) {
            $event2_max_comp = $row['event_max_comp'];
        }
        echo '"event2_max_comp": "'.$event2_max_comp.'"';
        $offset++;
    }

    echo ' }';
    $more = true;
}
echo " ]";

?>
<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

//athletes
$more = false;
$query = "SELECT * FROM `athletes`";
$result = mysqli_query($db, $query);
echo '[ ';
while ($row = mysqli_fetch_assoc($result)) {
    if ($more) {
        echo ', ';
    }
    echo '{ ';
    echo '"type": "athlete", ';
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

    echo '"event_id": "", ';
    echo '"competition": "", ';
    echo '"event_name": "", ';
    echo '"event_description": "", ';
    echo '"event_date": "", ';
    echo '"event_place": "", ';
    echo '"event_picture": "", ';
    echo '"event_picture2": "", ';
    echo '"event_link": "", ';
    echo '"event_max_comp": "", ';

    echo '"video_id": "", ';
    echo '"video_title": "", ';
    echo '"video_event": "", ';
    echo '"video_event_name": "", ';
    echo '"video_description": "", ';
    echo '"video_type": "", ';
    echo '"video_date_added": "", ';
    echo '"video_link": "" }';
    $more = true;
}

//upcoming events
$today = date("Y-m-d");
$event = array();
$query = "SELECT * FROM `events` WHERE NOT event_name = 'event_0' AND event_date >= '$today' ORDER BY event_date ASC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $event[] = $row;
}
$more = false;
foreach($event as $data) {
    $eventid = $data['event_id'];
    echo '{ ';
    echo '"type": "upcoming_event", ';
    echo '"athlete_id": "", ';
    echo '"athlete_firstname": "", ';
    echo '"athlete_lastname": "", ';
    echo '"athlete_nickname": "", ';
    echo '"athlete_picture": "", ';
    echo '"athlete_weightclass": "", ';
    echo '"athlete_grade": "", ';
    echo '"athlete_wins": "", ';
    echo '"athlete_losses": "", ';
    echo '"athlete_draws": "", ';
    echo '"total_yellowcards": "", ';
    echo '"total_redcards": "", ';

    echo '"event_id": "'.$data['event_id'].'", ';
    echo '"competition": "'.$data['competition'].'", ';
    echo '"event_name": "'.$data['event_name'].'", ';
    echo '"event_description": "'.$data['event_description'].'", ';
    echo '"event_date": "'.$data['event_date'].'", ';
    echo '"event_place": "'.$data['event_place'].'", ';
    echo '"event_picture": "'.$data['event_picture'].'", ';
    echo '"event_picture2": "'.$data['event_picture2'].'", ';
    echo '"event_link": "'.$data['event_link'].'", ';
    $query = "SELECT count( DISTINCT competition_id) AS event_max_comp FROM `eventcompetition` WHERE event_id = '$eventid'";
    $result = mysqli_query($db, $query);
    while ($row = mysqli_fetch_assoc($result)) {
        echo '"event_max_comp": "'.$row['event_max_comp'].'"';
    }

    echo '"video_id": "", ';
    echo '"video_title": "", ';
    echo '"video_event": "", ';
    echo '"video_event_name": "", ';
    echo '"video_description": "", ';
    echo '"video_type": "", ';
    echo '"video_date_added": "", ';
    echo '"video_link": "" ';
    echo '}, ';
    $more = true;
}

//old events
$today = date("Y-m-d");
$event = array();
$query = "SELECT * FROM `events` WHERE NOT event_name = 'event_0' AND event_date < '$today' ORDER BY event_date ASC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $event[] = $row;
}
$more = false;
foreach($event as $data) {
    $eventid = $data['event_id'];
    echo '{ ';
    echo '"type": "old_event", ';
    echo '"athlete_id": "", ';
    echo '"athlete_firstname": "", ';
    echo '"athlete_lastname": "", ';
    echo '"athlete_nickname": "", ';
    echo '"athlete_picture": "", ';
    echo '"athlete_weightclass": "", ';
    echo '"athlete_grade": "", ';
    echo '"athlete_wins": "", ';
    echo '"athlete_losses": "", ';
    echo '"athlete_draws": "", ';
    echo '"total_yellowcards": "", ';
    echo '"total_redcards": "", ';

    echo '"event_id": "'.$data['event_id'].'", ';
    echo '"competition": "'.$data['competition'].'", ';
    echo '"event_name": "'.$data['event_name'].'", ';
    echo '"event_description": "'.$data['event_description'].'", ';
    echo '"event_date": "'.$data['event_date'].'", ';
    echo '"event_place": "'.$data['event_place'].'", ';
    echo '"event_picture": "'.$data['event_picture'].'", ';
    echo '"event_picture2": "'.$data['event_picture2'].'", ';
    echo '"event_link": "'.$data['event_link'].'", ';
    $query = "SELECT count( DISTINCT competition_id) AS event_max_comp FROM `eventcompetition` WHERE event_id = '$eventid'";
    $result = mysqli_query($db, $query);
    while ($row = mysqli_fetch_assoc($result)) {
        echo '"event_max_comp": "'.$row['event_max_comp'].'"';
    }

    echo '"video_id": "", ';
    echo '"video_title": "", ';
    echo '"video_event": "", ';
    echo '"video_event_name": "", ';
    echo '"video_description": "", ';
    echo '"video_type": "", ';
    echo '"video_date_added": "", ';
    echo '"video_link": "" ';
    echo '}, ';
    $more = true;
}

//videos
$more = false;
$query = "SELECT * FROM `videos`";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $vid_link =  str_replace("https://www.youtube.com/embed/","",$row['video_link']);
    if ($more == true) {
        echo ', ';
    }
    echo '{ ';
    echo '"type": "video", ';
    echo '"athlete_id": "", ';
    echo '"athlete_firstname": "", ';
    echo '"athlete_lastname": "", ';
    echo '"athlete_nickname": "", ';
    echo '"athlete_picture": "", ';
    echo '"athlete_weightclass": "", ';
    echo '"athlete_grade": "", ';
    echo '"athlete_wins": "", ';
    echo '"athlete_losses": "", ';
    echo '"athlete_draws": "", ';
    echo '"total_yellowcards": "", ';
    echo '"total_redcards": "", ';

    echo '"event_id": "", ';
    echo '"competition": "", ';
    echo '"event_name": "", ';
    echo '"event_description": "", ';
    echo '"event_date": "", ';
    echo '"event_place": "", ';
    echo '"event_picture": "", ';
    echo '"event_picture2": "", ';
    echo '"event_link": "", ';
    echo '"event_max_comp": "", ';

    echo '"video_id": "'.$row['video_id'].'", ';
    echo '"video_title": "'.$row['video_title'].'", ';
    echo '"video_event": "'.$row['video_event'].'", ';
    echo '"video_event_name": "'.$row['video_event_name'].'", ';
    echo '"video_description": "'.$row['video_description'].'", ';
    echo '"video_type": "'.$row['video_type'].'", ';
    echo '"video_date_added": "'.$row['video_date_added'].'", ';
    echo '"video_link": "'.$vid_link.'" }';
    $more = true;
}
echo ' ]';
?>
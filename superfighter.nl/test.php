<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$today = date("Y-m-d");

$only1 = true;
$query = "SELECT * FROM `events` WHERE NOT event_name = 'event_0' AND event_date >= '$today' ORDER BY event_date ASC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    if ($only1) {
        $date = $row['event_date'];
        $year = substr($date, 0, -6);
        $month = substr($date, 5, -3);
        $day = substr($date, 8);
        echo '{ ';
        echo '"event_id": "'.$row['event_id'].'", ';
        echo '"event_name": "'.$row['event_name'].'", ';
        echo '"event_description": "'.$row['event_description'].'", ';
        echo '"event_place": "'.$row['event_place'].'", ';
        echo '"event_picture": "'.$row['event_picture'].'", ';
        echo '"event_picture2": "'.$row['event_picture2'].'", ';
        echo '"event_link": "'.$row['event_link'].'", ';
        echo '"event_year": "'.$year.'", ';
        echo '"event_month": "'.$month.'", ';
        echo '"event_day": "'.$day.'"';
        echo ' }';
        $only1 = false;
    }
}
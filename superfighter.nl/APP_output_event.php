<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$today = date("Y-m-d");

$event = array();
$query = "SELECT * FROM `events` WHERE NOT event_name = 'event_0' AND event_date >= '$today' ORDER BY event_date ASC";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $event[] = $row;
}

$more = false;
echo "[ ";
foreach($event as $data) {
    $eventid = $data['event_id'];
    if ($more == true) {
        echo ', ';
    }
    echo '{ ';
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
    echo ' }';
    $more = true;
}
echo " ]";

?>
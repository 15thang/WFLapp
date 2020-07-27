<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$more = false;
echo '[ ';
$query = "SELECT * FROM `videos`";
$result = mysqli_query($db, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $vid_link =  str_replace("https://www.youtube.com/embed/","",$row['video_link']);

    if ($more == true) {
        echo '}, ';
    }
    echo '{ ';
    echo '"video_id": "'.$row['video_id'].'", ';
    echo '"video_title": "'.$row['video_title'].'", ';
    echo '"video_event": "'.$row['video_event'].'", ';
    echo '"video_event_name": "'.$row['video_event_name'].'", ';
    echo '"video_description": "'.$row['video_description'].'", ';
    echo '"video_type": "'.$row['video_type'].'", ';
    echo '"video_date_added": "'.$row['video_date_added'].'", ';
    echo '"video_link": "'.$vid_link.'" ';
    $more = true;
}
echo '} ]'
?>
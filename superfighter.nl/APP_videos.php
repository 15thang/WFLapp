<?php
session_start();
if(isset($_SESSION['admin_name']))
    { 
?>
<?php
ob_start();
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
?>
<link rel="stylesheet" type="text/css" href="css/wflapp.css">
<link rel="stylesheet" type="text/css" href="css/APP_athlete_CSS.css">
<link rel="stylesheet" type="text/css" href="css/APP_event_CSS.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<section id="container_menu">
    <form action="APP_menu.php" method=post>
        <button class="ssbutton" type="submit" name="info">Menu</button>
    </form>
    <form action="APP_Toevoegen_video.php" method=post>
        <button class="ssbutton" type="submit" name="info">Add a video</button>
    </form>
</section><br><br><br>
<?php

$query = "SELECT * FROM `videos` ORDER BY video_id DESC";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    echo '<div style="height: 340px; width: 424px; background-color: limegreen; margin: 20px; float: left;"><iframe width="420" height="240" src="'.$row['video_link'].'"></iframe><br>
        Name: '.$row['video_title'].'<br>
        Type: '.$row['video_type'].'<br>
        Description: '.$row['video_description'].'<br>
        Date added: '.$row['video_date_added'].'<br>
        Event name: '.$row['video_event_name'].'
        <form id="form_delete_video" method="post" action="APP_delete_video.php?video_id='.$row['video_id'].'" style="float: right; margin-top: -60px;">
            <button type="submit" class="button" value="Delete" style="background-image: linear-gradient(to bottom, rgba(0, 163, 52,0) , rgba(255, 17, 0, 1) , rgba(0, 163, 52,0)">X</button>
        </form>
        <form id="form_edit_video" method="post" action="APP_edit_video.php?video_id='.$row['video_id'].'" style="float: right; margin-top: -30px;">
            <button type="submit" class="button" value="Edit" style="background-image: linear-gradient(to bottom, rgba(0, 163, 52,0) , rgba(173,255,47, 1) , rgba(0, 163, 52,0)">Edit</button>
        </form>
        
        </div>';
        
}
?>
<?php }
    else {
        echo 'Je moet inloggen';
    }
    ?>
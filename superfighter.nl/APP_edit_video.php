<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
?>
<head>
    <link rel="stylesheet" type="text/css" href="css/APP_CSS.css">
</head>

<div>
    <a href="APP_videos.php">Back to overview</a><br><br>
</div>
<?php
$video_id = $_GET['video_id'];
echo $video_id;

$query = "SELECT * FROM `videos` WHERE video_id = '$video_id'";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    //invulveld
    echo '<div id="field2">
        <form name="form1" method="post" action="" enctype="multipart/form-data">
        <h3>Edit video</h3>
        <label>Name video <font color="red">*</font></label><br>
        <input type="text" name="video_name" value="'.$row['video_title'].'" required><br>
        <label>Description <font color="red">*</font></label><br>
        <input type="text" name="video_description" value="'.$row['video_description'].'" required><br>
        <label>Video link <font color="red">*</font></label><br>
        <input type="text" name="video_link" placeholder="https://www.youtube.com/watch?v=dQw4w9WgXcQ" value="'.$row['video_link'].'" required><br>
        <label>Video type <font color="red">*</font></label><br>
        <select name="video_type" required>
            <option value="'.$row['video_type'].'">'.$row['video_type'].'</option>
            <option value="Trailer">Trailer</option>
            <option value="Highlight">Highlight</option>
            <option value="Full fight">Full fight</option>
            <option value="Other">Other</option>
        </select><br>
        <label>Select event (optional)</label><br>
        <select name="event_video">
        <option value="'.$row['video_event'].'">';
        if ($row['video_event'] != 0) {
            echo 'Keep previous event';
        }
        echo '</option>';
    }
$query = "SELECT * FROM `events` ORDER BY event_id DESC";
$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    if ($row['event_name'] != 'event_0') {
        echo '<option value="'.$row['event_id'].'">'.$row['event_name'].'</option>';
    }
}
    ?>
        </select><br>
        <br>
        <div class="input-group" style="float: left;">
            <button type="submit" class="btn" name="edit_video">Edit video</button>
        </div>
        <br>
    </form>
</div>
<div id="field">
    hoi
</div>

<div id="field">
    <?php
    if (isset($_POST['edit_video'])) {
        $video_name = ($_POST['video_name']);
        $video_description = ($_POST['video_description']);
        $video_link = ($_POST['video_link']);
        $video_type = ($_POST['video_type']);
        $video_event = ($_POST['event_video']);
        //event name
        $query = "SELECT event_name FROM `events` WHERE event_id = '$video_event'";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            $event_name = $row['event_name'];
        }
        //change link to right format
        $video_embed= str_replace("https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/", "$video_link");

        //echo wat je hebt ingevuld
        echo $video_name . $video_description .'<iframe width="420" height="300" src="'.$video_link.'"></iframe>';

        $query = "UPDATE videos SET video_title = '$video_name', video_description = '$video_description', video_link = '$video_embed', video_type = '$video_type', video_event = '$video_event', video_event_name = '$event_name'
                  WHERE video_id = '$video_id'";
        mysqli_query($db, $query);
    }
    ?>
</div>
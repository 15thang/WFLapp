<?php
ob_start();
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
?>
<head>
    <link rel="stylesheet" type="text/css" href="css/APP_CSS.css">
</head>

<div>
    <a href="APP_videos.php">Back to video overview</a><br><br>
</div>

<div id="field">
    <form name="form1" method="post" action="" enctype="multipart/form-data">
        <h3>Add video</h3>
        <label>Name video <font color="red">*</font></label><br>
        <input type="text" name="video_name" required><br>
        <label>Description <font color="red">*</font></label><br>
        <input type="text" name="video_description" required><br>
        <label>Video link <font color="red">*</font></label><br>
        <input type="text" name="video_link" placeholder="https://www.youtube.com/watch?v=dQw4w9WgXcQ" required><br>
        <label>Video type <font color="red">*</font></label><br>
        <select name="video_type" required>
            <option disabled selected value></option>
            <option value="Trailer">Trailer</option>
            <option value="Highlight">Highlight</option>
            <option value="Full fight">Full fight</option>
            <option value="Other">Other</option>
        </select><br>
        <label>Select event (optional)</label><br>
        <select name="event_video">
            <option value="1">No event</option>
            <?php
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
            <button type="submit" class="btn" name="add_video">Add video</button>
        </div>
        <br>
    </form>
</div>

<div id="field">
    hoi
</div>

<div id="field">
    <?php
    if (isset($_POST['add_video'])) {
        $video_name = ($_POST['video_name']);
        $video_date = date('Y-m-d');
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
        echo $video_name . $video_date . $video_description .'<iframe width="420" height="300" src="'.$video_link.'"></iframe>'.$video_event.'naam='.$event_name;

        $query = "INSERT INTO videos (video_title, video_description, video_type, video_date_added, video_link, video_event, video_event_name) 
  			  VALUES('$video_name', '$video_description', '$video_type','$video_date', '$video_embed', '$video_event', '$event_name')";
        mysqli_query($db, $query);

        //header("Location: APP_videos.php");
        ob_flush();

    }
    ?>
</div>
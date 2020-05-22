<?php
ob_start();
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
?>
<head>
    <link rel="stylesheet" type="text/css" href="css/APP_CSS.css">
</head>

<div>
    <a href="APP_events.php">Back to event overview</a><br><br>
</div>

<div id="field">
    <form name="form1" method="post" action="" enctype="multipart/form-data">
        <h3>Add Event</h3>
        <label>Name event</label><br>
        <input type="text" name="event_name"><br>
        <label>Day of event</label><br>
        <input type="date" name="event_date" min="2000-01-01" max="2030-01-01"><br>
        <label>Place</label><br>
        <input type="text" name="event_place"><br>
        <label>Description</label><br>
        <input type="text" name="event_description"><br>
        <label>Picture event</label><br>
        <input type="file" name="event_picture"><br>
        <label>Picture event 2</label><br>
        <input type="file" name="event_picture2"><br>
        <label>Purchase ticket link</label><br>
        <input type="text" name="event_link"><br>
        <br>
        <div class="input-group" style="float: left;">
            <button type="submit" class="btn" name="add_event">Add event</button>
        </div>
        <br>
    </form>
</div>

<div id="field">
    hoi
</div>

<div id="field">
    <?php
    if (isset($_POST['add_event'])) {
        $event_name = ($_POST['event_name']);
        $event_date = date('Y-m-d', strtotime($_POST['event_date']));
        $event_description = ($_POST['event_description']);
        $event_place = ($_POST['event_place']);
        $event_link = ($_POST['event_link']);

        //echo wat je hebt ingevuld
        echo $event_name . $event_date . $event_description . $event_place;

        if ($event_link == "") {
            $event_link = "https://www.eventbrite.nl/o/world-fighting-league-28797683507";
        }

        //check of picture input leeg is
        if ($_FILES['event_picture']['size'] == 0 && $_FILES['cover_image']['error'] == 0)
        {
            $dst="pics/eventpics/event_default1.png";
            move_uploaded_file($_FILES["event_picture"]["tmp_name"], $dst);
        }
        else {
            // cover_image is empty (and not an error)
            //foto naar mapje sturen
            $fnm=$_FILES["event_picture"]["name"];
            $dst="pics/eventpics/".$fnm;
            move_uploaded_file($_FILES["event_picture"]["tmp_name"], $dst);
        }

        //check of picture input leeg is
        if ($_FILES['event_picture2']['size'] == 0 && $_FILES['cover_image']['error'] == 0)
        {
            $dst2="pics/eventpics/event_default2.png";
            move_uploaded_file($_FILES["event_picture2"]["tmp_name"], $dst2);
        }
        else {
            // cover_image is empty (and not an error)
            //foto naar mapje sturen
            $fnm=$_FILES["event_picture2"]["name"];
            $dst2="pics/eventpics/".$fnm;
            move_uploaded_file($_FILES["event_picture2"]["tmp_name"], $dst2);

        }

        $query = "INSERT INTO events (event_name, event_date, event_description, event_place , event_picture, event_picture2, event_link) 
  			  VALUES('$event_name', '$event_date', '$event_description', '$event_place' , '$dst', '$dst2', '$event_link')";
        mysqli_query($db, $query);

        header("Location: APP_events.php");
        ob_flush();

    }
    ?>
</div>
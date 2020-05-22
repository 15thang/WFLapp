<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
?>
<head>
    <link rel="stylesheet" type="text/css" href="css/APP_CSS.css">
</head>

<div>
    <a href="APP_events.php">Back to overview</a><br><br>
</div>
<?php
$event_id = $_GET['event_id'];
echo $event_id;

$query = "SELECT * FROM `events` WHERE event_id = '$event_id'";

$results = mysqli_query($db, $query);
while ($row = $results->fetch_assoc()) {
    //Dit is de bestaande foto voor het geval er geen nieuwe foto wordt geupload.
    $event_picture = $row['event_picture'];
    $event_picture2 = $row['event_picture2'];
    //Als event_link de standaard link bevat, is het leeg
    if ($row['event_link'] == "https://www.eventbrite.nl/o/world-fighting-league-28797683507") {
        $event_link = "";
    } else {
        $event_link = $row['event_link'];
    }

    //invulveld
    echo '<div id="field2">
    <form name="form1" method="post" action="" enctype="multipart/form-data">
        <h3>Edit Event</h3>
        <label>Name event</label><br>
        <input type="text" name="event_name" value="' . $row['event_name'] . '"><br>
		<label>Day of event</label><br>
        <input type="date" name="event_date" min="2000-01-01" max="2030-01-01" value="' . $row['event_date'] . '"><br>
        <label>Place</label><br>
        <input type="text" name="event_place" value="' . $row['event_place'] . '"><br>
		<label>Description</label><br>
        <input type="text" name="event_description" value="' . $row['event_description'] . '"><br>
		<label>Picture event</label><br>
        <input type="file" name="event_picture" value="' . $row['event_picture'] . '"><br>
		<label>Picture event 2</label><br>
        <input type="file" name="event_picture2" value="' . $row['event_picture2'] . '"><br>
        <label>Purchase ticket link</label><br>
        <input type="text" name="event_link" value="' . $event_link . '"><br>
        <br>
        <div class="input-group" style="float: left;">
            <button type="submit" class="btn" name="add_event">Edit event</button>
        </div>
        <br>
    </form>
</div>';
}
?>
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
            $dst = $event_picture;
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
            $dst2 = $event_picture2;
        }
        else {
            // cover_image is empty (and not an error)
            //foto naar mapje sturen
            $fnm=$_FILES["event_picture2"]["name"];
            $dst2="pics/eventpics/".$fnm;
            move_uploaded_file($_FILES["event_picture2"]["tmp_name"], $dst2);
        }

        $query = "UPDATE events SET event_name = '$event_name', event_date = '$event_date', event_description = '$event_description',
                  event_place = '$event_place', event_picture = '$dst', event_picture2 = '$dst2', event_link = '$event_link' 
                  WHERE event_id = '$event_id'";
        mysqli_query($db, $query);

    }
    ?>
</div>
<?php
ob_start();
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$event_id = $_GET['event_id'];
$events7 = $_GET['events7'];
if ($events7 == 9) {
    echo "<script type='text/javascript'>alert('This competition already has 9 events!');</script>";
}

$query = "SELECT * FROM `events` WHERE event_id = '$event_id'";
$results = mysqli_query($db, $query);

while ($row = $results->fetch_assoc()) {
    echo '
	<link rel="stylesheet" type="text/css" href="css/wflapp.css">
	<link rel="stylesheet" type="text/css" href="css/APP_athlete_CSS.css">
	<link rel="stylesheet" type="text/css" href="css/APP_event_CSS.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<section id="container_menu">
	<form action="APP_events.php" method=post>
		<button class="ssbutton" type="submit" name="info">Back</button>
	</form>
	
	<form action="APP_competition.php" method=post>
		<button class="ssbutton" type="submit" name="info">Look for Competitions</button>
	</form>
	
	<form action="APP_website2.php" method=post>
		<button class="ssbutton" type="submit" name="info">Look for Athletes</button>
	</form>
</section>

<section id="eventinfo">
<body>
<!-- Foto van de atleet -->
<div id="up">
      <div id="picture_event">
		<img src="'.$row['event_picture'].'" id="pic"/>
		<img src="'.$row['event_picture2'].'" id="pic"/>
	  </div>

<!-- Event gegevens -->
<div id="eventinformation">
<table>
    <tr>
        <th>Event name: </th>
        <td>' . $row['event_name'] . '</td>
    </tr>
    <tr>
        <th>Location event: </th>
        <td>' . $row['event_place'] . '</td>    
    </tr>
    <tr>
        <th>Date event: </th>
        <td>' . $row['event_date'] . '</td>    
    </tr>
    <tr>
        <th>Description: </th>
        <td>' . $row['event_description'] . '</td>    
    </tr>
    </table>
</div>
<div id="eventcompetition">';
    $comp = $row['competition'];
    if ($comp == 0) {
        echo '<form id="form_add_comp2event" method="post" action="APP_add_comp2event.php?event_id=' . $event_id . '&competition_id=0&redcorner_id=0&bluecorner_id=0">
                <button type="submit" class="ssbutton">No competition! Add competition></button>
              </form>
               ';
    } else {
        echo '<form id="form_add_match2event" method="post" action="APP_add_match2event.php?event_id=' . $event_id . '&competition_id=' . $comp . '&redcorner_id=0&bluecorner_id=0">
                <button type="submit" class="ssbutton">Add more matches</button>
              </form>
               ';
    }
}
?>
</div>
<!-- Competitie -->
<div id="eventcompetition">

    <!-- rode hoek-->
    <div id="redcorner" style="float: left;">
        <table>
            <tr>
                <th>Red corner</th>
                <th>Stats</th>
            </tr>
            <?php
            $query = "SELECT * FROM matches WHERE matches.athlete_id
            IN (SELECT redcorner FROM `eventcompetition` WHERE competition_id = '$comp' AND event_id = '$event_id')
            AND matches.event_id = '$event_id'";
            $results = mysqli_query($db, $query);

            while ($row = $results->fetch_assoc()) {
                //switch case om de nummers naar letters te veranderen
                switch ($row['athlete_grade']) {
                    case "0":
                        $athlete_grade_letter = "";
                        break;
                    case "1":
                        $athlete_grade_letter = "A";
                        break;
                    case "2":
                        $athlete_grade_letter = "B";
                        break;
                    case "3":
                        $athlete_grade_letter = "C";
                        break;
                    case "4":
                        $athlete_grade_letter = "N";
                        break;
                    case "5":
                        $athlete_grade_letter = "J";
                        break;
                }
                //switch case om nummers naar namen te veranderen
                switch ($row['athlete_weightclass']) {
                    case "0":
                        $athlete_weightclassA = "";
                        break;
                    case "1":
                        $athlete_weightclassA = "95+";
                        break;
                    case "2":
                        $athlete_weightclassA = "95";
                        break;
                    case "3":
                        $athlete_weightclassA = "84";
                        break;
                    case "4":
                        $athlete_weightclassA = "77";
                        break;
                    case "5":
                        $athlete_weightclassA = "70";
                        break;
                    case "6":
                        $athlete_weightclassA = "65";
                        break;
                    case "7":
                        $athlete_weightclassA = "61";
                        break;
                }
                echo '
            <tr id="section'.$row['athlete_id'].'">
                <td><img id="cornerPic" src="'.$row['athlete_picture'].'" id="pic"/><form id="form_delete_match" method="post" action="APP_delete_match.php?red_id='.$row['athlete_id'].'&comp_id='.$comp.'&event_id='.$event_id.'">
                <button type="submit" class="button" value="Delete" style="background-color: red; cursor: pointer; font-family: raleway; font-weight: bold;">Remove match</button>
                </form>
                    '.$row['athlete_name'].'<br>'
                    .$row['athlete_nickname'].'<br>'
                    .$athlete_grade_letter.', '.$athlete_weightclassA.'
                </td>
                <td>
                <form name="formSubmitRedcorner" method="post" action="">
                    Red/Yellow cards<br><select name="badcard">';
                echo '
                    <option value="'.$row['redyellowcard'].'">'.$row['redyellowcard'].'</option>
                    <option value="1redcard">Red card</option>
                    <option value="1yellowcard">1 Yellow card</option>
                    <option value="2yellowcard">2 Yellow cards</option>
                    </select><br>
                    Punch points<br><input type="number" name="points" value="'.$row['points'].'"><br>
                    TKO/KO<br><select name="KO">
                    <option value="'.$row['ko'].'">'.$row['ko'].'</option>
                    <option value="1TKO">TKO</option>
                    <option value="1KO">KO</option>
                    </select><br><br>
                <button type="submit" name="submitRedcorner" value="'.$row['athlete_id'].'" style="background-color: lime;">Submit stats</button>
                </form>
                </td>
            </tr>
            ';
            }//submit red corner stats
            if (isset($_POST['submitRedcorner'])) {
                $athlete_id = ($_POST['submitRedcorner']);
                $redyellowcard = ($_POST['badcard']);
                $points = ($_POST['points']);
                $ko = ($_POST['KO']);

                header('location: APP_submit_match_outcome.php?athlete_id='.$athlete_id.'&red_id=1&blue_id=0&comp_id='.$comp.'&event_id='.$event_id.'&redyellowcard='.$redyellowcard.'&points='.$points.'&ko='.$ko);
                ob_flush();
            }
            ?>
        </table>
    </div>
    <!-- blauwe hoek-->
    <div id="bluecorner" style="float: right;">
        <table>
            <tr>
                <th>Stats</th>
                <th>Blue corner</th>
            </tr>
            <?php
            $query = "SELECT * FROM matches WHERE matches.athlete_id
            IN (SELECT bluecorner FROM `eventcompetition` WHERE competition_id = '$comp' AND event_id = '$event_id')
            AND matches.event_id = '$event_id'";
            $results = mysqli_query($db, $query);
            while ($row = $results->fetch_assoc()) {
                //switch case om de nummers naar letters te veranderen
                switch ($row['athlete_grade']) {
                    case "0":
                        $athlete_grade_letter = "";
                        break;
                    case "1":
                        $athlete_grade_letter = "A";
                        break;
                    case "2":
                        $athlete_grade_letter = "B";
                        break;
                    case "3":
                        $athlete_grade_letter = "C";
                        break;
                    case "4":
                        $athlete_grade_letter = "N";
                        break;
                    case "5":
                        $athlete_grade_letter = "J";
                        break;
                }
                //switch case om nummers naar namen te veranderen
                switch ($row['athlete_weightclass']) {
                    case "0":
                        $athlete_weightclassA = "";
                        break;
                    case "1":
                        $athlete_weightclassA = "95+";
                        break;
                    case "2":
                        $athlete_weightclassA = "95";
                        break;
                    case "3":
                        $athlete_weightclassA = "84";
                        break;
                    case "4":
                        $athlete_weightclassA = "77";
                        break;
                    case "5":
                        $athlete_weightclassA = "70";
                        break;
                    case "6":
                        $athlete_weightclassA = "65";
                        break;
                    case "7":
                        $athlete_weightclassA = "61";
                        break;
                }

                echo '
            <tr id="section'.$row['athlete_id'].'">
            <td>
                <form name="formSubmitBluecorner" method="post" action="">
                    Red/Yellow cards<br><select name="badcard">';
                echo '
                    <option value="'.$row['redyellowcard'].'">'.$row['redyellowcard'].'</option>
                    <option value="1redcard">Red card</option>
                    <option value="1yellowcard">1 Yellow card</option>
                    <option value="2yellowcard">2 Yellow cards</option>
                    </select><br>
                    Punch points<br><input type="number" name="points" value="'.$row['points'].'"><br>
                    TKO/KO<br><select name="KO">
                    <option value="'.$row['ko'].'">'.$row['ko'].'</option>
                    <option value="1TKO">TKO</option>
                    <option value="1KO">KO</option>
                    </select><br><br>
                <button type="submit" name="submitBluecorner" value="'.$row['athlete_id'].'" style="background-color: lime;">Submit stats</button>
                </form>
                </td>
                <td style="width: 20%;"><img id="cornerPic" src="'.$row['athlete_picture'].'" id="pic"/><form id="form_delete_match" method="post" action="APP_delete_match.php?blue_id='.$row['athlete_id'].'&comp_id='.$comp.'&event_id='.$event_id.'">
                <button type="submit" class="button" value="Delete" style="background-color: red; cursor: pointer; font-family: raleway; font-weight: bold;">Remove match</button>
                </form>
                    '.$row['athlete_name'].'<br>'
                    .$row['athlete_nickname'].'<br>'
                    .$athlete_grade_letter.', '.$athlete_weightclassA.'
                </td>
            </tr>
            ';
            }//submit blue corner
            if (isset($_POST['submitBluecorner'])) {
                $athlete_id = ($_POST['submitBluecorner']);
                $redyellowcard = ($_POST['badcard']);
                $points = ($_POST['points']);
                $ko = ($_POST['KO']);

                header('location: APP_submit_match_outcome.php?athlete_id='.$athlete_id.'&red_id=0&blue_id=1&comp_id='.$comp.'&event_id='.$event_id.'&redyellowcard='.$redyellowcard.'&points='.$points.'&ko='.$ko);
                ob_flush();
            }
            ?>
        </table>
    </div>
    </table>
</div>
<!-- Competitie statistieken -->
<div id="statistics">

</div>
</section>
</body>


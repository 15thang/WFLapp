<?php
ob_start();
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$event_id = $_GET['event_id'];
$selected_comp = $_GET['competition_id'];
$red_corner = true;
$red_cornerID = $_GET['redcorner_id'];
$blue_cornerID = $_GET['bluecorner_id'];
$more = $_GET['more'];

$query = "SELECT * FROM `competition` WHERE competition_id IN (SELECT competition_id FROM `eventcompetition` WHERE event_id = '$event_id') ORDER BY competition_id DESC";
$results = mysqli_query($db, $query);

if (!$red_cornerID == 0) {
    $red_corner = false;
}
?>
<head>
    <link rel="stylesheet" type="text/css" href="css/APP_CSS.css">
    <link rel="stylesheet" type="text/css" href="css/wflapp.css">
    <link rel="stylesheet" type="text/css" href="css/APP_event_CSS.css">
</head>

<div><!-- terugknop -->
    <?php
    echo'
        <form action="APP_event_info.php?event_id='.$event_id.'&events7=0" method=post>
            <button class="ssbutton" type="submit" name="info">Back</button>
        </form>';
    ?>
</div>

<!-- Selecteer competitie om atleten te weergeven -->
<div id="field">
    <form name="form1" method="post" action="" enctype="multipart/form-data">
        <div class="container" style="margin-top:10px;">
            <input id="myInput" type="text" placeholder="Search..">
            <table id="table_format" class="table table-bordered">
                <tr>
                    <th class="skip-filter" style="text-decoration: underline">Select competition for match</th>
                    <th class="skip-filter">Competition name</th>
                </tr>
                <tbody id="myTable">
                <?php
                while ($row = $results->fetch_assoc()) {
                    if ($selected_comp == $row['competition_id']){
                        echo '
                <tr style="background-color:green">
                <td>'.$row['competition_id'].'
                <label>
                <input type="radio" name="radioComp" value="'.$row['competition_id'].'"/>
                </label>
                </td>
                <td>'.$row['competition_name'].'</td>
                </td>
              </tr>';
                    } else {
                        echo '
                <tr>
                <td>'.$row['competition_id'].'
                <label>
                <input type="radio" name="radioComp" value="'.$row['competition_id'].'"/>
                </label>
                </td>
                <td>'.$row['competition_name'].'</td>
                </td>
              </tr>';
                    }
                }
                ?>
                </tbody>
            </table>
        </div>
    </form>
</div>
<div id="athleteVSdiv">
    <div id="topVS">
        <?php
        if ($red_corner == true && !$selected_comp == 0) {
            echo '<p id="p_VS1">SELECT CORNER 1</p>';
        } else if ($red_corner == false && $blue_cornerID == 0) {
            echo '<p id="p_VS2">SELECT CORNER 2</p>';
        } else if ($red_corner == false && $blue_cornerID != 0) {
            echo '<p id="p_VS2">CONFIRM MATCH</p>';
        } else {
            echo '<p id="p_VS1">SELECT A COMPETITION</p>';
        }
        ?>
    </div>
    <div id="athleteVS">
        <?php
        $query = "SELECT * FROM `athletes` WHERE athlete_id = '$red_cornerID'";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            $athlete_id = $row['athlete_id'];
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
                    $athlete_weightclassA = "Heavyweight";
                    break;
                case "2":
                    $athlete_weightclassA = "Light Heavyweight";
                    break;
                case "3":
                    $athlete_weightclassA = "Middleweight";
                    break;
                case "4":
                    $athlete_weightclassA = "Welterweight";
                    break;
                case "5":
                    $athlete_weightclassA = "Lightweight";
                    break;
                case "6":
                    $athlete_weightclassA = "Featherweight";
                    break;
                case "7":
                    $athlete_weightclassA = "Bantamweight";
                    break;
                case "8":
                    $athlete_weightclassA = "Flyweight";
                    break;
                case "9":
                    $athlete_weightclassA = "Strawweight";
                    break;
            }
            echo '<img id="cornerPic" src="' . $row['athlete_picture'] . '" id="pic"/><br>
                 '.$row['athlete_firstname'] . ' ' . $row['athlete_lastname'] . '<br>
                 '.$row['athlete_nickname'].'<br>
                 '.$athlete_grade_letter.'<br>
                 '.$athlete_weightclassA;
        }
        ?>
    </div>
    <h2 id="athleteVSh2">
        <?php
        $query = "SELECT * FROM events WHERE event_id = '$event_id'";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            echo $row['event_name'].'<br>';
        }
        $query2 = "SELECT * FROM `competition` WHERE competition_id 
          IN (SELECT competition_id FROM `athletecompetition` 
          WHERE competition_id ='$selected_comp')";
        $results2 = mysqli_query($db, $query2);
        while ($row = $results2->fetch_assoc()) {
            //show comp name
            echo $row['competition_name'].'<br><br>VS</h2>';

            //variabelen om te kijken hoeveelste event dit event is
            $event1 = $row['event1'];
            $event2 = $row['event2'];
            $event3 = $row['event3'];
            $event4 = $row['event4'];
            $event5 = $row['event5'];
            $event6 = $row['event6'];
            $event7 = $row['event7'];
            $event8 = $row['event8'];
            $event9 = $row['event9'];

            if ($event1 == 0) {
                $comp_event = 1;
            } else if ($event2 == 0) {
                $comp_event = 2;
            } else if ($event3 == 0) {
                $comp_event = 3;
            } else if ($event4 == 0) {
                $comp_event = 4;
            } else if ($event5 == 0) {
                $comp_event = 5;
            } else if ($event6 == 0) {
                $comp_event = 6;
            } else if ($event7 == 0) {
                $comp_event = 7;
            } else if ($event8 == 0) {
                $comp_event = 8;
            } else if ($event9 == 0) {
                $comp_event = 9;
            } else {
                $comp_event = 0;
            }
        }
        ?>
        <div id="athleteVS2">
            <?php
            $query = "SELECT * FROM `athletes` WHERE athlete_id = '$blue_cornerID'";
            $results = mysqli_query($db, $query);
            while ($row = $results->fetch_assoc()) {
                $athlete_id = $row['athlete_id'];
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
                        $athlete_weightclassA = "Heavyweight";
                        break;
                    case "2":
                        $athlete_weightclassA = "Light Heavyweight";
                        break;
                    case "3":
                        $athlete_weightclassA = "Middleweight";
                        break;
                    case "4":
                        $athlete_weightclassA = "Welterweight";
                        break;
                    case "5":
                        $athlete_weightclassA = "Lightweight";
                        break;
                    case "6":
                        $athlete_weightclassA = "Featherweight";
                        break;
                    case "7":
                        $athlete_weightclassA = "Bantamweight";
                        break;
                    case "8":
                        $athlete_weightclassA = "Flyweight";
                        break;
                    case "9":
                        $athlete_weightclassA = "Strawweight";
                        break;
                }
                echo '<img id="cornerPic" src="' . $row['athlete_picture'] . '" id="pic"/><br>
                 '.$row['athlete_firstname'] . ' ' . $row['athlete_lastname'] . '<br>
                 '.$row['athlete_nickname'].'<br>
                 '.$athlete_grade_letter.'<br>
                 '.$athlete_weightclassA;
            }
            echo '</div>';

            if ($red_corner == false && $blue_cornerID != 0) {
                echo '<form method="post">
            <button type="submit" name="submit_event_comp">Confirm</button>
        </form>';
            }

            if (isset($_POST['submit_event_comp'])) {
                $query = "UPDATE events SET competition = '$selected_comp' WHERE competition = 0 AND event_id = '$event_id'";
                mysqli_query($db, $query);

                $query = "INSERT INTO eventcompetition (event_id, competition_id, redcorner, bluecorner) 
  			        VALUES('$event_id','$selected_comp','$red_cornerID','$blue_cornerID')";
                mysqli_query($db, $query);

                header("location: APP_insert_match.php?event_id=".$event_id."&competition_id=".$selected_comp."&redcorner_id=".$red_cornerID."&bluecorner_id=".$blue_cornerID."&events7=0");
                ob_flush();
            }

            ?>
        </div>
        <!-- atleten tabel dat atleten uit de geselecteerde competitie weergeeft-->
        <?php
        if ($red_corner == true && !$selected_comp == 0) {
            echo '<div id=field style="background-color:red;">';
        } else if ($red_corner == false && $blue_cornerID == 0) {
            echo '<div id=field style="background-color:blue;">';
        }

        $query2 = "SELECT * FROM `competition` WHERE competition_id 
          IN (SELECT competition_id FROM `athletecompetition` 
          WHERE competition_id ='$selected_comp')";
        $results2 = mysqli_query($db, $query2);
        while ($row = $results2->fetch_assoc()) {
            if ($red_corner == true && !$selected_comp == 0) {
                echo '<h2>'.$row['competition_name'].' - Select red corner fighter</h2>';
            } else if ($red_corner == false && $blue_cornerID == 0) {
                echo '<h2>'.$row['competition_name'].' - Select blue corner fighter</h2>';
            }
        }
        if ($red_corner == true && !$selected_comp == 0) {
            echo '<table id="table_format" class="table table-bordered" style="background-color: red; border-radius: 0;">';
        } else if ($red_corner == false && $blue_cornerID == 0) {
            echo '<table id="table_format" class="table table-bordered" style="background-color: blue; border-radius: 0;">';
        } else {
            echo '<table id="table_format" class="table table-bordered" hidden>';
        }
        echo '
                <tr>
                    <th class="skip-filter" style="text-decoration: underline">Select athlete for match</th>
                    <th class="skip-filter">firstname</th>
                    <th class="skip-filter">lastname</th>
                    <th class="skip-filter">nickname</th>
                    <th class="skip-filter">picture</th>
                    <th class="skip-filter">height(cm)</th>
                    <th class="skip-filter">weight(kg)</th>
                    <th>Filter weightclass...</th>
                    <th>Filter grade...</th>
                    <th>Filter nationality...</th>
                    <th class="skip-filter">day_of_birth</th>
                </tr>
                <tbody id="myTable">';

        $query2 = "SELECT * FROM `athletes` WHERE athlete_id 
          IN (SELECT athlete_id FROM `athletecompetition` 
          WHERE competition_id ='$selected_comp')";
        $results2 = mysqli_query($db, $query2);
        while ($row = $results2->fetch_assoc()) {
            $picture = $row['athlete_picture'];
            $athlete_id = $row['athlete_id'];
            $value = $row['athlete_id'];
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
                    $athlete_weightclassA = "Heavyweight";
                    break;
                case "2":
                    $athlete_weightclassA = "Light Heavyweight";
                    break;
                case "3":
                    $athlete_weightclassA = "Middleweight";
                    break;
                case "4":
                    $athlete_weightclassA = "Welterweight";
                    break;
                case "5":
                    $athlete_weightclassA = "Lightweight";
                    break;
                case "6":
                    $athlete_weightclassA = "Featherweight";
                    break;
                case "7":
                    $athlete_weightclassA = "Bantamweight";
                    break;
                case "8":
                    $athlete_weightclassA = "Flyweight";
                    break;
                case "9":
                    $athlete_weightclassA = "Strawweight";
                    break;
            }

            if ($red_cornerID != $row['athlete_id'] && $blue_cornerID != $row['athlete_id']){
                echo '
                <tr>
                <td>' . $row['athlete_id'] . '
                <input type="checkbox" name="checkComp" value="' . $value . '" onclick="checkBoxColorRow(this);"></td>
                <td>' . $row['athlete_firstname'] . '</td>
                <td>' . $row['athlete_lastname'] . '</td>
                <td>' . $row['athlete_nickname'] . '</td>
                <td><img src="' . $picture . '" id="pic"/>' . '</td>
                <td>' . $row['athlete_height'] . '</td><td>' . $row['athlete_weight'] . '</td>
                <td>' . $athlete_weightclassA . '</td>
                <td>' . $athlete_grade_letter . '</td>
                <td>' . $row['athlete_nationality'] . '</td>
                <td>' . $row['athlete_day_of_birth'] . '</td>
              </tr>
              ';
            }
        }
        echo '</tbody>
            </table>
</div>';
        ?>


        <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script src="lisenme.js"></script>
        <script>
            jQuery('#table_format').ddTableFilter();
        </script>
        <!-- Script om van elke rij een link te maken -->
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const rows = document.querySelectorAll("tr[data-href]");

                rows.forEach(row => {
                    row.addEventListener("click", () => {
                        window.location.href = row.dataset.href;
                    });
                });
            });
        </script>
        <!-- filter tabel -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script>
            $(document).ready(function(){
                $("#myInput").on("keyup", function() {
                    var value = $(this).val().toLowerCase();
                    $("#myTable tr").filter(function() {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>
        <!-- verander kleur if checkbox is checked -->
        <script>
            function checkBoxColorRow(result){
                if(result.checked){
                    result.parentNode.parentNode.style.backgroundColor="rgba(250,178,10,0.1)";
                    result.parentNode.parentNode.style.Color="white";
                }
                else
                {
                    result.parentNode.parentNode.style.backgroundColor="";
                    result.parentNode.parentNode.style.Color="";
                }
            }
        </script>
        <!-- Script haalt waardes van Radiobutton en event_id en stuurt de waardes naar de url -->
        <script>
            $('input[type=radio]').click(function() {//jQuery works on clicking radio box
                var value2 = $(this).val(); //Get the clicked checkbox value
                var eventID = <?php echo $event_id;?>;
                window.location.href = "APP_add_match2event.php?event_id=" + eventID + "&competition_id=" + value2 + "&redcorner_id=0&bluecorner_id=0";
            });
        </script>
        <!-- Script haalt waardes van CheckBox(atleet) en stuurt de waardes naar de url -->
        <script>
            $('input[type=checkbox]').click(function() {//jQuery works on clicking checkbox
                var compid = <?php echo $selected_comp;?>;
                var eventID = <?php echo $event_id;?>;
                <?php
                if($red_corner == true){
                    $redcorner01 = 1;
                } elseif ($red_corner == false) {
                    $redcorner01 = 0;
                }
                ?>
                var redcorner01 = <?php echo $redcorner01;?>;
                if (redcorner01 == 1){
                    var redcorner_id = $(this).val(); //Get the clicked checkbox value
                    window.location.href = "APP_add_match2event.php?event_id=" + eventID + "&competition_id=" + compid + "&redcorner_id=" + redcorner_id + "&bluecorner_id=0";
                }
                else if (redcorner01 == 0){
                    var redcorner_id = <?php echo $red_cornerID?>;
                    var bluecorner_id = $(this).val(); //Get the clicked checkbox value
                    window.location.href = "APP_add_match2event.php?event_id=" + eventID + "&competition_id=" + compid + "&redcorner_id=" + redcorner_id + "&bluecorner_id=" + bluecorner_id;
                }
            });
        </script>
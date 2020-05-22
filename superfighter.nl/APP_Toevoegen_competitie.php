<?php
ob_start();
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$query = "SELECT * FROM `athletes` ORDER BY athlete_lastname ASC";
$results = mysqli_query($db, $query);
?>
<head>
    <link rel="stylesheet" type="text/css" href="css/APP_CSS.css">
</head>

<div>
    <a href="APP_competition.php">Back to competition overview</a><br><br>
</div>

<div id="field">
    <form name="form1" method="post" action="" enctype="multipart/form-data">
        <h3>Add Competition</h3>
        <label>Competition name</label><br>
        <input type="text" name="comp_name"><br>
        <br>
</div>
<div id="field">
    <div class="container" style="margin-top:50px;">
        <input type="submit" value="Make competition" name="add_comp">
        <input id="myInput" type="text" placeholder="Search..">
        <table id="table_format" class="table table-bordered">
            <tr>
                <th class="skip-filter" style="text-decoration: underline">Select athletes for competition</th>
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
                <th class="skip-filter">description</th>
            </tr>
            <?php
            while ($row = $results->fetch_assoc()) {
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

                echo '<tbody id="myTable">
                <tr>
                <td>'.$row['athlete_id'].'
                <input type="checkbox" name="checkComp[]" value="'.$value.'" onclick="checkBoxColorRow(this);"/></td>
                <td>'.$row['athlete_firstname'].'</td>
                <td>'.$row['athlete_lastname'].'</td>
                <td>'.$row['athlete_nickname'].'</td>
                <td><img src="'.$picture.'" id="pic"/>' .'</td>
                <td>'.$row['athlete_height'].'</td><td>'.$row['athlete_weight'].'</td>
                <td>'.$athlete_weightclassA .'</td>
                <td>'.$athlete_grade_letter.'</div></td>
                <td>'.$row['athlete_nationality'].'</td>
                <td>'.$row['athlete_day_of_birth'].'</td>
                <td>'.$row['athlete_description'].'</td>
                </td>
              </tr>
              </tbody>';
            }
            ?>
        </table>
        </form>
    </div>
    <!-- Stop de data in database -->
    <?php
    if(isset($_POST['add_comp'])){
        $comp_name = $_POST['comp_name'];
        $query = "INSERT INTO `competition` (competition_name)
  			  VALUES('$comp_name')";
        mysqli_query($db, $query);
        //get new comp id
        $query2 = "SELECT MAX(competition_id) AS max FROM competition";
        $result2 = $db->query($query2);
        $row = $result2->fetch_assoc();
        $comp_id = $row['max'];

        //insert event_0 so that competition_info works
        $query3 = "INSERT INTO `events` (competition, event_name, event_description)
  			        VALUES('$comp_id', 'event_0', 'Ignore event_0')";
        mysqli_query($db, $query3);
        //get max event_id (event_0 id)
        $query2 = "SELECT MAX(event_id) AS max FROM events WHERE event_name = 'event_0'";
        $result2 = $db->query($query2);
        $row = $result2->fetch_assoc();
        $event0 = $row['max'];
        //put event0 in competition
        mysqli_query($db, $query);

        if(!empty($_POST['checkComp'])) {
            foreach($_POST['checkComp'] as $value){
                $query3 = "INSERT INTO `athletecompetition` (athlete_id, competition_id)
  			        VALUES('$value', '$comp_id')";
                mysqli_query($db, $query3);

                //insert event0 event into eventcompetition
                $query = "INSERT INTO eventcompetition (event_id, competition_id, redcorner, bluecorner) 
  			        VALUES('$event0','$comp_id','$value', '$value')";
                mysqli_query($db, $query);
            }
        }
        //create event_0 matches
        $query4 = "SELECT match_id, redcorner FROM `eventcompetition` WHERE event_id = '$event0' AND competition_id = '$comp_id' ORDER BY match_id ASC";
        $results = mysqli_query($db, $query4);
        while ($row = $results->fetch_assoc()) {
            $match_id = $row['match_id'];
            $redcorner = $row['redcorner'];
            $query3 = "INSERT INTO `matches` (match_id, event_id, athlete_id)
  			        VALUES('$match_id', '$event0', '$redcorner')";
            mysqli_query($db, $query3);
        }
        $query = "UPDATE competition SET event0 = '$event0' WHERE competition_id = '$comp_id'";
        mysqli_query($db, $query);
        $query = "DELETE FROM competition WHERE competition_name = '$comp_name' AND event0 = 0";
        mysqli_query($db, $query);

        header("location: http://localhost/php/WFLapp/APP_competition.php");
        ob_flush();
    }

    ?>
</div>


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
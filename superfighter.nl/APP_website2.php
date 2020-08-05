<?php
session_start();
if(isset($_SESSION['username']))
    { 
echo'
<section id="container_menu">
	<form action="APP_menu.php" method=post>
		<button class="ssbutton" type="submit" name="info">Back</button>
	</form>
	
	<form action="APP_Toevoegen_Athlete.php" method=post>
		<button class="ssbutton" type="submit" name="info">Add to Database</button>
	</form>
	
	<form action="APP_Toevoegen_Athlete_Mail.html" method=post>
		<button class="ssbutton" type="submit" name="info">Mail test</button>
	</form>
	
	<form action="APP_events.php" method=post>
		<button class="ssbutton" type="submit" name="info">Look for events</button>
	</form>
</section>';
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$query = "SELECT * FROM `athletes` ORDER BY athlete_grade ASC,athlete_weight DESC, athlete_weightclass, athlete_lastname ASC";
$results = mysqli_query($db, $query);
?>
<!doctype html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/APP_CSS.css">
    <link rel="stylesheet" href="css/wflapp.css">
</head>
<body>
<br>
<div class="container" style="margin-top:50px;">
    <input id="myInput" type="text" placeholder="Search..">
    <table id="table_format" class="table table-bordered">
        <tr>
            <th class="skip-filter">athlete_id</th>
            <th class="skip-filter">firstname</th>
            <th class="skip-filter">lastname</th>
            <th class="skip-filter">nickname</th>
            <th class="skip-filter">picture</th>
            <th class="skip-filter">picture 2</th>
            <th class="skip-filter">weight(kg)</th>
            <th>Filter weightclass...</th>
            <th>Filter grade...</th>
            <th>Filter nationality...</th>
            <th class="skip-filter">day_of_birth</th>
            <th>Filter gym...</th>
            <th class="skip-filter">Trainer</th>
            <th>VA-number</th>
            <th class="skip-filter">total_matches</th>
            <th class="skip-filter">wins</th>
            <th class="skip-filter">losses</th>
            <th class="skip-filter">draws</th>
            <th class="skip-filter">points</th>
        </tr>
        <?php
        while ($row = $results->fetch_assoc()) {
            $picture = $row['athlete_picture'];
            $picture2 = $row['athlete_picture2'];
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
                case "8":
                    $athlete_weightclassA = "56";
                    break;
                case "9":
                    $athlete_weightclassA = "52";
                    break;
                case "10":
                    $athlete_weightclassA = "48";
                    break;
                case "11":
                    $athlete_weightclassA = "44";
                    break;
                case "12":
                    $athlete_weightclassA = "40";
                    break;
                case "13":
                    $athlete_weightclassA = "36";
                    break;
                case "14":
                    $athlete_weightclassA = "32";
                    break;
            }

            echo '<tbody id="myTable">
            <tr id="hoverknop" data-href="APP_athlete_info.php?athlete_id='.$athlete_id.'">
                <td>'.$row['athlete_id'].'
                <form id="form_edit_athlete" style="float:right;" method="post" action="APP_edit_athlete.php?athlete_id='.$athlete_id.'">
                <button type="submit" class="button" value="Edit" style="background-image: linear-gradient(to bottom, rgba(0, 163, 52,0) , rgba(173,255,47, 1) , rgba(0, 163, 52,0)">Edit</button></form></td>
                <td>'.$row['athlete_firstname'].'</td>
                <td>'.$row['athlete_lastname'].'</td>
                <td>'.$row['athlete_nickname'].'</td>
                <td><img src="'.$picture.'" id="pic"/>' .'</td>
                <td><img src="'.$picture2.'" id="pic"/>' .'</td>
                <td>'.$row['athlete_weight'].'</td>
                <td>'.$athlete_weightclassA .'</td>
                <td>'.$athlete_grade_letter.'</div></td>
                <td>'.$row['athlete_nationality'].'</td>
                <td>'.$row['athlete_day_of_birth'].'</td>
                <td>'.$row['athlete_gym'].'</td>
                <td>'.$row['athlete_trainer'].'</td>
                <td>'.$row['va_number'].'</td>
                <td>'.$row['athlete_total_matches'].'</td>
                <td>'.$row['athlete_wins'].'</td>
                <td>'.$row['athlete_losses'].'</td>
                <td>'.$row['athlete_draws'].'</td>
                <td>'.$row['athlete_points'].'</td>
                <td><form id="form_delete_athlete" method="post" action="APP_delete.php?athlete_id='.$athlete_id.'">
                <button type="submit" class="button" value="Delete" style="background-image: linear-gradient(to bottom, rgba(0, 163, 52,0) , rgba(255, 17, 0, 1) , rgba(0, 163, 52,0));">X</button>
                </form>
                </td>
                </tbody>
              </tr>';
        }
        ?>
    </table>
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
<?php }
    else {
        echo 'Je moet inloggen';
    }
    ?>
</body>
</head>
</html>
<?php
ob_start();
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
?>
<link rel="stylesheet" type="text/css" href="css/wflapp.css">
<link rel="stylesheet" type="text/css" href="css/APP_athlete_CSS.css">
<link rel="stylesheet" type="text/css" href="css/APP_event_CSS.css">
<link rel="stylesheet" type="text/css" href="css/APP_mailer_CSS.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<section id="container_menu">
    <form action="APP_menu.php" method=post>
        <button class="ssbutton" type="submit" name="info">Menu</button>
    </form>
</section><br><br><br>
<div id="side">
    <h2>Select:</h2>
    <button class="ssbutton" onclick="toggleHideAthlete()">Athlete E-Mail</button><br>
    <div id="athleteMail" class="mailContainer" style="display: none">
        <input type="submit" value="Add E-Mail to mail-list" name="add_athlete_to_mail">
        <input id="myInput" type="text" placeholder="Search..">
        <table id="table_format" class="table table-bordered">
            <tr>
                <th class="skip-filter" style="text-decoration: underline">Select</th>
                <th class="skip-filter">Name</th>
                <th>Filter weightclass...</th>
                <th>Filter grade...</th>
                <th class="skip-filter">E-Mail</th>
            </tr>
            <?php
            $query = "SELECT * FROM `athletes` ORDER BY athlete_grade ASC,athlete_weight DESC, athlete_weightclass, athlete_lastname ASC";
            $results = mysqli_query($db, $query);
            while ($row = $results->fetch_assoc()) {
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
                <td>'.$row['athlete_firstname'].' '.$row['athlete_lastname'].'</td>
                <td>'.$athlete_weightclassA .'</td>
                <td>'.$athlete_grade_letter.'</div></td>
                <td>'.$row['athlete_email'].'</td>
                </td>
              </tr>
              </tbody>';
            }
            ?>
        </table>
    </div>
    <button class="ssbutton" onclick="toggleHideGym()">Coach / Gym E-Mail</button><br>
    <div id="gymMail" class="mailContainer" style="display: none">
        <input type="submit" value="Add E-Mail to mail-list" name="add_athlete_to_mail">
        <input id="myInput2" type="text" placeholder="Search..">
        <table id="table_format" class="table table-bordered">
            <tr>
                <th class="skip-filter" style="text-decoration: underline">Select</th>
                <th class="skip-filter">Name</th>
                <th class="skip-filter">Gym</th>
                <th class="skip-filter">E-Mail</th>
            </tr>
            <?php
            $query = "SELECT * FROM `gym`";
            $results = mysqli_query($db, $query);
            while ($row = $results->fetch_assoc()) {
                $athlete_id = $row['id'];
                $value = $row['id'];

                echo '<tbody id="myTable">
                <tr>
                <td>'.$row['id'].'
                <input type="checkbox" name="checkComp[]" value="'.$value.'" onclick="checkBoxColorRow(this);"/></td>
                <td>'.$row['coach_name'].'</td>
                <td>'.$row['gym_name'].'</td>
                <td>'.$row['coach_email'].'</td>
                </td>
              </tr>
              </tbody>';
            }
            ?>
        </table>
    </div>
    <button class="ssbutton" onclick="toggleHideNews()">Nieuwsbrief</button><br>
    <div id="newsMail" class="mailContainer" style="display: none">
        <input type="submit" value="Add E-Mail to mail-list" name="add_athlete_to_mail">
        <input id="myInput3" type="text" placeholder="Search..">
        <table id="table_format" class="table table-bordered">
            <tr>
                <th class="skip-filter" style="text-decoration: underline">Select</th>
                <th class="skip-filter">Name</th>
                <th class="skip-filter">E-Mail</th>
            </tr>
            <?php
            $query = "SELECT * FROM `testmail`";
            $results = mysqli_query($db, $query);
            while ($row = $results->fetch_assoc()) {
                $athlete_id = $row['id'];
                $value = $row['id'];

                echo '<tbody id="myTable">
                <tr>
                <td>'.$row['id'].'
                <input type="checkbox" name="checkComp[]" value="'.$value.'" onclick="checkBoxColorRow(this);"/></td>
                <td>'.$row['naam'].'</td>
                <td>'.$row['email'].'</td>
                </td>
              </tr>
              </tbody>';
            }
            ?>
        </table>
    </div>
</div>
<div id="center">
    <h2>WFL E-Mail</h2>
    <table id="mailerTabel">
        <tr>
            <td><h3>Onderwerp</h3></td>
            <td><input type="text" name="naam_van" id="mail_subject"/></td>
        </tr>
        <tr>
            <td><h3>Bericht</h3></td>
            <td><textarea name="bericht" id="bericht" cols="45" rows="40"></textarea></td>
        </tr>
        <tr>
            <td><div align="center">
                    <input type="submit" name="Verzenden" id="Verzenden" value="Verzenden" />
                </div></td>
            <td><div align="center">
                    <input type="reset" name="Wissen" id="Wissen" value="Wissen" />
                </div></td>
        </tr>
    </table>
</div>
<div id="side">
    <h2>Mail to:</h2>
    <h3>(hier komt lijst met alle emails die geselecteerd zijn)</h3>
</div>

<!-- Hide/Show containers -->
<script>
    function toggleHideAthlete() {
        var x = document.getElementById("athleteMail");
        if (x.style.display === "block") {
            x.style.display = "none";
        } else {
            x.style.display = "block";
        }
    }
    function toggleHideGym() {
        var x = document.getElementById("gymMail");
        if (x.style.display === "block") {
            x.style.display = "none";
        } else {
            x.style.display = "block";
        }
    }
    function toggleHideNews() {
        var x = document.getElementById("newsMail");
        if (x.style.display === "block") {
            x.style.display = "none";
        } else {
            x.style.display = "block";
        }
    }
</script>

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
    $(document).ready(function(){
        $("#myInput2").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
    $(document).ready(function(){
        $("#myInput3").on("keyup", function() {
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
            result.parentNode.parentNode.style.backgroundColor="rgba(250,178,10,0.7)";
            result.parentNode.parentNode.style.Color="white";
        }
        else
        {
            result.parentNode.parentNode.style.backgroundColor="";
            result.parentNode.parentNode.style.Color="";
        }
    }
</script>
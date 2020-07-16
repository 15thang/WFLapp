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
    <div id="athleteMail" class="mailContainer" style="display: none"></div>
    <button class="ssbutton" onclick="toggleHideGym()">Coach / Gym E-Mail</button><br>
    <div id="gymMail" class="mailContainer" style="display: none"></div>
    <button class="ssbutton" onclick="toggleHideNews()">Nieuwsbrief</button><br>
    <div id="newsMail" class="mailContainer" style="display: none"></div>
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

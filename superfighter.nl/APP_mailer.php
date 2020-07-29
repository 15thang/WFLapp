<?php
ob_start();
session_start();
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

//Load composer's autoloader
require 'vendor/autoload.php';

const SECRET = "geheimpje";
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
    <button class="ssbutton2" onclick="toggleHideManualButtons()">Select manually</button>
    <div id="manualButtons" style="display: none">
        <button class="ssbutton" onclick="toggleHideAthlete()">Athlete E-Mail</button><br>
        <div id="athleteMail" class="mailContainer" style="display: none">
            <form name="form1" method="post" action="" enctype="multipart/form-data">
                <input type="submit" value="Add E-Mail to mail-list" name="add_mail_a">
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
                <tr>
                <td>'.$row['athlete_id'].'
                <input type="checkbox" name="checkAthlete[]" value="'.$value.'" onclick="checkBoxColorRow(this);"/></td>
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
            </form>
        </div>
        <button class="ssbutton" onclick="toggleHideGym()">Coach / Gym E-Mail</button><br>
        <div id="gymMail" class="mailContainer" style="display: none">
            <form name="form2" method="post" action="" enctype="multipart/form-data">
                <input type="submit" value="Add E-Mail to mail-list" name="add_mail_b">
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
                <input type="checkbox" name="checkGym[]" value="'.$value.'" onclick="checkBoxColorRow(this);"/></td>
                <td>'.$row['coach_name'].'</td>
                <td>'.$row['gym_name'].'</td>
                <td>'.$row['coach_email'].'</td>
                </td>
              </tr>
              </tbody>';
                    }
                    ?>
                </table>
            </form>
        </div>
        <button class="ssbutton" onclick="toggleHideNews()">Nieuwsbrief</button><br>
        <div id="newsMail" class="mailContainer" style="display: none">
            <form name="form3" method="post" action="" enctype="multipart/form-data">
                <input type="submit" value="Add E-Mail to mail-list" name="add_mail_c">
                <input id="myInput3" type="text" placeholder="Search..">
                <table id="table_format" class="table table-bordered">
                    <tr>
                        <th class="skip-filter" style="text-decoration: underline">Select</th>
                        <th class="skip-filter">Name</th>
                        <th class="skip-filter">E-Mail</th>
                    </tr>
                    <?php
                    $query = "SELECT * FROM `newsmail`";
                    $results = mysqli_query($db, $query);
                    while ($row = $results->fetch_assoc()) {
                        $athlete_id = $row['id'];
                        $value = $row['id'];

                        echo '<tbody id="myTable">
                <tr>
                <td>'.$row['id'].'
                <input type="checkbox" name="checkNews[]" value="'.$value.'" onclick="checkBoxColorRow(this);"/></td>
                <td>'.$row['naam'].'</td>
                <td>'.$row['email'].'</td>
                </td>
              </tr>
              </tbody>';
                    }
                    ?>
                </table>
            </form>
        </div>
    </div>
    <button class="ssbutton2" onclick="toggleHideCompetition()">Select all from competition</button>
    <div id="competitionMail" class="mailContainer" style="display: none">
        <form name="form_comp" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Add E-Mail to mail-list" name="add_mail_1">
            <input id="myInput_comp" type="text" placeholder="Search..">
            <table id="table_format" class="table table-bordered">
                <tr>
                    <th class="skip-filter" style="text-decoration: underline">Select</th>
                    <th class="skip-filter">Competition</th>
                </tr>
                <?php
                $query = "SELECT * FROM `competition` ORDER BY competition_id DESC";
                $results = mysqli_query($db, $query);
                while ($row = $results->fetch_assoc()) {
                    $competition_id = $row['competition_id'];
                    $value = $row['competition_id'];
                    echo '<tbody id="myTable">
                <tr>
                <td>'.$row['competition_id'].'
                <input type="checkbox" name="checkComp[]" value="'.$value.'" onclick="checkBoxColorRow(this);"/></td>
                <td>'.$row['competition_name'].'</td>
                </td>
              </tr>
              </tbody>';
                }
                ?>
            </table>
        </form>
    </div>
    <button class="ssbutton2" onclick="toggleHideEvent()">Select all from event</button>
    <div id="eventMail" class="mailContainer" style="display: none">
        <form name="form_event" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Add E-Mail to mail-list" name="add_mail_2">
            <input id="myInput_event" type="text" placeholder="Search..">
            <table id="table_format" class="table table-bordered">
                <tr>
                    <th class="skip-filter" style="text-decoration: underline">Select</th>
                    <th class="skip-filter">Event</th>
                </tr>
                <?php
                $query = "SELECT * FROM `events` WHERE NOT event_name = 'event_0' ORDER BY event_id DESC";
                $results = mysqli_query($db, $query);
                while ($row = $results->fetch_assoc()) {
                        $event_id = $row['event_id'];
                        $value = $row['event_id'];
                        echo '<tbody id="myTable">
                <tr>
                <td>'.$value.'
                <input type="checkbox" name="checkEvent[]" value="'.$value.'" onclick="checkBoxColorRow(this);"/></td>
                <td>'.$row['event_name'].'</td>
                </td>
              </tr>
              </tbody>';

                }
                ?>
            </table>
        </form>
    </div>
    <form name="form_event" method="post" action="" enctype="multipart/form-data">
        <input type="submit" class="ssbutton3" value="+ Select ALL athletes" name="add_mail_3">
    </form>
    <form name="form_event" method="post" action="" enctype="multipart/form-data">
        <input type="submit" class="ssbutton3" value="+ Select ALL trainers" name="add_mail_4">
    </form>
    <form name="form_event" method="post" action="" enctype="multipart/form-data">
        <input type="submit" class="ssbutton3" value="+ Select ALL newsletter" name="add_mail_5">
    </form>

</div>
<div id="center">
    <h2>WFL E-Mail</h2>
    <form name="form_send" method="post" action="" enctype="multipart/form-data">
        <table id="mailerTabel">
            <tr>
                <td><h3>Onderwerp</h3></td>
                <td><input type="text" name="mail_subject" id="mail_subject"/></td>
            </tr>
            <tr>
                <td><h3>Bericht</h3></td>
                <td><textarea name="mail_message" id="bericht" cols="45" rows="40"></textarea></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <div align="center">
                        <input class="ssbutton" type="submit" name="send_mail" id="send_mail" value="Send mail" />
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
<div id="side">
    <h2>Mail to:</h2>
    <h3>(hier komt lijst met alle emails die geselecteerd zijn)</h3>
    <?php
    if (empty($_SESSION['emailArray'])) {
        $_SESSION['emailArray'] = array();
    }
    //mail for athlete to array
    if(isset($_POST['add_mail_a'])){
        if(!empty($_POST['checkAthlete'])) {
            foreach($_POST['checkAthlete'] as $value){
                $query = "SELECT * FROM `athletes` WHERE athlete_id = '$value'";
                $results = mysqli_query($db, $query);
                while ($row = $results->fetch_assoc()) {
                    array_push($_SESSION['emailArray'], $row['athlete_email']);
                }
            }
        }
        $arr = array_unique($_SESSION['emailArray']);
        $whereIn = implode('<br>', $arr);
        echo '<form name="form_delete" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Remove emails" name="delete">
        </form>'.$whereIn;
    }
    //gym/coach mail
    if(isset($_POST['add_mail_b'])){
        if(!empty($_POST['checkGym'])) {
            foreach($_POST['checkGym'] as $value){
                $query = "SELECT * FROM `gym` WHERE id = '$value'";
                $results = mysqli_query($db, $query);
                while ($row = $results->fetch_assoc()) {
                    array_push($_SESSION['emailArray'], $row['coach_email']);

                }
            }
        }
        $arr = array_unique($_SESSION['emailArray']);
        $whereIn = implode('<br>', $arr);
        echo '<form name="form_delete" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Remove emails" name="delete">
        </form>'.$whereIn;
    }
    //news mail
    if(isset($_POST['add_mail_c'])){
        if(!empty($_POST['checkNews'])) {
            foreach($_POST['checkNews'] as $value){
                $query = "SELECT * FROM `newsmail` WHERE id = '$value'";
                $results = mysqli_query($db, $query);
                while ($row = $results->fetch_assoc()) {
                    array_push($_SESSION['emailArray'], $row['email']);
                }
            }
        }
        $arr = array_unique($_SESSION['emailArray']);
        $whereIn = implode('<br>', $arr);
        echo '<form name="form_delete" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Remove emails" name="delete">
        </form>'.$whereIn;
    }
    //all athlete mails from competition to array
    if (isset($_POST['add_mail_1'])){
        if(!empty($_POST['checkComp'])) {
            foreach($_POST['checkComp'] as $value){
                $query = "SELECT * FROM `athletes` WHERE athlete_id IN (SELECT athlete_id FROM `athletecompetition` WHERE competition_id = '$value')";
                $results = mysqli_query($db, $query);
                while ($row = $results->fetch_assoc()) {
                    array_push($_SESSION['emailArray'], $row['athlete_email']);
                }
            }
        }
        $arr = array_unique($_SESSION['emailArray']);
        $whereIn = implode('<br>', $arr);
        echo '<form name="form_delete" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Remove emails" name="delete">
        </form>'.$whereIn;
    }
    //all athlete mails from competition in event, to array
    if (isset($_POST['add_mail_2'])){
        if(!empty($_POST['checkEvent'])) {
            foreach($_POST['checkEvent'] as $value){
                $query = "SELECT * FROM `athletes` WHERE athlete_id IN (SELECT athlete_id FROM `athletecompetition` WHERE competition_id IN (SELECT competition_id FROM eventcompetition WHERE event_id = 124))";
                $results = mysqli_query($db, $query);
                while ($row = $results->fetch_assoc()) {
                    array_push($_SESSION['emailArray'], $row['athlete_email']);
                }
            }
        }
        $arr = array_unique($_SESSION['emailArray']);
        $whereIn = implode('<br>', $arr);
        echo '<form name="form_delete" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Remove emails" name="delete">
        </form>'.$whereIn;
    }
    //all athletes to array
    if (isset($_POST['add_mail_3'])){
        $query = "SELECT * FROM `athletes`";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            array_push($_SESSION['emailArray'], $row['athlete_email']);
        }
        $arr = array_unique($_SESSION['emailArray']);
        $whereIn = implode('<br>', $arr);
        echo '<form name="form_delete" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Remove emails" name="delete">
        </form>'.$whereIn;
    }
    //all trainers/coaches to array
    if (isset($_POST['add_mail_4'])){
        $query = "SELECT * FROM `gym`";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            array_push($_SESSION['emailArray'], $row['coach_email']);
        }
        $arr = array_unique($_SESSION['emailArray']);
        $whereIn = implode('<br>', $arr);
        echo '<form name="form_delete" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Remove emails" name="delete">
        </form>'.$whereIn;
    }
    //all newsletter subscribers emails to array
    if (isset($_POST['add_mail_5'])){
        $query = "SELECT * FROM `newsmail`";
        $results = mysqli_query($db, $query);
        while ($row = $results->fetch_assoc()) {
            array_push($_SESSION['emailArray'], $row['email']);
        }
        $arr = array_unique($_SESSION['emailArray']);
        $whereIn = implode('<br>', $arr);
        echo '<form name="form_delete" method="post" action="" enctype="multipart/form-data">
            <input type="submit" value="Remove emails" name="delete">
        </form>'.$whereIn;
    }

    if (isset($_POST['delete'])) {
        unset($_SESSION['emailArray']);
        header("Refresh:0");
    }
    ?>
</div>

<!-- Hide/Show containers -->
<script>
    function toggleHideManualButtons() {
        var x = document.getElementById("manualButtons");
        if (x.style.display === "block") {
            x.style.display = "none";
        } else {
            x.style.display = "block";
        }
    }
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
    function toggleHideCompetition() {
        var x = document.getElementById("competitionMail");
        if (x.style.display === "block") {
            x.style.display = "none";
        } else {
            x.style.display = "block";
        }
    }
    function toggleHideEvent() {
        var x = document.getElementById("eventMail");
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
    $(document).ready(function(){
        $("#myInput_comp").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
    $(document).ready(function(){
        $("#myInput_event").on("keyup", function() {
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

<?php
//PHP MAILER
if (isset($_POST['send_mail'])) {
    $mailArray = array_unique($_SESSION['emailArray']);
    if (!empty($mailArray)) {
        $subject = ($_POST['mail_subject']);
        $message = ($_POST['mail_message']);

        $i = 0;

        $mail = new PHPMailer(true);                              // Passing `true` enables exceptions
        foreach ($mailArray as $data) {
            try {
                //Server settings
                //Enable SMTP debugging
                // 0 = off (for production use)
                // 1 = client messages
                // 2 = client and server messages
                $mail->SMTPDebug = 0;
                $mail->isSMTP();
                $mail->Host = gethostbyname('smtp.gmail.com');//'smtp.gmail.com';
                $mail->SMTPAuth = true;
                $mail->Username = 'novaphptest@gmail.com';
                $mail->Password = phptest123;
                $mail->SMTPSecure = 'tls';
                $mail->SMTPAuth = true;
                $mail->Port = 587;
                $mail->SMTPOptions = array(
                    'ssl' => array(
                        'verify_peer' => false,
                        'verify_peer_name' => false,
                        'allow_self_signed' => true
                    )
                );
                //Recipients
                $mail->setFrom('novaphptest@gmail.com', 'World Fighting League');
                $mail->ClearAllRecipients();
                $mail->addAddress($data);

                //Content
                $mail->isHTML(true);
                $mail->Subject = $subject;
                $i++;
                $mail->Body = $message;
                $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

                $mail->send();
                echo '<p style="color: white; font-size: 20px;">Message has been sent to '.$data.'</p>';
            } catch (Exception $e) {
                echo '<p style="color: white; font-size: 20px;">Message could not be sent.</p>';
                echo '<p style="color: white; font-size: 20px;">Mailer Error: ' . $mail->ErrorInfo . '</p>';
            }
        }
        unset($_SESSION['emailArray']);
    } else {
        echo "<script type='text/javascript'>alert('No E-Mail adresses found.')</script>";
    }
}
?>
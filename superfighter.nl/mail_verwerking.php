<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$athlete_firstname = (str_replace("'","",$_POST['athlete_name']));
$athlete_lastname = (str_replace("'","",$_POST['athlete_lastname']));
$athlete_nickname = (str_replace("'","",$_POST['athlete_nickname']));
$athlete_gender = ($_POST['athlete_gender']);
$athlete_weight = ($_POST['athlete_weight']);
$athlete_weightclass = ($_POST['athlete_weightclass']);
$athlete_grade = ($_POST['athlete_grade']);
$athlete_nationality = ($_POST['athlete_nationality']);
$athlete_day_of_birth = date('Y-m-d', strtotime($_POST['athlete_day_of_birth']));
$athlete_description = (str_replace("'","",$_POST['athlete_description']));
$va_number = ($_POST['athlete_va_number']);
$date_added = date("Y-m-d");
//contact gegevens
$athlete_email = (str_replace("'","",$_POST['athlete_email']));
$athlete_phone1 = ($_POST['athlete_phone1']);
$athlete_phone2 = ($_POST['athlete_phone2']);
$athlete_adress = ($_POST['athlete_adress']);
$athlete_postal_code = (str_replace("'","",$_POST['athlete_postal_code']));
$athlete_city = (str_replace("'","",$_POST['athlete_city']));
//social media
$athlete_facebook = (str_replace("'","",$_POST['athlete_facebook']));
$athlete_twitter = (str_replace("'","",$_POST['athlete_twitter']));
$athlete_instagram = (str_replace("'","",$_POST['athlete_instagram']));
$athlete_linkedin = (str_replace("'","",$_POST['athlete_linkedin']));
$athlete_youtube = (str_replace("'","",$_POST['athlete_youtube']));
//gym/trainer
$gymname = ($_POST['athlete_gym']);
$trainer = ($_POST['athlete_trainer']);
$trainer_phone = ($_POST['athlete_trainer_phone']);
$trainer_email = ($_POST['athlete_trainer_email']);

//echo wat je hebt ingevuld
echo $athlete_firstname . $athlete_lastname . $athlete_nickname . $athlete_weightclass . $athlete_grade . $athlete_nationality . $athlete_day_of_birth
    . $athlete_description;

//check of picture1 input leeg is
if ($_FILES['athlete_picture']['size'] == 0 && $_FILES['cover_image']['error'] == 0)
{
    $dst="pics/athlete_avatar.png";
    move_uploaded_file($_FILES["athlete_picture"]["tmp_name"], $dst);
}
else {
    // cover_image is empty (and not an error)
    //foto naar mapje sturen
    $fnm=$_FILES["athlete_picture"]["name"];
    $dst="pics/athletepics/".$fnm;
    move_uploaded_file($_FILES["athlete_picture"]["tmp_name"], $dst);
}
//check of picture2 input leeg is
if ($_FILES['athlete_picture2']['size'] == 0 && $_FILES['cover_image']['error'] == 0)
{
    $dst2="pics/athlete_event.png";
    move_uploaded_file($_FILES["athlete_picture2"]["tmp_name"], $dst2);
}
else {
    // cover_image is empty (and not an error)
    //foto naar mapje sturen
    $fnm=$_FILES["athlete_picture2"]["name"];
    $dst2="pics/athletepics/".$fnm;
    move_uploaded_file($_FILES["athlete_picture2"]["tmp_name"], $dst2);
}

// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

//Load composer's autoloader
require 'vendor/autoload.php';

const SECRET = "geheimpje";

$mail = new PHPMailer(true);                              // Passing `true` enables exceptions
try {
    //Server settings
    //Enable SMTP debugging
    // 0 = off (for production use)
    // 1 = client messages
    // 2 = client and server messages
    $mail->SMTPDebug = 2;
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
    $mail->setFrom('novaphptest@gmail.com', 'superfighter.nl');
    $mail->addAddress('153061@novacollege.nl');

    //Content
    $mail->isHTML(true);
    $mail->Subject = $athlete_firstname.' '.$athlete_lastname.' wil aanmelden';
    $mail->Body = '<EOF 
                   <html>
                   <h2>Persoonlijke informatie atleet:</h2>
                   Atleet naam: '.$athlete_firstname.' '.$athlete_lastname.'<br>'.
                  'Bijnaam: '.$athlete_nickname.'<br>'.
                  'Gender: '.$athlete_gender.'<br>'.
                  'Gewicht: '.$athlete_weight.'<br>'.
                  'Klassement: '.$athlete_grade.'<br>'.
                  'Nationaliteit: '.$athlete_nationality.'<br>'.
                  'Geboortedatum: '.$athlete_day_of_birth.'<br>'.
                  'Beschrijving: '.$athlete_description.'<br>'.
                  'VA_nummer: '.$va_number.'<br><br>'.
                  '<h2>Contact informatie:</h2>
                   E-mail: '.$athlete_email.'<br>'.
                  'Telefoonnummer1: '.$athlete_phone1.'<br>'.
                  'Telefoonnummer2: '.$athlete_phone2.'<br>'.
                  'Adres: '.$athlete_adress.'<br>'.
                  'Postcode: '.$athlete_postal_code.'<br>'.
                  'Plaats: '.$athlete_city.'<br><br>'.
                  '<h2>Gym / Trainer</h2>'.
                  'Sportschool: '.$gymname.'<br>'.
                  'Trainer: '.$trainer.'<br>'.
                  'Telefoon trainer: '.$trainer_phone.'<br>'.
                  'E-mail trainer: '.$trainer_email.'<br><br>'.
                  '<h2>Social media links</h2>'.
                  'Facebook: '.$athlete_facebook.'<br>'.
                  'Twitter: '.$athlete_twitter.'<br>'.
                  'Instagram: '.$athlete_instagram.'<br>'.
                  'LinkedIn: '.$athlete_linkedin.'<br>'.
                  'Youtube: '.$athlete_youtube.'<br><br>'.
                  'Druk op link om atleet goed te keuren:<br>'.
                  '<a href="http://superfighter.nl/APP_toevoegen_athlete_PHP.php?athlete_name='.$athlete_firstname.'&athlete_lastname='.$athlete_lastname.'&athlete_nickname='.$athlete_nickname.'&athlete_gender='.$athlete_gender.'&athlete_weight='.$athlete_weight.'&athlete_weightclass='.$athlete_weightclass.'&athlete_grade='.$athlete_grade.'&athlete_nationality='.$athlete_nationality.'&athlete_day_of_birth='.$athlete_day_of_birth.'&athlete_description='.$athlete_description.'&athlete_va_number='.$va_number.'&athlete_email='.$athlete_email.'&athlete_phone1='.$athlete_phone1.'&athlete_phone2='.$athlete_phone2.'&athlete_adress='.$athlete_adress.'&athlete_postal_code='.$athlete_postal_code.'&athlete_city='.$athlete_city.'&athlete_facebook='.$athlete_facebook.'&athlete_twitter='.$athlete_twitter.'&athlete_instagram='.$athlete_instagram.'&athlete_linkedin='.$athlete_linkedin.'&athlete_youtube='.$athlete_youtube.'&athlete_gym='.$gymname.'&athlete_trainer='.$trainer.'&athlete_trainer_phone='.$trainer_phone.'&athlete_trainer_email='.$trainer_email.'">Klik hier!!!</a></html>';
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo 'Message could not be sent.';
    echo 'Mailer Error: ' . $mail->ErrorInfo;
}
?>
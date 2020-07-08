<?php

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

$naam = $_POST['naam_van'];
$mail_van = $_POST['mail_van'];
$onderwerp = $_POST['mail_ond'];
$telefoon = $_POST['telefoon'];
$bericht = $_POST['bericht'];
$mail = $_POST['Verzenden'];

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
    $mail->setFrom('novaphptest@gmail.com', 'Job Engelen');
    $mail->addAddress('153061@novacollege.nl'. $naam);

    //Content
    $mail->isHTML(true);
    $mail->Subject = 'Verzonden met mijn PHP code';
    $mail->Body =  'Naam = '.$athlete_firstname.' '.$athlete_lastname;
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo 'Message could not be sent.';
    echo 'Mailer Error: ' . $mail->ErrorInfo;
}

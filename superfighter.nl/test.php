<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$mailArray = array_unique($_SESSION['emailArray']);
$noMore = false;

// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

//Load composer's autoloader
require 'vendor/autoload.php';

const SECRET = "geheimpje";

$i = 0;

$mail = new PHPMailer(true);                              // Passing `true` enables exceptions
foreach ($mailArray as $data) {
    if (!$noMore) {
        $noMore = true;
    } else {
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
            $mail->ClearAllRecipients();
            $mail->addAddress($data);

            //Content
            $mail->isHTML(true);
            $mail->Subject = $data.' wil aanmelden';
            $i++;
            $mail->Body = '<EOF
                   <html>
                   <h2>Hoi hallo '.$data.'</h2>
                   '.$data.' mail nmr: '.$i.'
                   </html>';
            $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

            $mail->send();
            echo 'Message has been sent to '.$data;
            } catch (Exception $e) {
            echo 'Message could not be sent.';
            echo 'Mailer Error: ' . $mail->ErrorInfo;
        }
    }
}
?>
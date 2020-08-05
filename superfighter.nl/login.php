<?php
   //ob_start();
   session_start();
   
   include 'connection.php';
   
$username = $_POST['username'];
$password = $_POST['password'];
   
    $vraag="SELECT * FROM admin WHERE admin_name = '".$username."' AND admin_password = '".$password."'";
   
    $resultaat = $db->query($vraag);  
   
   
    $msg = '';
            
			if ($resultaat->num_rows>0)
{
    $row = $resultaat->fetch_assoc();
    $id = $row['id'];

    $_SESSION['gebruiker'] = $id;
    echo " Login successful! Returning to main page...";
    header('Refresh: 2; URL=APP_menu.php');
	}
	else
	{
    echo "Your e-mail doesn't exist or your password is incorrect.";
    header('Refresh: 2; URL=login.html');
	}
?>

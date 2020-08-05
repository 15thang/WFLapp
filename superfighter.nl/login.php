<?php
   //ob_start();
   session_start();
   
   
   
   $wachtwoord = $_POST['ww'];
   $gebruiker = $_POST['gebruikersnaam'];
 
   include 'connectie2.php';
   
    $vraag="SELECT * FROM users WHERE username = '".$gebruiker."' AND password = '".$wachtwoord."'";
   
    $resultaat = $conn->query($vraag);  
   
   
    $msg = '';
            
			if ($resultaat->num_rows>0)
{
    $row = $resultaat->fetch_assoc();
    $id = $row['id'];

    $_SESSION['gebruiker'] = $id;
    echo " Login successful! Returning to main page...";
    header('Refresh: 2; URL=webshop.php');
	}
	else
	{
    echo "Your e-mail doesn't exist or your password is incorrect.";
    header('Refresh: 2; URL=login.html');
	}
?>


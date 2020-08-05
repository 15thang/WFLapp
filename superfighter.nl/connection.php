<?php
$servername = "localhost";
$datausername = "jobenam437";
$datapassword = "a5i3v6jf";
$accounts = "jobenam437_wflapp";

// Create connection
$db = new mysqli($servername, $datausername, $datapassword, $accounts);

// Check connection
if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
} 
echo "Connected successfully";
?>
<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
// REGISTER USER
$email = mysqli_real_escape_string($db, $_POST['email']);


$query = "INSERT INTO newsmail (email)
  			  VALUES('$email')";
$results = mysqli_query($db, $query);
if($results>0)
{
    echo "email subscribed successfully";
}

?>
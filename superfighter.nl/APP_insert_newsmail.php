<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$email = $_POST['email'];

$query = "INSERT INTO newsmail (email)
  			  VALUES('$email')";
$results = $db->prepare($query);

$results->execute();

if($results>0)
{
    echo json_encode("Subscribed succesfully");
}

?>
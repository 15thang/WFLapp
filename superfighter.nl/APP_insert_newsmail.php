<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

$email = $_POST['email'];

if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
// Email correct
    $query = "INSERT INTO newsmail (email)
  			  VALUES('$email')";
    $results = $db->prepare($query);
    $results->execute();

    if($results>0)
    {
        echo json_encode("Subscribed succesfully");
    } else {
        echo json_encode("Could not subscribe");
    }
}
else {
//Email not correct
    echo json_encode("Could not subscribe");
}

?>
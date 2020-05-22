<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
$athlete_id = $_GET['athlete_id'];
$query = "SELECT * FROM `athletes` WHERE athlete_id = '$athlete_id'";
$results = mysqli_query($db, $query);

while ($row = $results->fetch_assoc()) {

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
            $athlete_weightclassA = "Heavyweight";
            break;
        case "2":
            $athlete_weightclassA = "Light Heavyweight";
            break;
        case "3":
            $athlete_weightclassA = "Middleweight";
            break;
        case "4":
            $athlete_weightclassA = "Welterweight";
            break;
        case "5":
            $athlete_weightclassA = "Lightweight";
            break;
        case "6":
            $athlete_weightclassA = "Featherweight";
            break;
        case "7":
            $athlete_weightclassA = "Bantamweight";
            break;
        case "8":
            $athlete_weightclassA = "Flyweight";
            break;
        case "9":
            $athlete_weightclassA = "Strawweight";
            break;
    }

    echo '
	<link rel="stylesheet" type="text/css" href="css/wflapp.css">
	<link rel="stylesheet" type="text/css" href="css/APP_athlete_CSS.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<section id="container_menu">
	<form action="APP_website2.php" method=post>
		<button class="ssbutton" type="submit" name="info">Back</button>
	</form>
	
	<form action="APP_Toevoegen_Athlete.php" method=post>
		<button class="ssbutton" type="submit" name="info">Add to Database</button>
	</form>
	
	<form action="APP_events.php" method=post>
		<button class="ssbutton" type="submit" name="info">Look for events</button>
	</form>
</section>;

<section id="athleteinfo">
<body>
<!-- Foto van de atleet -->
<div id="up">
	<div id="athletesocials">
      <div id="picture_athlete">
		<img src="'.$row['athlete_picture'].'" id="pic"/>
	  </div>
	  <div id="socials">
		<a href="'.$row['athlete_facebook'].'" class="fa fa-facebook"></a>
		<a href="'.$row['athlete_twitter'].'" class="fa fa-twitter"></a>
		<a href="'.$row['athlete_instagram'].'" class="fa fa-instagram"></a>
		<a href="'.$row['athlete_youtube'].'" class="fa fa-youtube"></a>
		<a href="'.$row['athlete_linkedin'].'" class="fa fa-linkedin"></a>
	  </div>
	</div>  

<!-- Persoonlijke gegevens -->
<div id="personal">
<table>
    <tr>
        <th>Firstname: </th>
        <td>'.$row['athlete_firstname'].'</td>
    </tr>
    <tr>
        <th>Lastname: </th>
        <td>'.$row['athlete_lastname'].'</td>    
    </tr>
    <tr>
        <th>Nickname: </th>
        <td>'.$row['athlete_nickname'].'</td>    
    </tr>
    <tr>
        <th>Gender: </th>
        <td>'.$row['athlete_gender'].'</td>
    </tr>
    <tr>
        <th>Nationality: </th>
        <td>'.$row['athlete_nationality'].'</td>    
    </tr>
    <tr>
        <th>Day of birth: </th>
        <td>'.$row['athlete_day_of_birth'].'</td>    
    </tr>
    <tr>
        <th>Height: </th>
        <td>'.$row['athlete_height'].'cm</td>    
    </tr>
    <tr>
        <th>Weight: </th>
        <td>'.$row['athlete_weight'].'kg</td>    
    </tr>
    <tr>
        <th>Weightclass: </th>
        <td>'.$athlete_weightclassA.'</td>    
    </tr>
    <tr>
        <th>Grade: </th>
        <td>'.$athlete_grade_letter.'</td>    
    </tr>
    <tr>
        <th>Description: </th>
        <td>'.$row['athlete_description'].'</td>    
    </tr>
    </table>
</div>
<!-- contact gegevens -->
<div id="contact">
<table>
    <tr>
        <th>Email: </th>
        <td>'.$row['athlete_email'].'</td>
    </tr>
    <tr>
        <th>Phone: </th>
        <td>'.$row['athlete_phone1'].'</td>    
    </tr>
    <tr>
        <th>Phone 2: </th>
        <td>'.$row['athlete_phone2'].'</td>    
    </tr>
    <tr>
        <th>Adress: </th>
        <td>'.$row['athlete_adress'].'</td>    
    </tr>
    <tr>
        <th>Postal code: </th>
        <td>'.$row['athlete_postal_code'].'</td>    
    </tr>
    <tr>
        <th>City/place: </th>
        <td>'.$row['athlete_city'].'</td>    
    </tr>
</table>
</div>
</div>

<!-- Social media tab
<div id="social_media">
    '.$row['athlete_facebook'].'<br>
    '.$row['athlete_twitter'].'<br>
    '.$row['athlete_instagram'].'<br>
    '.$row['athlete_linkedin'].'<br>
    '.$row['athlete_youtube'].'<br>
</div> -->

<!-- Competitie statistieken -->
<div id="statistics">
    
</div>
</section>
</body>
    ';

}
?>
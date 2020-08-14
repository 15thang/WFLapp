<?php
session_start();
if(isset($_SESSION['admin_name']))
    { 
?>
<link rel="stylesheet" href="css/wflapp.css">
<link rel="stylesheet" type="text/css" href="css/APP_CSS.css">

<section id="container_menu">
	<form action="APP_menu.php" method=post>
		<button class="ssbutton" type="submit" name="info">Back</button>
	</form>
	
	<form action="APP_Toevoegen_competitie.php" method=post>
		<button class="ssbutton" type="submit" name="info">Add to Database</button>
	</form>
	
	<form action="APP_website2.php" method=post>
		<button class="ssbutton" type="submit" name="info">Look for athletes</button>
	</form>
</section>
<?php

$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');

//standaard query
$query = "SELECT * FROM `competition` ORDER BY competition_id DESC";

$results = mysqli_query($db, $query);

echo '
<div class="container" style="padding-top:65px">
<table id="table_format" class="table table-bordered">
    <tr>
        <th style="width: 10%;">Competition id</th>
        <th>Competition name</th>
    </tr>';
while ($row = $results->fetch_assoc()) {
    $comp_id = $row['competition_id'];

    echo'<tr id="hoverknop" data-href="APP_competition_info.php?competition_id='.$comp_id.'">
			  <td>'.$row['competition_id'].'<form id="form_edit_event" style="float:right;" method="post" action="APP_edit_competition.php?comp_id='.$comp_id.'">
              <button type="submit" class="button" value="Edit" style="background-image: linear-gradient(to bottom, rgba(0, 163, 52,0) , rgba(173,255,47, 1) , rgba(0, 163, 52,0)">Edit</button></form></td>
              <td>'.$row['competition_name'].'</td>
			</tr>';


}

echo '</table> </div>';

?>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const rows = document.querySelectorAll("tr[data-href]");

    rows.forEach(row => {
        row.addEventListener("click", () => {
        window.location.href = row.dataset.href;
    });
    });
    });
</script>

<?php }
    else {
        echo 'Je moet inloggen';
    }
?>



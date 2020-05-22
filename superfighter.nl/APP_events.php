<link rel="stylesheet" href="css/wflapp.css">
<link rel="stylesheet" type="text/css" href="css/APP_CSS.css">
<?php
echo
'
<section id="container_menu">
	<form action="APP_menu.php" method=post>
		<button class="ssbutton" type="submit" name="info">Back</button>
	</form>
	
	<form action="APP_Toevoegen_event.php" method=post>
		<button class="ssbutton" type="submit" name="info">Add to Database</button>
	</form>
	
	<form action="APP_website2.php" method=post>
		<button class="ssbutton" type="submit" name="info">Look for Athletes</button>
	</form>
</section>';


$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
// -- SORTEER KNOPPEN -- //
//standaard query
$query = "SELECT * FROM `events` ORDER BY event_id DESC";
$results = mysqli_query($db, $query);

echo '
<div class="container" style="padding-top:65px">
<table id="table_format" class="table table-bordered">

    <tr>
        <th>event_id</th>
        <th>event name</th>
        <th>description</th>
        <th>event date</th>
        <th>event place</th>
        <th>event picture</th>
        <th>event picture 2</th>
    </tr>';
while ($row = $results->fetch_assoc()) {
    if ($row['event_name'] != 'event_0') {
        $picture = $row['event_picture'];
        $event_id = $row['event_id'];
        $picture2 = $row['event_picture2'];

        echo'<tr id="hoverknop" data-href="APP_event_info.php?event_id='.$event_id.'&events7=0">
			  <td>'.$row['event_id'].'<form id="form_edit_event" style="float:right;" method="post" action="APP_edit_event.php?event_id='.$event_id.'">
              <button type="submit" class="button" value="Edit" style="background-image: linear-gradient(to bottom, rgba(0, 163, 52,0) , rgba(173,255,47, 1) , rgba(0, 163, 52,0)">Edit</button></form></td>
              <td>'.$row['event_name'].'</td>
              <td>'.$row['event_description'].'</td>
			  <td>'.$row['event_date'].'</td>
			  <td>'.$row['event_place'].'</td>
              <td>'. '<img src="'.$picture.'" id="pic"/>' .'</td>
			  <td>'. '<img src="'.$picture2.'" id="pic"/>' .'</td>
			  <td><form id="form_delete_event" method="post" action="APP_delete_event.php?event_id='.$event_id.'">
              <button type="submit" class="button" value="Delete" style="background-image: linear-gradient(to bottom, rgba(0, 163, 52,0) , rgba(255, 17, 0, 1) , rgba(0, 163, 52,0)">X</button>
              </form></td>
			</tr>';
    }
}

echo '</table> </div>';

?>

<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="lisenme.js"></script>
<script>
    jQuery('#table_format').ddTableFilter();
</script>
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



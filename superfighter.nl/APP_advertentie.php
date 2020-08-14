<?php
session_start();
if(isset($_SESSION['admin_name']))
    { 
?>

<?php
ob_start();
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
?>
<head>
    <link rel="stylesheet" type="text/css" href="css/APP_CSS.css">
</head>

<div>
    <a href="APP_menu.php">Back to menu</a><br><br>
</div>

<div id="field">
    <form name="form1" method="post" action="" enctype="multipart/form-data">
        <h3>Add video</h3>
        <label>Image ad<font color="red">*</font></label><br>
        <input type="file" name="ad_image" required><br>
        <label>Ad link<font color="red">*</font></label><br>
        <input type="text" name="ad_link" placeholder="https://www.example.com/" required><br>
        <br>
        <div class="input-group" style="float: left;">
            <button type="submit" class="btn" name="add_ad">Add ad</button>
        </div>
        <br>
    </form>
</div>

<div id="field" style="float: right">
    <?php
    //standaard query
    $query = "SELECT * FROM `ads` ORDER BY ad_id DESC";

    $results = mysqli_query($db, $query);

    echo '
<div class="container" style="padding-top:65px">
<table id="table_format" class="table table-bordered">';
    while ($row = $results->fetch_assoc()) {
        $ad_id = $row['ad_id'];

        echo'
			<tr>
			    <td>
			            <img class="image" style="background-size: cover; height: 100px; width: 500px" src="'.$row['ad_image'].'">
                </td>
                <td><form id="form_delete_ad" method="post" action="APP_delete_ad.php?ad_id='.$ad_id.'">
              <button type="submit" class="button" value="Delete" style="background-image: linear-gradient(to bottom, rgba(0, 163, 52,0) , rgba(255, 17, 0, 1) , rgba(0, 163, 52,0)">X</button>
              </form></td>
            </tr>
            <tr>
              <td><a href="'.$row['ad_link'].'">'.$row['ad_link'].'</a></td>
              <td></td>
			</tr>';
    }

    echo '</table> </div>';
    ?>
</div>

<div id="field">
    <?php
    if (isset($_POST['add_ad'])) {

        $fnm=$_FILES["ad_image"]["name"];
        $dst="pics/adpics/".$fnm;
        move_uploaded_file($_FILES["ad_image"]["tmp_name"], $dst);

        $adlink = ($_POST['ad_link']);

        $query = "INSERT INTO ads (ad_image, ad_link) 
  			  VALUES('$dst', '$adlink')";
        mysqli_query($db, $query);

        header("Location: APP_advertentie.php");
        ob_flush();

    }
    ?>
</div>
<?php }
    else {
        echo 'Je moet inloggen';
    }
?>
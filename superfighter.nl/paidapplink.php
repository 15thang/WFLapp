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
        <label>APPSTORE LINK <font color="red">*</font></label><br>
        <input type="text" name="link" required><br>
        <label>STORE <font color="red">*</font></label><br>
        <select name="store" required>
            <option disabled selected value></option>
            <option value="android">Android</option>
            <option value="apple">Apple</option>
        </select><br>
        <br>
        <div class="input-group" style="float: left;">
            <button type="submit" class="btn" name="add_link">Add link</button>
        </div>
        <br>
    </form>
</div>

<div id="field">
    <?php
    if (isset($_POST['add_link'])) {
        $link = ($_POST['link']);
        $store = ($_POST['store']);

        $query = "INSERT INTO appstorelink (link, store) 
  			  VALUES('$link', '$store')";
        mysqli_query($db, $query);

        header("Location: APP_menu.php");
        ob_flush();

    }
    ?>
</div>
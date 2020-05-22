<?php
$db = mysqli_connect('localhost', 'jobenam437', 'a5i3v6jf', 'jobenam437_wflapp');
?>

<html>
<div class="input-group">
    <form method="post" action="APP_menu.php">
           <label>Gebruikersnaam</label>
        <input type="text" name="username" id="username">
        </div>
        <div class="input-group">
           <label>Wachtwoord</label>
           <input type="password" name="password" id="password">
        </div>
        <div class="input-group">
          <button type="submit" class="btn" name="login_user">Login</button>
        </div>
    </form>
</html>

<?php
session_start();
if (isset($_POST['login_user'])) {
    if ($_POST["username"] == "") {
        echo 'niet username ';
    }
    if ($_POST["password"] == "") {
        echo 'niet wachtwoord';
    }
}

$username = $_POST['username'];
$password = $_POST['password'];

$query = "SELECT * FROM admin WHERE admin_name='$username' AND admin_password='$password'";
$results = mysqli_query($db, $query);
if (mysqli_num_rows($results) == 1) {
    $_SESSION['username'] = $username;
    $row = $results->fetch_assoc();
    $_SESSION['success'] = "U bent nu ingelogd.";
    header('location: APP_menu.php');
}
else {
    echo 'Verkeerde gebruikersnaam of wachtwoord opgegeven';
}
?>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="css/login.css">

<form method=post action="login.php">

	<div class="container">
		<label for ="admin_name"><b>Gebruikersnaam</b></label>
		<input type="text" placeholder="Vul uw gebruikersnaam" name="admin_name" required>
		
		<label for ="admin_password"><b>Wachtwoord</b></label>
		<input type="wachtwoord" placeholder="Vul uw wachtwoord" name="admin_password" required>
		
		<input method="post" name="login" type="submit">Inloggen</input>
	</div>
</form>	
</html>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="css/login.css">

<form method=post action="login.php">

	<div class="container">
		<label for ="username"><b>Gebruikersnaam</b></label>
		<input type="text" placeholder="Vul uw gebruikersnaam" name="gebruikersnaam" required>
		
		<label for ="ww"><b>Wachtwoord</b></label>
		<input type="wachtwoord" placeholder="Vul uw wachtwoord" name="ww" required>
		
		<input method="post" name="login" type="submit">Inloggen</input>
	</div>

	<div class ="container" style="background-color:#f1f1f1">
	</div>
</form>	
</html>
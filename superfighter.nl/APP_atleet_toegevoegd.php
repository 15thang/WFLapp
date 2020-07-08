<?php
$naam = $_GET['naam'];
?>
<!DOCTYPE html>
<html>
<head>
    <style>
        h1 {text-align: center;}
        p {text-align: center;}
        .special-word {
            color: red;
        }
    </style>
</head>
<body>

<h1><span class='special-word'><?php echo $naam; ?></span> is toegevoegd</h1>
<p><a href="http://superfighter.nl/APP_website2.php">Atleten pagina</a></p>

</body>
</html>

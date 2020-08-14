<!DOCTYPE html>
<html>
<?php
session_start();
if(isset($_SESSION['admin_name']))
    { 
?>

<head>
    <title>Group Project</title>
    <link rel="stylesheet" href="css/slideshow.css">
    <link rel="stylesheet" href="css/wflapp.css">
</head>

<body>
    <div class="slideshow-container">
        <div class="mySlides fade">
            <div class="image">
                <img class="image" style="background-size: inherit" src="pics/wflicon.jpg">
            </div>
        </div>
        <div class="mySlides fade">
            <div class="image">
                <img class="image" style="background-size: cover" src="pics/wfl3.jpg">
            </div>
        </div>
        <div class="mySlides fade">
            <div class="image">
                <img class="image" src="pics/wfl2.jpg">
            </div>
        </div>
    </div>

    <!-- Next and previous buttons -->
    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
    <a class="next" onclick="plusSlides(1)">&#10095;</a>
    </div>
    <br>
    <!-- The dots/circles -->
    <div style="text-align:center">
        <span class="dot" onclick="currentSlide(1)"></span>
        <span class="dot" onclick="currentSlide(2)"></span>
        <span class="dot" onclick="currentSlide(3)"></span>
    </div>

    <div id="menu">
        <section id="container">
            <div id="athlete" href="APP_website2.php">
                <a href="APP_website2.php">Athletes</a>
            </div>
            <div id="events">
                <a href="APP_events.php">Events</a>
            </div>
            <div id="competition">
                <a href="APP_competition.php">Competition</a>
            </div>
            <div id="videos">
                <a href="APP_videos.php">Videos</a>
            </div>
            <div id="competition">
                <a href="APP_mailer.php">E-Mail</a>
            </div>
<div id="competition">
                <a href="APP_advertentie.php">Ad</a>
            </div>
            <div id="output">
                <a href="APP_output.php">Other</a>
            </div>
        </section>
    </div>

</body>

<script>
    var slideIndex = 0;
    carousel();
    showSlides(slideIndex);

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function currentSlide(n) {
        showSlides(slideIndex = n);
    }

    function showSlides(n) {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        var dots = document.getElementsByClassName("dot");
        if (n > slides.length) {
            slideIndex = 1
        }
        if (n < 1) {
            slideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        slides[slideIndex - 1].style.display = "block";
        dots[slideIndex - 1].className += " active";
    }

    function carousel() {
        var i;
        var x = document.getElementsByClassName("mySlides");
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        slideIndex++;
        if (slideIndex > x.length) {
            slideIndex = 1
        }
        x[slideIndex - 1].style.display = "block";
        setTimeout(carousel, 7500); // Change image every 2 seconds
    }
</script>
<?php }
    else {
        echo 'Je moet inloggen';
    }
    ?>
</html>
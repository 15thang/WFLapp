<?php
//sorteer atleet id
if (isset($_POST['sort_id'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_id DESC";
}
if (isset($_POST['sort_id2'])) {
}
//sorteer voornaam A/Z of Z/A
if (isset($_POST['sort_firstname'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_firstname ASC";
}
if (isset($_POST['sort_firstname2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_firstname DESC";
}
//sorteer achternaam A/Z of Z/A
if (isset($_POST['sort_lastname'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_lastname ASC";
}
if (isset($_POST['sort_lastname2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_lastname DESC";
}
//sorteer hoogte laag/hoog hoog/laag
if (isset($_POST['sort_height2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_height ASC";
}
if (isset($_POST['sort_height'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_height DESC";
}
//sorteer gewicht laag/hoog hoog/laag
if (isset($_POST['sort_weight'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_weight ASC";
}
if (isset($_POST['sort_weight2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_weight DESC";
}
//sorteer weightclass
if (isset($_POST['sort_weightclass'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_weightclass ASC";
}
if (isset($_POST['sort_weightclass2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_weightclass DESC";
}
//sorteer fighter grade
if (isset($_POST['sort_grade'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_grade ASC";
}
if (isset($_POST['sort_grade2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_grade DESC";
}
//sorteer leeftijd
if (isset($_POST['sort_birth2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_day_of_birth ASC";
}
if (isset($_POST['sort_birth'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_day_of_birth DESC";
}
//sorteer total matches
if (isset($_POST['sort_total_matches2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_total_matches ASC";
}
if (isset($_POST['sort_total_matches'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_total_matches DESC";
}
//sorteer wins
if (isset($_POST['sort_wins2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_wins ASC";
}
if (isset($_POST['sort_wins'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_wins DESC";
}
//sorteer losses
if (isset($_POST['sort_losses2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_losses ASC";
}
if (isset($_POST['sort_losses'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_losses DESC";
}
//sorteer draws
if (isset($_POST['sort_draws2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_draws ASC";
}
if (isset($_POST['sort_draws'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_draws DESC";
}
//sorteer punten
if (isset($_POST['sort_points2'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_points ASC";
}
if (isset($_POST['sort_points'])) {
    $query = "SELECT * FROM `athletes` ORDER BY athlete_points DESC";
}

?>
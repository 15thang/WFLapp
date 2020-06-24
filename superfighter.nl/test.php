<?php
$arr = 	array(
    array('name' => 'John', 'age' => 30, 'website' => 'http://learnphp.co'),
    array('name' => 'Joe', 'age' => 28, 'website' => 'http://johnmorrisonline.com'),
    array('name' => 'Amy', 'age' => 32, 'website' => 'http://amy.com'),
    array('name' => 'Alex', 'age' => 22, 'website' => 'http://thealex.com'),
    array('name' => 'Pat', 'age' => 40, 'website' => 'http://patsjourney.com'),
);

?>

<?php
array_multisort($arr);
?>

<?php
function val_sort($array,$key) {

    //Loop through and get the values of our specified key
    foreach($array as $k=>$v) {
        $b[] = strtolower($v[$key]);
    }

    asort($b);

    echo '<br />';
    print_r($b);

    foreach($b as $k=>$v) {
        $c[] = $array[$k];
    }

    return $c;
}

$sorted = val_sort($arr, 'age');
?>

<pre><?php print_r($sorted); ?></pre>
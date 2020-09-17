<?php


$hostname = 'localhost';
$username = 'root';
$password = '';
$database = 'ecommerce';

$db = new mysqli($hostname, $username, $password, $database);

//untuk mengecek apakah link diatas error atau tidak
if($db->connect_errno){
	echo ('Connect Error Database'.$db->connect_errno);
	exit();
}
?>
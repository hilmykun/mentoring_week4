<?php


include 'database.php';

$title = $_POST['title'];
$content = $_POST['content'];

$db->query("INSERT INTO tb_diaryku(title, content)VALUES('".$title."','".$content."')");
?>
<?php

include 'database.php';

$id = $_POST['id'];
$title = $_POST['title'];
$content = $_POST['content'];

$db->query("UPDATE tb_diaryku SET title='$title', content = '$content' WHERE id = '$id.'");

?>
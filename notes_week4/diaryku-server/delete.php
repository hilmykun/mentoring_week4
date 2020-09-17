<?php


include 'database.php';


$id = $_POST['id'];


$db->query("DELETE FROM tb_diaryku WHERE id = '".$id."'");
?>
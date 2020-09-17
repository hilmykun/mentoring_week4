<?php

include "database.php";

$query = $db->query("SELECT * FROM tb_diaryku");
$result= array();

while ($rowData = $query->fetch_assoc()){
	$result[] = $rowData;
}

echo json_encode($result);

?>
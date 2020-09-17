<?php

include "database.php";

$query = $db->query("SELECT * FROM tb_ecommerce");
$result= array();

while ($rowData = $query->fetch_assoc()){
	$result[] = $rowData;
}

echo json_encode($result);

?>
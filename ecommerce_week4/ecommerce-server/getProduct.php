<?php

include "koneksi.php";

$response = array();

$sql = mysqli_query($connect, "SELECT * FROM tb_product order by idProduct desc");
while ($a = mysqli_fetch_array($sql)) {
	# code...

	$key['idProduct'] = $a['idProduct'];
	$key['productName'] = $a['productName'];
	$key['sellingPrice'] = (int)$a['sellingPrice'];
	$key['createDate'] = $a['createDate'];
	$key['cover'] = $a['cover'];
	$key['status'] = $a['status'];
	$key['description'] = $a['description'];

	array_push($response, $key);
}

echo json_encode($response);

?>
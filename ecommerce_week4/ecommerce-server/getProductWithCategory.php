<?php

include "koneksi.php";

$response = array();

$sql = mysqli_query($connect, "SELECT * FROM tb_category order by id asc");
while ($a = mysqli_fetch_array($sql)) {
	# code...

	$idCategory = $a['id'];
	$key['id'] = $idCategory;
	$key['categoryName'] = $a['categoryName'];
	$key['status'] = $a['status'];
	$key['createDate'] = $a['createDate'];
	
	$key['product'] = array();

	$query = mysqli_query($connect, "SELECT * FROM tb_product where idCategory='$idCategory'");

	while ($b = mysqli_fetch_array($query)) {
		# code...

		$key['product'][] = array(
			'idProduct'=>$b['idProduct'],
			'idCategory'=>$b['idCategory'],
			'productName'=>$b['productName'],
			'sellingPrice'=>(int)$b['sellingPrice'],
			'createDate'=>$b['createDate'],
			'cover'=>$b['cover'],
			'status'=>$b['status'],
			'description'=>$b['description'],
				
		);
	
	}
	array_push($response, $key);
}

echo json_encode($response);

?>
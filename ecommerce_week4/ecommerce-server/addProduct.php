<?php


include 'koneksi.php';

if($_SERVER['REQUEST_METHOD'] == 'POST'){
	
	$response = array();
	$productName = $_POST['productName'];
	$sellingPrice = $_POST['sellingPrice'];
	$description = $_POST['description'];
	$idCategory = $_POST['idCategory'];
	
	$image = date('dmYHis') . str_replace(" ","", basename($_FILES['image']['name']));
	$path = "./imageProduct/" . $image;
	
	move_uploaded_file($_FILES['image']['tmp_name'], $path);
	
	$insert = "INSERT INTO tb_product VALUE(NULL,'$idCategory','$productName','$sellingPrice',NOW(),'$image','1','$description')";

	if(mysqli_query($connect, $insert)){
		
		$response['value'] = 1;
		$response['message'] = "Succes add product";
		echo json_encode($response);
	}else{
		$response['value'] = 2;
		$response['message'] = "Failed add product";
		echo json_encode($response);
	
	}
	}

?>
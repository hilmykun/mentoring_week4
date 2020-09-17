<?php

include "koneksi.php";

if($_SERVER['REQUEST_METHOD'] == 'POST'){
	$response = array();
	$username = $_POST['username'];
	$password = md5($_POST['password']);

	//Cek Login

	$cek = ("SELECT * FROM tb_user WHERE username='$username' and password='$password'");
	$result = mysqli_fetch_array(mysqli_query($connect, $cek));

	if(isset($result)){
		$response['value'] = 1;
		$response['message'] = "Berhasil login";

		$response['username'] = $result['username'];
		$response['email'] = $result['email'];
		echo json_encode($response);
	}
	else{
		$response['value'] = 0;
		$response['message'] = "Gagal Login";
		echo json_encode($response);
	}

}

?>
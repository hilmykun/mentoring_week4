<?php


require "koneksi.php";

if($_SERVER['REQUEST_METHOD'] == "POST"){
	$response = array();
	$username = $_POST['username'];
	$password = md5($_POST['password']);
	$email = $_POST['email'];

	//Cek apakah sudah memenuhi/tidak

	$cek = "SELECT * FROM tb_user WHERE username='$username'";
	$result = mysqli_fetch_array(mysqli_query($connect, $cek));

	//Cek user apakah tersedia atau tidak
	if(isset($result)){
		$response['value'] = 2;
		$response['message'] = "Maaf username sudah digunakan";

		echo json_encode($response);
	}
	//Jika tidak tersedia, maka bisa register
	else{
		$insert = "INSERT INTO tb_user VALUES(NULL, '$username', '$password', '$email')";

		if(mysqli_query($connect, $insert)){
			$response['value'] = 1;
			$response['message'] = "Berhasil daftar";

			echo json_encode($response);
		}else{
			$response['value'] = 0;
			$response['message'] = "Gagal daftar";

			echo json_encode($response);
		}
	}
}
?>
<?php
require_once "koneksi.php";

if (isset($_POST['nis']) && isset($_POST['password']))
{
    $serverhost = "http://localhost/kelulusan/assets/";

    $nis = $_POST['nis'];
    $password = $_POST['password'];

    $statement = $koneksi->prepare(
        "SELECT tb_siswa.*, CONCAT('$serverhost', tb_dokumen.nm_dokumen) as pdf FROM tb_siswa LEFT JOIN tb_dokumen ON tb_siswa.nis = tb_dokumen.nis WHERE tb_siswa.nis=:nis and tb_siswa.password=:password"
    );

    $statement->bindParam(':nis', $nis);
    $statement->bindParam(':password', $password);

    $statement->execute();

    $result = $statement->rowCount();
    
    header('Content-Type: application/json');

    if ($result > 0)
    {
        http_response_code(200);
        $data = $statement->fetch();
    }
    else
    {
        http_response_code(401);
        $data = ['error' => 'username atau password salah'];
    }

    echo json_encode($data);

    exit;
}

exit;
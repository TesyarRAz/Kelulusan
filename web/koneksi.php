<?php

try
{
    $koneksi = new PDO("mysql:host=localhost;dbname=db_kelulusan", "root", "", [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
}
catch (Exception $ex)
{
    die ($ex->getMessage());
}
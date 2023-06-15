<?php
$username = 'root';
$password = '';
$dbname = 'db_routing';
$servername = 'localhost';


$conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
    die('Conexión fallida: ' . mysqli_connect_error());
}
?>
<?php
$username = 'root';
$password = '';
$dbname = 'db_routing';
$servername = '192.168.1.100';


$conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
    die('Conexión fallida: ' . mysqli_connect_error());
}
?>
<?php 
header('Content-Type: application/json');
require_once '../models/tbl_repartidores.php';
require '../utils/utils.php';

$action = '';
if (isset($_GET['action'])) {
    $action = $_GET['action'];
}

$repartidores = new tbl_repartidores();

switch ($action) {
    case 'getAll':
        $repartidores->getAll();
        break;
    case 'getById':
        $repartidores->idRepartidor =  $_GET['idRepartidor'];
        $repartidores->getById();
        break;
    case 'Create':
        create();
        break;
    case 'Update':
        update();
        break;
    case 'Delete':
        $repartidores->idRepartidor =  $_GET['idrepartidore'];
        $repartidores->delete();
        break;
    default:
        $repartidores->getAll();
        break;
}

    //POST
function create()
{
    try {
        $json = file_get_contents('php://input');
        $obj = json_decode($json, true);

        if ($obj == null) {
            Utils::Response(0, "No se recibieron parametros", null);
            return;
        }

        $repartidores = new tbl_repartidores();
        $repartidores->nbRepartidor = $obj['nbRepartidores'];

        $repartidores->Create();
    } catch (Exception $e) {
        Utils::Response(0, "Error al crear el registro: " . $e, null);
    }
}

//POST
function update()
{
    try {
        $json = file_get_contents('php://input');
        $obj = json_decode($json, true);

        if ($obj == null) {
            Utils::Response(0, "No se recibieron parametros", null);
            return;
        }

        $repartidores = new tbl_repartidores();
        $repartidores->idRepartidor = $obj['idRepartidores'];
        $repartidores->nbRepartidor = $obj['nbRepartidores'];
       
        $repartidores->Update();
    } catch (Exception $e) {
        Utils::Response(0, "Error al actualizar el registro: " . $e, null);
    }
}




?>
<?php 
header('Content-Type: application/json');
require_once '../models/tbl_repartidores.php';
require '../utils/utils.php';

$action = '';
if (isset($_GET['action'])) {
    $action = $_GET['action'];
}

$estatus = new tbl_estatus();

switch ($action) {
    case 'getAll':
        $estatus->getAll();
        break;
    case 'getById':
        $estatus->idEstatus =  $_GET['idEstatus'];
        $estatus->getById();
        break;
    case 'Create':
        create();
        break;
    case 'Update':
        update();
        break;
    case 'Delete':
        $estatus->idEstatus =  $_GET['idEstatus'];
        $estatus->delete();
        break;
    default:
        $estatus->getAll();
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
        $repartidores->nbRepartidores = $obj['nbRepartidores'];

        $estatus->Create();
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
        $repartidores->idRepartidores = $obj['idRepartidores'];
        $repartidores->nbRepartidores = $obj['nbRepartidores'];
       
        $estatus->Update();
    } catch (Exception $e) {
        Utils::Response(0, "Error al actualizar el registro: " . $e, null);
    }
}




?>
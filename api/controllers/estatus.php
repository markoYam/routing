<?php
header('Content-Type: application/json');
require_once '../models/tbl_estatus.php';
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
    case 'getByModulo':
        $estatus->nbModulo = $_GET['nbModulo'];
        $estatus->getByModulo();
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

        $estatus = new tbl_estatus();
        $estatus->nbEstatus = $obj['nbEstatus'];
        $estatus->nbModulo = $obj['nbModulo'];

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

        $estatus = new tbl_estatus();
        $estatus->idEstatus = $obj['idEstatus'];
        $estatus->nbEstatus = $obj['nbEstatus'];
        $estatus->nbModulo = $obj['nbModulo'];

        $estatus->Update();
    } catch (Exception $e) {
        Utils::Response(0, "Error al actualizar el registro: " . $e, null);
    }
}

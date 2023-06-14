<?php
header('Content-Type: application/json');
require_once '../models/tbl_ruteo.php';
require '../utils/utils.php';


$action = '';
if (isset($_GET['action'])) {
    $action = $_GET['action'];
}

$ruteo = new tbl_ruteo();

switch ($action) {
    case 'getAll':
        $ruteo->getAll();
        break;
    case 'getById':
        $ruteo->idRuteo =  $_GET['idRuteo'];
        $ruteo->getById();
        break;
    case 'Create':
        createRuteo();
        break;
    case 'Update':
        updateRuteo();
        break;
    case 'Delete':
        $ruteo->idRuteo =  $_GET['idRuteo'];
        $ruteo->delete();
        break;
    default:
        $ruteo->getAll();
        break;
}

function createRuteo()
{
    try {
        $json = file_get_contents('php://input');
        $obj = json_decode($json, true);

        if ($obj == null) {
            Utils::Response(0, "No se recibieron parametros", null);
            return;
        }

        $ruteo = new tbl_ruteo();
        $ruteo->idRuteo = $obj['idRuteo'];
        $ruteo->nbRuteo = $obj['nbRuteo'];
        $ruteo->feRegistro = $obj['feRegistro'];
        $ruteo->feEntrega = $obj['feEntrega'];
        $ruteo->idEstatus = $obj['idEstatus'];
        $ruteo->idCategoria = $obj['idCategoria'];


        $ruteo->Create();
    } catch (Exception $e) {
        Utils::Response(0, "Error al crear el registro: " . $e, null);
    }
}

function updateRuteo()
{
    try {
        $json = file_get_contents('php://input');
        $obj = json_decode($json, true);

        if ($obj == null) {
            Utils::Response(0, "No se recibieron parametros", null);
            return;
        }

        $ruteo = new tbl_ruteo();
        $ruteo->idRuteo = $obj['idRuteo'];
        $ruteo->nbRuteo = $obj['nbRuteo'];
        $ruteo->feRegistro = $obj['feRegistro'];
        $ruteo->feEntrega = $obj['feEntrega'];
        $ruteo->idEstatus = $obj['idEstatus'];
        $ruteo->idCategoria = $obj['idCategoria'];

        $ruteo->Update();
    } catch (Exception $e) {
        Utils::Response(0, "Error al actualizar el registro: " . $e, null);
    }
}

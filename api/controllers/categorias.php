<?php 
header('Content-Type: application/json');
require_once '../models/tbl_categoria.php';
require '../utils/utils.php';

$action = '';
if (isset($_GET['action'])) {
    $action = $_GET['action'];
}

$categoria = new tbl_categoria();

switch ($action) {
    case 'getAll':
        $categoria->getAll();
        break;
    case 'getById':
        $categoria->idCategoria =  $_GET['idCategoria'];
        $categoria->getById();
        break;
    case 'Create':
        create();
        break;
    case 'Update':
        update();
        break;
    case 'Delete':
        $categoria->idCategoria =  $_GET['idCategoria'];
        $categoria->delete();
        break;
    default:
        $categoria->getAll();
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

        $categoria = new tbl_categoria();
        $categoria->nbCategoria = $obj['nbCategoria'];

        $categoria->Create();
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

        $categoria = new tbl_categoria();
        $categoria->idCategoria = $obj['idCategoria'];
        $categoria->nbCategoria = $obj['nbCategoria'];
       
        $categoria->Update();
    } catch (Exception $e) {
        Utils::Response(0, "Error al actualizar el registro: " . $e, null);
    }
}


?>
<?php 
header('Content-Type: application/json');
require_once '../models/tbl_paradas.php';
require '../utils/utils.php';

$action = '';
if (isset($_GET['action'])) {
    $action = $_GET['action'];
}

$paradas = new tbl_paradas();

switch ($action) {
    case 'getAll':
        $paradas->getAll();
        break;
    case 'getById':
        $paradas->idRuta =  $_GET['idRuta'];
        $paradas->getById();
        break;
    case 'getByRuta':
        $paradas->idRuta =  $_GET['idRuta'];
        $paradas->getByRuta();
        break;
    case 'getByRepartidor':
        $paradas->idRepartidor =  $_GET['idRepartidor'];
        $paradas->getByRepartidor();
        break;
    case 'getByEstatus':
        $paradas->idEstatus =  $_GET['idEstatus'];
        $paradas->getByEstatus();
        break;
    case 'Create':
        createParada();
        break;
    case 'Update':
        updateParada();
        break;
    case 'Delete':
        $paradas->idParada =  $_GET['idParada'];
        $paradas->delete();
        break;
    default:
        $paradas->getAll();
        break;
}

function createParada()
{
    try {
        $json = file_get_contents('php://input');
        $obj = json_decode($json, true);

        if ($obj == null) {
            Utils::Response(0, "No se recibieron parametros", null);
            return;
        }

        $paradas = new tbl_paradas();
        $paradas->idParada = $obj['idParada'];
        $paradas->nbParada = $obj['nbParada'];
        $paradas->desParada = $obj['desParada'];
        $paradas->dcLatitud = $obj['dcLatitud'];
        $paradas->dcLongitud = $obj['dcLongitud'];
        $paradas->desDireccion = $obj['desDireccion'];
        $paradas->idRuta = $obj['idRuta'];
        $paradas->idRepartidor = $obj['idRepartidor'];
        $paradas->idEstatus = $obj['idEstatus'];
        $paradas->dcPrecioCompra = $obj['dcPrecioCompra'];
        $paradas->dcPrecioVenta = $obj['dcPrecioVenta'];
        $paradas->dcTotal = $obj['dcTotal'];


        $paradas->Create();
    } catch (Exception $e) {
        Utils::Response(0, "Error al crear el registro: " . $e, null);
    }
}

function updateParada()
{
    try {
        $json = file_get_contents('php://input');
        $obj = json_decode($json, true);

        if ($obj == null) {
            Utils::Response(0, "No se recibieron parametros", null);
            return;
        }

        $paradas = new tbl_paradas();
        $paradas->idParada = $obj['idParada'];
        $paradas->nbParada = $obj['nbParada'];
        $paradas->desParada = $obj['desParada'];
        $paradas->dcLatitud = $obj['dcLatitud'];
        $paradas->dcLongitud = $obj['dcLongitud'];
        $paradas->desDireccion = $obj['desDireccion'];
        $paradas->idRuta = $obj['idRuta'];
        $paradas->idRepartidor = $obj['idRepartidor'];
        $paradas->idEstatus = $obj['idEstatus'];
        $paradas->dcPrecioCompra = $obj['dcPrecioCompra'];
        $paradas->dcPrecioVenta = $obj['dcPrecioVenta'];
        $paradas->dcTotal = $obj['dcTotal'];
        
        $paradas->Update();
    } catch (Exception $e) {
        Utils::Response(0, "Error al actualizar el registro: " . $e, null);
    }
}

?>
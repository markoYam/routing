<?php 
header('Content-Type: application/json');
require_once '../models/tbl_productos_paradas.php';
require '../utils/utils.php';

$action = '';
if (isset($_GET['action'])) {
    $action = $_GET['action'];
}

$productoParada = new tbl_productos_paradas();

switch ($action) 
{
    case 'getAll':
        $productoParada->getAll();
        break;
    case 'getById':
        $productoParada->idProductoParada =  $_GET['idProductoParada'];
        $productoParada->getById();
        break;
    case 'getByParada':
        $productoParada->idParada =  $_GET['idParada'];
        $productoParada->getByParada();
        break;
    case 'Create':
        create();
        break;
    case 'Update':
        update();
        break;
    case 'Delete':
        $productoParada->idCategoria =  $_GET['idcategoria'];
        $productoParada->delete();
        break;
    default:
        $productoParada->getAll();
        break;
    }


    function createProductosParada()
    {
         try 
    {
        $json = file_get_contents('php://input');
        $obj = json_decode($json, true);

        if ($obj == null) 
        {
            Utils::Response(0, "No se recibieron parametros", null);
            return;
        }

        $ProductoParada = new tbl_productos_paradas();
        $ProductoParada->idProductoParada = $obj['idProductoParada'];
        $ProductoParada->nbProducto = $obj['nbProducto'];
        $ProductoParada->dcCantidad = $obj['dcCantidad'];
        $ProductoParada->dcPrecioVenta = $obj['dcPrecioVenta'];
        $ProductoParada->dcPrecioCompra = $obj['dcPrecioCompra'];
        $ProductoParada->dcTotal = $obj['dcTotal'];
        $ProductoParada->idParada = $obj['idParada'];



        $ProductoParada->Create();
        } catch (Exception $e) {
        Utils::Response(0, "Error al crear el registro: " . $e, null);
    }
    }

    function updateProductosparada()
{
    try {
        $json = file_get_contents('php://input');
        $obj = json_decode($json, true);

        if ($obj == null) {
            Utils::Response(0, "No se recibieron parametros", null);
            return;
        }

       $ProductoParada = new tbl_productos_paradas();
        $ProductoParada->idProductoParada = $obj['idProductoParada'];
        $ProductoParada->nbProducto = $obj['nbProducto'];
        $ProductoParada->dcCantidad = $obj['dcCantidad'];
        $ProductoParada->dcPrecioVenta = $obj['dcPrecioVenta'];
        $ProductoParada->dcPrecioCompra = $obj['dcPrecioCompra'];
        $ProductoParada->dcTotal = $obj['dcTotal'];
        $ProductoParada->idParada = $obj['idParada'];

        $ProductoParada->Update();
    } catch (Exception $e) {
        Utils::Response(0, "Error al actualizar el registro: " . $e, null);
    }
       
} 


?>
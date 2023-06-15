<?php 
include '../config.php'; 

class tbl_productos_paradas{
public $idProductoParada;
public $nbProducto;
public $dcCantidad;
public $dcPrecioVenta;
public $dcPrecioCompra;
public $dcTotal;
public $idParada;

function __construct()
{
}
    //getAll
    function getAll()
    {
        try {
            $query = "SELECT * FROM tbl_productos_paradas";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $ProductoParada = new tbl_productos_paradas();
                $ProductoParada->idProductoParada = $row['idProductoParada'];
                $ProductoParada->nbProducto = $row['nbProducto'];
                $ProductoParada->dcCantidad = $row['dcCantidad'];
                $ProductoParada->dcPrecioVenta = $row['dcPrecioVenta'];
                $ProductoParada->dcPrecioCompra = $row['dcPrecioCompra'];
                $ProductoParada->dcTotal = $row['dcTotal'];
                $ProductoParada->idParada = $row['idParada'];
                
                array_push($array, $ProductoParada);
            }

            if (count($array) == 0) {
                Utils::Response(0, "No se encontraron registros", null);
            } else {
                Utils::Response(1, "Operación realizada con éxito", $array);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al obtener el registro: " . $e, null);
        }
    }

    function getById()
    {
        try {
            //prevent sql injection
            $this->idProductoParada = mysqli_real_escape_string($GLOBALS['conn'], $this->idProductoParada);

            $query = "SELECT * FROM tbl_productos_paradas WHERE idProductoParada = '$this->idProductoParada'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $ProductoParada = new tbl_productos_paradas();
                $ProductoParada->idProductoParada = $row['idProductoParada'];
                $ProductoParada->nbProducto = $row['nbProducto'];
                $ProductoParada->dcCantidad = $row['dcCantidad'];
                $ProductoParada->dcPrecioVenta = $row['dcPrecioVenta'];
                $ProductoParada->dcPrecioCompra = $row['dcPrecioCompra'];
                $ProductoParada->dcTotal = $row['dcTotal'];
                $ProductoParada->idParada = $row['idParada'];
                

                array_push($array, $ProductoParada);
            }

            if (count($array) == 0) {
                Utils::Response(0, "No se encontraron registros", null);
            } else {
                Utils::Response(1, "Operación realizada con éxito", $array);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al obtener el registro: " . $e, null);
        }
    }

    //getByParada
    function getByParada()
    {
        try {
            //prevent sql injection
            $this->idProductoParada = mysqli_real_escape_string($GLOBALS['conn'], $this->idProductoParada);

            $query = "SELECT * FROM tbl_productos_paradas WHERE idProductoParada = '$this->idProductoParada'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $ProductoParada = new tbl_productos_paradas();
                $ProductoParada->idProductoParada = $row['idProductoParada'];
                $ProductoParada->nbProducto = $row['nbProducto'];
                $ProductoParada->dcCantidad = $row['dcCantidad'];
                $ProductoParada->dcPrecioVenta = $row['dcPrecioVenta'];
                $ProductoParada->dcPrecioCompra = $row['dcPrecioCompra'];
                $ProductoParada->dcTotal = $row['dcTotal'];
                $ProductoParada->idParada = $row['idParada'];
                array_push($array, $ProductoParada);
            }

            if (count($array) == 0) {
                Utils::Response(0, "No se encontraron registros", null);
            } else {
                Utils::Response(1, "Operación realizada con éxito", $array);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al obtener el registro: " . $e, null);
        }
    }

    //Create
    function create()
    {
        try {
            //prevent sql injection
            $this->nbProducto = mysqli_real_escape_string($GLOBALS['conn'], $this->nbProducto);
            $this->dcCantidad = mysqli_real_escape_string($GLOBALS['conn'], $this->dcCantidad);
            $this->dcPrecioVenta = mysqli_real_escape_string($GLOBALS['conn'], $this->dcPrecioVenta);
            $this->dcPrecioCompra = mysqli_real_escape_string($GLOBALS['conn'], $this->dcPrecioCompra);
            $this->dcTotal = mysqli_real_escape_string($GLOBALS['conn'], $this->dcTotal);
            $this->idParada = mysqli_real_escape_string($GLOBALS['conn'], $this->idParada);

            $query = "INSERT INTO tbl_productos_paradas (nbProducto,dcCantidad,dcPrecioVenta,dcPrecioCompra,dcTotal,idParada) VALUES ('$this->nbProducto', '$this->dcCantidad', '$this->dcPrecioVenta', '$this->dcPrecioCompra', '$this->dcTotal',this->idParada)";
            $result = mysqli_query($GLOBALS['conn'], $query);

            if ($result) {
                Utils::Response(1, "Operación realizada con éxito", null);
            } else {
                Utils::Response(0, "Error al crear el registro: " . mysqli_error($GLOBALS['conn']), null);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al crear el registro: " . $e, null);
        }
    }

    //Update
    function update()
    {
        try {
            //prevent sql injection
            $this->nbProducto = mysqli_real_escape_string($GLOBALS['conn'], $this->nbProducto);
            $this->dcCantidad = mysqli_real_escape_string($GLOBALS['conn'], $this->dcCantidad);
            $this->dcPrecioVenta = mysqli_real_escape_string($GLOBALS['conn'], $this->dcPrecioVenta);
            $this->dcPrecioCompra = mysqli_real_escape_string($GLOBALS['conn'], $this->dcPrecioCompra);
            $this->dcTotal = mysqli_real_escape_string($GLOBALS['conn'], $this->dcTotal);
            $this->idParada = mysqli_real_escape_string($GLOBALS['conn'], $this->idParada);

            $query = "UPDATE tbl_productos_paradas SET nbProducto = '$this->nbProducto', dcCantidad = '$this->dcCantidad', dcPrecioVenta = '$this->dcPrecioVenta', dcPrecioCompra = '$this->dcPrecioCompra', dcTotal = '$this->dcTotal', idParada = '$this->idParada WHERE idProductoParada = '$this->idProductoParada'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            if ($result) {
                Utils::Response(1, "Operación realizada con éxito", null);
            } else {
                Utils::Response(0, "Error al actualizar el registro: " . mysqli_error($GLOBALS['conn']), null);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al actualizar el registro: " . $e, null);
        }
    }

    //Delete
    function delete()
    {
        try {
            //prevent sql injection
            $this->idProductoParada = mysqli_real_escape_string($GLOBALS['conn'], $this->idProductoParada);

            $query = "DELETE FROM tbl_productos_paradas WHERE id = '$this->idProductoParada'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            if ($result) {
                Utils::Response(1, "Operación realizada con éxito", null);
            } else {
                Utils::Response(0, "Error al eliminar el registro: " . mysqli_error($GLOBALS['conn']), null);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al eliminar el registro: " . $e, null);
        }
    }



}



?>
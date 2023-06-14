<?php
include '../config.php';
class tbl_categoria
{
    /*idCategoria
nbCategoria
*/

    public $idCategoria;
    public $nbCategoria;

    function __construct()
    {
    }

    //getAll
    function getAll()
    {
        try {
            $query = "SELECT * FROM tbl_categoria";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $categoria = new tbl_categoria();
                $categoria->idCategoria = $row['idCategoria'];
                $categoria->nbCategoria = $row['nbCategoria'];
                array_push($array, $categoria);
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

    //getById
    function getById()
    {
        try {
            //prevent sql injection
            $this->idCategoria = mysqli_real_escape_string($GLOBALS['conn'], $this->idCategoria);

            $query = "SELECT * FROM tbl_categoria WHERE idCategoria = '$this->idCategoria'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $categoria = new tbl_categoria();
                $categoria->idCategoria = $row['idCategoria'];
                $categoria->nbCategoria = $row['nbCategoria'];
                array_push($array, $categoria);
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

    //create
    function create()
    {
        try {
            //prevent sql injection
            $this->nbCategoria = mysqli_real_escape_string($GLOBALS['conn'], $this->nbCategoria);

            $exist = Utils::isRegisterExists($GLOBALS['conn'], "tbl_categoria", "nbCategoria", $this->nbCategoria);

            if ($exist) {
                Utils::Response(0, "Ya existe un registro con el mismo nombre", null);
                return;
            }

            $query = "INSERT INTO tbl_categoria (nbCategoria) VALUES ('$this->nbCategoria')";
            $result = mysqli_query($GLOBALS['conn'], $query);

            if ($result) {
                Utils::Response(1, "Operación realizada con éxito", null);
            } else {
                Utils::Response(0, "Error al insertar el registro", null);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al insertar el registro: " . $e, null);
        }
    }

   

    //update
    function update()
    {
        try {
            //prevent sql injection
            $this->idCategoria = mysqli_real_escape_string($GLOBALS['conn'], $this->idCategoria);
            $this->nbCategoria = mysqli_real_escape_string($GLOBALS['conn'], $this->nbCategoria);

            $query = "UPDATE tbl_categoria SET nbCategoria = '$this->nbCategoria' WHERE idCategoria = '$this->idCategoria'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            if ($result) {
                Utils::Response(1, "Operación realizada con éxito", null);
            } else {
                Utils::Response(0, "Error al actualizar el registro", null);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al actualizar el registro: " . $e, null);
        }
    }

    //delete
    function delete()
    {
        try {
            //prevent sql injection
            $this->idCategoria = mysqli_real_escape_string($GLOBALS['conn'], $this->idCategoria);

            $query = "DELETE FROM tbl_categoria WHERE idCategoria = '$this->idCategoria'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            if ($result) {
                Utils::Response(1, "Operación realizada con éxito", null);
            } else {
                Utils::Response(0, "Error al eliminar el registro", null);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al eliminar el registro: " . $e, null);
        }
    }
}

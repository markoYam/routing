<?php
include '../config.php';
class tbl_estatus
{
    public $idEstatus;
    public $nbEstatus;
    public $nbModulo;

    function __construct()
    {
    }

    function getAll()
    {
        try {
            $query = "SELECT * FROM tbl_estatus";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $estatus = new tbl_estatus();
                $estatus->idEstatus = $row['idEstatus'];
                $estatus->nbEstatus = $row['nbEstatus'];
                $estatus->nbModulo = $row['nbModulo'];
                array_push($array, $estatus);
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

    function getByModulo()
    {
        try {

            //prevent sql injection
            $this->nbModulo = mysqli_real_escape_string($GLOBALS['conn'], $this->nbModulo);

            $query = "SELECT * FROM tbl_estatus WHERE nbModulo = '$this->nbModulo'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $estatus = new tbl_estatus();
                $estatus->idEstatus = $row['idEstatus'];
                $estatus->nbEstatus = $row['nbEstatus'];
                $estatus->nbModulo = $row['nbModulo'];
                array_push($array, $estatus);
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
            $this->idEstatus = mysqli_real_escape_string($GLOBALS['conn'], $this->idEstatus);

            $query = "SELECT * FROM tbl_estatus WHERE idEstatus = '$this->idEstatus'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $estatus = new tbl_estatus();
                $estatus->idEstatus = $row['idEstatus'];
                $estatus->nbEstatus = $row['nbEstatus'];
                $estatus->nbModulo = $row['nbModulo'];
                array_push($array, $estatus);
            }

            if (count($array) == 0) {
                Utils::Response(0, "No se encontraron registros", null);
            } else {
                Utils::Response(1, "Operación realizada con éxito", $array[0]);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al obtener el registro: " . $e, null);
        }
    }

    function create()
    {
        try {
            //prevent sql injection
            $this->nbEstatus = mysqli_real_escape_string($GLOBALS['conn'], $this->nbEstatus);
            $this->nbModulo = mysqli_real_escape_string($GLOBALS['conn'], $this->nbModulo);

            $query = "INSERT INTO tbl_estatus (nbEstatus, nbModulo) VALUES ('$this->nbEstatus', '$this->nbModulo')";
            $result = mysqli_query($GLOBALS['conn'], $query);

            if ($result) {
                Utils::Response(1, "Operación realizada con éxito", null);
            } else {
                Utils::Response(0, "Ocurrio un error al guardar el estatus", null);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al crear el registro: " . $e, null);
        }
    }

    function update()
    {
        try {
            //prevent sql injection
            $this->nbEstatus = mysqli_real_escape_string($GLOBALS['conn'], $this->nbEstatus);
            $this->nbModulo = mysqli_real_escape_string($GLOBALS['conn'], $this->nbModulo);

            $query = "UPDATE tbl_estatus SET nbEstatus = '$this->nbEstatus', nbModulo = '$this->nbModulo' WHERE idEstatus = '$this->idEstatus'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            if ($result) {
                Utils::Response(1, "Operación realizada con éxito", null);
            } else {
                Utils::Response(0, "Ocurrio un error al actualizar el estatus", null);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al actualizar el registro: " . $e, null);
        }
    }

    function delete()
    {
        try {
            //prevent sql injection
            $this->idEstatus = mysqli_real_escape_string($GLOBALS['conn'], $this->idEstatus);

            $query = "DELETE FROM tbl_estatus WHERE idEstatus = '$this->idEstatus'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            if ($result) {
                Utils::Response(1, "Operación realizada con éxito", null);
            } else {
                Utils::Response(0, "Ocurrio un error al eliminar el estatus", null);
            }
        } catch (Exception $e) {
            Utils::Response(0, "Error al eliminar el registro: " . $e, null);
        }
    }
}

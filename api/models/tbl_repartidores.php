<?php
include '../config.php';

class tbl_repartidores
{

    public $idRepartidor;
    public $nbRepartidor;


    function __construct()
    {
    }

    //getAll
    function getAll()
    {
        try {
            $query = "SELECT * FROM tbl_repartidores";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $repartidores = new tbl_repartidores();
                $repartidores->idRepartidor = $row['idRepartidor'];
                $repartidores->idRepartidor = $row['idRepartidor'];

                array_push($array, $repartidores);
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
            $this->idRepartidor = mysqli_real_escape_string($GLOBALS['conn'], $this->idRepartidor);

            $query = "SELECT * FROM tbl_repartidores WHERE idRepartidor = '$this->idRepartidor'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $repartidores = new tbl_repartidores();
                $repartidores->idRepartidor = $row['idRepartidor'];
                $repartidores->nbRepartidor = $row['nbRepartidor'];

                array_push($array, $repartidores);
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
            $this->nbRepartidor = mysqli_real_escape_string($GLOBALS['conn'], $this->nbRepartidor);

            $exist = Utils::isRegisterExists($GLOBALS['conn'], "tbl_repartidores", "nbRepartidor", $this->nbRepartidor);

            if ($exist) {
                Utils::Response(0, "Ya existe un registro con el mismo nombre", null);
                return;
            }

            $query = "INSERT INTO tbl_repartidores (nbRepartidor) VALUES ('$this->nbRepartidor')";
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
}

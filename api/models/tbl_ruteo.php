<?php
include '../config.php';
require 'tbl_estatus.php';
require 'tbl_categoria.php';

class tbl_ruteo
{
    public $idRuteo;
    public $nbRuteo;
    public $feRegistro;
    public $feEntrega;
    public $idEstatus;
    public $idCategoria;
    public $estatus;
    public $categoria;
    public $numParadas;

    function __construct()
    {
    }

    //getAll
    function getAll()
    {
        try {
            $query = "SELECT * FROM tbl_ruteo";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $ruteo = new tbl_ruteo();
                $ruteo->idRuteo = $row['idRuteo'];
                $ruteo->nbRuteo = $row['nbRuteo'];
                $ruteo->feRegistro = $row['feRegistro'];
                $ruteo->feEntrega = $row['feEntrega'];
                $ruteo->idEstatus = $row['idEstatus'];
                $ruteo->idCategoria = $row['idCategoria'];

                $queryNumParadas = "SELECT COUNT(*) AS numParadas FROM tbl_paradas WHERE idRuta = '$ruteo->idRuteo'";
                $resultNumParadas = mysqli_query($GLOBALS['conn'], $queryNumParadas);
                $rowNumParadas = mysqli_fetch_array($resultNumParadas);
                $ruteo->numParadas = $rowNumParadas['numParadas'];

                
                $queryEstatus = "SELECT * FROM tbl_estatus WHERE idEstatus = '$ruteo->idEstatus'";

                $resultEstatus = mysqli_query($GLOBALS['conn'], $queryEstatus);
                
                while ($rowEstatus = mysqli_fetch_array($resultEstatus)) {
                    $estatus = new tbl_estatus();
                    $estatus->idEstatus = $rowEstatus['idEstatus'];
                    $estatus->nbEstatus = $rowEstatus['nbEstatus'];
                    $estatus->nbModulo = $rowEstatus['nbModulo'];

                    $ruteo->estatus = $estatus;
                }

                $queryCategoria = "SELECT * FROM tbl_categoria WHERE idCategoria = '$ruteo->idCategoria'";

                $resultCategoria = mysqli_query($GLOBALS['conn'], $queryCategoria);

                while ($rowCategoria = mysqli_fetch_array($resultCategoria)) {
                    $categoria = new tbl_categoria();
                    $categoria->idCategoria = $rowCategoria['idCategoria'];
                    $categoria->nbCategoria = $rowCategoria['nbCategoria'];
                    $ruteo->categoria = $categoria;
                }


                array_push($array, $ruteo);
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
    function getByIdCategoria(){
        try {
            //prevent sql injection
            $this->idCategoria = mysqli_real_escape_string($GLOBALS['conn'], $this->idCategoria);

            $query = "SELECT * FROM tbl_ruteo WHERE idCategoria = '$this->idCategoria'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $ruteo = new tbl_ruteo();
                $ruteo->idRuteo = $row['idRuteo'];
                $ruteo->nbRuteo = $row['nbRuteo'];
                $ruteo->feRegistro = $row['feRegistro'];
                $ruteo->feEntrega = $row['feEntrega'];
                $ruteo->idEstatus = $row['idEstatus'];
                $ruteo->idCategoria = $row['idCategoria'];

                $queryNumParadas = "SELECT COUNT(*) AS numParadas FROM tbl_paradas WHERE idRuta = '$ruteo->idRuteo'";
                $resultNumParadas = mysqli_query($GLOBALS['conn'], $queryNumParadas);
                $rowNumParadas = mysqli_fetch_array($resultNumParadas);
                $ruteo->numParadas = $rowNumParadas['numParadas'];

                array_push($array, $ruteo);
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
            $this->idRuteo = mysqli_real_escape_string($GLOBALS['conn'], $this->idRuteo);

            $query = "SELECT * FROM tbl_ruteo WHERE idRuteo = '$this->idRuteo'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $ruteo = new tbl_ruteo();
                $ruteo->idRuteo = $row['idRuteo'];
                $ruteo->nbRuteo = $row['nbRuteo'];
                $ruteo->feRegistro = $row['feRegistro'];
                $ruteo->feEntrega = $row['feEntrega'];
                $ruteo->idEstatus = $row['idEstatus'];
                $ruteo->idCategoria = $row['idCategoria'];

                $queryNumParadas = "SELECT COUNT(*) AS numParadas FROM tbl_paradas WHERE idRuta = '$ruteo->idRuteo'";
                $resultNumParadas = mysqli_query($GLOBALS['conn'], $queryNumParadas);
                $rowNumParadas = mysqli_fetch_array($resultNumParadas);
                $ruteo->numParadas = $rowNumParadas['numParadas'];

                array_push($array, $ruteo);
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
    //getByCategoria
    function getByCategoria()
    {
        try {
            //prevent sql injection
            $this->idCategoria = mysqli_real_escape_string($GLOBALS['conn'], $this->idCategoria);

            $query = "SELECT * FROM tbl_ruteo WHERE idCategoria = '$this->idCategoria'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $ruteo = new tbl_ruteo();
                $ruteo->idRuteo = $row['idRuteo'];
                $ruteo->nbRuteo = $row['nbRuteo'];
                $ruteo->feRegistro = $row['feRegistro'];
                $ruteo->feEntrega = $row['feEntrega'];
                $ruteo->idEstatus = $row['idEstatus'];
                $ruteo->idCategoria = $row['idCategoria'];

                $queryNumParadas = "SELECT COUNT(*) AS numParadas FROM tbl_paradas WHERE idRuta = '$ruteo->idRuteo'";
                $resultNumParadas = mysqli_query($GLOBALS['conn'], $queryNumParadas);
                $rowNumParadas = mysqli_fetch_array($resultNumParadas);
                $ruteo->numParadas = $rowNumParadas['numParadas'];

                array_push($array, $ruteo);
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
    //getByEstatus
    function getByEstatus()
    {
        try {
            //prevent sql injection
            $this->idEstatus = mysqli_real_escape_string($GLOBALS['conn'], $this->idEstatus);

            $query = "SELECT * FROM tbl_ruteo WHERE idEstatus = '$this->idEstatus'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $ruteo = new tbl_ruteo();
                $ruteo->idRuteo = $row['idRuteo'];
                $ruteo->nbRuteo = $row['nbRuteo'];
                $ruteo->feRegistro = $row['feRegistro'];
                $ruteo->feEntrega = $row['feEntrega'];
                $ruteo->idEstatus = $row['idEstatus'];
                $ruteo->idCategoria = $row['idCategoria'];

                $queryNumParadas = "SELECT COUNT(*) AS numParadas FROM tbl_paradas WHERE idRuta = '$ruteo->idRuteo'";
                $resultNumParadas = mysqli_query($GLOBALS['conn'], $queryNumParadas);
                $rowNumParadas = mysqli_fetch_array($resultNumParadas);
                $ruteo->numParadas = $rowNumParadas['numParadas'];

                array_push($array, $ruteo);
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
            $this->nbRuteo = mysqli_real_escape_string($GLOBALS['conn'], $this->nbRuteo);
            $this->feRegistro = mysqli_real_escape_string($GLOBALS['conn'], $this->feRegistro);
            $this->feEntrega = mysqli_real_escape_string($GLOBALS['conn'], $this->feEntrega);
            $this->idEstatus = mysqli_real_escape_string($GLOBALS['conn'], $this->idEstatus);
            $this->idCategoria = mysqli_real_escape_string($GLOBALS['conn'], $this->idCategoria);

            $query = "INSERT INTO tbl_ruteo (nbRuteo, feRegistro, feEntrega, idEstatus, idCategoria) VALUES ('$this->nbRuteo', '$this->feRegistro', '$this->feEntrega', '$this->idEstatus', '$this->idCategoria')";
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
            $this->idRuteo = mysqli_real_escape_string($GLOBALS['conn'], $this->idRuteo);
            $this->nbRuteo = mysqli_real_escape_string($GLOBALS['conn'], $this->nbRuteo);
            $this->feRegistro = mysqli_real_escape_string($GLOBALS['conn'], $this->feRegistro);
            $this->feEntrega = mysqli_real_escape_string($GLOBALS['conn'], $this->feEntrega);
            $this->idEstatus = mysqli_real_escape_string($GLOBALS['conn'], $this->idEstatus);
            $this->idCategoria = mysqli_real_escape_string($GLOBALS['conn'], $this->idCategoria);

            $query = "UPDATE tbl_ruteo SET nbRuteo = '$this->nbRuteo', feRegistro = '$this->feRegistro', feEntrega = '$this->feEntrega', idEstatus = '$this->idEstatus', idCategoria = '$this->idCategoria' WHERE idRuteo = '$this->idRuteo'";
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
            $this->idRuteo = mysqli_real_escape_string($GLOBALS['conn'], $this->idRuteo);

            $numParadas = 0;
            $queryNumParadas = "SELECT COUNT(*) AS numParadas FROM tbl_paradas WHERE idRuta = '$this->idRuteo'";
            $resultNumParadas = mysqli_query($GLOBALS['conn'], $queryNumParadas);
            $rowNumParadas = mysqli_fetch_array($resultNumParadas);
            $numParadas = $rowNumParadas['numParadas'];

            if($numParadas > 0){
                Utils::Response(0, "No se puede eliminar el registro, ya que tiene paradas asociadas", null);
                return;
            }

            $query = "DELETE FROM tbl_ruteo WHERE idRuteo = '$this->idRuteo'";
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

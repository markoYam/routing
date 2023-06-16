<?php 
include '../config.php'; 

class tbl_paradas{

    public $idParada;
    public $nbParada;
    public $desParada;
    public $dcLatitud;
    public $dcLongitud;
    public $desDireccion;
    public $idRuteo;
    public $idRepartidor;
    public $idEstatus;
    public $dcPrecioCompra;
    public $dcPrecioVenta;
    public $dcTotal;
    public $estatus;
    public $ruteo;
    public $repartidor;

    function __construct()
    {
    }

    //getAll
    function getAll()
    {
        try {
            $query = "SELECT * FROM tbl_paradas";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $paradas = new tbl_paradas();
                $paradas->idParada = $row['idParada'];
                $paradas->nbParada = $row['nbParada'];
                $paradas->desParada = $row['desParada'];
                $paradas->dcLatitud = $row['dcLatitud'];
                $paradas->dcLongitud = $row['dcLongitud'];
                $paradas->desDireccion = $row['desDireccion'];
                $paradas->idRuta = $row['idRuteo'];
                $paradas->idRepartidor = $row['idRepartidor'];
                $paradas->idEstatus = $row['idEstatus'];
                $paradas->dcPrecioCompra = $row['dcPrecioCompra'];
                $paradas->dcPrecioVenta = $row['dcPrecioVenta'];
                $paradas->dcTotal = $row['dcTotal'];
                
                $queryEstatus = "SELECT * FROM tbl_estatus WHERE idEstatus = '$paradas->idEstatus'";

                $resultEstatus = mysqli_query($GLOBALS['conn'], $queryEstatus);
                
                while ($rowEstatus = mysqli_fetch_array($resultEstatus)) {
                    $estatus = new tbl_estatus();
                    $estatus->idEstatus = $rowEstatus['idEstatus'];
                    $estatus->nbEstatus = $rowEstatus['nbEstatus'];
                    $estatus->nbModulo = $rowEstatus['nbModulo'];
                    $paradas->estatus = $estatus;
                    
                }

                $queryRepartidor = "SELECT * FROM tbl_repartidores WHERE idRepartidor = '$paradas->idRepartidor'";

                $resultRepartidor = mysqli_query($GLOBALS['conn'], $queryRepartidor);
                
                while ($rowRepartidor = mysqli_fetch_array($resultRepartidor)) {
                    $paradas = new tbl_repartidores();
                    $paradas->idRepartidor = $rowRepartidor['idRepartidor'];
                    $paradas->nbRepartidor = $rowRepartidor['nbRepartidor'];
                    $paradas->repartidor = $repartidor;
                }






                $queryRuteo = "SELECT * FROM tbl_ruteo WHERE idRuteo = '$paradas->idRuteo'";

                $resultRuteo = mysqli_query($GLOBALS['conn'], $queryRuteo);
                
                while ($rowRuteo = mysqli_fetch_array($resultRuta)) {
                    $rutas = new tbl_ruteo();
                    $rutas->idParada = $rowRuteo['idParada'];
                    $rutas->nbParada = $rowRuteo['nbParada'];
                    $rutas->desParada = $rowRuteo['desParada'];
                    $rutas->dcLatitud = $rowRuteo['dcLatitud'];
                    $rutas->dcLongitud = $rowRuteo['dcLongitud'];
                    $rutas->desDireccion = $rowRuteo['desDireccion'];
                    $rutas->idRuta = $rowRuteo['idRuteo'];
                    $rutas->idRepartidor = $rowRuteo['idRepartidor'];
                    $rutas->idEstatus = $rowRuteo['idEstatus'];
                    $rutas->dcPrecioCompra = $rowRuteo['dcPrecioCompra'];
                    $rutas->dcPrecioVenta = $rowRuteo['dcPrecioVenta'];
                    $rutas->dcTotal = $rowRuteo['dcTotal'];
                    $rutas->ruteo = $ruteo;
                }
                array_push($array, $rutas);
            }

            if (count($array) == 0) {
                Utils::Response(0, "No se encontraron registros", null);
            } else {
                Utils::Response(1, "Operación realizada con éxito", $array);
            }
        }
        
         catch (Exception $e) {
            Utils::Response(0, "Error al obtener el registro: " . $e, null);
        }

    }

    //getById
    function getById()
    {
        try {
            //prevent sql injection
            $this->idParada = mysqli_real_escape_string($GLOBALS['conn'], $this->idParada);

            $query = "SELECT * FROM tbl_paradas WHERE idParada = '$this->idParada'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $paradas = new tbl_paradas();
                $paradas->idParada = $row['idParada'];
                $paradas->nbParada = $row['nbParada'];
                $paradas->desParada = $row['desParada'];
                $paradas->dcLatitud = $row['dcLatitud'];
                $paradas->dcLongitud = $row['dcLongitud'];
                $paradas->desDireccion = $row['desDireccion'];
                $paradas->idRuta = $row['idRuta'];
                $paradas->idRepartidor = $row['idRepartidor'];
                $paradas->idEstatus = $row['idEstatus'];
                $paradas->dcPrecioCompra = $row['dcPrecioCompra'];
                $paradas->dcPrecioVenta = $row['dcPrecioVenta'];
                $paradas->dcTotal = $row['dcTotal'];
                array_push($array, $paradas);
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

    //getByRuta
    function getByRuta()
    {
        try {
            //prevent sql injection
            $this->idRuta = mysqli_real_escape_string($GLOBALS['conn'], $this->idRuta);

            $query = "SELECT * FROM tbl_paradas WHERE idRuta = '$this->idRuta'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $paradas = new tbl_paradas();
                $paradas->idParada = $row['idParada'];
                $paradas->nbParada = $row['nbParada'];
                $paradas->desParada = $row['desParada'];
                $paradas->dcLatitud = $row['dcLatitud'];
                $paradas->dcLongitud = $row['dcLongitud'];
                $paradas->desDireccion = $row['desDireccion'];
                $paradas->idRuta = $row['idRuta'];
                $paradas->idRepartidor = $row['idRepartidor'];
                $paradas->idEstatus = $row['idEstatus'];
                $paradas->dcPrecioCompra = $row['dcPrecioCompra'];
                $paradas->dcPrecioVenta = $row['dcPrecioVenta'];
                $paradas->dcTotal = $row['dcTotal'];
                array_push($array, $paradas);
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

    //getByRepartidor
    function getByRepartidor()
    {
        try {
            //prevent sql injection
            $this->idRepartidor = mysqli_real_escape_string($GLOBALS['conn'], $this->idRepartidor);

            $query = "SELECT * FROM tbl_paradas WHERE idRepartidor = '$this->idRepartidor'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $paradas = new tbl_paradas();
                $paradas->idParada = $row['idParada'];
                $paradas->nbParada = $row['nbParada'];
                $paradas->desParada = $row['desParada'];
                $paradas->dcLatitud = $row['dcLatitud'];
                $paradas->dcLongitud = $row['dcLongitud'];
                $paradas->desDireccion = $row['desDireccion'];
                $paradas->idRuta = $row['idRuta'];
                $paradas->idRepartidor = $row['idRepartidor'];
                $paradas->idEstatus = $row['idEstatus'];
                $paradas->dcPrecioCompra = $row['dcPrecioCompra'];
                $paradas->dcPrecioVenta = $row['dcPrecioVenta'];
                $paradas->dcTotal = $row['dcTotal'];
                array_push($array, $paradas);
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

            $query = "SELECT * FROM tbl_paradas WHERE idEstatus = '$this->idEstatus'";
            $result = mysqli_query($GLOBALS['conn'], $query);

            $array = array();
            while ($row = mysqli_fetch_array($result)) {
                $paradas = new tbl_paradas();
                $paradas->idParada = $row['idParada'];
                $paradas->nbParada = $row['nbParada'];
                $paradas->desParada = $row['desParada'];
                $paradas->dcLatitud = $row['dcLatitud'];
                $paradas->dcLongitud = $row['dcLongitud'];
                $paradas->desDireccion = $row['desDireccion'];
                $paradas->idRuta = $row['idRuta'];
                $paradas->idRepartidor = $row['idRepartidor'];
                $paradas->idEstatus = $row['idEstatus'];
                $paradas->dcPrecioCompra = $row['dcPrecioCompra'];
                $paradas->dcPrecioVenta = $row['dcPrecioVenta'];
                $paradas->dcTotal = $row['dcTotal'];
                array_push($array, $paradas);
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
            $this->nbParada = mysqli_real_escape_string($GLOBALS['conn'], $this->nbParada);
            $this->desParada = mysqli_real_escape_string($GLOBALS['conn'], $this->desParada);
            $this->dcLatitud = mysqli_real_escape_string($GLOBALS['conn'], $this->dcLatitud);
            $this->dcLongitud = mysqli_real_escape_string($GLOBALS['conn'], $this->dcLongitud);
            $this->desDireccion = mysqli_real_escape_string($GLOBALS['conn'], $this->desDireccion);
            $this->idRuta = mysqli_real_escape_string($GLOBALS['conn'], $this->idRuta);
            $this->idRepartidor = mysqli_real_escape_string($GLOBALS['conn'], $this->idRepartidor);
            $this->idEstatus = mysqli_real_escape_string($GLOBALS['conn'], $this->idEstatus);
            $this->dcPrecioCompra = mysqli_real_escape_string($GLOBALS['conn'], $this->dcPrecioCompra);
            $this->dcPrecioVenta = mysqli_real_escape_string($GLOBALS['conn'], $this->dcPrecioVenta);
            $this->dcTotal = mysqli_real_escape_string($GLOBALS['conn'], $this->dcTotal);

            $query = "INSERT INTO tbl_paradas (nbParada, desParada, dcLatitud, dcLongitud, desDireccion, idRuta, idRepartidor, idEstatus, dcPrecioCompra, dcPrecioVenta, dcTotal) VALUES ('$this->nbParada', '$this->desParada', '$this->dcLatitud', '$this->dcLongitud', '$this->desDireccion','$this->idRuta','$this->idRepartidor','$this->idEstatus','$this->dcPrecioCompra','$this->dcPrecioVenta','$this->dcTotal' )";
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
            $this->nbParada = mysqli_real_escape_string($GLOBALS['conn'], $this->nbParada);
            $this->desParada = mysqli_real_escape_string($GLOBALS['conn'], $this->desParada);
            $this->dcLatitud = mysqli_real_escape_string($GLOBALS['conn'], $this->dcLatitud);
            $this->dcLongitud = mysqli_real_escape_string($GLOBALS['conn'], $this->dcLongitud);
            $this->desDireccion = mysqli_real_escape_string($GLOBALS['conn'], $this->desDireccion);
            $this->idRuta = mysqli_real_escape_string($GLOBALS['conn'], $this->idRuta);
            $this->idRepartidor = mysqli_real_escape_string($GLOBALS['conn'], $this->idRepartidor);
            $this->idEstatus = mysqli_real_escape_string($GLOBALS['conn'], $this->idEstatus);
            $this->dcPrecioCompra = mysqli_real_escape_string($GLOBALS['conn'], $this->dcPrecioCompra);
            $this->dcPrecioVenta = mysqli_real_escape_string($GLOBALS['conn'], $this->dcPrecioVenta);
            $this->dcTotal = mysqli_real_escape_string($GLOBALS['conn'], $this->dcTotal);

            $query = "UPDATE tbl_paradas SET nbParada = '$this->nbParada', desParada = '$this->desParada', dcLatitud = '$this->dcLatitud', dcLongitud = '$this->dcLongitud', desDireccion = '$this->desDireccion' idRuta = '$this->idRuta', idRepartidor = '$this->idRepartidor', idEstatus = '$this->idEstatus', dcPrecioCompra = '$this->dcPrecioCompra', dcPrecioVenta = '$this->dcPrecioVenta', dcTotal = '$this->dcTotal' WHERE idParada = '$this->idParada'";
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
            $this->idParada = mysqli_real_escape_string($GLOBALS['conn'], $this->idParada);

            $query = "DELETE FROM tbl_paradas WHERE idParada = '$this->idParada'";
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
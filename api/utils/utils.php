<?php
class Utils {


    static function Response($status, $message, $data){
        $response = array();
        $response['status'] = $status;
        $response['message'] = $message;
        $response['data'] = $data;
        
        echo json_encode($response);
    }

    static function isRegisterExists($conn, $table, $field, $value)
    {
        $query = "SELECT * FROM $table WHERE $field = '$value'";
        $result = mysqli_query($conn, $query);

        if (mysqli_num_rows($result) > 0) {
            return true;
        } else {
            return false;
        }
    }
}

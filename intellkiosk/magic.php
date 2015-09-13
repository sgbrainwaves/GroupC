<?php
    $base=$_REQUEST['image'];
    $pathn=$_REQUEST['file_path'];
    $binary=base64_decode($base);
    header('Content-Type: bitmap; charset=utf-8');
    $file = fopen($pathn, 'wb');
    fwrite($file, $binary);
    fclose($file);

    

?>

<?php 
  $serverName = "localhost";
  $connectionInfo = array("Database" => "semestralFP", "UID" => "fpuser", "PWD" => "root", "CharacterSet" => "UTF-8");
  
  $con = sqlsrv_connect($serverName, $connectionInfo);

  if ($con) {
    echo "conexión exitosa";
  } else {
    echo "fallo en la conexión";
  }
?>
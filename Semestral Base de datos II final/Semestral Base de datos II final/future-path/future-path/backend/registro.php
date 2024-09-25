<!DOCTYPE html>
<?php
include("conexion.php");
?>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registro Estudiante</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>

<body>
  <div class="container-lg">
    <form class="row mx-auto p-5" method="POST" action="registro.php">
      <h1>Registro de Estudiantes</h1>
      <div class="mb-3 col-auto">
        <label for="id" class="form-label">ID Estudiante</label>
        <input type="text" name="idEst" class="form-control" placeholder="Ej. EST0" id="id" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-auto">
        <label for="cedula" class="form-label">Cédula</label>
        <input type="text" name="cedulaEst" class="form-control" placeholder="X-XXX-XXXX" id="cedula" aria-describedby="textHelp">
      </div>
      <div class="mb-3 w-25 col-sm-6">
        <label for="nombre" class="form-label">Primer Nombre</label>
        <input type="text" name="nombreEst" class="form-control" id="nombre" aria-describedby="textHelp">
      </div>
      <div class="mb-3 w-25 col-sm-6">
        <label for="apellido" class="form-label">Primer Apellido</label>
        <input type="text" name="apellidoEst" class="form-control" id="apellido" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-sm-2">
        <label for="edad" class="form-label">Edad</label>
        <input type="number" name="edadEst" class="form-control" id="edad" aria-describedby="numberHelp">
      </div>
      <div class="mb-3 me-5-lg col-auto">
        <label for="fnacimiento" class="form-label">Fecha de Nacimiento</label>
        <input type="text" name="fnacimientoEst" class="form-control" placeholder="AAAA-MM-DD" id="fnacimiento" aria-describedby="textHelp">
      </div>
      <div class="mb-3 w-25 col-sm-7">
        <label for="bachiller" class="form-label">Bachiller</label>
        <input type="text" name="bachillerEst" class="form-control" placeholder="Informática, Ciencias o Humanidades" id="bachiller" aria-describedby="textHelp">
      </div>
      <div class="mb-3 w-25 col-sm-5">
        <label for="gpa" class="form-label">Promedio Escolar</label>
        <input type="number" name="gpaEst" step="0.01" class="form-control" id="gpa" aria-describedby="numberHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="numeroTelefono" class="form-label">Número de Teléfono</label>
        <input type="text" name="numeroTelEst" class="form-control" placeholder="6666-6666" id="numeroTelefono" aria-describedby="textHelp">
      </div>
      <div class="mb-3">
        <select class="form-select w-25 p-2" aria-label="Default select example" name="generoEst">
          <option selected>Seleccione Su Género</option>
          <option value="M">M</option>
          <option value="F">F</option>
        </select>
      </div>
      <div class="mb-3 col-sm-3">
        <label for="provincia" class="form-label">Provincia</label>
        <input type="text" name="provinciaEst" class="form-control" id="provincia" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="distrito" class="form-label">Distrito</label>
        <input type="text" name="distritoEst" class="form-control" id="distrito" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="ncalle" class="form-label">Número de Calle</label>
        <input type="number" name="numeroCalleEst" class="form-control" id="ncalle" aria-describedby="numberHelp">
      </div>
      <div class="mb-3">
        <select class="form-select w-25 p-2" aria-label="Default select example" name="idcolegioEst">
          <option selected>Seleccione Su Colegio</option>
          <option value="COL1">CTG</option>
          <option value="COL2">PPS</option>
          <option value="COL3">MCO</option>
          <option value="COL4">IPTCH</option>
          <option value="COL5">IPTC</option>
          <option value="COL6">IESJ</option>
        </select>
      </div>
      <div class="col-12">
        <button type="submit" class="btn btn-primary" name="enviarEst">Enviar</button> 
    
        <a href="message.php" class="btn btn-primary mx-3">Volver
        </a>
      </div>
    </form> 
  </div>
  <?php
    if (isset($_POST['enviarEst'])) {
      $id = $_POST['idEst'];
      $cedula = $_POST['cedulaEst'];
      $nombre = $_POST['nombreEst'];
      $apellido = $_POST['apellidoEst'];
      $edad = $_POST['edadEst'];
      // Fecha Nacimiento
      $f_nacimiento = $_POST['fnacimientoEst'];
      $fechaObjeto = date_create($f_nacimiento);
      $nacimiento = $fechaObjeto->format('Y-m-d');
      //
      $bachiller = $_POST['bachillerEst'];
      $n_telefono = $_POST['numeroTelEst'];
      $genero = $_POST['generoEst'];
      $gpa = $_POST['gpaEst'];
      $provincia = $_POST['provinciaEst'];
      $distrito = $_POST['distritoEst'];
      $n_calle = $_POST['numeroCalleEst'];
      $id_colegio = $_POST['idcolegioEst'];

      $insertarEst = "INSERT INTO estudiantes (idestudiantes, cedulae, nombre, apellido, edad, nacimiento, bachiller, numeroEs, genero, gpa, sectorEs, direccionEs, calleEs, idcolegios) VALUES('$id','$cedula','$nombre','$apellido',$edad,'$nacimiento','$bachiller','$n_telefono','$genero',$gpa,'$provincia','$distrito','$n_calle','$id_colegio')";

      $ejecutarEst = sqlsrv_query($con, $insertarEst);

      if ($ejecutarEst) {
        echo "<h3>Registro Exitoso</h3>";
      }
    }
  ?>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
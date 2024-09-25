<!DOCTYPE html>
<?php
  include("conexion.php");
?>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registro Tutor</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>
<body>
<div class="container-lg">
    <form class="row mx-auto p-5" method="POST" action="tutor.php">
      <h1>Tutor</h1>
      <div class="mb-3 col-auto">
        <label for="id" class="form-label">ID Tutor</label>
        <input type="text" name="idtutor" class="form-control" placeholder="Ej. TUTOR1" id="id" aria-describedby="textHelp" autocomplete="off">
      </div>
      <div class="mb-3 w-25 col-sm-6">
        <label for="nombre" class="form-label">Nombre</label>
        <input type="text" name="nombreTutor" class="form-control" id="nombre" aria-describedby="textHelp">
      </div>
      <div class="mb-3 w-25 col-sm-6">
        <label for="apellido" class="form-label">Apellido</label>
        <input type="text" name="apellidoTutor" class="form-control" id="apellido" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-auto">
        <label for="cedula" class="form-label">Cédula</label>
        <input type="text" name="cedulaTutor" class="form-control" placeholder="X-XXX-XXXX" id="cedula" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="numeroTelefono" class="form-label">Número de Teléfono</label>
        <input type="text" name="numeroTelTutor" class="form-control" placeholder="6666-6666" id="numeroTelefono" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="email" class="form-label">Correo Electrónico</label>
        <input type="email" name="emailTutor" class="form-control" id="email" aria-describedby="textHelp">
      </div>
      <div class="mb-3">
        <select class="form-select w-25 p-2" aria-label="Default select example" name="idpatrocinadores">
          <option selected>Seleccione el Patrocinador</option>
          <option value="PATRO1">Super 99</option>
          <option value="PATRO2">El Costo</option>
          <option value="PATRO3">Felipe Motta</option>
          <option value="PATRO4">Ricardo Perez S.A</option>
          <option value="PATRO5">Supermercados Rey</option>
          <option value="PATRO6">Samsung</option>
        </select>
      </div>
      <div class="col-12">
        <a>
         <button type="submit" class="btn btn-primary" name="enviarTutor">Enviar</button>
        </a>
      
        <a href="message.php" class="btn btn-primary mx-3">
          Volver
        </a>
      </div>
    </form>
  </div>

  <?php
  if (isset($_POST['enviarTutor'])) {
    $idtutor = $_POST['idtutor'];
    $nombretutor = $_POST['nombreTutor'];
    $apellidotutor = $_POST['apellidoTutor'];
    $cedulatutor = $_POST['cedulaTutor'];
    $ntelefonotutor = $_POST['numeroTelTutor'];
    $emailtutor = $_POST['emailTutor'];
    $idpatro = $_POST['idpatrocinadores'];

    $insertarTutor = "INSERT INTO Tutor (idtutor, nombre, apellido, cedulaTutor, numeroTutor, correoTutor, idpatrocinadores)
    VALUES ('$idtutor','$nombretutor','$apellidotutor','$cedulatutor','$ntelefonotutor','$emailtutor', '$idpatro')";

    $ejecutarTutor = sqlsrv_query($con, $insertarTutor);

    if ($ejecutarTutor) {
      echo "<h3>Registro Exitoso</h3>";
    }
  }
  ?>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
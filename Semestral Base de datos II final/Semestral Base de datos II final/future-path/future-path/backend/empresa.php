<!DOCTYPE html>
<?php
  include("conexion.php");
?>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registro Empresa</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>
<body>
<div class="container-lg">
    <form class="row mx-auto p-5" method="POST" action="empresa.php">
      <h1>Patrocinio</h1>
      <div class="mb-3 col-auto">
        <label for="id" class="form-label">ID Patrocinador</label>
        <input type="text" name="idPatro" class="form-control" placeholder="Ej. PATRO1" id="id" aria-describedby="textHelp" autocomplete="off">
      </div>
      <div class="mb-3 col-auto">
        <label for="cedula" class="form-label">RUC</label>
        <input type="text" name="rucPatro" class="form-control" id="ruc" aria-describedby="textHelp">
      </div>
      <div class="mb-3 w-25 col-sm-6">
        <label for="nombre" class="form-label">Nombre</label>
        <input type="text" name="nombrePatro" class="form-control" id="nombre" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="provincia" class="form-label">Provincia</label>
        <input type="text" name="provinciaPatro" class="form-control" id="provincia" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="distrito" class="form-label">Distrito</label>
        <input type="text" name="distritoPatro" class="form-control" id="distrito" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="ncalle" class="form-label">Número de Calle</label>
        <input type="text" name="numeroCallePatro" class="form-control" id="ncalle" aria-describedby="numberHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="numeroTelefono" class="form-label">Número de Teléfono</label>
        <input type="text" name="numeroTelPatro" class="form-control" placeholder="222-2222" id="numeroTelefono" aria-describedby="textHelp">
      </div>
      <div class="mb-3 col-sm-3">
        <label for="email" class="form-label">Correo Electrónico</label>
        <input type="email" name="emailPatro" class="form-control" id="email" aria-describedby="textHelp">
      </div>
      <div class="col-12">
        <a>
         <button type="submit" class="btn btn-primary" name="enviarPatro">Enviar</button>
        </a>
      
        <a href="message.php" class="btn btn-primary mx-3">
          Volver
        </a>
      </div>
    </form>
  </div>

  <?php
  if (isset($_POST['enviarPatro'])) {
    $idpatrocinio = $_POST['idPatro'];
    $ruc = $_POST['rucPatro'];
    $nombrepatro = $_POST['nombrePatro'];
    $provinciapatro = $_POST['provinciaPatro'];
    $distritopatro = $_POST['distritoPatro'];
    $ncallepatro = $_POST['numeroCallePatro'];
    $ntelefonopatro = $_POST['numeroTelPatro'];
    $emailpatro = $_POST['emailPatro'];

    $insertarPatro = "INSERT INTO Patrocinadores (idpatrocinadores, ruc, nombre, sectorPatro, direccionPatro, callePatro, numeroPatro, correoPatro)
    VALUES('$idpatrocinio','$ruc','$nombrepatro','$provinciapatro','$distritopatro','$ncallepatro','$ntelefonopatro','$emailpatro')";

    $ejecutarPatro = sqlsrv_query($con, $insertarPatro);

    if ($ejecutarPatro) {
      echo "<h3>Registro Exitoso</h3>";
    }
  }
  ?>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>
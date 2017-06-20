<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <meta charset="utf-8">
        <title>Info Espectaculo</title>
        <!-- scripts -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <c:url value="/js/jquery-3.2.1.min.js" var="jqueryJS" />
        <c:url value="/js/bootstrap.min.js" var="bootstrapJS" />
        <c:url value="/js/funciones.js" var="funcionesJS" />
       <!-- <script type="text/javascript"   src="https://maps.google.com/maps/api/js?key=AIzaSyBWuPoNiIST3MEBiTTl3fFLs0tuQH1noDQ"></script>-->
         
        <script src="${jqueryJS}"></script>
        <script src="${bootstrapJS}"></script>
        <script src="${funcionesJS}"></script>
        <!-- scripts -->
        <script
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBWuPoNiIST3MEBiTTl3fFLs0tuQH1noDQ">
        </script>
        <script type="text/javascript">
        	
	        $( document ).ready(function() {
	        	cargaInfoEspectaculo();
				});

        </script>
        <!-- styles -->
        <c:url value="/css/bootstrap.css" var="bootstrapCSS" />
	    <link rel="stylesheet" href="${bootstrapCSS}">
		<!-- styles -->
    </head>
    <body>
        <header>
            <div class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container" id="barraNavegador">
              <div class="navbar-header ">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                  <span class="sr-only">Desplegar / Ocultar Menu</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index"><h3>TicketYa!</h3></a>
              </div>
              <!--Inicio de menu-->
              <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                  <li class="active"><a href="index">Inicio<span class="sr-only">(current)</span></a></li>
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">Espectaculos <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="#">Musica</a></li>
                      <li><a href="#">Teatro</a></li>
                      <li><a href="#">Deportes</a></li>
                      <li><a href="#">Infantiles</a></li>
                    </ul>
                  </li>
                  <li><a href="#">Contacto</a></li>
                </ul>
                <form class="navbar-form navbar-left" role="search">
                  <div class="form-group">
                    <input type="text" class="form-control" placeholder="Buscar">
                  </div>
                  <button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-search"></span></button>
                </form>
                <ul class="nav navbar-nav navbar-right">
                  <li><a href="login">Iniciar Sesi�n</a></li>
                  <li><a href="registro">Registrarse</a></li>
                </ul>
              </div>
            </div>
            </div>
        </header>
        <div class="container" id="principalInfo">
            <div class="col-md-12 container" id="barraUbicacion">
                <section class="post "></section>
                  <div class="paginado">
                      <ul class="breadcrumb">
                        <li><a href="index">Inicio</a></li>
                        <li><a id="tipoEspectaculo" href="#"></a></li>
                        <li class="active" id="nomEspectaculo"></li>
                      </ul>
                  </div>
            </div>


            <div class="col-md-7" id=imagenEspectaculo>
                <c:url value="/img/gorillaz.jpeg" var="imgGorillaz" />
                <img src="${imgGorillaz}" class="img-responsive-info" alt="" width="100%" height= "100%">
            </div>

            <div class="col-md-5 responsive nowrap" id=infoEspectaculo  >
                <div class="panel panel-primary" id=panelEspectaculo>
                  <div class="panel-heading">
                    <h3 class="panel-title" id="evento"></h3>
                  </div>
                  <div class="panel-body">
                    <div class="panelEspectaculo" id="panelScroll">
                        <p id="descripcion"></p>
                        <p id="fecha"><b>Fecha:  </b></p>
                        <p id="sala"><b>Lugar:  </b></p>
                        <p id="direccion"><b>Direccion:  </b></p>
                        <p id="localidades"><b>Localidades a la venta:  </b></p>
                   </div>
                    <button class="btn btn-success btn-group-justified" type=" button" id="btnComprar">Comprar</button>
                 </div>

                </div>
            </div>

            <div class="col-md-3 responsive nowrap" >
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Medios de pago</h3>
                    </div>
                    <div class="panel-body" id="mediosPagos" >
                        Oca, Santander y Scotiabank hasta en 3 pagos sin recargo.
                    </div>

                </div>
            </div>
            <div class="col-md-4" >
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Entradas</h3>
                    </div>
                    <div class="panel-body" id="promocion">
                        <p id="sector"><b>Sector: </b> </p>
                        <p id="precioSector"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span> </p>
                        
                    </div>

                </div>
            </div>
            <div class="col-md-5 responsive nowrap" id="mapa" >
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title" id="lugarMapa"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> </h3>
                    </div>
                    <div class="panel-body" id="map">
						<!-- carga el mapa de la ubicacion del lugar -->
                    </div>

                </div>
            </div>

        </div>

        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-xs-6">
                        <p>Proyecto Fin de carrera - Tecn�logo en inform�tica </p>
                        <p>Grupo 6 - Santiago Tabarez, Ver�nica P�rez y Camilo Orquera</p>
                    </div>
                    <div class="col-xs-6">
                        <ul class="list-inline text-right">
                            <li><a href="#">Inicio</a></li>

                        </ul>

                    </div>
                </div>

            </div>
        </footer>
    </body>
</html>

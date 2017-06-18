<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="es">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	    <!-- Scripts -->
		<c:url value="/js/jquery-3.2.1.min.js" var="jqueryJS" />
		<c:url value="/js/jquery.dataTables.min.js" var="datatableJS" />
		<c:url value="/js/bootstrap.min.js" var="bootstrapJS" />
		<c:url value='/fullcalendar/lib/moment.min.js' var="momentJS" />
	    <c:url value='/fullcalendar/fullcalendar.js' var="fullcalendarJS" />
	    <c:url value='/fullcalendar/locale/es.js' var="esJS" />
	    <script src="${jqueryJS}"></script>
	    <script src="${datatableJS}"></script>
	    <script src="${bootstrapJS}"></script>
	    <script src="${momentJS}"></script>
	    <script src="${fullcalendarJS}" charset="utf-8"></script>
	    <script src="${esJS}" charset="utf-8"></script>

	    <script type="text/javascript">
		    $(document).ready(function() {
			    // inicia el calendario
			    $('#calendar').fullCalendar({
			    })
		    });
	    </script>
	    <script type="text/javascript">
		    $(document).ready( function () {
		        var table= $('#espectaculo').dataTable( {
		            "ajax": {
		                       "url": '/obtenerEspectaculos/',
		                       "dataType": 'json',
		                       "dataSrc": "",
		                       "type": "GET",
		                       "beforeSend": function(xhr){
		                               var pathname = window.location.pathname;
		                               xhr.setRequestHeader("X-TenantID", pathname.split('/')[1]);
		                       }
		            },
		            "columns" :  [
		                            { "data": "id"},
		                            { "data": "nombre" },
		                            { "data": "descripcion" },
		                            { "data": "idTipoEspectaculo" }
		                        ]
		        });
		    });
	    </script>
		<!-- Scripts -->

		<!-- Styles -->
	    <c:url value="/css/bootstrap.css" var="bootstrapCSS" />
	    <c:url value="/fullcalendar/fullcalendar.css" var="fullCalendarCSS" />
	    <link rel="stylesheet" href="${bootstrapCSS}">
	    <link rel="stylesheet" href="${fullCalendarCSS}">
	    <!-- Styles -->

	    <title>Inicio</title>
	</head>

	<body>
		<header>
			<div class="navbar navbar-default navbar-fixed-top" role="navigation">
				<div class="container"  id="barraNavegador">
					<div class="navbar-header">
					    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
							<span class="sr-only">Desplegar / Ocultar Menu</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
					    </button>

				    	<a class="navbar-brand" href="#"><h3>TicketYa!</h3></a>
				    </div>

				    <!--Inicio de menu-->
			        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		        	    <ul class="nav navbar-nav">
				            <li class="active"><a href="#">Inicio<span class="sr-only">(current)</span></a></li>

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
    			            <li><a href="register">Registrarse</a></li>
    			        </ul>
			        </div>
                </div>
			</div>
	    </header>

	    <div class="container" id="principal">
		    <!--Carrousel-->
	        <div class="col-md-9">
	            <div id="carousel_index" class="carousel slide" data-ride="carousel">
	                <!--Indicador-->
	                <ol class="carousel-indicators">
	                      <li data-target="#carousel_index" data-slide-to="0" class="active"></li>
	                      <li data-target="#carousel_index" data-slide-to="1"></li>
	                      <li data-target="#carousel_index" data-slide-to="2"></li>
	                </ol>

	                <!--Contenedor del slide-->
	                <div class="carousel-inner" role="listbox">
	                    <div class="item active">
							<c:url value="/img/gorillaz.jpeg" var="imgGorillaz" />
	                        <img src="${imgGorillaz}" class="img-responsive" alt="" width="100%" >
	                        <div class="carousel-caption hidden-xs hidden-sm">
	                            <div class="banner">
	                                <h3>GORILLAZ en Uruguay</h3>
	                                <p>Primavera 0</p>
	                            </div>
	                        </div>
	                    </div>

	                    <div class="item">
							<c:url value="/img/calamaro.jpg" var="imgCalamaro" />
	                        <img src="${imgCalamaro}" class="img-responsive" alt="" width="100%" >
	                        <div class="carousel-caption hidden-xs hidden-sm">
	                            <div class="banner">
	                                <h3>Calamaro</h3>
	                                <p>Auditorio del Sodre</p>
	                            </div>
	                        </div>
	                    </div>

	                    <div class="item">
							<c:url value="/img/midachi.jpg" var="imgMidachi" />
	                        <img src="${imgMidachi}" class="img-responsive" alt="" width="100%"  >
	                        <div class="carousel-caption hidden-xs hidden-sm">
	                            <div class="banner">
	                                <h3>MIDACHI</h3>
	                                <p>Agosto en Landia</p>
	                            </div>
	                        </div>
	                    </div>
	                </div>
					
	                <!--Controles-->
	                <a href="#carousel_index" class="left carousel-control" role="button" data-slide="prev">
	                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	                    <span class="sr-only">Anterior</span>
	                </a>

	                <a href="#carousel_index" class="right carousel-control" role="button" data-slide="next">
	                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	                    <span class="sr-only">Siguiente</span>
	                </a>
	            </div>
	        </div>

			<!--Calendario-->
	        <div class="col-md-3 hidden-xs hidden-sm">
	            <div class="panel panel-success" id="calendario">
	                <div class="panel-heading">
	                    <h3 class="panel-title">Calendario</h3>
	                </div>

	                <div class="panel-body" id="calendario-body">
	                    <div id='calendar'></div>
	                </div>
	            </div>
	        </div>

	        <!--Lista de espectaculos-->
	        <div class="col-md-9" id="listaEspectaculos">
	            <div class="panel panel-primary" >
	              <div class="panel-heading">
	                   <h3 class="panel-title">Espectaculos</h3>
	                 </div>

	                 <div class="panel-body">
	                     <div class="table-responsive">
	                         <table class="table table-striped table-hover" id="espectaculo">
	                            <thead>
	                                <tr class="success">
	                                	<th>id</th>
                                    	<th>Evento</th>
	                                    <th>Descripci�n</th>
	                                    <th>Tipo de espectaculo</th>
	                                </tr>
	                            </thead>

	                            <tbody>
	                             
	                            </tbody>
	                        </table>
	                     </div>

						<!--Paginacion-->
	                    <ul class="pagination pagination-sm">
							<li class="disabled"><a href="#">&laquo;</a></li>
							<li class="active"><a href="#">1</a></li>
							<li><a href="#">&raquo;</a></li>
	                    </ul>
	                </div>
	            </div>
	        </div>

	        <!--Informacion-->
	        <div class="col-md-3 hidden-xs hidden-sm" id="informacion">
	            <div class="panel panel-info" >
	              <div class="panel-heading">
	                <h3 class="panel-title">Informaci�n</h3>
	              </div>
				  
	              <div class="panel-body">
	                Para poder comprar entradas a los eventos, previamente debe estar registrado
	              </div>
	            </div>
	        </div>
    	</div>

	    <!-- Pie de pagina -->
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

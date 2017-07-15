<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="es">
<head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
    	<title>Inicio</title>

	    <!-- scripts -->
        <c:url value="/js/jquery-3.2.1.min.js" var="jqueryJS" />
        <c:url value="/js/bootstrap.min.js" var="bootstrapJS" />
        <c:url value="/js/funcionesAdmin.js" var="funcionesAdminJS" />
        <c:url value="/js/jquery.dataTables.js" var="datatableJS" />
        <script src="${jqueryJS}"></script>
        <script src="${bootstrapJS}"></script>
        <script src="${funcionesAdminJS}"></script>
        <script src="${datatableJS}"></script>
        <!-- scripts -->
        <!-- estilos -->
		<c:url value="/css/bootstrap.css" var="bootstrapCSS" />
	    <link rel="stylesheet" href="${bootstrapCSS}">
	    <c:url value="/css/admin.css" var="adminCSS" />
	    <link rel="stylesheet" href="${adminCSS}">
	    <!-- estilos -->
        <script type="text/javascript">

	    		$( document ).ready(function() {
	    			sidebarAdmin();
                    activeSidebar();
	    			});

	    </script>

</head>

<body>
    <header>
        <div class="navbar navbar-default sidebar" role="navigation" id="headerAdmin">
        <div id="sidebarAdmin">
          <div class="navbar-header ">
            <a class="navbar-brand" href="#" id="nombreTenant"><h3>TicketYa!</h3></a>
          </div>
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
              <li class="active"><a href="#">Panel del administrador<span class="sr-only">(current)</span></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li><a href="login.html">Iniciar Sesi�n</a></li>
              <li><a href="registro.html">Registrarse</a></li>
              <!-- <a id="btnLogout" class="btn btn-link" title="Salir"><span class="glyphicon glyphicon-log-out"></span></a> -->
            </ul>
          </div>
        </div>
        </div>
    </header>

        <nav class="navbar navbar-default sidebar" role="navigation" id="sidebarAdmin">
          <div class="container-fluid">
            <div class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
              <ul class="nav navbar-nav sideAdmin">
                <li class="active"><a id="inicio" href="#">Inicio<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-home"></span></a></li>
                <li class="dropdown">
                  <a id="usuarios" href="#" class="dropdown-toggle" data-toggle="dropdown">Usuarios <span class="caret"></span><span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></span></a>
                  <ul class="dropdown-menu forAnimate" role="menu">
                    <li><a id="portero" href="#">Portero</a></li>
                  </ul>
                </li>
                <li ><a id="espectaculos" onclick="cargaDatatableEspectaculo();" href="#">Espectaculos<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-star"></span></a></li>
                <li ><a id="salas" onclick="cargaDatatableSalas();" href="#">Salas<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-home"></span></a></li>
                <li ><a id="realizaciones" href="#">Realizaciones<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-tags"></span></a></li>
                <li ><a id="reportes" href="#">Reportes<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-stats"></span></a></li>
              </ul>
            </div>
          </div>
        </nav>

    <div class="container" id="dashboard">
        <div id="panelIndex" class="col-md-12" >
        	<div class="panel panel-success" id="panelContenedor">
    			  <div class="panel-heading">Panel heading</div>
    			  <div class="panel-body" id="panelAdmin">
	    			  <p>Probando probanproabn</p>
	    			  <p>Probando probanproabn</p>
	    			  <p>Probando probanproabn</p>
	    			  <p>Probando probanproabn</p>
	    			  <p>Probando probanproabn</p>
	    			  <p>Probando probanproabn</p>
	    			  <p>Probando probanproabn</p>
	    			  Panel content
	    			    Guia
	    			    <a href=#> lalalalallllalalalalal</a>
	    			    <p>Probando probanproabn</p>
    			  </div>
    		</div>

        </div>
        
        <div id="divPortero"  style="display:none;">
            <div class="col-md-12" >
                <ul class="breadcrumb">
                  <li><a href="#">Inicio</a></li>
                  <li>Usuarios</li>
                  <li class="active">Portero</li>
                </ul>
            </div>
            <!-----------Portero---------------->
            <div class="col-md-12" id="datatable">
                <div class="table-responsive">
                    <table class="table table-striped table-hover ">
                        <thead>
                             <tr class="success">
                                 <th>Fecha</th>
                                 <th>Evento</th>
                                 <th>Lugar</th>
                             </tr>
                        </thead>
                    </table>
                </div>

            </div>
        </div>
        <div id="divEspectaculos" style="display:none;">
            <div class="col-md-12" >
                <ul class="breadcrumb">
                  <li><a href="#">Inicio</a></li>
                  <li class="active">Espectaculos</li>
                </ul>
            </div>
            <!---------Espectaculos--------->
            <div class="col-md-12" id="datatable">
                <div class="table-responsive">
                    <table id="tablaEspectaculo" class="table table-striped table-hover ">
	                       <thead>
	                           <tr class="success"> 
	                             <th>Id</th>  
	      	                     <th>Nombre</th>
	      	                     <th>Descripcion</th>
	                             <th>Tipo Espectaculo</th>
	                           </tr>
	                       </thead>
	
	                       <tbody>
	                        
	                       </tbody>
	                 </table>
                </div>

            </div>
        </div>
        <div id="divSalas" style="display:none;">
            <div class="col-md-12" >
                <ul class="breadcrumb">
                  <li><a href="#">Inicio</a></li>
                  <li class="active">Salas</li>
                </ul>
            </div>
            <!---------Salas------->
            <div class="col-md-12" id="datatable">
                <div class="table-responsive">
                    <table id="tablaSala" class="table table-striped table-hover ">
                        <thead>
                             <tr class="success">
                             	 <th>id</th>
                                 <th>Nombre</th>
                                 <th>Direccion</th>
                                 <th>Cantidad de localidaddes</th>
                             </tr>
                        </thead>
                    </table>
                </div>

            </div>
        </div>
        <div id="divRealizaciones" style="display:none;">
            <div class="col-md-12" >
                <ul class="breadcrumb">
                  <li><a href="#">Inicio</a></li>
                  <li class="active">Realizaciones</li>
                </ul>
            </div>
            <!--------Realizaciones---------->
            <div class="col-md-12" id="datatable">
                <div class="table-responsive">
                    <table class="table table-striped table-hover ">
                        <thead>
                             <tr class="success">
                                 <th>Fecha</th>
                                 <th>idEspectaculo</th>
                                 <th>Sala</th>
                             </tr>
                        </thead>
                    </table>
                </div>

            </div>
        </div>
        <div id="divReportes" style="display:none;">
            <div class="col-md-12" >
                <ul class="breadcrumb">
                  <li><a href="#">Inicio</a></li>
                  <li class="active">Reportes</li>
                </ul>
            </div>
            <!-------------Reportes----------->
            <div class="col-md-12" id="datatable">
                <div class="table-responsive">
                    <table class="table table-striped table-hover ">
                        <thead>
                             <tr class="success">
                                 <th>Cantidad de entradas</th>
                                 <th>Evento</th>
                                 <th>Recaudado</th>
                             </tr>
                        </thead>
                    </table>
                </div>

            </div>
        </div>
    </div>


    <footer>
        <nav class="navbar navbar-default " id="footerNav">
            <div  id="footer">
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <a id="aFotter" href="#"><h4 id="h4Fotter">TicketYa!</h4></a>
                    </li>


                </ul>
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <p id="pFooter">Proyecto Fin de carrera - Tecn�logo en inform�tica</p>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><p id="pFooter">Santiago Tab�rez, Ver�nica P�rez y Camilo Orquera</p></li>
                </ul>
            </div>
        </nav>
    </footer>



</body>

</html>


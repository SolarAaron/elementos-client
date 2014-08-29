<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@taglib prefix="slr" tagdir="/WEB-INF/tags/" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Proyecto punto de venta</title>
        <c:choose>
            <c:when test="${((empty param.theme) ? '' : param.theme) == 'default'}">
                <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile-1.4.3.css" />
            </c:when>
            <c:when test="${!empty param.theme}">
                <link rel="stylesheet" href="css/themes/${param.theme}.css" />
                <link rel="stylesheet" href="css/themes/jquery.mobile.icons.min.css" />
                <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile.structure-1.4.3.css" />
            </c:when>
            <c:otherwise>
                <link rel="stylesheet" href="css/themes/slr-g.css" />
                <link rel="stylesheet" href="css/themes/jquery.mobile.icons.min.css" />
                <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile.structure-1.4.3.css" />
            </c:otherwise>
        </c:choose>
        <script src="js/misc.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.1.js"></script>
        <script src="http://code.jquery.com/mobile/1.4.3/jquery.mobile-1.4.3.js"></script>
        <script>
            function empleado_pagar(i){
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8095/mvn-web-spr/util/nominas/" + i,
                    success: function(data){
                        $("#empleado-status").html("<br>" + data.object).trigger("create");
                        empleado_load();
                    }
                });
            }
            ;

            function empleado_borrar(i){
                $.ajax({
                    type: "DELETE",
                    url: "http://localhost:8095/mvn-web-spr/util/empleados/" + i,
                    success: function(data){
                        $("#empleado-status").html("<br>" + data.object).trigger("create");
                        empleado_load();
                    }
                });
            }
            ;

            function producto_borrar(i){
                $.ajax({
                    type: "DELETE",
                    url: "http://localhost:8095/mvn-web-spr/util/productos/" + i,
                    success: function(data){
                        $("#producto-status").html("<br>" + data.object).trigger("create");
                        producto_load();
                    }
                });
            }
            ;

            function cliente_borrar(i){
                $.ajax({
                    type: "DELETE",
                    url: "http://localhost:8095/mvn-web-spr/util/clientes/" + i,
                    success: function(data){
                        $("#cliente-status").html("<br>" + data.object).trigger("create");
                        cliente_load();
                    }
                });
            }
            ;

            <slr:autoscript base="empleado" ldattribs="nombre,salario,nomina.saldo" restsvc='"http://localhost:8095/mvn-web-spr/util/empleados"' pagar="Pagar:idE" borrar="Eliminar:idE" datavars="password" pathvars="nombre,salario" actioncolumn="${true}" />
            <slr:autoscript base="producto" ldattribs="codP,descripcion,precio" restsvc='"http://localhost:8095/mvn-web-spr/util/productos"' borrar="Borrar:codP" datavars="descripcion" pathvars="codigo,precio" actioncolumn="${true}" />
            <slr:autoscript base="cliente" ldattribs="nombre" restsvc='"http://localhost:8095/mvn-web-spr/util/clientes"' borrar="Borrar:clientePK.idC" datavars="nombre,password" pathvars="nomUsuario" actioncolumn="${true}"/>
            <slr:autoscript base="venta" ldattribs="idV,idE.nombre,idC.nombre,fecha:toDate" restsvc='"http://localhost:8095/mvn-web-spr/util/ventas"' datavars="idE,idC" pathvars="" actioncolumn="${false}" listinputs="idE;idE;nombre;http://localhost:8095/mvn-web-spr/util/empleados,idC;clientePK.idC;nombre;http://localhost:8095/mvn-web-spr/util/clientes"/>

            $(document).ready(function(){
                $(".slrmenu").html(<slr:mkmenu c-productos="Productos" b-inicio="Inicio" d-nomina="Nomina" a-cliente="Clientes" e-venta="Ventas" />).trigger("create");
                $(document).on("pagebeforechange", function(e, data){
                    empleado_load();
                    empleado_fill()
                    producto_load();
                    producto_fill();
                    cliente_load();
                    cliente_fill();
                    venta_load();
                    venta_fill();
                });
            }); //ready
        </script>
    </head>
    <body>
        <slr:jqbody ID="b-inicio" header_text="Inicio" data-transition="slide" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            Inicio
        </slr:jqbody>
        <slr:jqbody ID="d-nomina" header_text="Nomina" data-transition="slide" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            <slr:autoform base="empleado" inputs="Nombre:nombre:text,Salario:salario:number,Password:password:password" label="empleados" tblheaders="Nombre,Salario,Estado de cuenta" title="Empleados" actioncolumn="${true}" />
        </slr:jqbody>
        <slr:jqbody ID="c-productos" header_text="Productos" data-transition="slide" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            <slr:autoform base="producto" inputs="Codigo:codigo:text,Descripcion:descripcion:text,Precio:precio:number" label="producto" tblheaders="Codigo,Descripcion,Precio" title="Productos" actioncolumn="${true}" />
        </slr:jqbody>
        <slr:jqbody ID="a-cliente" header_text="Clientes" data-transition="slide" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            <slr:autoform base="cliente" inputs="Nombre de usuario:nomUsuario:text,Nombre:nombre:text,Password:password:password" label="cliente" tblheaders="Cliente" title="Clientes" actioncolumn="${true}" />
        </slr:jqbody>
        <slr:jqbody ID="e-venta" header_text="Ventas" data-transition="slide" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            <slr:autoform base="venta" inputs="Empleado:idE:list,Cliente:idC:list" label="Venta" tblheaders="Folio,Empleado,Cliente,Fecha" title="Ventas" actioncolumn="${false}" />
        </slr:jqbody>
    </body>
</html>

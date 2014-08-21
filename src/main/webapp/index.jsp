<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@taglib prefix="slr" tagdir="/WEB-INF/tags/" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Proyecto punto de venta</title>
        <link rel="stylesheet" href="css/themes/slr-x.css" />
        <link rel="stylesheet" href="css/themes/jquery.mobile.icons.min.css" />
        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile.structure-1.4.3.css" />
        <script src="http://code.jquery.com/jquery-1.11.1.js"></script>
        <script src="http://code.jquery.com/mobile/1.4.3/jquery.mobile-1.4.3.js"></script>
        <script>
            function empleado_pagar(i){
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8095/mvn-web-spr/util/nominas/" + i,
                    success: function(data){
                        $("#empleado-status").html("<br>" + data.object).trigger("create");
                        $("#empleado-load").click();
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
                        $("#producto-load").click();
                    }
                });
            }
            ;

            <slr:autoscript base="empleado" ldattribs="nombre,salario,nomina.saldo" restsvc='"http://localhost:8095/mvn-web-spr/util/empleados"' pagar="Pagar:idE" datavars="password" pathvars="nombre,salario" />
            <slr:autoscript base="producto" ldattribs="codP,descripcion,precio" restsvc='"http://localhost:8095/mvn-web-spr/util/productos"' borrar="Borrar:codP" datavars="descripcion" pathvars="codigo,precio" />

            $(document).ready(function(){
                $(".slrmenu").html(<slr:mkmenu c-productos="Productos" b-inicio="Inicio" d-nomina="Nomina" />).trigger("create");
                $("#empleado-load").click();
                $("#producto-load").click();
            }); //ready
        </script>
    </head>
    <body>
        <slr:jqbody ID="b-inicio" header_text="Prueba" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            Inicio
        </slr:jqbody>
        <slr:jqbody ID="d-nomina" header_text="Nomina" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            <slr:autoform base="empleado" inputs="Nombre:nombre:text,Salario:salario:number,Password:password:password" label="empleados" tblheaders="Nombre,Salario,Estado de cuenta" title="Empleados" />
        </slr:jqbody>
        <slr:jqbody ID="c-productos" header_text="Productos" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            <slr:autoform base="producto" inputs="Codigo:codigo:text,Descripcion:descripcion:text,Precio:precio:number" label="producto" tblheaders="Codigo,Descripcion,Precio" title="Insertar productos" />
        </slr:jqbody>
    </body>
</html>

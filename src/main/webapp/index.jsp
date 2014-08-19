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
            function emp_upd(i){
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

            function empleado_load(){
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8095/mvn-web-spr/util/empleados",
                    data: {
                    },
                    success: function(data, textStatus, jqXHR){
                        $("#empleado-response").html("");
                        for(i = 0; i < data.object.length; i++){
                            $("#empleado-response").html($("#empleado-response").html() + "<tr><td>" +
                                data.object[i].nombre + "</td><td>" +
                                data.object[i].salario + "</td><td>" +
                                (data.object[i].nomina ? (data.object[i].nomina.saldo) : "aun no pagado") + "</td><td>" +
                                ' <input type="button" value="pagar" id="usr' + data.object[i].idE + '" data-inline="true" onclick="emp_upd(' + data.object[i].idE + ')"/>' + "</td></tr>"
                                );
                        }
                        var tmp = $("#empleado-response").html();
                        $("#empleado-response").html(tmp).trigger("create");
                    }
                }); //ajax
            }

            function empleado_insert(){
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8095/mvn-web-spr/util/empleados/" + $("#empleado-nombre").val() + "/" + $("#empleado-salario").val(),
                    data: {
                        password: $("#empleado-password").val()
                    },
                    success: function(dta){
                        $("#empleado-status").html(dta.object).trigger("create");
                        $("#empleado-load").click();
                    }
                }); //ajax
            }

            $(document).ready(function(){
                $(".slrmenu").html(<slr:mkmenu c-productos="Productos" b-inicio="Inicio" d-nomina="Nomina" />).trigger("create");
                $("#empleado-load").click();
            }); //ready
        </script>
    </head>
    <body>
        <slr:jqbody ID="b-inicio" header_text="Prueba" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            Inicio
        </slr:jqbody>
        <slr:jqbody ID="d-nomina" header_text="Nomina" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            <slr:autoform base="empleado" inputs="Nombre:nombre:text,Salario:salario:number,Password:password:password" label="empleados" tblheaders="Nombre,Salario,Estado de cuenta,Acciones" title="Empleados" />
        </slr:jqbody>
        <slr:jqbody ID="c-productos" header_text="Productos" class="ui-alt-icon ui-responsive-panel" defpage="b-inicio">
            <slr:autoform base="producto" inputs="Codigo:codigo:text,Descripcion:descripcion:text,Precio:precio:number" label="producto" tblheaders="Codigo,Descripcion,Precio,Acciones" title="Insertar productos" />
        </slr:jqbody>
    </body>
</html>

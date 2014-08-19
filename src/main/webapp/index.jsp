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
                        $("#nom-ins").html("<br>" + data.object).trigger("create");
                        $("#nom-ld").click();
                    }
                });
            }
            ;

            $(document).ready(function(){
                $("#nom-ld").click(function(){
                    $.ajax({
                        type: "GET",
                        url: "http://localhost:8095/mvn-web-spr/util/empleados",
                        data: {
                        },
                        success: function(data, textStatus, jqXHR){
                            $("#nom-ld-resp").html("");
                            for(i = 0; i < data.object.length; i++){
                                $("#nom-ld-resp").html($("#nom-ld-resp").html() + "<tr><td>" +
                                    data.object[i].nombre + "</td><td>" +
                                    data.object[i].salario + "</td><td>" +
                                    (data.object[i].nomina ? (data.object[i].nomina.saldo) : "aun no pagado") + "</td><td>" +
                                    ' <input type="button" value="pagar" id="usr' + data.object[i].idE + '" data-inline="true" onclick="emp_upd(' + data.object[i].idE + ')"/>' + "</td></tr>"
                                    );
                            }
                            var tmp = $("#nom-ld-resp").html();
                            $("#nom-ld-resp").html(tmp).trigger("create");
                        }
                    }); //ajax
                }); //click
                $("#emp-ins").click(function(){
                    $.ajax({
                        type: "POST",
                        url: "http://localhost:8095/mvn-web-spr/util/empleados/" + $("#emp-nm").val() + "/" + $("#emp-py").val(),
                        data: {
                            password: $("#emp-pwd").val()
                        },
                        success: function(dta){
                            $("#nom-ins").html(dta.object).trigger("create");
                            $("#nom-ld").click();
                        }
                    }); //ajax
                }); //click
                $(".slrmenu").html(<slr:mkmenu c-productos="Productos" b-inicio="Inicio" d-nomina="Nomina" />).trigger("create");
                $("#nom-ld").click();
            }); //ready
        </script>
    </head>
    <body>
        <slr:jqbody ID="b-inicio" header_text="Prueba" class="ui-alt-icon" defpage="main-page">
            Inicio
        </slr:jqbody>
        <slr:jqbody ID="d-nomina" header_text="Nomina" class="ui-alt-icon" defpage="main-page">
            <form>
                <table>
                    <tr rowspan="2">
                        <td colspan="2" align="center">
                            Insertar empleados
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <div id="nom-ins"></div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Nombre:
                        </td>
                        <td>
                            <input id="emp-nm" data-inline="true" type="text" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Salario:
                        </td>
                        <td>
                            <input id="emp-py" data-inline="true" type="number" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Password:
                        </td>
                        <td>
                            <input id="emp-pwd" data-inline="true" type="password" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="button" id="nom-ld" value="Mostrar empleados" data-theme="b" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="button" value="Insertar" id="emp-ins" data-theme="c" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <table width="100%">
                                <thead class="ui-body-b ui-corner-all" align="center">
                                    <tr>
                                        <td>
                                            Nombre
                                        </td>
                                        <td>
                                            Salario
                                        </td>
                                        <td>
                                            Estado de cuenta
                                        </td>
                                        <td>
                                            Acciones
                                        </td>
                                    </tr>
                                </thead>
                                <tbody id="nom-ld-resp" align="center"></tbody>
                            </table>
                        </td>
                    </tr>
                </table>
            </form>
        </slr:jqbody>
        <slr:jqbody ID="c-productos" header_text="Productos" class="ui-alt-icon" defpage="main-page">
            <form>
                
            </form>
        </slr:jqbody>
    </body>
</html>

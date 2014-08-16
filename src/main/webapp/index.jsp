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
            function clfunc(i){
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8095/mvn-web-spr/util/nominas/" + i,
                    success: function(data){
                        $("#pagos").html("<br>" + data.object);
                        $("#slrmsg").click();
                    }
                });
            }
            ;

            $(document).ready(function(){
                $("#slrmsg").click(function(){
                    $.ajax({
                        type: "GET",
                        url: "http://localhost:8095/mvn-web-spr/util/empleados",
                        data: {
                        },
                        success: function(data, textStatus, jqXHR){
                            $("#resp").html("");
                            for(i = 0; i < data.object.length; i++){
                                $("#resp").html($("#resp").html() + "<li>" + data.object[i].idE +
                                    "-- nombre: " + data.object[i].nombre + ", salario: " +
                                    data.object[i].salario +
                                    (data.object[i].nomina ? (", en cuenta: " + data.object[i].nomina.saldo) : ", aun no pagado ") +
                                    ' <input type="button" value="pagar" id="usr' +
                                    data.object[i].idE +
                                    '" class="btn btn-lg btn-default" onclick="clfunc(' +
                                    data.object[i].idE + ')"/>' + "</li>");
                            }
                            var tmp = $("#resp").html();
                            $("#resp").html(tmp).trigger("create");
                        }
                    }); //ajax
                }); //click
                $("#submit").click(function(){
                    $.ajax({
                        type: "POST",
                        url: "http://localhost:8095/mvn-web-spr/util/empleados/" + $("#nm").val() + "/" + $("#sl").val(),
                        data: {
                            password: $("#ps").val()
                        },
                        success: function(dta, textStatus, jqXHR){
                            $("#ins").html(dta.object);
                            $("#slrmsg").click();
                        }
                    }); //ajax
                }); //click
                $(".slrmenu").html(
                    '<li><a href="#main-page">Inicio</a></li>' +
                    '<li><a href="#test">Prueba</a></li>'
                    ); // menu
            }); //ready
        </script>
    </head>
    <body>
        <slr:jqbody ID="main-page" header_text="Inicio">
            <h1 id="slrmsg" class="btn btn-lg btn-success">Mostrar empleados</h1>
            <ul id="resp"></ul>
            Insertar:
            <form>
                Nombre: <input id="nm" type="text" /><br>
                Salario: <input id="sl" type="number" /><br>
                Password: <input id="ps" type="password" /><br>
                <input type="button" value="insertar" id="submit" class="btn btn-lg btn-default" />
            </form><br>
            <div id="ins"></div>
            <div id="pagos"></div>
        </slr:jqbody>
        <slr:jqbody ID="test" header_text="Prueba">
            K ase
        </slr:jqbody>
    </body>
</html>

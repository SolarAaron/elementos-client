<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bienvenido</title>
        <script src="/web-client-x/jscript/libs/jquery/jquery.js"></script>
        <link rel="stylesheet" href="/web-client-x/jscript/libs/twitter-bootstrap/css/bootstrap.css">
        <script>
            function clfunc(i){
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8095/mvn-web-spr/util/nomina/" + i,
                    success: function(data){
                        $("#pagos").html("<br>" + data.object);
                        $("#slrmsg").click();
                    }
                });
            };

            $(document).ready(function(){
                $("#slrmsg").click(function(){
                    $.ajax({
                        type: "GET",
                        url: "http://localhost:8095/mvn-web-spr/util/empleados",
                        data: {

                        },
                        success: function (data, textStatus, jqXHR) {
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
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        }
                    }); //ajax
                }); //click
                $("#submit").click(function(){
                    $.ajax({
                        type: "POST",
                        url: "http://localhost:8095/mvn-web-spr/util/empleado/" + $("#nm").val() + "/" + $("#sl").val(),
                        success: function (dta, textStatus, jqXHR) {
                            $("#ins").html(dta.object);
                            $("#slrmsg").click();
                        }
                    }); //ajax
                }); //click
            }); //ready
        </script>
    </head>
    <body>
        <h1 id="slrmsg" class="btn btn-lg btn-success">Mostrar empleados</h1>
        <ul id="resp"></ul>
        Insertar:
        <form>
            Nombre: <input id="nm" type="text"><br>
            Salario: <input id="sl" type="number"><br>
            <input type="button" value="insertar" id="submit" class="btn btn-lg btn-default" />
        </form><br>
        <div id="ins"></div>
        <div id="pagos"></div>
    </body>
</html>

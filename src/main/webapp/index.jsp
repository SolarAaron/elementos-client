<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bienvenido</title>
        <script src="jscript/libs/jquery/jquery.js"></script>
        <link rel="stylesheet" href="jscript/libs/twitter-bootstrap/css/bootstrap.css">
        <script>
            $(document).ready(function(){
                $("#slrmsg").click(function(){
                    $.ajax({
                        type: "GET",
                        url: "http://localhost:8095/mvn-web-spr/util/usuarios",
                        data: {

                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#resp").html("");
                            for(i = 0; i < data.object.length; i++){
                                $("#resp").html($("#resp").html() + "<br><br>" + data.object[i].id + " nombre: " + data.object[i].nombre + ", salario: " + data.object[i].salario);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        }
                    }); //ajax
                }); //click
                $("#submit").click(function(){
                    $.ajax({
                        type: "POST",
                        url: "http://localhost:8095/mvn-web-spr/util/usuario/" + $("#nm").val() + "/" + $("#sl").val(),
                        success: function (data, textStatus, jqXHR) {
                            $("#resp").html($("#resp").html() + "<br>" + data.object);
                        }
                    }); //ajax
                }); //click
            }); //ready
        </script>
    </head>
    <body>
        <h1 id="slrmsg" class="btn btn-lg btn-success">Do click me.</h1>
        <div id="resp"></div>
        Insertar:
        <form>
            Nombre: <input id="nm" type="text"><br>
            Salario: <input id="sl" type="number"><br>
            <input type="button" id="submit" class="btn btn-lg btn-default">
        </form>
    </body>
</html>

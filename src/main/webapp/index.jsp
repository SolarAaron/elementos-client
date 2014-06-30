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
                //alert("Cargando.....");
                $("#slrmsg").click(function(){
                    $("#resp").html($.ajax({
                        type: "GET",
                        url: "http://localhost:8612/mvn-web-spr/util/usuarios/usuario",
                        data: {
                            
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#resp").html("Login: " + data.login + "<br>Admin: " + data.adminRol);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                        
                        }
                    })); //ajax
                }); //click
            }); //ready
        </script>
    </head>
    <body>
        <h1 id="slrmsg" class="btn btn-lg btn-success">Do click me.</h1>
        <div id="resp"></div>
    </body>
</html>

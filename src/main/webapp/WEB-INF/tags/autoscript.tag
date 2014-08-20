<%-- 
    Document   : autoscript
    Created on : 20/08/2014, 01:33:13 PM
    Author     : Aaron Torres <solaraaron@gmail.com>
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="slr" tagdir="/WEB-INF/tags/" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="base" required="true"%>
<%@attribute name="restsvc" required="true" %>
<%@attribute name="ldattribs" required="true" %>

<%-- any content can be specified here e.g.: --%>
<script>
    function ${base}_load(){
        $.ajax({
            type: GET,
            url: ${restsvc},
            success: function(data){
                
            }
        });
    }
</script>
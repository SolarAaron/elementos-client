<%--
    Document   : mkmenu
    Created on : 19/08/2014, 11:26:14 AM
    Author     : Aaron Torres <solaraaron@gmail.com>
--%>

<%@tag description="generates html lists with buttons" dynamic-attributes="items" pageEncoding="UTF-8"%>
<%@taglib prefix="slr" tagdir="/WEB-INF/tags/" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- The list of normal or fragment attributes can be specified here: --%>

<%-- any content can be specified here e.g.: --%>
'' +
<c:forEach items="${items}" var="a">
    '<li><a href="#${a.key}">${a.value}</a></li>' +
</c:forEach>
''
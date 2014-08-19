<%--
    Document   : jqbody
    Created on : 15/08/2014, 05:51:34 PM
    Author     : Aaron Torres
--%>

<%@tag description="generates a jquery-mobile page template" dynamic-attributes="dyn" pageEncoding="UTF-8"%>
<%@taglib prefix="slr" tagdir="/WEB-INF/tags/" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="ID" required="true"%>
<%@attribute name="header_text" required="true"%>
<%@attribute name="defpage" required="true" %>

<%-- any content can be specified here e.g.: --%>
<div data-role="page" id="${ID}" <c:forEach items="${dyn}" var="a"> ${a.key}="${a.value}" </c:forEach> >
    <div data-role="panel" id="${ID}-panel" data-display="overlay">
        <ul class="slrmenu ui-mini">
            <%-- Fill menu in javascript --%>
        </ul>
    </div>
    <div data-role="header" data-position="fixed">
        <a href="#${defpage}" class="ui-btn ui-btn-icon-left ui-icon-home ui-btn-b ui-corner-all ui-shadow ui-mini">Inicio</a>
        <a href="#${ID}-panel" class="ui-btn ui-btn-icon-left ui-icon-action ui-btn-b ui-corner-all ui-shadow ui-mini">Menu</a>
        <h1>
            ${header_text}
        </h1>
    </div>
    <div data-role="content" align='center'>
        <jsp:doBody />
    </div>
    <div data-role="footer" data-position="fixed">
        <slr:copyright name="Aaron Torres" />
    </div>
</div>
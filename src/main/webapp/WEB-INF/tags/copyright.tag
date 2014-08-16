<%--
    Document   : copyright
    Created on : 15/08/2014, 05:55:31 PM
    Author     : Aaron Torres
--%>

<%@tag description="copyright notice" pageEncoding="UTF-8"%>
<%@ tag body-content="empty" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="name" required="true"%>

<%-- any content can be specified here e.g.: --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="now" scope="application" class="java.util.Date" />
Copyright © ${now.year + 1900} ${name}
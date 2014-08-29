<%--
    Document   : autoform
    Created on : 19/08/2014, 05:32:01 PM
    Author     : Aaron Torres
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="slr" tagdir="/WEB-INF/tags/" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="base" required="true" %>
<%@attribute name="label" required="true" %>
<%@attribute name="title" required="true" %>
<%@attribute name="inputs" required="true" %>
<%@attribute name="tblheaders" required="true" %>
<%@attribute name="actioncolumn" required="true" type="java.lang.Boolean" %>

<%-- any content can be specified here e.g.: --%>
<form>
    <table>
        <tr>
            <td colspan="2" align="center">
                ${title}
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <div id="${base}-status"></div>
            </td>
        </tr>
        <c:forEach items="${inputs}" var="in">
            <c:set var="spl" value="${in.split(':')}" />
            <tr>
                <td align="right">
                    <label for="${base}-${spl[1]}">${spl[0]}</label>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${spl[2].equals('list')}">
                                <select id="${base}-${spl[1]}">
                                    <optgroup id="${base}-${spl[1]}-options" label="Escoger ${spl[0]}..."></optgroup>
                                </select>
                        </c:when>
                        <c:otherwise>
                            <input id="${base}-${spl[1]}" data-inline="true" type="${spl[2]}" />
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="2" align="center">
                <input type="button" id="${base}-load" value="Mostrar ${label}" data-theme="b" onclick="${base}_load()" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="button" value="Insertar ${label}" id="${base}-insert" data-theme="c" onclick="${base}_insert()" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <table width="100%">
                    <thead class="ui-body-b ui-corner-all" align="center">
                        <tr>
                            <c:forEach items="${tblheaders}" var="hd">
                                <td>
                                    ${hd}
                                </td>
                            </c:forEach>
                            <c:if test="${actioncolumn}">
                                <td>
                                    Acciones
                                </td>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody id="${base}-response" align="center"></tbody>
                </table>
            </td>
        </tr>
    </table>
</form>
<%--
    Document   : autoscript
    Created on : 20/08/2014, 01:33:13 PM
    Author     : Aaron Torres <solaraaron@gmail.com>
--%>

<%@tag description="put the tag description here" dynamic-attributes="actions" pageEncoding="UTF-8"%>
<%@taglib prefix="slr" tagdir="/WEB-INF/tags/" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="base" required="true"%>
<%@attribute name="restsvc" required="true" %>
<%@attribute name="ldattribs" required="true" %>
<%@attribute name="pathvars" required="true" %>
<%@attribute name="datavars" required="true" %>
<%@attribute name="actioncolumn" required="true" type="java.lang.Boolean" %>
<%@attribute name="listinputs" required="false" %>

<%-- any content can be specified here e.g.: --%>

function ${base}_load(){
    $.ajax({
        type: "GET",
        url: ${restsvc},
        success: function(data){
            $("#${base}-response").html("");
            for(i = 0; i < data.object.length; i++){
                $("#${base}-response").html($("#${base}-response").html() + "<tr>" +
                <c:forEach items="${ldattribs}" var="att">
                    <c:set value="${fn:split(att, ':')}" var="attribspec" />
                    <c:set value="${fn:split(attribspec[0], '.')}" var="attpath" />
                    "<td>" +
                        <c:forEach items="${attpath}" var="pv" varStatus="stat">
                            <c:set var="fp" value="(${stat.first ? 'data.object[i]' : fp} ? ${stat.first ? 'data.object[i]' : fp}.${pv} : null)" />
                        </c:forEach>
                        <c:set var="fp" value="${(empty attribspec[1]) ? fp : attribspec[1].concat('(').concat(fp).concat(')')}" />
                        ${fp} +
                    "</td>" +
                </c:forEach>
                <c:if test="${actioncolumn}">
                    "<td>" +
                        <c:forEach items="${actions}" var="btn">
                            <c:set var="spl" value="${btn.value.split(':')}" />
                            '<input type="button" value="${spl[0]}" id="${base}-${btn.key}-' + <c:forEach items="${spl[1]}" var="arg" varStatus="stat">data.object[i].${arg} ${stat.last? '': '+ \'-\' +'} </c:forEach> + '" data-inline="true" onclick="${base}_${btn.key}(' + <c:forEach items="${spl[1]}" var="arg" varStatus="stat"> '\'' + data.object[i].${arg} + '\'' ${stat.last? '': ','} </c:forEach> + ')" />' +
                        </c:forEach>
                    "</td>" +
                </c:if>
                "</tr>");
            }
            var tmp = $("#${base}-response").html();
            $("#${base}-response").html(tmp).trigger("create");
        }
    });
};

function ${base}_insert(){
    $.ajax({
        type: "POST",
        url: ${restsvc}<c:forEach items="${pathvars}" var="pth" varStatus="stat"> + "/" + $("#${base}-${pth}").val()</c:forEach>,
        data: {
            <c:forEach items="${datavars}" var="dvr" varStatus="stat">
                ${dvr}: $("#${base}-${dvr}").val() ${stat.last ? '' : ','}
            </c:forEach>
        },
        success: function(dta){
            $("#${base}-status").html(dta.object).trigger("create");
            ${base}_load();
            ${base}_fill();
        }
    });
};

function ${base}_fill(){
    <c:forEach items="${(empty listinputs) ? '' : listinputs}" var="in">
        <c:set var="inx" value="${in.split(';')}"/>
        $.ajax({
            type: "GET",
            url: "${inx[3]}",
            success: function(data){
                $("#${base}-${inx[0]}-options").html("");
                for(i = 0; i < data.object.length; i++){
                    $("#${base}-${inx[0]}-options").html($("#${base}-${inx[0]}-options").html() +
                        '<option value="' + data.object[i].${inx[1]} + '">' + data.object[i].${inx[2]} + '</option>'
                    );
                }
                var tmp = $("#${base}-${inx[0]}-options").html();
                $("#${base}-${inx[0]}-options").html(tmp).trigger("create");
            }
        });
    </c:forEach>
}

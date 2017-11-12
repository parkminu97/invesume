<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:if test="${pageContext.request.contextPath == '/'}">
    <c:set var="ctxPath" scope="request" value="" />
</c:if>
<c:if test="${pageContext.request.contextPath != '/'}">
    <c:set var="ctxPath" scope="request" value="${pageContext.request.contextPath}" />
</c:if>
<c:if test="${pageContext.request.serverPort == 80}">
    <c:set var="serverPort" scope="request" value="" />
</c:if>
<c:if test="${pageContext.request.serverPort != 80}">
    <c:set var="serverPort" scope="request" value=":${pageContext.request.serverPort}" />
</c:if>

1
<c:set var="httpCtxPath" scope="request">${ctxPath}</c:set>
<c:set var="httpCtxPath2" scope="request">${pageContext.request.scheme}://${pageContext.request.serverName}${serverPort}${ctxPath}</c:set>
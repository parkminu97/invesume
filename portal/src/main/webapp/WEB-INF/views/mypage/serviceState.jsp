<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/tagLib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/WEB-INF/views/include/head.jsp" %>
    <link href="${httpCtxPath}/resources/css/products.css" rel="stylesheet" type="text/css"/>
    <link href="${httpCtxPath}/resources/css/my_room.css" rel="stylesheet" type="text/css"/>

    <script>
    $(window).load(function() {
    });
    
    </script>
</head>
<body>
<form id="listForm" name="listForm" method="post">
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="my_page">
        <%@include file="/WEB-INF/views/include/left.jsp" %>
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">서비스 이용현황</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 서비스 이용현황</p>
            </div>

            <div class="room_top_wrap">
                <img src="${httpCtxPath}/resources/img/service.png" width="100%">
            </div>
        </div>
    </div>

    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

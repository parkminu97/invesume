<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/tagLib.jsp" %>
<c:if test="${sessionScope.userInfo.admin eq 'N'}">
<c:set var="userCheck" value="true"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<link href="${httpCtxPath}/resources/css/products.css" rel="stylesheet" type="text/css"/>
<script>
$(window).load(function(){
});

</script>
</head>
<body>
    <%@include file="/WEB-INF/views/include/top.jsp" %>
    <div class="titleimg_wrap">
        <img src="${httpCtxPath}/resources/img/titleimg_products.jpg" alt="c_service">
    </div><!--메뉴 대표이미지 끝 -->
    <div class="section_wrap">
        <section>
            <div class="content_title">
                <h2 style="float:left;">고객센터</h2>
                <p style="float:right;">HOME &gt; 고객센터</p>
            </div>
            <article class="article_inpo3">
                  <h3>호텔클릭투콜</h3>
                  <p>
                        회사주소 : 서울시 서초구 사임당로8길 17, 201<br><br>
                        문의메일 : mail1234@invesume.com<br><br>
                        대표전화 : 02-2039-3977<br><br>
                        팩스 : 02-2039-3978<br><br><br><br>
                  </p>
                  <h3>서비스데스크 바로가기</h3>
                  <a href="http://jira.invesume.com:8080/servicedesk/customer/portal/8" target="_blank"><img src="${httpCtxPath}/resources/img/servicedesk_bt.png" alt="servicedesk"></a>
            </article>
        </section>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html> 
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
    
    function fn_list(currentPage) {
        if(typeof(currentPage) == "undefined") currentPage = 1;
        $("#currentPage").val(currentPage);
        
        
        $("#listForm").attr("action", "${httpCtxPath}/mypage/portalCustList.action");
        $("#listForm").submit();
    }

    </script>
</head>
<body>
<form id="listForm" name="listForm" method="post">
    <input type="hidden" id="currentPage" name="currentPage" value="${params.currentPage}">
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="my_page">
        <%@include file="/WEB-INF/views/include/left.jsp" %>
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">고객관리</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 고객관리</p>
            </div>

            <div class="table_bar">
                <div class="search_box">
                    고객명 :
                    <input type="text" id="searchName" name="searchName" value="${params.searchName}"> 
                    <input class="search_bt" type="button" title="검색하기" onclick="fn_list();" />
                </div>
                    
                <div class="page_list_wrap">
                    <select class="page_list_n" id="pageRow" name="pageRow" onchange="fn_list();">
                        <option value="10" <c:if test="${params.pageRow eq '10'}">selected</c:if>>10</option>
                        <option value="20" <c:if test="${params.pageRow eq '20'}">selected</c:if>>20</option>
                        <option value="30" <c:if test="${params.pageRow eq '30'}">selected</c:if>>30</option>
                        <option value="50" <c:if test="${params.pageRow eq '50'}">selected</c:if>>50</option>
                        <option value="100" <c:if test="${params.pageRow eq '100'}">selected</c:if>>100</option>
                    </select>
                </div>
            </div>
            
            <table class="r_table">
                <thead>
                    <tr>
                        <th>NO</th>
                        <th>고객명</th>
                        <th>연락처</th>
                        <th>이메일</th>
                        <th>서비스 이용 횟수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listInfo.list}" var="data" varStatus="status">
                    <tr>
                        <td>${listInfo.totalCount - (( listInfo.currentPage - 1) * listInfo.pageRow) - status.index}</td>
                        <td>${data.user_name}</td>
                        <td>${data.user_tel}</td>
                        <td>${data.user_email}</td>
                        <td>${data.service_cnt}</td>
                    </tr>
                    </c:forEach>
                    <c:if test="${listInfo.totalCount eq 0 }">
                    <tr>
                        <td colspan="5">검색 결과가 존재하지 않습니다.</td>
                    </tr>
                    </c:if>
                </tbody>
            </table>
            
            <c:out value="${listInfo.pagingHtml}" escapeXml="false" />
            
        </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

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
        
        
        $("#listForm").attr("action", "${httpCtxPath}/mypage/productPaymentList.action");
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
                <h2 style="float:left;">결제현황</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 결제현황</p>
            </div>

            <div class="table_bar">
                <div class="search_box">
                    결제상품 : 
                    <select id="searchUtilService" name="searchUtilService">
                        <option value="" <c:if test="${params.searchUtilService eq ''}">selected</c:if>>전체</option>
                        <option value="1" <c:if test="${params.searchUtilService eq '1'}">selected</c:if>>Demo</option>
                        <option value="2" <c:if test="${params.searchUtilService eq '2'}">selected</c:if>>Basic</option>
                        <option value="3" <c:if test="${params.searchUtilService eq '3'}">selected</c:if>>Premium</option>
                    </select>
                    <c:if test="${sessionScope.userInfo.admin eq 'Y'}">
                    결제자 : <input type="text" id="searchPayUserName" name="searchPayUserName" value="${params.searchPayUserName}">
                    </c:if>
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
                        <th>결제상품</th>
                        <c:if test="${sessionScope.userInfo.admin eq 'Y'}">
                        <th>결제자</th>
                        </c:if>
                        <th>결제일자</th>
                        <th>결제방법</th>
                        <th>결제금액</th>
                        <th>서비스 기간</th>
                        <th>사용여부</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listInfo.list}" var="data" varStatus="status">
                    <tr>
                        <td>${listInfo.totalCount - (( listInfo.currentPage - 1) * listInfo.pageRow) - status.index}</td>
                        <td>${data.util_service_name}</td>
                        <c:if test="${sessionScope.userInfo.admin eq 'Y'}">
                        <td>${data.pay_user_name}</td>
                        </c:if>
                        <td>${data.pay_day}</td>
                        <td>${data.pay_type}</td>
                        <td><fmt:formatNumber value="${data.pay_money}" pattern="#,###" /></td>
                        <td>${data.use_start_date} ~ ${data.use_end_date}</td>
                        <td>${data.use_yn}</td>
                    </tr>
                    </c:forEach>
                    <c:if test="${listInfo.totalCount eq 0 }">
                    <tr>
                        <td colspan="8">검색 결과가 존재하지 않습니다.</td>
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

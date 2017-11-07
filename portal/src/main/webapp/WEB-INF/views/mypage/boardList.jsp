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
        
        
        $("#listForm").attr("action", "${httpCtxPath}/mypage/boardList.action");
        $("#listForm").submit();
    }
    
    function fn_insert() {
        $("#listForm").attr("action", "${httpCtxPath}/mypage/boardInsert.action");
        $("#listForm").submit();
    }

    function fn_view(no) {
    	$("#no").val(no);
        $("#listForm").attr("action", "${httpCtxPath}/mypage/boardUpdate.action");
        $("#listForm").submit();
    }

    </script>
</head>
<body>
<form id="listForm" name="listForm" method="post">
    <input type="hidden" id="currentPage" name="currentPage" value="${params.currentPage}">
    <input type="hidden" id="board_gubun" name="board_gubun" value="${params.board_gubun}">
    <input type="hidden" id="no" name="no">
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="my_page">
        <%@include file="/WEB-INF/views/include/left.jsp" %>
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">${boardTitle}관리</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; ${boardTitle}관리</p>
            </div>

            <div class="table_bar">
                <div class="search_box">
                    제목 : <input type="text" id="searchSubject" name="searchSubject" value="${params.searchSubject}">
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
                <colgroup>
                    <col width="40"/>
                    <col width="*"/>
                    <c:if test="${params.board_gubun eq 'E' }">
                    <col width="20%"/>
                    </c:if>
                    <col width="100"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>NO</th>
                        <th>제목</th>
	                    <c:if test="${params.board_gubun eq 'E' }">
	                    <th>이벤트 기간</th>
	                    </c:if>
                        <th>등록일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listInfo.list}" var="data" varStatus="status">
                    <tr>
                        <td>${listInfo.totalCount - (( listInfo.currentPage - 1) * listInfo.pageRow) - status.index}</td>
                        <td style="text-align:left;padding-left:10px">
                            <a href="javascript:fn_view('${data.no}');">${data.subject}</a>
                        </td>
                        <c:if test="${params.board_gubun eq 'E' }">
                        <td>${data.event_start_date} ~ ${data.event_end_date}</td>
                        </c:if>
                        <td>${data.insert_dt}</td>
                    </tr>
                    </c:forEach>
                    <c:if test="${listInfo.totalCount eq 0 }">
                    <tr>
                        
                        <td colspan="4">검색 결과가 존재하지 않습니다.</td>
                    </tr>
                    </c:if>
                </tbody>
            </table>
            
            <c:out value="${listInfo.pagingHtml}" escapeXml="false" />

            <p class="text_bt_style"><a href="javascript:fn_insert();" target="_self">${boardTitle} 등록</a></p>
            
        </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

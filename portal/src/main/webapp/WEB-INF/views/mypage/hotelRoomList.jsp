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
        
        $("#listForm").attr("action", "${httpCtxPath}/mypage/hotelRoomList.action");
        $("#listForm").submit();
    }

    function fn_insert() {
        $("#listForm").attr("action", "${httpCtxPath}/mypage/hotelRoomInsert.action");
        $("#listForm").submit();
    }

    function fn_view(no) {
    	$("#no").val(no);
        $("#listForm").attr("action", "${httpCtxPath}/mypage/hotelRoomView.action");
        $("#listForm").submit();
    }

    function fn_delete(no) {
        if(!confirm("정말로 해당 객실정보를 삭제하시겠습니까?")) return;
        $("#no").val(no);
        var params = $("form[name=listForm]").serialize();

        $.ajax({
            url : "${httpCtxPath}/mypage/hotelRoomDeleteProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 객실정보가 삭제되었습니다.");
                    fn_list();
                } else {
                    alert("객실정보 삭제처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
                }
            },
            error : function(request,status,error) {
                alert("시스템 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
            }
        });
    }

    </script>
</head>
<body>
<form id="listForm" name="listForm" method="post">
    <input type="hidden" id="currentPage" name="currentPage" value="${params.currentPage}">
    <input type="hidden" id="no" name="no" value="">
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="my_page">
        <%@include file="/WEB-INF/views/include/left.jsp" %>
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">호텔객실관리</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 호텔셋팅 &gt; 호텔객실관리</p>
            </div>

            <div class="table_bar">
                <div class="search_box">
                    객실명 : <input type="text" id="searchRoomName" name="searchRoomName" value="${params.searchRoomName}"/>
                    사용여부 : 
                    <select id="searchRoomUseYn" name="searchRoomUseYn">
                        <option value="">전체</option>
                        <option value="Y" <c:if test="${params.searchRoomUseYn eq 'Y'}">selected</c:if>>사용</option>
                        <option value="N" <c:if test="${params.searchRoomUseYn eq 'N'}">selected</c:if>>미사용</option>
                    </select>
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
                        <th width="50">NO</th>
                        <th width="200">객실이미지</th>
                        <th>객실명</th>
                        <th>투숙인원 규정</th>
                        <th>객실요금</th>
                        <th>사용여부</th>
                        <th>비고</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listInfo.list}" var="data" varStatus="status">
                    <tr>
                        <td>
                            ${listInfo.totalCount - (( listInfo.currentPage - 1) * listInfo.pageRow) - status.index}
                        </td>
                        <td>
                            <c:if test="${data.rep_room_img eq null}">
                            <img src="${httpCtxPath}/resources/img/no_image.jpg" width="200" height="90">
                            </c:if>
                            <c:if test="${data.rep_room_img ne null}">
                            <img src="${httpCtxPath}/webFile/imgFileView.action?path=${data.rep_room_img}" width="200" height="90">
                            </c:if>
                        </td>
                        <td>${data.room_name}</td>
                        <td>${data.room_people_rule}</td>
                        <td><fmt:formatNumber value="${data.room_money}" pattern="#,###" /></td>
                        <td>${data.room_use_yn}</td>
                        <td class="modi_delet">
                            <a href="javascript:fn_view('${data.no}');" target="_self">상세</a>
                            <a href="javascript:fn_delete('${data.no}');" target="_self">삭제</a>
                        </td>
                    </tr>
                    </c:forEach>
                    <c:if test="${listInfo.totalCount eq 0 }">
                    <tr>
                        <td colspan="7">검색 결과가 존재하지 않습니다.</td>
                    </tr>
                    </c:if>
                </tbody>
            </table>
            
            <c:out value="${listInfo.pagingHtml}" escapeXml="false" />
            
            <p class="text_bt_style"><a href="javascript:fn_insert();" target="_self">객실등록</a></p>
            
        </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

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
    
    function fn_menu_list_check() {
        for(var i=0; i < listForm.useMenu.length; i++) {
            listForm.useMenu[i].checked = listForm.allChk.checked;
        }
    }
    
    function fn_insert() {
    	var checkedList = "";
        $("input[name=useMenu]:checkbox").each(function() {
            if($(this).is(":checked")) {
            	if(checkedList != "") checkedList += ",";
                checkedList += $(this).val();
            }
        });
    	
        var params = {"useMenu" : checkedList};

        $.ajax({
            url : "${httpCtxPath}/mypage/serviceCompProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 모바일에서 사용할 메뉴가 설정되었습니다.");
                    location.href="${httpCtxPath}/mypage/serviceComp.action";
                } else {
                    alert("모바일에서 사용할 메뉴 설정처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
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
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="my_page">
        <%@include file="/WEB-INF/views/include/left.jsp" %>
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">서비스 구성관리</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 서비스 구성관리</p>
            </div>

            <table class="r_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="allChk" name="allChk" onclick="fn_menu_list_check();"></th>
                        <th>메뉴명</th>
                        <th>메뉴설명</th>
                        <th>현재 사용중인 메뉴</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${menuList}" var="data" varStatus="status">
                    <tr>
                        <td>
                            <c:set var="checkedNoList" value="${fn:split(hotelInfo.use_menu, ',')}" />
                            <c:set var="checked" value=""/>
                            <c:forEach items="${checkedNoList}" var="data2">
                                <c:if test="${data.no eq data2}">
                                    <c:set var="checked" value="checked"/>
                                </c:if>
                            </c:forEach>
                            <input type="checkbox" id="useMenu" name="useMenu" value="${data.no}" ${checked}>
                        </td>
                        <td>${data.menu_name}</td>
                        <td>${data.menu_desc}</td>
                        <td>
                            <c:if test="${checked ne '' }">O</c:if>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>

            <p style="padding-top:20px;" class="text_bt_style"><a href="javascript:fn_insert();" target="_self">모바일에서 사용할 메뉴 설정</a></p>
            
        </div>
    </div>

    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

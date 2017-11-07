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
    
    function fn_update() {
        popUp("${httpCtxPath}/mypage/portalUserUpdate.action", "MyPagePortalUser", "600", "400");
    }

    function fn_password_update() {
        popUp("${httpCtxPath}/mypage/portalUserPasswordUpdate.action", "MyPagePortalUser2", "600", "400");
    }

    function fn_refresh() {
        location.href = "${httpCtxPath}/mypage/info.action";
    }
    
    function fn_hotel_user_insert() {
        popUp("${httpCtxPath}/mypage/hotelUserInsert.action", "hotelUserInsert", "600", "450");
    }
    
    function fn_hotel_user_delete(id) {
        if(!confirm("정말로 담당자를 삭제하시겠습니까?")) return;

        var params = {"id" : id};

        $.ajax({
            url : "${httpCtxPath}/mypage/hotelUserDeleteProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 담당자가 삭제되었습니다.");
                    fn_refresh();
                } else {
                    alert("담당자 삭제처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
                }
            },
            error : function(request,status,error) {
                alert("시스템 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
            }
        });
    }
    
    function fn_delete() {
    	popUp("${httpCtxPath}/mypage/portalUserDelete.action", "portalUserDelete", "600", "450");
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
                <h2 style="float:left;">회원정보</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 회원정보</p>
            </div>

            <div class="room_top_wrap">
                <div class="bt_group">
                    <p class="text_bt_style"><a href="javascript:fn_delete();" target="_self" style="background:#333; margin-left:10px;">회원탈퇴</a></p>
                    <p class="text_bt_style"><a href="javascript:fn_password_update();" target="_self" style="margin-left:10px;">비밀번호 변경</a></p>
                    <p class="text_bt_style"><a href="javascript:fn_update();" target="_self">회원정보 수정</a></p>
                </div>

                <h3 class="sub_title">마스터 회원정보</h3>
                <ul class="room_input">
                    <li>
                        <label for="id" class="room_label">아이디</label>
                        <input type="text" id="id" name="id" value="${portalUserInfo.user_id}" class="r_input" readonly="readonly">
                    </li>
                    <li>
                        <label for="name" class="room_label">이름</label>
                        <input type="text" id="name" name="name" value="${portalUserInfo.user_name}" class="r_input" maxlength="25" readonly="readonly">
                    </li>
                    <li>
                        <label for="tel" class="room_label">연락처</label>
                        <input type="text" id="tel" name="tel" value="${portalUserInfo.user_tel}" class="r_input" maxlength="20" readonly="readonly">
                    </li>
                    <li>
                        <label for="email" class="room_label">이메일</label>
                        <input type="text" id="email" name="email" value="${portalUserInfo.user_email}" class="r_input" maxlength="50" readonly="readonly">
                    </li>
                </ul>
            </div>

            <div class="room_bottom_wrap">
                <div class="title_imgbt">
                    <h3 class="sub_title2">호텔 담당자 정보</h3>
                </div>
                <table class="r_regi_table">
                    <thead>
                        <tr>
                            <th>담당자 아이디</th>
                            <th>담당자명</th>
                            <th>권한</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${hotelUserList}" var="data" varStatus="status">
                        <tr>
                            <td>${data.user_id}</td>
                            <td>${data.user_name}</td>
                            <td>${data.user_auth}</td>
                            <td class="img_delet">
                                <a href="javascript:fn_hotel_user_delete('${data.user_id}')" target="_self">삭제</a>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${fn:length(hotelUserList) eq 0}">
                        <tr>
                            <td colspan="4" class="center">검색 결과가 존재하지 않습니다.</td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
                <div class="bt_group">
                    <p class="text_bt_style"><a href="javascript:fn_hotel_user_insert();" target="_self">담당자 등록</a></p>
                </div>

            </div>
        </div>
    </div>

    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

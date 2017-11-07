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
    
    function fn_list() {
        $("#insertForm").attr("action", "${httpCtxPath}/mypage/hotelRoomList.action");
        $("#insertForm").submit();
    }

    function fn_update() {
        var params = $("form[name=insertForm]").serialize();

        $.ajax({
            url : "${httpCtxPath}/mypage/hotelRoomUpdateProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 객실정보가 수정되었습니다.");
                    fn_list();
                } else {
                    alert("객실정보 수정처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
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
<form id="insertForm" name="insertForm" method="post">
    <input type="hidden" id="currentPage" name="currentPage" value="${params.currentPage}">
    <input type="hidden" id="searchRoomName" name="searchRoomName" value="${params.searchRoomName}">
    <input type="hidden" id="searchRoomUseYn" name="searchRoomUseYn" value="${params.searchRoomUseYn}">
    <input type="hidden" id="no" name="no" value="${hotelRoomInfo.no}">
    
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="my_page">
        <%@include file="/WEB-INF/views/include/left.jsp" %>
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">호텔객실수정</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 호텔셋팅 &gt; 호텔객실관리 &gt; 호텔객실수정</p>
            </div>

            <div class="room_top_wrap">
                <h3 class="sub_title">객실정보</h3>
                <ul class="room_input">
                    <li>
                        <label class="room_label">객실명</label>
                        <input class="r_input" id="room_name" name="room_name" type="text" maxlength="25" value="${hotelRoomInfo.room_name}">
                    </li>
                    <li>
                        <label class="room_label" for="use">사용여부</label>
                        <input type="radio" id="room_use_yn" name="room_use_yn" value="Y" <c:if test="${hotelRoomInfo.room_use_yn eq 'Y'}">checked</c:if>>
                        <label for="room_use_yn">사용</label>
                        <input type="radio" id="room_use_yn" name="room_use_yn" value="N" <c:if test="${hotelRoomInfo.room_use_yn eq 'N'}">checked</c:if>>
                        <label for="room_use_yn">사용안함</label>
                    </li>
                    <li>
                        <label class="room_label" for="room_money">객실요금</label>
                        <input class="r_input" id="room_money" name="room_money" type="text" maxlength="20" value="${hotelRoomInfo.room_money}">
                    </li>
                    <li>
                        <label class="room_label" for="room_people_rule">투숙인원 규정</label>
                        <input class="r_input" id="room_people_rule" name="room_people_rule" type="text" maxlength="25" value="${hotelRoomInfo.room_people_rule}">
                    </li>
                    <li>
                        <label class="room_label" for="room_position">위치</label>
                        <input class="r_input" id="room_position" name="room_position" type="text" maxlength="10" value="${hotelRoomInfo.room_position}">
                    </li>
                    <li>
                        <label class="room_label" for="room_bed_type">베드타입</label>
                        <input class="r_input" id="room_bed_type" name="room_bed_type" type="text" maxlength="25" value="${hotelRoomInfo.room_bed_type}">
                    </li>
                </ul>
                <ul class="room_input" style="border-left:1px solid #cdcfd3; box-sizing:border-box;">
                    <li>
                        <label class="room_label" for="room_comp">객실구성</label>
                        <input class="r_input" id="room_comp" name="room_comp" type="text" maxlength="50" value="${hotelRoomInfo.room_comp}">
                    </li>
                    <li>
                        <label class="room_label" for="room_info" >객실정보</label>
                        <textarea id="room_info" name="room_info" rows="5" cols="37">${hotelRoomInfo.room_info}</textarea>
                    </li>
                    <li>
                        <label class="room_label" for="room_service">제공서비스</label>
                        <textarea id="room_service" name="room_service" rows="5" cols="37">${hotelRoomInfo.room_service}</textarea>
                    </li>
                </ul>
            </div>
            
            <div class="bt_group">
                <p class="text_bt_style"><a href="javascript:fn_list();" target="_self" style="background:#333; margin-left:10px;">목록</a></p>
                <p class="text_bt_style"><a href="javascript:fn_update();" target="_self">객실수정</a></p>
            </div>

        </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

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

    function fn_insert() {
        if($("#room_name").val() == "") {
            alert("객실명을 입력하여 주십시오.");
            $("#room_name").focus();
            return;
        }

        if(!confirm("객실 정보를 등록하시겠습니까?")) return;

        var params = $("form[name=insertForm]").serialize();

        $.ajax({
            url : "${httpCtxPath}/mypage/hotelRoomInsertProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 객실 정보가 등록되었습니다.");
                    fn_list();
                } else {
                    alert("객실 정보 등록처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
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
    
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="my_page">
        <%@include file="/WEB-INF/views/include/left.jsp" %>
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">호텔객실등록</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 호텔셋팅 &gt; 호텔객실관리 &gt; 호텔객실등록</p>
            </div>

            <div class="room_top_wrap">
                <ul class="room_input">
                    <li>
                        <label class="room_label" for="room_name">객실명</label>
                        <input class="r_input" id="room_name" name="room_name" type="text" maxlength="25">
                    </li>
                    <li>
                        <label class="room_label" for="use">사용여부</label>
                        <input type="radio" id="room_use_yn" name="room_use_yn" value="Y">
                        <label for="room_use_yn">사용</label>
                        <input type="radio" id="room_use_yn" name="room_use_yn" value="N" checked>
                        <label for="room_use_yn">사용안함</label>
                    </li>
                    <li>
                        <label class="room_label" for="room_money">객실요금</label>
                        <input class="r_input" id="room_money" name="room_money" type="text" maxlength="20" onkeyup="onlyNumber(this);">
                    </li>
                    <li>
                        <label class="room_label" for="room_people_rule">투숙인원 규정</label>
                        <input class="r_input" id="room_people_rule" name="room_people_rule" type="text" placeholder="예) 성인 2인 기준/최대 3인" maxlength="25">
                    </li>
                    <li>
                        <label class="room_label" for="room_position">위치</label>
                        <input class="r_input" id="room_position" name="room_position" type="text" maxlength="10">
                    </li>
                    <li>
                        <label class="room_label" for="room_bed_type">베드타입</label>
                        <input class="r_input" id="room_bed_type" name="room_bed_type" type="text" maxlength="25">
                    </li>
                </ul>
                <ul class="room_input" style="border-left:1px solid #cdcfd3; box-sizing:border-box;">
                    <li>
                        <label class="room_label" for="room_comp">객실구성</label>
                        <input class="r_input" id="room_comp" name="room_comp" type="text" maxlength="50">
                    </li>
                    <li>
                        <label class="room_label" for="room_info" >객실정보</label>
                        <textarea id="room_info" name="room_info" rows="5" cols="37"></textarea>
                    </li>
                    <li>
                        <label class="room_label" for="room_service">제공서비스</label>
                        <textarea id="room_service" name="room_service" rows="5" cols="37"></textarea>
                    </li>
                </ul>
            </div>
            
            <div class="bt_group">
                <p class="text_bt_style"><a href="javascript:fn_list();" target="_self" style="background:#333; margin-left:10px;">취소</a></p>
                <p class="text_bt_style"><a href="javascript:fn_insert();" target="_self">객실등록</a></p>
            </div>
            
        </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

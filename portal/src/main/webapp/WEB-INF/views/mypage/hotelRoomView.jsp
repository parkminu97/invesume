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

    function fn_view() {
        $("#insertForm").attr("action", "${httpCtxPath}/mypage/hotelRoomView.action");
        $("#insertForm").submit();
    }

    function fn_list() {
        $("#insertForm").attr("action", "${httpCtxPath}/mypage/hotelRoomList.action");
        $("#insertForm").submit();
    }

    function fn_update() {
        $("#insertForm").attr("action", "${httpCtxPath}/mypage/hotelRoomUpdate.action");
        $("#insertForm").submit();
    }
    
    function fn_delete() {
        if(!confirm("정말로 객실정보를 삭제하시겠습니까?")) return;
        var params = $("form[name=insertForm]").serialize();

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

    function fn_img_upload() {
        popUp("${httpCtxPath}/mypage/hotelRoomImgUpload.action", "hotelRoomImgUpload", "600", "400");
    }

    function fn_room_img_delete(no, room_img) {
        if(!confirm("정말로 해당 객실 이미지를 삭제하시겠습니까?")) return;
        var params = {"riNo" : $("#no").val(), "no" : no, "room_img" : room_img};

        $.ajax({
            url : "${httpCtxPath}/mypage/hotelRoomImgDeleteProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 객실 이미지가 삭제되었습니다.");
                    fn_view();
                } else {
                    alert("객실 이미지 삭제처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
                }
            },
            error : function(request,status,error) {
                alert("시스템 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
            }
        });
    }

    function fn_hotel_room_rep_img_update(no) {
        if(!confirm("해당 이미지를 객실 대표 이미지로 등록하시겠습니까?")) return;
        var params = {"no" : $("#no").val(), "repRoomImg" : no};

        $.ajax({
            url : "${httpCtxPath}/mypage/hotelRoomRepImgUpdate.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 객실 대표 이미지가 등록되었습니다.");
                    fn_view();
                } else {
                    alert("객실 대표 이미지 등록처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
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
                <h2 style="float:left;">호텔객실상세</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 호텔셋팅 &gt; 호텔객실관리 &gt; 호텔객실상세</p>
            </div>

            <div class="room_top_wrap">
                <h3 class="sub_title">객실정보</h3>
                <ul class="room_input">
                    <li>
                        <label class="room_label">객실명</label>
                        <input class="r_input" id="room_name" name="room_name" type="text" maxlength="25" value="${hotelRoomInfo.room_name}" readonly="readonly">
                    </li>
                    <li>
                        <label class="room_label" for="use">사용여부</label>
                        <input type="radio" id="room_use_yn" name="room_use_yn" value="Y" <c:if test="${hotelRoomInfo.room_use_yn eq 'Y'}">checked</c:if> disabled="disabled">
                        <label for="room_use_yn">사용</label>
                        <input type="radio" id="room_use_yn" name="room_use_yn" value="N" <c:if test="${hotelRoomInfo.room_use_yn eq 'N'}">checked</c:if> disabled="disabled">
                        <label for="room_use_yn">사용안함</label>
                    </li>
                    <li>
                        <label class="room_label" for="room_money">객실요금</label>
                        <input class="r_input" id="room_money" name="room_money" type="text" maxlength="20" value="${hotelRoomInfo.room_money}" readonly="readonly">
                    </li>
                    <li>
                        <label class="room_label" for="room_people_rule">투숙인원 규정</label>
                        <input class="r_input" id="room_people_rule" name="room_people_rule" type="text" maxlength="25" value="${hotelRoomInfo.room_people_rule}" readonly="readonly">
                    </li>
                    <li>
                        <label class="room_label" for="room_position">위치</label>
                        <input class="r_input" id="room_position" name="room_position" type="text" maxlength="10" value="${hotelRoomInfo.room_position}" readonly="readonly">
                    </li>
                    <li>
                        <label class="room_label" for="room_bed_type">베드타입</label>
                        <input class="r_input" id="room_bed_type" name="room_bed_type" type="text" maxlength="25" value="${hotelRoomInfo.room_bed_type}" readonly="readonly">
                    </li>
                </ul>
                <ul class="room_input" style="border-left:1px solid #cdcfd3; box-sizing:border-box;">
                    <li>
                        <label class="room_label" for="room_comp">객실구성</label>
                        <input class="r_input" id="room_comp" name="room_comp" type="text" maxlength="50" value="${hotelRoomInfo.room_comp}" readonly="readonly">
                    </li>
                    <li>
                        <label class="room_label" for="room_info" >객실정보</label>
                        <textarea id="room_info" name="room_info" rows="5" cols="37" readonly="readonly">${hotelRoomInfo.room_info}</textarea>
                    </li>
                    <li>
                        <label class="room_label" for="room_service">제공서비스</label>
                        <textarea id="room_service" name="room_service" rows="5" cols="37" readonly="readonly">${hotelRoomInfo.room_service}</textarea>
                    </li>
                </ul>
            </div>
            
            
            <div class="room_bottom_wrap">
                <div class="title_imgbt">
                    <h3 class="sub_title2">객실이미지 등록</h3>
                    <p class="r_imgadd_bt"><a href="javascript:fn_img_upload();" target="_self">이미지 추가</a></p>
                </div>
                <table class="r_regi_table">
                    <thead>
                        <tr>
                            <th width="100px;">대표이미지 설정</th>
                            <th>객실이미지</th>
                            <th>비고</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${hotelRoomImgList}" var="data" varStatus="status">
                        <tr>
                            <td><input type="radio" id="rep_room_img" name="rep_room_img" value="${data.no}" onclick="fn_hotel_room_rep_img_update(this.value);" <c:if test="${data.no eq hotelRoomInfo.rep_room_img}">checked</c:if>></td>
                            <td style="text-align:left"><img src="${httpCtxPath}/webFile/imgFileView.action?path=${data.room_img}" width="200" height="90"></td>
                            <td class="img_delet">
                                <a href="javascript:fn_room_img_delete('${data.no}', '${data.room_img}');" target="_self">삭제</a>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${fn:length(hotelRoomImgList) eq 0}">
                        <tr>
                            <td colspan="3" class="center">검색 결과가 존재하지 않습니다.</td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
                <div class="bt_group">
                    <p class="text_bt_style"><a href="javascript:fn_list();" target="_self" style="background:#333; margin-left:10px;">목록</a></p>
                    <p class="text_bt_style"><a href="javascript:fn_delete();" target="_self" style="margin-left:10px;">객실삭제</a></p>
                    <p class="text_bt_style"><a href="javascript:fn_update();" target="_self">객실수정</a></p>
                </div>
            </div>

        </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

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
    
    function fn_refresh() {
        location.href = "${httpCtxPath}/mypage/hotelInfo.action";
    }

    function fn_hotel_update() {
        if($("#hotel_name").val() == "") {
            alert("호텔명을 입력하여 주십시오.");
            $("#hotel_name").focus();
            return;
        }

        if(!confirm("호텔 정보를 " + "${typeDesc}" + "하시겠습니까?")) return;

        var params = $("form[name=listForm]").serialize();

        $.ajax({
            url : "${httpCtxPath}/mypage/hotelInfoProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 호텔 정보가 " + "${typeDesc}" + "되었습니다.");
                    location.href = "${httpCtxPath}/mypage/hotelInfo.action";
                } else {
                    alert("담당자  " + "${typeDesc}" + "처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
                }
            },
            error : function(request,status,error) {
                alert("시스템 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
            }
        });
    }
    
    function fn_img_upload() {
    	if("${hotelInfo.rep_img}" != "") {
    		alert("이미 등록된 대표 아이콘이 존재합니다.\n대표 아이콘 삭제 후 등록하여 주십시오.");
    		return;
    	}
        popUp("${httpCtxPath}/mypage/hotelRepImgUpload.action", "hotelRoomImgUpload", "600", "400");
    }
    
    function fn_img_delete(rep_img) {
        if(!confirm("정말로 대표 아이콘을 삭제하시겠습니까?")) return;
        var params = {"rep_img" : rep_img};

        $.ajax({
            url : "${httpCtxPath}/mypage/hotelRepImgDeleteProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 대표 아이콘이 삭제되었습니다.");
                    fn_refresh();
                } else {
                    alert("대표 아이콘 삭제처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
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
                <h2 style="float:left;">호텔정보</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 호텔셋팅 &gt; 호텔정보</p>
            </div>

            <div class="room_top_wrap">
                <ul class="room_input">
                    <li>
                        <label for="hotel_name" class="room_label">호텔명</label>
                        <input type="text" id="hotel_name" name="hotel_name" value="${hotelInfo.hotel_name}" class="r_input" maxlength="25">
                        <input type="hidden" id="type" name="type" value="${type}">
                    </li>
                    <li>
                        <label for="rep_email" class="room_label">대표 이메일</label>
                        <input type="text" id="rep_email" name="rep_email" value="${hotelInfo.rep_email}" class="r_input" maxlength="25">
                    </li>
                    <li>
                        <label for="rep_tel" class="room_label">대표 연락처</label>
                        <input type="text" id="rep_tel" name="rep_tel" value="${hotelInfo.rep_tel}" class="r_input" maxlength="20" onkeyup="onlyNumber(this);">
                    </li>
                    <li>
                        <label for="country" class="room_label">국가</label>
                        <select id="country" name="country">
                            <option value="">국가선택</option>
                            <option value="KR" <c:if test="${hotelInfo.country eq 'KR'}">selected</c:if>>South Korea</option>
                            <option value="US" <c:if test="${hotelInfo.country eq 'US'}">selected</c:if>>USA</option>
                            <option value="PH" <c:if test="${hotelInfo.country eq 'PH'}">selected</c:if>>Philippines</option>
                        </select>
                    </li>
                    <li>
                        <label for="hotel_addr1" class="room_label">호텔 주소</label>
                        <input type="text" id="hotel_addr1" name="hotel_addr1" value="${hotelInfo.hotel_addr1}" class="r_input" maxlength="100">
                    </li>
                    <li>
                        <label for="hotel_addr2" class="room_label">상세 주소</label>
                        <input type="text" id="hotel_addr2" name="hotel_addr2" value="${hotelInfo.hotel_addr2}" class="r_input" maxlength="100">
                    </li>
                    <li>
                        <label class="room_label">대표 아이콘</label>
                        <c:if test="${hotelInfo.rep_img eq null}">
                        <img src="${httpCtxPath}/resources/img/no.png">
                        </c:if>
                        <c:if test="${hotelInfo.rep_img ne null}">
                        <img src="${httpCtxPath}/webFile/imgFileView.action?path=${hotelInfo.rep_img}">
                        
                        &nbsp;&nbsp;&nbsp;
                        <a href="javascript:fn_img_delete();"><img src="${httpCtxPath}/resources/img/i_delet.png">삭제</a>
                        </c:if>
                    </li>
                </ul>
            </div>

            <div class="bt_group">
                <p class="text_bt_style"><a href="javascript:fn_img_upload();" target="_self" style="margin-left:10px;">호텔 대표 아이콘 등록</a></p>
                <p class="text_bt_style"><a href="javascript:fn_hotel_update();" target="_self">호텔 정보 ${typeDesc}</a></p>
            </div>
        </div>
    </div>

    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

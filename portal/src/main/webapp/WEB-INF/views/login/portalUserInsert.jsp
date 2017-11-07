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
    	$("#id").focus();
    });
    
    function fn_insert() {
        if($("#id").val() == "") {
            alert("아이디를 입력하여 주십시오.");
            $("#id").focus();
            return;
        }

        if($("#pwd").val() == "") {
            alert("비밀번호를 입력하여 주십시오.");
            $("#pwd").focus();
            return;
        }

        if($("#confirmPwd").val() == "") {
            alert("비밀번호 확인을 입력하여 주십시오.");
            $("#confirmPwd").focus();
            return;
        }
        
        if($("#pwd").val() != $("#confirmPwd").val()) {
        	alert("입력된 비밀번호가 일치하지 않습니다.");
        	$("#confirmPwd").focus();
            return;
        }
        
        if($("#name").val() == "") {
            alert("이름을 입력하여 주십시오.");
            $("#name").focus();
            return;
        }

        if($("#tel").val() == "") {
            alert("연락처를 입력하여 주십시오.");
            $("#tel").focus();
            return;
        }

        var params = $("form[name=insertForm]").serialize();
        
        $.ajax({
            url : "${httpCtxPath}/portalUserInsertProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
            	if(response == "1") {
            		alert("정상적으로 회원가입되었습니다.\n로그인 후 이용하시기 바랍니다.");
            		location.href ="${httpCtxPath}/login.action"
            	} else if(response == "2") {
            		alert("이미 등록된 아이디입니다.\n다른 아이디로 가입하시기 바랍니다.");
            		$("#id").focus();
            	} else {
            		alert("회원가입처리 과정 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
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
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="titleimg_wrap">
        <img src="${httpCtxPath}/resources/img/titleimg_products.jpg" alt="products">
    </div><!--메뉴 대표이미지 끝 -->
    
    <div class="my_page">
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">호텔클릭투콜 회원가입</h2>
            </div>

            <div class="room_top_wrap">
                <ul class="room_input">
                    <li>
                        <label for="id" class="room_label">아이디</label>
                        <input type="text" id="id" name="id" class="r_input" maxlength="20">
                    </li>
                    <li>
                        <label for="pwd" class="room_label">비밀번호</label>
                        <input type="password" id="pwd" name="pwd" class="r_input" maxlength="20">
                    </li>
                    <li>
                        <label for="confirmPwd" class="room_label">비밀번호 확인</label>
                        <input type="password" id="confirmPwd" name="confirmPwd" class="r_input" maxlength="20">
                    </li>
                    <li>
                        <label for="name" class="room_label">이름</label>
                        <input type="text" id="name" name="name" class="r_input" maxlength="25">
                    </li>
                    <li>
                        <label for="tel" class="room_label">연락처</label>
                        <input type="text" id="tel" name="tel" class="r_input" maxlength="20" onkeyup="onlyNumber(this);">
                    </li>
                    <li>
                        <label for="email" class="room_label">이메일</label>
                        <input type="text" id="email" name="email" class="r_input" maxlength="50">
                    </li>
                </ul>
            </div>
            <div class="bt_group">
                <p class="text_bt_style"><a href="javascript:fn_insert();" target="_self">회원가입</a></p>
            </div>
        </div>
    </div>

    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/tagLib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="keyword" content="Hotel,Click to Call,호텔클릭투콜,클릭투콜,호텔">
    <title>Hotel Click to Call</title>

    <script type="text/javascript" src="${httpCtxPath}/resources/lib/jquery/jquery-1.11.1.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/lib/jquery-ui/jquery-ui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/js/common.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/js/util.js" charset="utf-8"></script>

    <link href="${httpCtxPath}/resources/css/reset.css" rel="stylesheet" type="text/css"/>
    <link href="${httpCtxPath}/resources/css/popup.css" rel="stylesheet" type="text/css"/>
    
	<script>
	    $(window).load(function() {
	    });
	    
	    function fn_update() {
	        if($("#id").val() == "") {
	            alert("아이디를 입력하여 주십시오.");
	            $("#id").focus();
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
	            url : "${httpCtxPath}/mypage/portalUserUpdateProcess.action",
	            type : "POST",
	            dataType : "json",
	            data : params,
	            async : false,
	            success : function(response, status, request) {
	            	if(response == "1") {
	            		alert("정상적으로 회원정보가 수정되었습니다.");
	            		opener.fn_refresh();
	            		self.close();
	            	} else {
	            		alert("회원정보 수정처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
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
<div class="popup_client_wrap">
    <div class="popup_client">
        <div class="popup_client_top">
            <h3><img src="${httpCtxPath}/resources/img/pop_hotellogo.png" alt="hotellogo"></h3>
        </div>
        
        <table style="border : 3px solid #888;"><tr><th>마스터 회원정보 수정</th></tr></table>

        <table>
        <tr>
            <th style="width:40%">아이디</th>
            <td>${sessionScope.userInfo.user_id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td><input type="text" id="name" name="name" value="${sessionScope.userInfo.user_name}" maxlength="25"></td>
        </tr>
        <tr>
            <th>연락처</th>
            <td><input type="text" id="tel" name="tel" value="${sessionScope.userInfo.user_tel}" maxlength="20" onkeyup="onlyNumber(this);"></td>
        </tr>
        <tr>
            <th>E-mail</th>
            <td><input type="text" id="email" name="email" value="${sessionScope.userInfo.user_email}" maxlength="50"></td>
        </tr>
        </tbody>
        </table>
        <p class="popup_bt"><a href="javascript:self.close();" target="_self">닫기</a></p>
        <p class="popup_bt"><a href="javascript:fn_update();" target="_self">마스터 회원정보 수정</a></p>
    </div>
</div>
</form>
</body>
</html>

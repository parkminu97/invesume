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
    
    function fn_delete() {
        if(!confirm("정말로 회원탈퇴를 하시겠습니까?")) return;

        $.ajax({
            url : "${httpCtxPath}/mypage/portalUserDeleteProcess.action",
            type : "POST",
            dataType : "json",
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 회원탈퇴 처리되었습니다.");
                    opener.location.href = "${httpCtxPath}";
                    self.close();
                } else {
                    alert("회원탈퇴 처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
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
<div class="popup_client_wrap">
    <div class="popup_client">
        <div class="popup_client_top">
            <h3><img src="${httpCtxPath}/resources/img/pop_hotellogo.png" alt="hotellogo"></h3>
        </div>
        
        <table style="border : 3px solid #888;"><tr><th>회원탈퇴</th></tr></table>

        회원탈퇴시 안내 내용
        
        <p class="popup_bt"><a href="javascript:self.close();" target="_self">닫기</a></p>
        <p class="popup_bt"><a href="javascript:fn_delete();" target="_self">회원 탈퇴</a></p>

    </div>
</div>
</body>
</html>
        
<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/tagLib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/WEB-INF/views/include/head.jsp" %>
    <script type="text/javascript" src="${httpCtxPath}/resources/js/rsa/jsbn.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/js/rsa/rsa.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/js/rsa/prng4.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/js/rsa/rng.js" charset="utf-8"></script>
    
    <link href="${httpCtxPath}/resources/css/products.css" rel="stylesheet" type="text/css"/>
    <link href="${httpCtxPath}/resources/css/my_room.css" rel="stylesheet" type="text/css"/>
    
    <script>
    $(window).load(function() {
        var cookieUserId = fn_getCookie("loginUserId");
        if(cookieUserId == "") {
            $("#userId").focus();
            $("#userId").val('${params.userId}');
        } else {
            $("#userId").val(cookieUserId);
            $("#rememberme").attr("checked",true);
            $("#userPassword").focus();
        }
        $(document).on("keypress", "#userPassword", function(e) {
            if (e.which == 13) {
                fn_login();
                return false;
            }
        });
    });
    
    function fn_login() {
        if($("#userId").val() == "") {
            alert("아이디를 입력하여 주십시오.");
            $("#userId").focus();
            return;
        }

        if($("#userPassword").val() == "") {
            alert("비밀번호를 입력하여 주십시오.");
            $("#userPassword").focus();
            return;
        }

        var expiredays = 0;
        if($("input:checkbox[id='rememberme']").is(":checked")) {
            expiredays = 365;
        } 
        
        fn_setCookie("loginUserId", $("#userId").val(), expiredays);
        
        var rsa;
        try {
            rsa = new RSAKey();
            rsa.setPublic("${publicKeyModulus}", "${publicKeyExponent}");
        } catch(e) {
            alert(e);
        }

        var params = {"userId" : rsa.encrypt($("#userId").val()), "userPassword" : rsa.encrypt($("#userPassword").val())};
        $.ajax({
            url : "${httpCtxPath}/loginProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    location.href = "${httpCtxPath}/mypage/dashBoard.action";
                } else if(response == "10") {
                	location.href = "${httpCtxPath}/mypage/portalCustList.action";
                } else {
                	if(response ==  "2") {
                		alert("시스템 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
                	} else if(response == "3") {
                		alert("아이디 또는 비밀번호가 일치하지 않습니다.");
                	} else if(response == "4") {
                		alert("포털 가입 정보가 존재하지 않습니다.");
                	}
                    location.href = "${httpCtxPath}/login.action";
                } 

            },
            error : function(request,status,error) {
                alert("시스템 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
            }
        });
    }
    </script>
<script>
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
                <h2 style="float:left;">호텔클릭투콜 로그인</h2>
            </div>

            <div class="room_top_wrap">
                <ul class="room_input">
                    <li>
                        <label for="id" class="room_label">아이디</label>
                        <input type="text" id="userId" name="userId" class="r_input" maxlength="20">
                    </li>
                    <li>
                        <label for="pwd" class="room_label">패스워드</label>
                        <input type="password" id="userPassword" name="userPassword" class="r_input" maxlength="20">
                    </li>
                    <li>
                        <input type="checkbox" id="rememberme"><label for="rememberme">아이디 기억하기</label>
                    </li>
                </ul>
            </div>
            <div class="bt_group">
                <p class="text_bt_style"><a href="javascript:fn_login();" target="_self">로그인</a></p>
            </div>
        </div>
    </div>
    
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>

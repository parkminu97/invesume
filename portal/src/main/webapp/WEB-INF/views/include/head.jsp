<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,target-densitydpi=medium-dpi" />
    <meta name="apple-mobile-web-app-capable" content="no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />

    <title>Hotel Click to Call</title>

    <script type="text/javascript" src="${httpCtxPath}/resources/lib/jquery/jquery-1.11.1.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/lib/jquery-ui/jquery-ui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/lib/jquery-timepicker/jquery.timepicker.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/js/common.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/js/util.js" charset="utf-8"></script>
    <script type="text/javascript" src="${httpCtxPath}/resources/js/slippry.min.js" charset="utf-8"></script>
    <!--
    <script src="https://use.edgefonts.net/cabin;source-sans-pro:n2,i2,n3,n4,n6,n7,n9.js"></script>
    -->

    <link href="${httpCtxPath}/resources/lib/jquery-ui/css/redmond/jquery-ui-1.8.18.custom.css" rel="stylesheet" type="text/css"/>
    <link href="${httpCtxPath}/resources/css/slippry.css" rel="stylesheet" type="text/css"/>
    <link href="${httpCtxPath}/resources/css/reset.css" rel="stylesheet" type="text/css"/>
    <link href="${httpCtxPath}/resources/css/main.css" rel="stylesheet" type="text/css"/>
        
    <script>
    function fn_home() {
    	location.href = "${httpCtxPath}/main.action";
    }
    function fn_logout(type) {
        $.ajax({
            url : "${httpCtxPath}/logout.action",
            type : "POST",
            dataType : "text",
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 로그아웃 되었습니다.");
                    location.href = "${httpCtxPath}/main.action"
                } else {
                    alert("로그아웃 처리 중 오류가 발생하였습니다.");
                }
            },
            error : function(request,status,error) {
                alert("시스템 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
            }
        });
    }
    </script>

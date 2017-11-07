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
    
    function fn_list(currentPage) {
        if(typeof(currentPage) == "undefined") currentPage = 1;
        $("#currentPage").val(currentPage);
        
        
        $("#listForm").attr("action", "${httpCtxPath}/boardList.action");
        $("#listForm").submit();
    }
    </script>
</head>
<body>
<div class="popup_client_wrap">
    <div class="popup_client">
        <div class="popup_client_top">
            <h3><img src="${httpCtxPath}/resources/img/pop_hotellogo.png" alt="hotellogo"></h3>
        </div>
        
        <table style="border : 3px solid #888;"><tr><th>공지사항 상세</th></tr></table>

        <table>
        <tr>
            <th style="width:40%;padding:10px;">제목</th>
            <td style="padding:10px;">${boardInfo.subject}</td>
        </tr>
        <tr>
            <th style="width:40%;padding:10px;">내용</th>
            <td style="padding:10px;min-height:200px;"><pre>${boardInfo.content}</pre></td>
        </tr>
        </table>
        <p class="popup_bt"><a href="javascript:self.close();" target="_self">닫기</a></p>
    </div>
</div>
</body>
</html>
        
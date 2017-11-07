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
    
    function fn_insert() {
    	if($("#file").val() == "") {
    		alert("파일을 선택하여 주십시오.");
    		return;
    	}
    	
        $("#insertForm").attr("action", "${httpCtxPath}/mypage/hotelRepImgUploadProcess.action");
        $("#insertForm").attr("target", "actionFrame");
        $("#insertForm").submit();
    }
    
    function fn_insert_process_after(result) {
    	if(result == "1") {
    		alert("정상적으로 호텔 대표 아이콘이 등록되었습니다.");
    		self.close();
    		opener.fn_refresh();
    	}
    	else alert("호텔 대표 아이콘 등록처리 중 오류가 발생하였습니다.");
    }
    </script>
</head>
<body>
<form id="insertForm" name="insertForm" method="post" enctype="multipart/form-data">
<div class="popup_client_wrap">
    <div class="popup_client">
        <div class="popup_client_top">
            <h3><img src="${httpCtxPath}/resources/img/pop_hotellogo.png" alt="hotellogo"></h3>
        </div>
        
        <table style="border : 3px solid #888;"><tr><th>호텔 대표 아이콘 등록</th></tr></table>

        <table>
        <tr>
            <th>파일 첨부</th>
            <td>
                <input type="file" id="file" name="file">
            </td>
        </tr>
        </tbody>
        </table>
        <p class="popup_bt"><a href="javascript:self.close();" target="_self">닫기</a></p>
        <p class="popup_bt"><a href="javascript:fn_insert();" target="_self">아이콘 업로드</a></p>
    </div>
</div>
</form>
<iframe id="actionFrame" name="actionFrame" style="display:none"></iframe>
</body>
</html>

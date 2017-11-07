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
    var cnt = 0;
    $(window).load(function() {
    });
    
    function addForm(){
        var addedFormDiv = document.getElementById("addedFormDiv");
        
        var date = new Date();
        var file = date.getTime();
             
        var str = "<input type=file name=file_"+cnt+">";
        if(cnt > 0) {
            str += " <a href='javascript:del(" + file + ")'>삭제</a>";
        }

        ++cnt;
        var addedDiv = document.createElement("div"); // 폼 생성
        addedDiv.id = file; // 폼 Div에 ID 부 여 (삭제를 위해)
        addedDiv.innerHTML  = str; // 폼 Div안에 HTML삽입
        $("#addedFormDiv").append(addedDiv);
    }

    function del(value){
        var addedFormDiv = document.getElementById("addedFormDiv");
        var addedDiv = document.getElementById(value);
        addedFormDiv.removeChild(addedDiv);
    }

    function fn_insert() {
        $("#insertForm").attr("action", "${httpCtxPath}/mypage/hotelRoomImgUploadProcess.action?riNo="+$("#no",opener.document).val());
        $("#insertForm").attr("target", "actionFrame");
        $("#insertForm").submit();
    }
    
    function fn_insert_process_after(result) {
    	if(result == "1") {
    		alert("정상적으로 객실 이미지가 추가되었습니다.");
    		self.close();
    		opener.fn_view();
    	}
    	else alert("객실 이미지 추가처리 중 오류가 발생하였습니다.");
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
        
        <table style="border : 3px solid #888;"><tr><th>객실 이미지 등록</th></tr></table>

        <table>
        <tr>
            <th>파일 첨부</th>
            <td>
                <a href='javascript:addForm()'>파일 첨부</a>
                <div id="addedFormDiv"></div>
            
            </td>
        </tr>
        </tbody>
        </table>
        <p class="popup_bt"><a href="javascript:self.close();" target="_self">닫기</a></p>
        <p class="popup_bt"><a href="javascript:fn_insert();" target="_self">이미지 업로드</a></p>
    </div>
</div>
</form>
<iframe id="actionFrame" name="actionFrame" style="display:none"></iframe>
</body>
</html>

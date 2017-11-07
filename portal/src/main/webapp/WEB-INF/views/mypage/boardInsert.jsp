<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/tagLib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/WEB-INF/views/include/head.jsp" %>
    <link href="${httpCtxPath}/resources/css/products.css" rel="stylesheet" type="text/css"/>
    <link href="${httpCtxPath}/resources/css/my_room.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${httpCtxPath}/resources/lib/smartEditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
    <style>
        .ui-datepicker select.ui-datepicker-month{ width:30%; font-size: 12px; }
        .ui-datepicker select.ui-datepicker-year{ width:40%; font-size: 12px; }
    </style>
    
    <script>
    $(window).load(function() {
        $(document).ready(function(){
            $.datepicker.regional['ko'] = {
                closeText: '닫기',
                prevText: '이전',
                nextText: '다음',
                currentText: '오늘',
                monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
                dayNames: ['일','월','화','수','목','금','토'],
                dayNamesShort: ['일','월','화','수','목','금','토'],
                dayNamesMin: ['일','월','화','수','목','금','토'],
                dateFormat: 'yy-mm-dd',
                firstDay: 0,
                showMonthAfterYear: true,
                changeYear: true,
                yearSuffix: '년 ',
                autoSize: false
            };
            $.datepicker.setDefaults($.datepicker.regional['ko']);
            initDatePicker("event_start_date");
            initDatePicker("event_end_date");
        });
    });

    function fn_list() {
        $("#insertForm").attr("action", "${httpCtxPath}/mypage/boardList.action");
        $("#insertForm").submit();
    }

    function fn_insert() {
        oEditors[0].exec("UPDATE_CONTENTS_FIELD", []);

        if($("#subject").val() == "") {
            alert("제목을 입력하여 주십시오.");
            $("#subject").focus();
            return;
        }
        
        if($("#content").val() == "") {
            alert("내용을 입력하여 주십시오.");
            $("#content").focus();
            return;
        }
        <c:if test="${params.board_gubun eq 'E' }">
        if($("#event_start_date").val() == "") {
            alert("이벤트 시작일을 입력하여 주십시오.");
            $("#event_start_date").focus();
            return;
        }
        if($("#event_end_date").val() == "") {
            alert("이벤트 종료일을 입력하여 주십시오.");
            $("#event_end_date").focus();
            return;
        }
        var startDate = $("#event_start_date").val().replace(".", "").replace(".", "");
        var endDate = $("#event_end_date").val().replace(".", "").replace(".", "");
        

        if(startDate > endDate) {
        	alert("이벤트 기간을 다시 입력하여 주십시오.");
        	$("#event_end_date").focus();
            return;
        }
        </c:if>
        var params = $("form[name=insertForm]").serialize();
        $.ajax({
            url : "${httpCtxPath}/mypage/boardInsertProcess.action",
            type : "POST",
            dataType : "json",
            data : params,
            async : false,
            success : function(response, status, request) {
                if(response == "1") {
                    alert("정상적으로 ${boardTitle}이 등록되었습니다.");
                    fn_list();
                } else {
                    alert("${boardTitle}등록처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
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
    <input type="hidden" id="board_gubun" name="board_gubun" value="${params.board_gubun}">
    <input type="hidden" id="searchSubject" name="searchSubject" value="${params.searchSubject}">
    <input type="hidden" id="no" name="no" value="${boardInfo.no}">
    
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="my_page">
        <%@include file="/WEB-INF/views/include/left.jsp" %>
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">${boardTitle} 등록</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; ${boardTitle}관리 &gt; ${boardTitle} 등록</p>
            </div>

            <div class="room_bottom_wrap">
                <table class="r_regi_table">
                <tbody>
                <tr>
                    <th style="width:20%;vertical-align:middle;height:40px;background:#c68d7f;color:#fff;font-weight:600;border-right:1px solid #e2e2e2;">제목</th>
                    <td style="text-align:left;padding-left:10px"><input id="subject" name="subject" type="text" maxlength="100" size="100"></td>
                </tr>
                <c:if test="${params.board_gubun eq 'E' }">
                <tr>
                    <th style="width:20%;vertical-align:middle;height:40px;background:#c68d7f;color:#fff;font-weight:600;border-right:1px solid #e2e2e2;">이벤트 기간</th>
                    <td style="text-align:left;padding-left:10px">
                        <input id="event_start_date" name="event_start_date" type="text" maxlength="10" size="10" readonly="readonly">
                         ~ 
                         <input id="event_end_date" name="event_end_date" type="text" maxlength="10" size="10" readonly="readonly">
                    </td>
                </tr>
                </c:if>
                <tr>
                    <th style="vertical-align:middle;height:40px;background:#c68d7f;color:#fff;font-weight:600;border-right:1px solid #e2e2e2;">내용</th>
                    <td style="text-align:left;padding-left:10px;padding-right:10px"><textarea id="content" name="content" style="width:100%; height:300px; display:none;"></textarea></td>
                </tr>
                </tbody>
                </table>
	            <div class="bt_group">
	                <p class="text_bt_style"><a href="javascript:fn_list();" target="_self" style="background:#333; margin-left:10px;">목록</a></p>
	                <p class="text_bt_style"><a href="javascript:fn_insert();" target="_self">등록</a></p>
	            </div>

            </div>

        </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
<script type="text/javascript">
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "content",
        sSkinURI: "${httpCtxPath}/resources/lib/smartEditor2/SmartEditor2Skin.jsp",
        htParams : {
            bUseToolbar : true,             // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,         // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            fOnBeforeUnload : function(){
                //alert("완료!");
            }
        }, //boolean
        fOnAppLoad : function(){
            //예제 코드
            //oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
        },
        fCreator: "createSEditor2"
    });
</script>
</body>
</html>

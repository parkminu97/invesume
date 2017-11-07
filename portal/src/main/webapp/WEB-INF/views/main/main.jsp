<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/tagLib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>

<script>
$(window).load(function(){
});
</script>
</head>
<body>
    <%@include file="/WEB-INF/views/include/top.jsp" %>
    <div class="slide_wrap">
        <article class="demo_block">
            <ul id="demo1">
                <li><a href="#"><img src="${httpCtxPath}/resources/img/image-1.jpg" alt=""></a></li>
                <li><a href="#"><img src="${httpCtxPath}/resources/img/image-1.jpg"  alt=""></a></li>
                <li><a href="#"><img src="${httpCtxPath}/resources/img/image-1.jpg" alt=""></a></li>
                <li><a href="#"><img src="${httpCtxPath}/resources/img/image-1.jpg" alt=""></a></li>
            </ul>
        </article>
        <script>
            $(function() {
                var demo1 = $("#demo1").slippry({
                    // transition: 'fade',
                    // useCSS: true,
                    // speed: 1000,
                    // pause: 3000,
                    // auto: true,
                    // preload: 'visible',
                    // autoHover: false
                });

                $('.stop').click(function () {
                    demo1.stopAuto();
                });

                $('.start').click(function () {
                    demo1.startAuto();
                });

                $('.prev').click(function () {
                    demo1.goToPrevSlide();
                    return false;
                });
                $('.next').click(function () {
                    demo1.goToNextSlide();
                    return false;
                });
                $('.reset').click(function () {
                    demo1.destroySlider();
                    return false;
                });
                $('.reload').click(function () {
                    demo1.reloadSlider();
                    return false;
                });
                $('.init').click(function () {
                    demo1 = $("#demo1").slippry();
                    return false;
                });
            });
        </script>
    </div><!-- 슬라이드쇼 끝 -->
    <div class="section_wrap">
        <section>
            <div class="content_title">
                <h2 style="float:left;">호텔클릭투콜 이용방법</h2>
                <a href="http://confluence.invesume.com:8090/download/attachments/9372725/hcall_manual.pdf?api=v2" target="_blank" style="float:right; margin-bottom:10px;"><img src="${httpCtxPath}/resources/img/menual_button.png"  alt="메뉴얼다운로드"></a>
            </div>
            <ul class="method_step">
                <li><img src="${httpCtxPath}/resources/img/step_01.png" alt="step01"></li>
                <li><img src="${httpCtxPath}/resources/img/step_02.png" alt="step02"></li>
                <li><img src="${httpCtxPath}/resources/img/step_03.png" alt="step03"></li>
                <li><img src="${httpCtxPath}/resources/img/step_04.png" alt="step04"></li>
            </ul>
        </section>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html> 
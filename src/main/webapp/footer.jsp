<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        
        <footer class="tm-bg-dark-blue">
            <div class="container">
                <div class="row">
                    <p class="col-sm-12 text-center tm-font-light tm-color-white p-4 tm-margin-b-0">
                    Copyright &copy; <span class="tm-current-year">2025</span> ParadoxInteractive - Design: Tooplate</p>        
                </div>
            </div>                
        </footer>
    </div> <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/datepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.singlePageNav.min.js"></script>
    <script src="${pageContext.request.contextPath}/slick/slick.min.js"></script>
    
    <script>
        $(document).ready(function(){
            // 스크롤 시 네비게이션 바 색상 변경
            $(window).on("scroll", function() {
                if($(window).scrollTop() > 100) {
                    $(".tm-top-bar").addClass("active");
                } else {
                   $(".tm-top-bar").removeClass("active");
                }
            });
            
            // 모바일 메뉴 닫기
            $('.nav-link').click(function(){
                $('#mainNav').removeClass('show');
            });

            // 저작권 연도 자동 업데이트
            $('.tm-current-year').text(new Date().getFullYear());
        });
    </script>
    
    <jsp:include page="section_chatbot.jsp" />
</body>
</html>
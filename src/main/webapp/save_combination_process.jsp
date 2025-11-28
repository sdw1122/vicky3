<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.CompanyDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. 로그인 확인
    String memberId = (String) session.getAttribute("userID");
    if (memberId == null) {
        %>
        <script>
            alert("로그인이 필요한 서비스입니다.");
            location.href = "login.jsp";
        </script>
        <%
        return;
    }

    // 2. 파라미터 수신
    String combName = request.getParameter("combinationName");
    String[] selectedIds = request.getParameterValues("finalSelection");

    // 3. 유효성 검사
    if (selectedIds == null || selectedIds.length == 0) {
        %>
        <script>
            alert("선택된 기업이 없습니다.");
            history.back();
        </script>
        <%
        return;
    }

    if (selectedIds.length > 6) {
        %>
        <script>
            alert("최대 6개까지만 저장할 수 있습니다.");
            history.back();
        </script>
        <%
        return;
    }

    // 4. 저장 수행
    CompanyDAO dao = new CompanyDAO();
    boolean result = dao.saveCombination(memberId, combName, selectedIds);

    // 5. 결과 이동
    if (result) {
        response.sendRedirect("my_combinations.jsp"); // 저장된 목록 페이지로 이동
    } else {
        %>
        <script>
            alert("저장 중 오류가 발생했습니다.");
            history.back();
        </script>
        <%
    }
%>
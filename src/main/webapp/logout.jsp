<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 세션 무효화 (저장된 모든 속성 삭제)
    session.invalidate();
%>
<script type="text/javascript">
    // 2. 알림창을 띄우고 메인 페이지로 이동
    alert("성공적으로 로그아웃 되었습니다.");
    location.href = "index.jsp";
</script>
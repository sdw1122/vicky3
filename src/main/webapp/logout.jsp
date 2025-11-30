<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //세션 무효화
    session.invalidate();
%>
<script type="text/javascript">
    alert("성공적으로 로그아웃 되었습니다.");
    location.href = "index.jsp";
</script>
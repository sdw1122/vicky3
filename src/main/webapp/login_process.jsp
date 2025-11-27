<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.vicky.dao.MemberDAO" %>
<%
    request.setCharacterEncoding("utf-8");

    // 1. 파라미터 받기
    String id = request.getParameter("id");
    String passwd = request.getParameter("passwd");

    // 2. DAO를 통해 인증 시도
    MemberDAO dao = new MemberDAO();
    int result = dao.login(id, passwd);

    // 3. 결과에 따른 처리
    if (result == 1) {
        // [로그인 성공]
        // 세션에 아이디와 이름 저장
        String userName = dao.getUserName(id);
        session.setAttribute("userID", id);
        session.setAttribute("userName", userName);
        
        // 메인 페이지로 이동
        response.sendRedirect("index.jsp");
    } else if (result == 0) {
        // [비밀번호 불일치]
        out.println("<script>");
        out.println("alert('비밀번호가 일치하지 않습니다.');");
        out.println("history.back();"); // 이전 페이지로 이동
        out.println("</script>");
    } else if (result == -1) {
        // [아이디 없음]
        out.println("<script>");
        out.println("alert('존재하지 않는 아이디입니다.');");
        out.println("history.back();");
        out.println("</script>");
    } else {
        // [DB 오류]
        out.println("<script>");
        out.println("alert('데이터베이스 오류가 발생했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>
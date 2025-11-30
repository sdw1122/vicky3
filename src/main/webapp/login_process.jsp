<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.vicky.dao.MemberDAO" %>
<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String passwd = request.getParameter("passwd");

    MemberDAO dao = new MemberDAO();
    int result = dao.login(id, passwd);

    if (result == 1) {
        String userName = dao.getUserName(id);
        session.setAttribute("userID", id);
        session.setAttribute("userName", userName);
        response.sendRedirect("index.jsp");
    } else if (result == 0) {
        out.println("<script>");
        out.println("alert('비밀번호가 일치하지 않습니다.');");
        out.println("history.back();");
        out.println("</script>");
    } else if (result == -1) {
        out.println("<script>");
        out.println("alert('존재하지 않는 아이디입니다.');");
        out.println("history.back();");
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("alert('데이터베이스 오류가 발생했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>
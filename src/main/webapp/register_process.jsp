<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.vicky.dao.MemberDAO" %>
<%@ page import="com.vicky.dto.MemberDTO" %>
<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String passwd = request.getParameter("passwd");
    String name = request.getParameter("name");

    MemberDAO dao = new MemberDAO();

    // 아이디 중복 확인
    if (dao.confirmId(id)) {
        out.println("<script>");
        out.println("alert('이미 존재하는 아이디입니다.');");
        out.println("history.back();");
        out.println("</script>");
    } else {
        // 중복이 아니면 회원 정보 저장
        MemberDTO dto = new MemberDTO();
        dto.setId(id);
        dto.setPasswd(passwd);
        dto.setName(name);

        dao.insertMember(dto);

        // 가입 완료 후 로그인 페이지로 이동
        out.println("<script>");
        out.println("alert('회원가입이 완료되었습니다! 로그인해주세요.');");
        out.println("location.href='login.jsp';");
        out.println("</script>");
    }
%>
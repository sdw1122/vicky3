<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.GalleryDAO" %>
<%@ page import="com.vicky.dto.GalleryDTO" %>
<%@ page import="java.io.File" %>

<%
    // 1. 파라미터 받기
    String noStr = request.getParameter("no");
    int no = 0;
    if(noStr != null) no = Integer.parseInt(noStr);

    // 2. 권한 검증 (주소창 입력으로 삭제 시도 방지)
    String loginId = (String) session.getAttribute("userID");
    GalleryDAO dao = new GalleryDAO();
    GalleryDTO dto = dao.getGallery(no);

    if (dto == null) {
%>
        <script>
            alert("존재하지 않는 게시글입니다.");
            history.back();
        </script>
<%
        return;
    }

    // 글쓴이 ID와 로그인 ID가 다르면 차단 (관리자라면 || "admin".equals(loginId) 추가 가능)
    if (loginId == null || !loginId.equals(dto.getWriterId())) {
%>
        <script>
            alert("삭제 권한이 없습니다.");
            history.back();
        </script>
<%
        return;
    }

    // 3. 첨부 파일 삭제 (서버 용량 관리)
    if (dto.getFileName() != null) {
        String savePath = request.getServletContext().getRealPath("upload");
        File file = new File(savePath + File.separator + dto.getFileName());
        if(file.exists()) {
            file.delete();
        }
    }

    // 4. DB 데이터 삭제
    int result = dao.deleteGallery(no);

    if(result > 0) {
%>
        <script>
            alert("게시글이 삭제되었습니다.");
            location.href = "gallery.jsp";
        </script>
<%
    } else {
%>
        <script>
            alert("삭제 실패.");
            history.back();
        </script>
<%
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.GalleryDAO" %>
<%@ page import="com.vicky.dto.GalleryDTO" %>
<%@ page import="java.io.File" %>

<%
    String noStr = request.getParameter("no");
    int no = 0;
    if(noStr != null) no = Integer.parseInt(noStr);

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

    if (loginId == null || !loginId.equals(dto.getWriterId())) {
%>
        <script>
            alert("삭제 권한이 없습니다.");
            history.back();
        </script>
<%
        return;
    }

    if (dto.getFileName() != null) {
        String savePath = request.getServletContext().getRealPath("upload");
        File file = new File(savePath + File.separator + dto.getFileName());
        if(file.exists()) {
            file.delete();
        }
    }

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
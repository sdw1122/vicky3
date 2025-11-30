<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="com.vicky.dao.GalleryDAO" %>
<%@ page import="com.vicky.dto.GalleryDTO" %>

<%
    request.setCharacterEncoding("UTF-8");

    String savePath = request.getServletContext().getRealPath("upload");
    
    File uploadDir = new File(savePath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    int maxSize = 10 * 1024 * 1024; 
    String encoding = "UTF-8";

    try {
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        
        String fileName = multi.getFilesystemName("fileName"); 

        String writerId = (String) session.getAttribute("userID");
        String writerName = (String) session.getAttribute("userName");

        if (writerId == null) {
            writerId = multi.getParameter("writer_id");
        }
        if (writerName == null) {
            writerName = "익명";
        }

        GalleryDTO dto = new GalleryDTO();
        dto.setTitle(title);
        dto.setContent(content);
        dto.setFileName(fileName);
        dto.setWriterId(writerId);
        dto.setWriter(writerName);

        GalleryDAO dao = new GalleryDAO();
        dao.insertGallery(dto);

        response.sendRedirect("gallery.jsp");

    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("게시글 등록 중 오류가 발생했습니다.");
            history.back();
        </script>
<%
    }
%>
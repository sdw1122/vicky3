<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.GalleryDAO" %>
<%@ page import="com.vicky.dto.GalleryDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:include page="header.jsp" />

<%
    // 1. 파라미터 받기
    int no = 0;
    try {
        no = Integer.parseInt(request.getParameter("no"));
    } catch (NumberFormatException e) {
        // 번호가 없거나 이상하면 목록으로 보내기
        response.sendRedirect("gallery.jsp");
        return;
    }

    // 2. DB에서 데이터 가져오기
    GalleryDAO dao = new GalleryDAO();
    GalleryDTO dto = dao.getGallery(no);

    // 3. 게시글이 없으면 삭제된 글이라고 알림
    if (dto == null) {
%>
        <script>
            alert("삭제되거나 존재하지 않는 게시글입니다.");
            history.back();
        </script>
<%
        return;
    }
    
    // 날짜 포맷
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<div class="tm-section tm-section-pad tm-bg-gray">
    <div class="container">
        <div class="row">
            <div class="col-12 tm-bg-white p-4 mb-4" style="border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
                
                <div class="border-bottom pb-3 mb-4">
                    <h3 class="tm-color-primary mb-3"><%= dto.getTitle() %></h3>
                    <div class="d-flex justify-content-between text-muted" style="font-size: 0.9em;">
                        <div>
                            <span class="mr-3">글쓴이: <strong><%= dto.getWriter() == null ? "익명" : dto.getWriter() %></strong></span>
                        </div>
                        <div>
                            <span><%= sdf.format(dto.getRegDate()) %></span>
                        </div>
                    </div>
                </div>

                <div class="content-body" style="min-height: 200px;">
                    
                    <% if(dto.getFileName() != null && !dto.getFileName().isEmpty()) { %>
                    <div class="text-center mb-4">
                        <img src="upload/<%= dto.getFileName() %>" class="img-fluid" style="max-width: 100%; border-radius: 3px;" alt="첨부 이미지">
                    </div>
                    <% } %>

                    <div style="white-space: pre-wrap; line-height: 1.6;"><%= dto.getContent() %></div>
                </div>
                
                <div class="text-right mt-5 pt-3 border-top">
                    <a href="gallery.jsp" class="btn btn-secondary tm-btn-gray">목록</a>
                    </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.GalleryDAO" %>
<%@ page import="com.vicky.dto.GalleryDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:include page="header.jsp" />

<%
    GalleryDAO dao = new GalleryDAO();
    List<GalleryDTO> list = dao.getList();
    
    // 날짜
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<div class="tm-section tm-section-pad tm-bg-gray" id="tm-section-4">
    <div class="container">
        <div class="row mb-4">
            <div class="col-8">
                <h2 class="tm-section-title tm-color-primary" style="color: black;">갤러리 게시판</h2>
            </div>
            <div class="col-4 text-right">
                <a href="gallery_write.jsp" class="btn btn-primary tm-btn-primary">글쓰기</a>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <table class="table table-hover tm-bg-white">
                    <thead class="thead-light">
                        <tr class="text-center">
                            <th scope="col" style="width: 10%;">번호</th>
                            <th scope="col" style="width: 50%;">제목</th>
                            <th scope="col" style="width: 15%;">글쓴이</th>
                            <th scope="col" style="width: 15%;">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(GalleryDTO dto : list) { %>
                        <tr class="text-center">
                            <td><%= dto.getNo() %></td>
                            <td class="text-left">
                                <a href="gallery_view.jsp?no=<%= dto.getNo() %>" style="color: #333; font-weight: bold;">
                                    <%= dto.getTitle() %>
                                    <% if(dto.getFileName() != null) { %>
                                        <i class="fa fa-picture-o" aria-hidden="true" style="color: #999; margin-left: 5px;"></i>
                                    <% } %>
                                </a>
                            </td>
                            <td><%= dto.getWriter() == null ? "익명" : dto.getWriter() %></td>
                            <td><%= sdf.format(dto.getRegDate()) %></td>
                        </tr>
                        <% } %>
						
                        <% if(list.size() == 0) { %>
                        <tr>
                            <td colspan="4" class="text-center py-4">등록된 게시글이 없습니다.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
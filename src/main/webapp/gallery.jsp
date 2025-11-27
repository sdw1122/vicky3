<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.GalleryDAO" %>
<%@ page import="com.vicky.dto.GalleryDTO" %>
<%@ page import="java.util.List" %>

<jsp:include page="header.jsp" />

<%
    GalleryDAO dao = new GalleryDAO();
    List<GalleryDTO> list = dao.getList();
%>

<div class="tm-section tm-section-pad tm-bg-gray" id="tm-section-4">
    <div class="container">
        <div class="row mb-4">
            <div class="col-8">
                <h2 class="tm-section-title tm-color-primary" style="color: black;">스크린샷</h2>
            </div>
            <div class="col-4 text-right">
                <a href="gallery_write.jsp" class="btn btn-primary tm-btn-primary">글쓰기</a>
            </div>
        </div>

        <div class="row">
            <% for(GalleryDTO dto : list) { %>
            <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                <article class="tm-bg-white mr-2 h-100">
                    <% if(dto.getFileName() != null) { %>
                    <div class="img-wrapper" style="height: 200px; overflow: hidden;">
                        <img src="upload/<%= dto.getFileName() %>" alt="Image" class="img-fluid" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                    <% } %>
                    
                    <div class="tm-article-pad">
                        <header>
                            <h3 class="text-uppercase tm-article-title-2"><%= dto.getTitle() %></h3>
                        </header>
                        <p><%= dto.getContent().length() > 50 ? dto.getContent().substring(0, 50) + "..." : dto.getContent() %></p>
                        <p class="text-muted" style="font-size: 0.8em;"><%= dto.getRegDate() %></p>
                        <a href="#" class="text-uppercase btn-primary tm-btn-primary small">자세히 보기</a>
                    </div>                                 
                </article>
            </div>
            <% } %>
            
            <% if(list.size() == 0) { %>
            <div class="col-12">
                <p class="text-center">등록된 게시글이 없습니다.</p>
            </div>
            <% } %>
        </div>
    </div>
</div>


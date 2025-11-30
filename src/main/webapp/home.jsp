<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.vicky.dao.GalleryDAO" %>
<%@ page import="com.vicky.dto.GalleryDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String language = request.getParameter("language");
    if(language != null && !language.isEmpty()) {
        session.setAttribute("language", language);
    } 
    else {
        language = (String) session.getAttribute("language");
        if(language == null) {
            language = "ko";
        }
    }
%>
<fmt:setLocale value="<%=language %>" />
<fmt:bundle basename="bundle.message">

<%
    // 갤러리 데이터 가져오기
    GalleryDAO gDao = new GalleryDAO();
    List<GalleryDTO> gList = gDao.getList(); // DAO의 getList() 호출
%>

<div class="tm-section tm-bg-img" id="tm-section-1"></div>

<div class="tm-section-2">
    <div class="container">
        

        <div class="row">
            <div class="col text-center">
                <h2 class="tm-section-title"><fmt:message key="welcome.title" /></h2>
                <p class="tm-color-white tm-section-subtitle"><fmt:message key="welcome.subtitle" /></p>
                <br><br>
            </div>              
        </div>
    </div>        
</div>

<br>

<div class="tm-section tm-section-pad tm-bg-gray">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h2 class="tm-section-title-2 tm-color-primary tm-margin-b-20"><fmt:message key="board.title" /></h2>
                <p class="tm-margin-b-20"><fmt:message key="board.desc" /></p>
            </div>
        </div>

        <div class="row">
            <%
                if (gList != null && !gList.isEmpty()) {
                    int limit = 0;
                    for (GalleryDTO dto : gList) {
                        if (limit >= 3) break; // 최대 3개까지만 출력
            %>
            <div class="col-sm-12 col-md-4 col-lg-4 tm-margin-b-20">
                <div class="tm-article tm-bg-white tm-bg-white-shadow" style="padding: 20px; height: 100%;">
                    <div style="height: 180px; overflow: hidden; background: #eee; display: flex; align-items: center; justify-content: center; margin-bottom: 15px;">
                        <% if(dto.getFileName() != null && !dto.getFileName().isEmpty()) { %>
                            <img src="upload/<%= dto.getFileName() %>" alt="Image" style="width: 100%; height: auto;">
                        <% } else { %>
                            <i class="fa fa-picture-o fa-3x tm-color-primary"></i>
                        <% } %>
                    </div>
                    
                    <h3 class="tm-article-title-1">
                        <a href="gallery_view.jsp?no=<%= dto.getNo() %>" class="tm-color-black"><%= dto.getTitle() %></a>
                    </h3>
                    <p class="tm-font-light" style="font-size: 0.9rem;">
                        <fmt:message key="board.author" /> <%= dto.getWriter() %><br>
                        <fmt:message key="board.date" /> <%= dto.getRegDate() %>
                    </p>
                    <a href="gallery_view.jsp?no=<%= dto.getNo() %>" class="text-uppercase tm-color-primary tm-font-semibold"><fmt:message key="board.readmore" /></a>
                </div>
            </div>
            <%
                        limit++;
                    }
                } else {
            %>
            <div class="col-12 text-center">
                <p><fmt:message key="board.empty" /></p>
            </div>
            <%
                }
            %>
        </div>
        
        <div class="row">
            <div class="col-12 text-center tm-margin-t-20" style="margin-top: 30px;">
                <a href="gallery.jsp" class="btn btn-primary"><fmt:message key="btn.viewall" /></a>
            </div>
        </div>
    </div>
</div>

<br>

<div class="tm-bg-white tm-bg-white-shadow ie-container-width-fix-2">
    <div class="container ie-h-align-center-fix">
        <div class="row">
            <div class="col-xs-12 ml-auto mr-auto ie-container-width-fix">
                <jsp:include page="search_event_form.jsp" />
            </div>               
        </div>      
    </div>
</div>

<br>

<div class="tm-bg-white tm-bg-white-shadow ie-container-width-fix-2">
    <div class="container ie-h-align-center-fix">
        <div class="row">
            <div class="col-xs-12 ml-auto mr-auto ie-container-width-fix">
                <jsp:include page="search_company_form.jsp" />
            </div>          
        </div>      
    </div>
</div>

<div class="tm-section tm-position-relative">
    <div class="container tm-pt-5 tm-pb-4">
        <div class="row text-center">
            
            <article class="col-sm-12 col-md-4 col-lg-4 col-xl-4 tm-article">                            
                <i class="fa tm-fa-6x fa-camera-retro tm-color-primary tm-margin-b-20"></i>
                <h3 class="tm-color-primary tm-article-title-1"><fmt:message key="section.screenshot.title" /></h3>
                <p><fmt:message key="section.screenshot.desc" /></p>
                <a href="gallery.jsp" class="text-uppercase tm-color-primary tm-font-semibold"><fmt:message key="link.go" /></a>
            </article>
            
            <article class="col-sm-12 col-md-4 col-lg-4 col-xl-4 tm-article">            
                <i class="fa tm-fa-6x fa-building tm-color-primary tm-margin-b-20"></i>
                <h3 class="tm-color-primary tm-article-title-1"><fmt:message key="section.company.title" /></h3>
                <p><fmt:message key="section.company.desc" /></p>
                <a href="company_history.jsp" class="text-uppercase tm-color-primary tm-font-semibold"><fmt:message key="link.go" /></a>
            </article>
            
            <article class="col-sm-12 col-md-4 col-lg-4 col-xl-4 tm-article">                           
                <i class="fa tm-fa-6x fa-history tm-color-primary tm-margin-b-20"></i>
                <h3 class="tm-color-primary tm-article-title-1"><fmt:message key="section.event.title" /></h3>
                <p><fmt:message key="section.event.desc" /></p>
                <a href="historical_event.jsp" class="text-uppercase tm-color-primary tm-font-semibold"><fmt:message key="link.go" /></a>                           
            </article>

        </div>         
    </div>
</div>
</fmt:bundle>
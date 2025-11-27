<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vicky Archive</title>
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/slick/slick-theme.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/datepicker.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tooplate-style.css">
</head>

<body>
	<%
	    String userID = (String) session.getAttribute("userID");
	    String userName = (String) session.getAttribute("userName");
	%>
    <div class="tm-main-content" id="top">
        <div class="tm-top-bar-bg"></div>
        <div class="tm-top-bar" id="tm-top-bar">
            <div class="container">
                <div class="row">
                    <nav class="navbar navbar-expand-lg narbar-light">
                        <a class="navbar-brand mr-auto" href="index.jsp">
                            <img src="${pageContext.request.contextPath}/img/logo.png" alt="Site logo">
                            Vicky3 Archive
                        </a>
                        <button type="button" id="nav-toggle" class="navbar-toggler collapsed" data-toggle="collapse" data-target="#mainNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div id="mainNav" class="collapse navbar-collapse tm-bg-white">
                            <ul class="navbar-nav ml-auto">
                                <li class="nav-item"><a class="nav-link" href="index.jsp">홈</a></li>
                                <li class="nav-item"><a class="nav-link" href="gallery.jsp">스크린샷</a></li>
                                <li class="nav-item"><a class="nav-link" href="#tm-section-5">역사적 사건</a></li>
                                <li class="nav-item"><a class="nav-link" href="company_history.jsp">역사적 기업</a></li>
                                <% if (userID == null) { %>
							        <li class="nav-item"><a class="nav-link" href="login.jsp">로그인</a></li>
							    <% } else { %>
							        <li class="nav-item"><a class="nav-link" href="logout.jsp">로그아웃</a></li>
							    <% } %>
                            </ul>
                        </div>                            
                    </nav>            
                </div>
            </div>
        </div>
